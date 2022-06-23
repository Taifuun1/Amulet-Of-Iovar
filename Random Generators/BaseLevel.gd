extends EnemyPathfinding
class_name BaseLevel

onready var astarNode = AStar2D.new()
onready var corridorsAstarNode = AStar2D.new()

var levelId
var dungeonType
var dungeonLevelName

var grid = []
var rooms = []
var spawnableFloors = []
var stairs = {}

var critters = []

func create(_dungeonType, _dungeonLevelName):
	levelId = Globals.levelId
	name = str(Globals.levelId)
	Globals.levelId += 1
	dungeonType = _dungeonType
	dungeonLevelName = _dungeonLevelName



# Dungeon generation helper functions

func createGrid(_tile = Globals.tiles.EMPTY):
	for _x in range(Globals.gridSize.x):
		grid.append([])
		for _y in range(Globals.gridSize.y):
			grid[_x].append({
				"tile": _tile,
				"critter": null,
				"items": []
			})

func placeCritter(_tile, _critter):
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

func placeRoom(_position, _size, _tileset = { "wall": "WALL_DUNGEON", "floor": "FLOOR_DUNGEON" }, isSpawnable = false):
	for x in range(_position.x, _position.x + _size.x):
		for y in range(_position.y, _position.y + _size.y):
			if (
				(
					x == _position.x and 
					(
						y >= _position.y and
						y < _position.y + _size.y
					)
				) or
				(
					x == _position.x + _size.x - 1 and 
					(
						y >= _position.y and
						y < _position.y + _size.y
					)
				) or
				(
					y == _position.y and 
					(
						x >= _position.x and
						x < _position.x + _size.x
					)
				) or
				(
					y == _position.y + _size.y - 1 and 
					(
						x >= _position.x and
						x < _position.x + _size.x
					)
				)
			):
				grid[x][y].tile = Globals.tiles[_tileset.wall]
				if spawnableFloors.has(Vector2(x, y)):
					spawnableFloors.erase(Vector2(x, y))
			else:
				grid[x][y].tile = Globals.tiles[_tileset.floor]
				if isSpawnable:
					spawnableFloors.append(Vector2(x, y))
				elif spawnableFloors.has(Vector2(x, y)):
					spawnableFloors.erase(Vector2(x, y))
	rooms.append({
		"position": _position,
		"size": _size,
		"doors": []
	})

func placeDoors(_doors):
	var _room = rooms.back()
	var _position
	for _door in range(randi() % (_doors[1] - _doors[0] + 1) + _doors[0]):
		while true:
			if randi() % 2 == 0:
				if randi() % 2 == 0:
					_position = Vector2(
						randi() % (int(_room.size.x) - 2) + (int(_room.position.x) + 1),
						int(_room.position.y)
					)
				else:
					_position = Vector2(
						randi() % (int(_room.size.x) - 2) + (int(_room.position.x) + 1),
						int(_room.position.y) + int(_room.size.y) - 1
					)
			else:
				if randi() % 2 == 0:
					_position = Vector2(
						int(_room.position.x),
						randi() % (int(_room.size.y) - 2) + (int(_room.position.y) + 1)
					)
				else:
					_position = Vector2(
						int(_room.position.x) + int(_room.size.x) - 1,
						randi() % (int(_room.size.y) - 2) + (int(_room.position.y) + 1)
					)
			if isTileDoor(_position):
				continue
			else:
				grid[_position.x][_position.y].tile = Globals.tiles.CLOSED_DOOR
				rooms.back().doors.append(_position)
				break

func isTileDoor(_position):
	for _room in rooms:
		for _door in _room.doors:
			if _door == _position:
				return true
	return false

func placeStairs(_stairType = "DUNGEON", _isDouble = false):
	var downStair = spawnableFloors[randi() % spawnableFloors.size() - 1]
	var secondDownStair
	var upStair
	var _stairs = {
		"downStair": null,
		"secondDownStair": null,
		"upStair": null
	}
	
	grid[downStair.x][downStair.y].tile = Globals.tiles["DOWN_STAIR_{type}".format({ "type": _stairType })]
	_stairs.downStair = downStair
	if _isDouble:
		while true:
			secondDownStair = spawnableFloors[randi() % spawnableFloors.size() - 1]
			if downStair != secondDownStair:
				grid[secondDownStair.x][secondDownStair.y].tile = Globals.tiles["DOWN_STAIR_{type}".format({ "type": _stairType })]
				_stairs.secondDownStair = secondDownStair
				break
	while true:
		upStair = spawnableFloors[randi() % spawnableFloors.size() - 1]
		if downStair != upStair:
			grid[upStair.x][upStair.y].tile = Globals.tiles["UP_STAIR_{type}".format({ "type": _stairType })]
			_stairs.upStair = upStair
			break
	
	stairs = _stairs

