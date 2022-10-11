extends BaseLevel
class_name GenericLevel

onready var corridorsAstarNode = AStar2D.new()



###########################################
### Dungeon generation helper functions ###
###########################################

func placeRoom(_position, _size, _tileset = { "wall": "WALL_DUNGEON", "floor": "FLOOR_DUNGEON" }):
	for x in range(_position.x, _position.x + _size.x):
		for y in range(_position.y, _position.y + _size.y):
			grid[x][y].interactable = null
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
			else:
				grid[x][y].tile = Globals.tiles[_tileset.floor]
	rooms.append({
		"position": _position,
		"size": _size,
		"doors": []
	})

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
	if !isTileLegible(Vector2(_tilePosition.x - 1, _tilePosition.y + _roomSizeY), _legibleTiles):
		return 0
	for _roomSizeX in range(_roomSizeMax.x):
		var _checkedTilePositions = [
			Vector2(_tilePosition.x + _roomSizeX, _tilePosition.y + _roomSizeY),
			Vector2(_tilePosition.x + _roomSizeX + 1, _tilePosition.y + _roomSizeY),
			Vector2(_tilePosition.x + _roomSizeX, _tilePosition.y + _roomSizeY + 1),
			Vector2(_tilePosition.x + _roomSizeX, _tilePosition.y + _roomSizeY - 1)
		]
		if !areTilesLegible(_checkedTilePositions, _legibleTiles):
			return _checkedTilePositions[0].x - _tilePosition.x - 1
	return _roomSizeMax.x

func areTilesLegible(_positions, _legibleTiles):
	for _position in _positions:
		if isTileLegible(_position, _legibleTiles):
			continue
		else:
			return false
	return true

func isTileLegible(_position, _legibleTiles):
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
			if isTileADoor2(_position):
				continue
			else:
				grid[_position.x][_position.y].tile = Globals.tiles.DOOR_CLOSED
				rooms.back().doors.append(_position)
				break

func isTileADoor2(_position):
	for _room in rooms:
		for _door in _room.doors:
			if _door == _position:
				return true
	return false



#######################
### Astar functions ###
#######################

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
			if isOutSideTileMap(pointRelative):
				continue
			if not corridorsAstarNode.has_point(pointRelativeIndex):
				continue
			corridorsAstarNode.connect_points(pointIndex, pointRelativeIndex, true)
