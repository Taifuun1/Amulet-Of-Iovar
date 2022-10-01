extends EnemyPathfinding
class_name BaseLevel

onready var astarNode = AStar2D.new()

var levelId
var dungeonType
var dungeonLevelName
var visibility

var grid = []
var rooms = []
var floors = []
var spawnableFloors = []
var stairs = {}

var critters = []

func create(_dungeonType, _dungeonLevelName, _visibility):
	levelId = Globals.levelId
	name = str(Globals.levelId)
	Globals.levelId += 1
	dungeonType = _dungeonType
	dungeonLevelName = _dungeonLevelName
	visibility = _visibility



###########################################
### Dungeon generation helper functions ###
###########################################

func createGrid(_tile = Globals.tiles.EMPTY):
	Globals.generatedLevels += 1
	$"/root/World/UI/UITheme/StartScreen".setLoadingText("Generating level... \n{generatedLevels}".format({ "generatedLevels": Globals.generatedLevels }))
	for _x in range(Globals.gridSize.x):
		grid.append([])
		for _y in range(Globals.gridSize.y):
			grid[_x].append({
				"tile": _tile,
				"tileMetaData": {
					"xFlip": false,
					"yFlip": false
				},
				"critter": null,
				"items": [],
				"interactable": null
			})

func getGenerationGrid():
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			grid[x][y].tile = get_cellv(Vector2(x,y))
			grid[x][y].tileMetaData = {
				"xFlip": is_cell_x_flipped(x, y),
				"yFlip": is_cell_y_flipped(x, y)
			}

func placeCritterOnTypeOfTile(_tile, _critter):
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if _tile == grid[x][y].tile:
				grid[x][y].critter = _critter
				return

func getCritterTile(_critter):
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if grid[x][y].critter == _critter:
				return Vector2(x, y)
	return false

func getTilePosition(_tile):
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if _tile == grid[x][y].tile:
				return Vector2(x, y)
	return false

func getSpawnableFloors(_spawnableFloors):
	for x in Globals.gridSize.x:
		for y in Globals.gridSize.y:
			for _spawnableFloor in _spawnableFloors:
				if grid[x][y].tile == Globals.tiles[_spawnableFloor]:
					spawnableFloors.append(Vector2(x, y))
					break

func placeStairs(_stairType = "DUNGEON", _isDouble = false):
	stairs["downStair"] = placeStair("downStair", "DOWN_STAIR_", _stairType)
	if _isDouble:
		stairs["secondDownStair"] = placeStair("secondDownStair", "DOWN_STAIR_", _stairType)
	stairs["upStair"] = placeStair("secondDownStair", "UP_STAIR_", _stairType)
	for _stair in stairs.values():
		grid[_stair.x][_stair.y].interactable = null

func placeStair(_stairName, _stairTile, _stairType):
	for _i in range(20):
		var _stair = spawnableFloors[randi() % spawnableFloors.size()]
		if !isTileAStair(_stair):
			grid[_stair.x][_stair.y].tile = Globals.tiles[_stairTile + "{type}".format({ "type": _stairType })]
			spawnableFloors.erase(_stair)
			return _stair
	push_error("Dungeon generation failed, can't place stairs")

func placeDoors(_doors):
	for _room in rooms:
		for _door in range(randi() % (_doors.max - _doors.min + 1) + _doors.min):
			placeDoor(_room)
		
#		var _minPos
#		var _maxPos
#		var _size
#		for _floorTile in _room:
#			if _minPos == null:
#				_minPos = _floorTile
#			if _maxPos == null:
#				_maxPos = _floorTile
#
#			if _minPos.x > _floorTile.x:
#				_minPos.x = _floorTile.x
#			if _maxPos.x < _floorTile.x:
#				_maxPos.x = _floorTile.x
#
#			if _minPos.y > _floorTile.y:
#				_minPos.y = _floorTile.y
#			if _maxPos.y < _floorTile.y:
#				_maxPos.y = _floorTile.y
#
#		_size = Vector2(_maxPos.x - _minPos.x, _maxPos.y - _minPos.y)
#
#		print(_minPos)
#		print(_maxPos)
#		print(_size)
#		for _door in range(randi() % (_doors.max + 1) + _doors.min):
#			placeDoor(_minPos, _maxPos, _size)

func placeDoor(_room):#_minPos, _maxPos, _size):
	for _i in range(20):
		var _tile = _room.walls[randi() % _room.walls.size()]
		if isTileADoor(_tile):
			continue
		else:
			grid[_tile.x][_tile.y].tile = Globals.tiles.DOOR_CLOSED
			_room.walls.erase(_tile)
			return
