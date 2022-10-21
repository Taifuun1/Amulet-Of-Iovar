extends EnemyPathfinding
class_name BaseLevel

onready var astarNode = AStar2D.new()
onready var weightedAstarNode = AStar2D.new()

var levelId
var dungeonType
var dungeonLevelName
var visibility

var grid = []
var rooms = []
var areas = []
var floors = []
var openTiles = []
var spawnableItemTiles = []
var spawnableCritterTiles = []
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
				"effects": [],
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

func getSpawnableTiles(_openTiles, _spawnableItemTiles, _spawnableCritterTiles, useAreas = false):
	for x in Globals.gridSize.x:
		for y in Globals.gridSize.y:
			for _tile in _openTiles:
				if useAreas:
					for _area in areas:
						if _area.has(Vector2(x, y)) and _area.size() > 75:
							openTiles.append(Vector2(x, y))
							break
				elif grid[x][y].tile == Globals.tiles[_tile]:
					openTiles.append(Vector2(x, y))
					break
	for x in Globals.gridSize.x:
		for y in Globals.gridSize.y:
			for _tile in _spawnableItemTiles:
				if useAreas:
					for _area in areas:
						if _area.has(Vector2(x, y)) and _area.size() > 75:
							spawnableItemTiles.append(Vector2(x, y))
							break
				elif grid[x][y].tile == Globals.tiles[_tile]:
					spawnableItemTiles.append(Vector2(x, y))
					break
	for x in Globals.gridSize.x:
		for y in Globals.gridSize.y:
			for _tile in _spawnableCritterTiles:
				if useAreas:
					for _area in areas:
						if _area.has(Vector2(x, y)) and _area.size() > 75:
							spawnableCritterTiles.append(Vector2(x, y))
							break
				elif grid[x][y].tile == Globals.tiles[_tile]:
					spawnableCritterTiles.append(Vector2(x, y))
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
		var _stair = spawnableItemTiles[randi() % spawnableItemTiles.size()]
		if !isTileAStair(_stair):
			grid[_stair.x][_stair.y].tile = Globals.tiles[_stairTile + "{type}".format({ "type": _stairType })]
			spawnableItemTiles.erase(_stair)
			if spawnableCritterTiles.has(_stair):
				spawnableCritterTiles.erase(_stair)
			return _stair
	push_error("Dungeon generation failed, can't place stairs")

func placeDoors(_doors):
	for _room in rooms:
		for _door in range(randi() % (_doors.max - _doors.min + 1) + _doors.min):
			placeDoor(_room)

func placeDoor(_room):
	for _i in range(20):
		var _tile = _room.walls[randi() % _room.walls.size()]
		if isTileADoor(_tile):
			continue
		else:
			grid[_tile.x][_tile.y].tile = Globals.tiles.DOOR_CLOSED
			_room.walls.erase(_tile)
			return
	push_error("Cant place doors")

func areAllStairsConnected():
	astarNode.clear()
	pathFind(Globals.blockedTiles)
	
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
#						if !isTileAlreadyInARoom(_adjacentTile):
						grid[_adjacentTile.x][_adjacentTile.y].tile = Globals.tiles[_tileType.wall]
	
	# Get walls
	for _room in rooms:
		var _walls = []
		for _floorTile in _room.floors:
			for _tileType in _tileTypes:
				for _adjacentTile in checkAdjacentTilesForTile(_floorTile, [_tileType.wall]):
#					if !isTileAlreadyInARoom(_adjacentTile):
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

func getArea(_tile, _tileType):
	var _areaTiles = [_tile]
	var _adjacentTiles = checkAdjacentTilesForTile(_tile, [_tileType])
	_areaTiles.append_array(_adjacentTiles)
	while !_adjacentTiles.empty():
		for _adjacentTile in checkAdjacentTilesForTile(_adjacentTiles.pop_back(), [_tileType]):
			if !_areaTiles.has(_adjacentTile):
				_adjacentTiles.append(_adjacentTile)
				_areaTiles.append(_adjacentTile)
	return _areaTiles

