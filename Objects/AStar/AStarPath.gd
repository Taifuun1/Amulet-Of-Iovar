extends TileMap
class_name AStarPath

onready var astarNode = AStar2D.new()

func _ready():
	pass

func calculatePath(pathStartPosition, pathEndPosition):
	var pathStartPointIndex = id(pathStartPosition)
	var pathEndPointIndex = id(pathEndPosition)
	return astarNode.get_point_path(pathStartPointIndex, pathEndPointIndex)

func pathFind(grid, tiles):
	astarNode.clear()
	var walkableTiles = addWalkableTiles(grid, tiles)
	connectWalkableCells(walkableTiles, grid)

func addWalkableTiles(grid, tiles):
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
			astarNode.add_point(id(point), point, 1.0)
	return points

func connectWalkableCells(points, grid):
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
			if not astarNode.has_point(pointRelativeIndex):
				continue
			astarNode.connect_points(pointIndex, pointRelativeIndex, true)

func isOutSideTileMap(point, grid):
	return point.x < 0 or point.y < 0 or point.x >= grid.size() or point.y >= grid[0].size()

func id(point):
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b