#		var _position
#		if randi() % 2 == 0:
#			if randi() % 2 == 0:
#				_position = Vector2(
#					randi() % (int(_size.x) + 1) + int(_minPos.x),
#					int(_minPos.y)
#				)
#			else:
#				_position = Vector2(
#					randi() % (int(_size.x) + 1) + int(_minPos.x),
#					int(_minPos.y) + int(_size.y)
#				)
#		else:
#			if randi() % 2 == 0:
#				_position = Vector2(
#					int(_minPos.x),
#					randi() % (int(_size.y) + 1) + int(_minPos.y)
#				)
#			else:
#				_position = Vector2(
#					int(_minPos.x) + int(_size.x),
#					randi() % (int(_size.y) + 1) + int(_minPos.y)
#				)
#		if isTileADoor(_position):
#			continue
#		else:
#			print("get doored")
#			grid[_position.x][_position.y].tile = Globals.tiles.DOOR_CLOSED
#			break
	push_error("Cant place doors")

func areAllStairsConnected():
	astarNode.clear()
	pathFind([
		Globals.tiles.EMPTY,
		Globals.tiles.WALL_DUNGEON,
		Globals.tiles.WALL_SAND,
		Globals.tiles.WALL_BRICK_SAND,
		Globals.tiles.WALL_BOARD,
		Globals.tiles.WALL_BRICK_LARGE,
		Globals.tiles.GRASS_TREE,
		Globals.tiles.VILLAGE_WALL_HORIZONTAL,
		Globals.tiles.VILLAGE_WALL_CORNER,
		Globals.tiles.VILLAGE_WALL_VERTICAL,
		Globals.tiles.WALL_BRICK_SMALL,
		Globals.tiles.VILLAGE_WALL_HALFWALL,
		Globals.tiles.GRASS_DEAD_TREE,
		Globals.tiles.WALL_STONE_BRICK,
		Globals.tiles.WALL_WOOD_PLANK
	])
	
	if stairs.values().size() == 0 or stairs["downStair"] == null or stairs["upStair"] == null:
		return false
	for startStair in stairs.values():
		for endStair in stairs.values():
			if startStair == endStair:
				continue
			if calculatePath(startStair, endStair).size() == 0:
				return false
	return true

func getAndCleanUpRooms(_tileTypes):
	# Get floors
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			for _tileType in _tileTypes:
				if grid[x][y].tile == Globals.tiles[_tileType.floor] and !isTileAlreadyInARoom(Vector2(x,y)):
					rooms.append({
						"floors": getRoom(Vector2(x, y), _tileType),
						"walls": []
					})
					break
	# Clean up missing walls
	for _room in rooms:
		for _floorTile in _room.floors:
			for _tileType in _tileTypes:
				if grid[_floorTile.x][_floorTile.y].tile == Globals.tiles[_tileType.floor]:
					for _adjacentTile in checkAdjacentTilesForTile(_floorTile, [_tileType.floor, _tileType.wall], false):
						if !isTileAlreadyInARoom(_adjacentTile):
							grid[_adjacentTile.x][_adjacentTile.y].tile = Globals.tiles[_tileType.wall]
	# Get walls
	for _room in rooms:
		var _walls = []
		for _floorTile in _room.floors:
			for _tileType in _tileTypes:
				for _adjacentTile in checkAdjacentTilesForTile(_floorTile, [_tileType.wall]):
					if !isTileAlreadyInARoom(_adjacentTile):
						_walls.append(_adjacentTile)
		_room.walls = _walls

func getRoom(_tile, _tileType):
	var _roomTiles = [_tile]
	var _adjacentTiles = checkAdjacentTilesForTile(_tile, [_tileType.floor])
	_roomTiles.append_array(_adjacentTiles)
	while !_adjacentTiles.empty():
		for _adjacentTile in checkAdjacentTilesForTile(_adjacentTiles.pop_back(), [_tileType.floor]):
			if !_roomTiles.has(_adjacentTile):
				_adjacentTiles.append(_adjacentTile)
				_roomTiles.append(_adjacentTile)
	return _roomTiles

func fillEmptyTiles(_tile):
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if grid[x][y].tile == -1:
				grid[x][y].tile = Globals.tiles[_tile]

func placeRandomInteractables(_interactables):
	for _interactable in _interactables:
		match _interactable:
			"altar":
				if randi() % 13 == 0:
					for _i in range(randi() % 2 + 1):
						var _randomSpawnableTile = spawnableFloors[randi() % spawnableFloors.size()]
						if grid[_randomSpawnableTile.x][_randomSpawnableTile.y].interactable == null:
							grid[_randomSpawnableTile.x][_randomSpawnableTile.y].interactable = Globals.interactables.ALTAR