func fillEmptyTiles(_tile, _fillEdges = null):
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if grid[x][y].tile == -1:
				grid[x][y].tile = Globals.tiles[_tile]
	if _fillEdges != null:
		for x in range(grid.size()):
			if grid[x][0].tile == Globals.tiles.DOOR_CLOSED:
				grid[x][0].tile = Globals.tiles[_fillEdges]
		for x in range(grid.size()):
			if grid[x][grid[x].size() - 1].tile == Globals.tiles.DOOR_CLOSED:
				grid[x][grid[x].size() - 1].tile = Globals.tiles[_fillEdges]
		for y in range(1, grid[0].size() - 1):
			if grid[0][y].tile == Globals.tiles.DOOR_CLOSED:
				grid[0][y].tile = Globals.tiles[_fillEdges]
		for y in range(1, grid[0].size() - 1):
			if grid[grid.size() - 1][y].tile == Globals.tiles.DOOR_CLOSED:
				grid[grid.size() - 1][y].tile = Globals.tiles[_fillEdges]

func placeRandomInteractables(_interactables):
	for _interactable in _interactables:
		match _interactable:
			"altar":
				if randi() % 13 == 0:
					for _i in range(randi() % 2 + 1):
						var _randomSpawnableTile = spawnableItemTiles[randi() % spawnableItemTiles.size()]
						if grid[_randomSpawnableTile.x][_randomSpawnableTile.y].interactable == null:
							grid[_randomSpawnableTile.x][_randomSpawnableTile.y].interactable = Globals.interactables.ALTAR

func resetLevel():
	rooms.clear()
	floors.clear()
	openTiles.clear()
	spawnableItemTiles.clear()
	spawnableCritterTiles.clear()
	stairs.clear()
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			grid[x][y].tile = -1

func cleanOutPremadeTilemap():
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			set_cellv(Vector2(x,y), -1)

func whichTilesAreOpenAndFreeOfCritters(_tile, _distance):
	var _legibleTiles = []
	for x in range(_tile.x - _distance, _tile.x + _distance + 1):
		for y in range(_tile.y - _distance, _tile.y + _distance + 1):
			if isTileOpenAndFreeOfCritters(Vector2(x,y)):
				_legibleTiles.append(Vector2(x,y))
	return _legibleTiles

func isTileOpenAndFreeOfCritters(_tile):
	if Globals.isTileFree(_tile, grid) and isTileFreeOfCritters(_tile):
		return true
	return false

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
	connectAllCells(addLegibleTiles(_illegibleTiles))

func addLegibleTiles(_illegibleTiles):
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
			if isTileIllegibleInPathfind(point, _illegibleTiles):
				continue
			points.append(point)
			astarNode.add_point(id(point), point, 1.0)
	return points

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

func isTileIllegibleInPathfind(_point, _illegibleTiles):
	for _illegibleTile in _illegibleTiles:
		if grid[_point.x][_point.y].tile == _illegibleTile:
			return true
	return false

# Weighted pathfinding
func calculateWeightedPath(pathStartPosition, pathEndPosition):
	return weightedAstarNode.get_point_path(id(pathStartPosition), id(pathEndPosition))

func pathFindWeightedPath(_illegibleTiles, _pointWeighting):
	weightedAstarNode.clear()
	connectAllWeightedCells(addLegibleWeighedTiles(_illegibleTiles, _pointWeighting))

func addLegibleWeighedTiles(_illegibleTiles, _pointWeighting):
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
			if isTileIllegibleInPathfind(point, _illegibleTiles):
				continue
			else:
				var _weight = 1.0
				for _weighting in _pointWeighting:
					if grid[x][y].tile == Globals.tiles[_weighting.tile]:
						_weight = _weighting.weighting
				points.append(point)
				weightedAstarNode.add_point(id(point), point, _weight)
	return points

func connectAllWeightedCells(points):
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
			if not weightedAstarNode.has_point(pointRelativeIndex):
				continue
			weightedAstarNode.connect_points(pointIndex, pointRelativeIndex, true)



################################
### General helper functions ###
################################

func updateTilemapToGrid():
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			set_cellv(Vector2(x, y), Globals.tiles[grid[x][y].tile])

func doFinalPathfinding(_blockedTiles = Globals.blockedTiles):
	pathFind(_blockedTiles)
	enemyPathfinding(grid)

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

