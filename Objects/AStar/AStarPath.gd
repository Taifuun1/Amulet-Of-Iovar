extends TileMap
class_name AStarPath

onready var pathFindingAstarNode = AStar2D.new()
onready var corridorsAstarNode = AStar2D.new()
onready var caveAstarNode = AStar2D.new()

func _ready():
	pass


# Critters pathfinding
func calculatePathFindingPath(pathStartPosition, pathEndPosition):
	return pathFindingAstarNode.get_point_path(id(pathStartPosition), id(pathEndPosition))

# Mines pathfinding
func calculateCavePath(pathStartPosition, pathEndPosition):
	return caveAstarNode.get_point_path(id(pathStartPosition), id(pathEndPosition))

# Corridors pathfinding
func calculateCorridorsPath(pathStartPosition, pathEndPosition):
	return corridorsAstarNode.get_point_path(id(pathStartPosition), id(pathEndPosition))


# Cave creation
func pathFindCave(grid):
	caveAstarNode.clear()
	var caveTiles = addAlltiles(grid)
	connectAllCells(caveTiles, grid, true)
	addCaveDividers(grid)

func addAlltiles(grid):
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
			points.append(point)
			caveAstarNode.add_point(id(point), point, 1.0)
	return points

func connectAllCells(points, grid, aStarGrid = false):
	for point in points:
		var pointIndex = id(point)
		var pointsRelative
		if aStarGrid:
			pointsRelative = PoolVector2Array([
				Vector2(point.x, point.y - 1),
				Vector2(point.x + 1, point.y),
				Vector2(point.x, point.y + 1),
				Vector2(point.x - 1, point.y)
			])
		else:
			pointsRelative = PoolVector2Array([
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
			if not caveAstarNode.has_point(pointRelativeIndex):
				continue
			caveAstarNode.connect_points(pointIndex, pointRelativeIndex, true)

func addCaveDividers(_grid):
	var _verticalDividers = [
		{
			"length": randi() % 10 + 10,
			"startPos": Vector2(randi() % 10 + 0, 12)
		},
		{
			"length": randi() % 9 + 13,
			"startPos": Vector2(randi() % 14 + 14, 12)
		},
		{
			"length": randi() % 4 + 8,
			"startPos": Vector2(randi() % 3 + 40, 12)
		}
	]
	var _horizontalDividers = [
		{
			"length": randi() % 3 + 10,
			"startPos": Vector2(20, randi() % 7 + 0)
		},
		{
			"length": randi() % 3 + 7,
			"startPos": Vector2(20, randi() % 3 + 12)
		},
		{
			"length": randi() % 3 + 10,
			"startPos": Vector2(40, randi() % 7 + 0)
		},
		{
			"length": randi() % 3 + 7,
			"startPos": Vector2(40, randi() % 3 + 12)
		}
	]
	for _verticalDivider in _verticalDividers:
		for _number in range(_verticalDivider.length):
			var _point = id(Vector2(_verticalDivider.startPos.x + _number, _verticalDivider.startPos.y))
			if caveAstarNode.has_point(_point):
				caveAstarNode.remove_point(_point)
	for _horizontalDivider in _horizontalDividers :
		for _number in range(_horizontalDivider.length):
			var _point = id(Vector2(_horizontalDivider.startPos.x, _horizontalDivider.startPos.y + _number))
			if caveAstarNode.has_point(_point):
				caveAstarNode.remove_point(_point)


# Enemy pathfinding
func enemyPathFinding(grid):
	pathFindingAstarNode.clear()
	var walkableTiles = addWalkableTiles(grid)
	connectWalkableCells(walkableTiles, grid)

func addWalkableTiles(grid):
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
			if (
				grid[point.x][point.y].tile == Globals.tiles.EMPTY or
				grid[point.x][point.y].tile == Globals.tiles.WALL or
				grid[point.x][point.y].tile == Globals.tiles.UP_STAIR or
				grid[point.x][point.y].tile == Globals.tiles.DOWN_STAIR
			):
				continue
			points.append(point)
			pathFindingAstarNode.add_point(id(point), point, 1.0)
	return points

func connectWalkableCells(points, grid):
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
			if not pathFindingAstarNode.has_point(pointRelativeIndex):
				continue
			pathFindingAstarNode.connect_points(pointIndex, pointRelativeIndex, true)


# Dungeon corridors creation
func pathFindCorridors(grid):
	corridorsAstarNode.clear()
	var corridorTiles = addCorridorTiles(grid)
	connectCorridorCells(corridorTiles, grid)

func addCorridorTiles(grid):
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
			if (
				grid[point.x][point.y].tile == Globals.tiles.WALL or
				grid[point.x][point.y].tile == Globals.tiles.FLOOR or
				grid[point.x][point.y].tile == Globals.tiles.GRASS or
				grid[point.x][point.y].tile == Globals.tiles.UP_STAIR or
				grid[point.x][point.y].tile == Globals.tiles.DOWN_STAIR
			):
				continue
			points.append(point)
			corridorsAstarNode.add_point(id(point), point, 1.0)
	return points

func connectCorridorCells(points, grid):
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


# Helper functions
func isOutSideTileMap(point, grid):
	return point.x < 0 or point.y < 0 or point.x >= grid.size() or point.y >= grid[0].size()

func hasPoint(point):
	return pathFindingAstarNode.has_point(id(point))

func id(point):
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b


func placeStairs(_grid, _spawnableFloors, _isDouble = false):
	var downStair = _spawnableFloors[randi() % _spawnableFloors.size() - 1]
	var secondDownStair
	var upStair
	var stairs = {
		"downStair": null,
		"secondDownStair": null,
		"upStair": null
	}
	
	_grid[downStair.x][downStair.y].tile = Globals.tiles.DOWN_STAIR
	stairs.downStair = downStair
	if _isDouble:
		while true:
			secondDownStair = _spawnableFloors[randi() % _spawnableFloors.size() - 1]
			if downStair != secondDownStair:
				_grid[secondDownStair.x][secondDownStair.y].tile = Globals.tiles.DOWN_STAIR
				stairs.secondDownStair = secondDownStair
				break
	while true:
		upStair = _spawnableFloors[randi() % _spawnableFloors.size() - 1]
		if downStair != upStair:
			_grid[upStair.x][upStair.y].tile = Globals.tiles.UP_STAIR
			stairs.upStair = upStair
			break
	
	return stairs
