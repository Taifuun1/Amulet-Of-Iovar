extends TileMap
class_name AStarPath

onready var pathFindingAstarNode = AStar2D.new()
onready var corridorsAstarNode = AStar2D.new()

func _ready():
	pass

func calculatePathFindingPath(pathStartPosition, pathEndPosition):
	var pathStartPointIndex = id(pathStartPosition)
	var pathEndPointIndex = id(pathEndPosition)
	return pathFindingAstarNode.get_point_path(pathStartPointIndex, pathEndPointIndex)

func calculateCorridorsPath(pathStartPosition, pathEndPosition):
	return corridorsAstarNode.get_point_path(id(pathStartPosition), id(pathEndPosition))

func pathFindPathFinding(grid, tiles):
	pathFindingAstarNode.clear()
	var walkableTiles = addWalkableTiles(grid, tiles)
	connectWalkableCells(walkableTiles, grid)

func pathFindCorridors(grid, tiles):
	corridorsAstarNode.clear()
	var corridorTiles = addCorridorTiles(grid, tiles)
	connectCorridorCells(corridorTiles, grid)

func addWalkableTiles(grid, tiles):
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
			if (
				grid[point.x][point.y].tile == tiles.EMPTY or
				grid[point.x][point.y].tile == tiles.WALL or
				grid[point.x][point.y].tile == tiles.UP_STAIR or
				grid[point.x][point.y].tile == tiles.DOWN_STAIR
			):
				continue
			points.append(point)
			pathFindingAstarNode.add_point(id(point), point, 1.0)
	return points

func addCorridorTiles(grid, tiles):
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
			if (
				grid[point.x][point.y].tile == tiles.WALL or
				grid[point.x][point.y].tile == tiles.FLOOR or
				grid[point.x][point.y].tile == tiles.FOUNTAIN or
				grid[point.x][point.y].tile == tiles.UP_STAIR or
				grid[point.x][point.y].tile == tiles.DOWN_STAIR
			):
				continue
			points.append(point)
			corridorsAstarNode.add_point(id(point), point, 1.0)
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

func isOutSideTileMap(point, grid):
	return point.x < 0 or point.y < 0 or point.x >= grid.size() or point.y >= grid[0].size()

func id(point):
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b