func resetLevel():
	rooms.clear()
	floors.clear()
	spawnableFloors.clear()
	stairs.clear()
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			grid[x][y].tile = -1

func cleanOutPremadeTilemap():
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			set_cellv(Vector2(x,y), -1)

func isTileFreeOfCritters(_tile):
	if grid[_tile.x][_tile.y].critter == null:
		return true
	return false

func isTileAStair(_newStair):
	for _stair in stairs.values():
		if _newStair == _stair:
			return true
	return false

func isTileADoor(_tile):
	if grid[_tile.x][_tile.y].tile == Globals.tiles.DOOR_CLOSED:
		return true
	return false



#######################
### Astar functions ###
#######################

# General pathfinding
func calculatePath(pathStartPosition, pathEndPosition):
	return astarNode.get_point_path(id(pathStartPosition), id(pathEndPosition))

func pathFind(_illegibleTiles):
	astarNode.clear()
	connectAllCells(addLegibletiles(_illegibleTiles))

func addLegibletiles(_illegibleTiles):
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
			if isTileIllegibleInGeneralPathfind(point, _illegibleTiles):
				continue
			points.append(point)
			astarNode.add_point(id(point), point, 1.0)
	return points

func isTileIllegibleInGeneralPathfind(_point, _illegibleTiles):
	for _illegibleTile in _illegibleTiles:
		if grid[_point.x][_point.y].tile == _illegibleTile:
			return true
	return false

func connectAllCells(points):
	for point in points:
		var pointIndex = id(point)
		var pointsRelative = PoolVector2Array([
			Vector2(point.x, point.y - 1),
			Vector2(point.x + 1, point.y - 1),
			Vector2(point.x + 1, point.y),
			Vector2(point.x + 1, point.y + 1),
			Vector2(point.x, point.y + 1),
			Vector2(point.x - 1, point.y + 1),
			Vector2(point.x - 1, point.y),
			Vector2(point.x - 1, point.y - 1)
		])
		for pointRelative in pointsRelative:
			var pointRelativeIndex = id(pointRelative)
			if isOutSideTileMap(pointRelative):
				continue
			if not astarNode.has_point(pointRelativeIndex):
				continue
			astarNode.connect_points(pointIndex, pointRelativeIndex, true)



################################
### General helper functions ###
################################

func checkAdjacentTilesForOpenSpace(_position, _checkForSingleOpenSpace = false, checkForCritters = false, _shuffleDirections = true):
	var _openTiles = []
	var _directions = [
		Vector2(-1, -1),
		Vector2(0, -1),
		Vector2(1, -1),
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(0, 1),
		Vector2(-1, 1),
		Vector2(-1, 0)
	]
	if _shuffleDirections:
		_directions.shuffle()
	for _direction in _directions:
		var _checkedTilePosition = Vector2(_position.x + _direction.x, _position.y + _direction.y)
		if !isOutSideTileMap(_checkedTilePosition):
			var _checkedTileInGrid = grid[_checkedTilePosition.x][_checkedTilePosition.y]
			if Globals.isTileFree(_checkedTilePosition, grid):
				if checkForCritters:
					if _checkedTileInGrid.critter == null:
						_openTiles.append(_checkedTilePosition)
						if _checkForSingleOpenSpace:
							return _openTiles
				else:
					_openTiles.append(_checkedTilePosition)
					if _checkForSingleOpenSpace:
						return _openTiles
	return _openTiles

func checkAdjacentTilesForTile(_tile, _tileTypes, _checkForTile = true):
	var _tiles = []
	var _directions = [
		Vector2(-1, -1),
		Vector2(0, -1),
		Vector2(1, -1),
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(0, 1),
		Vector2(-1, 1),
		Vector2(-1, 0)
	]
	for _direction in _directions:
		var _checkedTilePosition = Vector2(_tile.x + _direction.x, _tile.y + _direction.y)
		if !isOutSideTileMap(_checkedTilePosition):
			if isTileOneOfTypes(_checkedTilePosition, _tileTypes) and _checkForTile:
				_tiles.append(_checkedTilePosition)
			elif !isTileOneOfTypes(_checkedTilePosition, _tileTypes) and !_checkForTile:
				_tiles.append(_checkedTilePosition)
	return _tiles

func isTileOneOfTypes(_checkedTilePosition, _tileTypes):
	for _tileType in _tileTypes:
		if grid[_checkedTilePosition.x][_checkedTilePosition.y].tile == Globals.tiles[_tileType]:
			return true
	return false

func isTileAlreadyInARoom(_tile):
	for _room in rooms:
		for _floor in _room.floors:
			if _floor == _tile:
				return true
		for _wall in _room.walls:
			if _wall == _tile:
				return true
	return false