# Get locations and sizes of legible rooms on level
func getAllLegibleRoomLocations(_legibleTiles, _roomSizeMin, _roomSizeMax):
	var _legibleLocations = []
	for y in grid[0].size():
		for x in grid.size():
			var _isLegibleLocation = isRoomFromTileLegible(Vector2(x, y), _legibleTiles, _roomSizeMin, _roomSizeMax)
			if _isLegibleLocation.legible:
				_legibleLocations.append({
					"position": Vector2(x, y),
					"size": _isLegibleLocation.size
				})
	return _legibleLocations

func isRoomFromTileLegible(_tilePosition, _legibleTiles, _roomSizeMin, _roomSizeMax):
	var _legibleRoomWidth = _roomSizeMax.x
	for _roomSizeY in range(_roomSizeMax.y):
		var _howLongIsLegibleRowLength = howLongIsLegibleRow(_tilePosition, _roomSizeY, _legibleTiles, _roomSizeMin, _roomSizeMax)
		if _howLongIsLegibleRowLength < _roomSizeMin.x:
			if _legibleRoomWidth >= _roomSizeMin.x and _roomSizeY >= _roomSizeMin.y:
				return {
					"legible": true,
					"size": Vector2(_legibleRoomWidth, _roomSizeY)
				}
			else:
				return {
					"legible": false,
					"size": null
				}
		if _howLongIsLegibleRowLength < _legibleRoomWidth:
			_legibleRoomWidth = _howLongIsLegibleRowLength
	return {
		"legible": true,
		"size": Vector2(_legibleRoomWidth, _roomSizeMax.y)
	}

func howLongIsLegibleRow(_tilePosition, _roomSizeY, _legibleTiles, _roomSizeMin, _roomSizeMax):
	for _roomSizeX in range(_roomSizeMax.x):
		var _checkedTilePosition = Vector2(_tilePosition.x + _roomSizeX, _tilePosition.y + _roomSizeY)
		var _isLegibleTile = isTileLegible(_legibleTiles, _checkedTilePosition)
		if !_isLegibleTile:
			return _checkedTilePosition.x - _tilePosition.x - 1
	return _roomSizeMax.x

func isTileLegible(_legibleTiles, _position):
	if (
		_position.x == 0 or
		_position.y == 0 or
		_position.x >= Globals.gridSize.x - 1 or
		_position.y >= Globals.gridSize.y - 1
	):
		return false
	for _legibleTile in _legibleTiles:
		if grid[_position.x][_position.y].tile == _legibleTile:
			return true
	return false



# Astar functions

# Dungeon corridors pathfinding
func calculateCorridorsPath(pathStartPosition, pathEndPosition):
	return corridorsAstarNode.get_point_path(id(pathStartPosition), id(pathEndPosition))

# Dungeon corridors pathfinding creation
func pathfindDungeonCorridors():
	corridorsAstarNode.clear()
	var _corridorTiles = addCorridorTiles()
	connectCorridorCells(_corridorTiles)

func addCorridorTiles():
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
			if (
				grid[point.x][point.y].tile == Globals.tiles.WALL_DUNGEON or
				grid[point.x][point.y].tile == Globals.tiles.FLOOR_DUNGEON or
				grid[point.x][point.y].tile == Globals.tiles.GRASS or
				grid[point.x][point.y].tile == Globals.tiles.UP_STAIR_DUNGEON or
				grid[point.x][point.y].tile == Globals.tiles.DOWN_STAIR_DUNGEON
			):
				continue
			points.append(point)
			corridorsAstarNode.add_point(id(point), point, 1.0)
	return points

func connectCorridorCells(points):
	for point in points:
		var pointIndex = id(point)
		var pointsRelative = PoolVector2Array([
			Vector2(point.x + 1, point.y),
			Vector2(point.x - 1, point.y),
			Vector2(point.x, point.y + 1),
			Vector2(point.x, point.y - 1)
		])
		for pointRelative in pointsRelative:
			var pointRelativeIndex = id(pointRelative)
			if isOutSideTileMap(pointRelative, grid):
				continue
			if not corridorsAstarNode.has_point(pointRelativeIndex):
				continue
			corridorsAstarNode.connect_points(pointIndex, pointRelativeIndex, true)

# General pathfinding
func calculatePath(pathStartPosition, pathEndPosition):
	return astarNode.get_point_path(id(pathStartPosition), id(pathEndPosition))

func pathFind():
	astarNode.clear()
	connectAllCells(addAlltiles())

func addAlltiles():
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
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
			if isOutSideTileMap(pointRelative, grid):
				continue
			if not astarNode.has_point(pointRelativeIndex):
				continue
			astarNode.connect_points(pointIndex, pointRelativeIndex, true)
