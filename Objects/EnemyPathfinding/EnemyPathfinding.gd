extends TileMap
class_name EnemyPathfinding

onready var pathFindingAstarNode = AStar2D.new()

func _ready():
	pass



############################
### Critters pathfinding ###
############################

func calculatePathFindingPath(pathStartPosition, pathEndPosition):
	return pathFindingAstarNode.get_point_path(id(pathStartPosition), id(pathEndPosition))

func enemyPathfinding(grid):
	pathFindingAstarNode.clear()
	var walkableTiles = addWalkableTiles(grid)
	connectWalkableCells(walkableTiles)
	disableCritterCells(grid, walkableTiles)

func addWalkableTiles(grid):
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
			if !Globals.isTileFree(point, grid) or grid[point.x][point.y].tile == Globals.tiles.DOOR_CLOSED:
				continue
			points.append(point)
			pathFindingAstarNode.add_point(id(point), point, 1.0)
	return points

func connectWalkableCells(points):
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
			if not pathFindingAstarNode.has_point(pointRelativeIndex):
				continue
			pathFindingAstarNode.connect_points(pointIndex, pointRelativeIndex, true)

func disableCritterCells(grid, points):
	for point in points:
		if grid[point.x][point.y].critter != null and grid[point.x][point.y].critter != 0:
			removePointFromEnemyPathfinding(point)

func addPointToEnemyPathding(point):
	var _pointId = id(point)
	if pathFindingAstarNode.has_point(_pointId):
		pathFindingAstarNode.set_point_disabled(_pointId, false)
	else:
		pathFindingAstarNode.add_point(_pointId, point, 1.0)
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
			if not pathFindingAstarNode.has_point(pointRelativeIndex):
				continue
			pathFindingAstarNode.connect_points(_pointId, pointRelativeIndex, true)

func removePointFromEnemyPathfinding(point):
	if pathFindingAstarNode.has_point(id(point)):
		pathFindingAstarNode.set_point_disabled(id(point), true)



########################
### Helper functions ###
########################

func isOutSideTileMap(point):
	return point.x < 0 or point.y < 0 or point.x >= Globals.gridSize.x or point.y >= Globals.gridSize.y

func hasPoint(point):
	return pathFindingAstarNode.has_point(id(point))

func id(point):
	var a = point.x
	var b = point.y
	return (a + b) * (a + b + 1) / 2 + b
