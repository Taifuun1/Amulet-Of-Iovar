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
	for _x in range(Globals.gridSize.x):
		grid.append([])
		for _y in range(Globals.gridSize.y):
			grid[_x].append({
				"tile": _tile,
				"critter": null,
				"items": [],
				"interactable": null
			})

func getGenerationGrid():
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			grid[x][y].tile = get_cellv(Vector2(x,y))

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

func getSpawnableFloors():
	for x in Globals.gridSize.x:
		for y in Globals.gridSize.y:
			if grid[x][y].tile == Globals.tiles.CORRIDOR:
				spawnableFloors.append(Vector2(x, y))

func placeStairs(_stairType = "DUNGEON", _isDouble = false):
	stairs["downStair"] = placeStair("downStair", "DOWN_STAIR_", _stairType)
	if _isDouble:
		stairs["secondDownStair"] = placeStair("secondDownStair", "DOWN_STAIR_", _stairType)
	stairs["upStair"] = placeStair("secondDownStair", "UP_STAIR_", _stairType)
	for _stair in stairs:
		grid[_stair.x][_stair.y].interactable = null

func placeStair(_stairName, _stairTile, _stairType):
	for _i in range(20):
		var _stair = spawnableFloors[randi() % spawnableFloors.size()]
		if !isTileAStair(_stair):
			var _previousTile = grid[_stair.x][_stair.y]
			grid[_stair.x][_stair.y].tile = Globals.tiles[_stairTile + "{type}".format({ "type": _stairType })]
			return _stair
	push_error("Dungeon generation failed, can't place stairs")

func areAllStairsConnected():
	astarNode.clear()
	pathFind([
		Globals.tiles.EMPTY,
		Globals.tiles.WALL_DUNGEON,
		Globals.tiles.WALL_SAND,
		Globals.tiles.WALL_BRICK_SAND,
		Globals.tiles.WALL_BOARD
	])
	
	for startStair in stairs.values():
		for endStair in stairs.values():
			if startStair == endStair:
				continue
			if calculatePath(startStair, endStair).size() == 0:
				return false
	return true

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
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			grid[x][y].tile = -1

func isTileFree(_tile):
	if grid[_tile.x][_tile.y].critter == null:
		return true
	return false

func isTileAStair(_newStair):
	for _stair in stairs.values():
		if _newStair == _stair:
			return true
	return false

func isTileDoor(_position):
	for _room in rooms:
		for _door in _room.doors:
			if _door == _position:
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
			if isOutSideTileMap(pointRelative, grid):
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
		if !$"/root/World".level.isOutSideTileMap(_checkedTilePosition, $"/root/World".level.grid):
			var _checkedTileInGrid = $"/root/World".level.grid[_checkedTilePosition.x][_checkedTilePosition.y]
			if (
				_checkedTileInGrid.tile != Globals.tiles.EMPTY and
				_checkedTileInGrid.tile != Globals.tiles.WALL_DUNGEON and
				_checkedTileInGrid.tile != Globals.tiles.WALL_SAND and
				_checkedTileInGrid.tile != Globals.tiles.WALL_BRICK_SAND and
				_checkedTileInGrid.tile != Globals.tiles.WALL_BOARD
			):
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
