extends TileMap
class_name EnemyPathfinding

onready var pathFindingAstarNode = AStar2D.new()
onready var caveAstarNode = AStar2D.new()

func _ready():
	pass


# Critters pathfinding
func calculatePathFindingPath(pathStartPosition, pathEndPosition):
	return pathFindingAstarNode.get_point_path(id(pathStartPosition), id(pathEndPosition))


# Enemy pathfinding
func enemyPathfinding(grid):
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
				grid[point.x][point.y].tile == Globals.tiles.WALL_DUNGEON or
				grid[point.x][point.y].tile == Globals.tiles.WALL_SAND or
				grid[point.x][point.y].tile == Globals.tiles.WALL_BRICK_SAND or
				grid[point.x][point.y].tile == Globals.tiles.WALL_BOARD
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

func addPointToEnemyPathding(point):
	pathFindingAstarNode.set_point_disabled(id(point), false)

func removePointFromEnemyPathfinding(point):
	pathFindingAstarNode.set_point_disabled(id(point), true)


# Helper functions
func isOutSideTileMap(point, grid):
	return point.x < 0 or point.y < 0 or point.x >= grid.size() or point.y >= grid[0].size()

func hasPoint(point):
	return pathFindingAstarNode.has_point(id(point))

func id(point):
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b