func placePresetItems(_items, _level):
	for _item in _items:
		if _item.has("items"):
			if _item.items.types != null:
				if typeof(_item.tiles) == TYPE_VECTOR2_ARRAY:
					for x in range(_item.tiles[0].x, _item.tiles[1].x + 1):
						for y in range(_item.tiles[0].y, _item.tiles[1].y + 1):
							if randi() % 101 <= _item.chance and Globals.isTileFree(Vector2(x, y), grid) and grid[x][y].tile != Globals.tiles.DOOR_CLOSED:
								$"/root/World/Items/Items".createItem(
									$"/root/World/Items/Items".getRandomItemByItemTypes(_item.items.types, _item.items.randomByRarity),
									Vector2(x, y),
									1,
									false,
									{},
									_level
								)
				else:
					if randi() % 101 <= _item.chance and Globals.isTileFree(_item.tiles, grid) and grid[_item.tiles.x][_item.tiles.y].tile != Globals.tiles.DOOR_CLOSED:
						$"/root/World/Items/Items".createItem(
							$"/root/World/Items/Items".getRandomItemByItemTypes(_item.items.types, _item.items.randomByRarity),
							_item.tiles,
							1,
							false,
							{},
							_level
						)
			elif _item.items.names != null:
				if typeof(_item.tiles) == TYPE_VECTOR2_ARRAY:
					for x in range(_item.tiles[0].x, _item.tiles[1].x + 1):
						for y in range(_item.tiles[0].y, _item.tiles[1].y + 1):
							if randi() % 101 <= _item.chance and Globals.isTileFree(Vector2(x, y), grid) and grid[x][y].tile != Globals.tiles.DOOR_CLOSED:
								$"/root/World/Items/Items".createItem(
									_item.items.names[randi() % _item.items.names.size()],
									Vector2(x, y),
									1,
									false,
									{},
									_level
								)
				else:
					if randi() % 101 <= _item.chance and Globals.isTileFree(_item.tiles, grid) and grid[_item.tiles.x][_item.tiles.y].tile != Globals.tiles.DOOR_CLOSED:
						$"/root/World/Items/Items".createItem(
							_item.items.names,
							_item.tiles,
							1,
							false,
							{},
							_level
						)

func placePresetCritters(_critters, _level):
	for _critter in _critters:
		if _critter.has("critters"):
#			if _critter.critters.races != null:
#				if typeof(_critter.tiles) == TYPE_VECTOR2_ARRAY:
#					for x in range(_critter.tiles[0].x, _critter.tiles[1].x + 1):
#						for y in range(_critter.tiles[0].y, _critter.tiles[1].y + 1):
#							if randi() % 101 <= _critter.chance and Globals.isTileFree(Vector2(x, y), grid) and grid[x][y].tile != Globals.tiles.DOOR_CLOSED:
#								$"/root/World/Items/Items".createItem(
#									$"/root/World/Items/Items".getRandomItemByItemTypes(_critter.critters.races, _critter.critters.randomByRarity),
#									Vector2(x, y),
#									false,
#									{},
#									_level,
#									grid
#								)
#				else:
#					if randi() % 101 <= _critter.chance and Globals.isTileFree(_critter.tiles, grid) and grid[_critter.tiles.x][_critter.tiles.y].tile != Globals.tiles.DOOR_CLOSED:
#						$"/root/World/Items/Items".createItem(
#							$"/root/World/Items/Items".getRandomItemByItemTypes(_critter.critters.races, _critter.items.randomByRarity),
#							_critter.tiles,
#							false,
#							{},
#							_level,
#							grid
#						)
			if _critter.critters.names != null:
				if typeof(_critter.tiles) == TYPE_VECTOR2_ARRAY:
					for x in range(_critter.tiles[0].x, _critter.tiles[1].x + 1):
						for y in range(_critter.tiles[0].y, _critter.tiles[1].y + 1):
							if randi() % 101 <= _critter.chance and Globals.isTileFree(Vector2(x, y), grid) and grid[x][y].tile != Globals.tiles.DOOR_CLOSED:
								var _isDeactivated = null
								if _critter.has("isDeactivated"): _isDeactivated = _critter.isDeactivated
								$"/root/World/Critters/Critters".spawnCritter(
									_critter.critters.names[randi() % _critter.critters.names.size()],
									Vector2(x, y),
									_isDeactivated,
									_level
								)
				else:
					if randi() % 101 <= _critter.chance and Globals.isTileFree(_critter.tiles, grid) and grid[_critter.tiles.x][_critter.tiles.y].tile != Globals.tiles.DOOR_CLOSED:
						var _isDeactivated = null
						if _critter.has("isDeactivated"): _isDeactivated = _critter.isDeactivated
						$"/root/World/Critters/Critters".spawnCritter(
							_critter.critters.names,
							_critter.tiles,
							_isDeactivated,
							_level
						)

func isTileAlreadyInARoom(_tile):
	for _room in rooms:
		for _floor in _room.floors:
			if _floor == _tile:
				return true
		for _wall in _room.walls:
			if _wall == _tile:
				return true
	return false

func isTileAlreadyInAnArea(_tile):
	for _area in areas:
		for _floor in _area:
			if _floor == _tile:
				return true
	return false
