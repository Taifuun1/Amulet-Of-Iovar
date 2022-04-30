extends AStarPath

var tiles

var dungeonType = "minesOfTidoh"

var level
var grid = []
var caverns = []
var spawnableFloors = []
var spawnPoints = []
var stairs = {}

var critters = []

func setName():
	level = Globals.levelId
	name = str(Globals.levelId)
	Globals.levelId += 1

func createNewLevel(_tiles):
	tiles = _tiles
	
	# Create rooms with doors and staircases
	for _x in range(Globals.gridSize.x):
		grid.append([])
		for _y in range(Globals.gridSize.y):
			grid[_x].append({
				"tile": tiles.EMPTY,
				"critter": null,
				"items": []
			})
	
	createCave()
	connectSpawnAreas()
	expandSpawnAreas()
	fattenCorridors()
	stairs = placeStairs(grid, tiles, spawnableFloors, false)
	
	enemyPathFinding(grid, tiles)
	
	return self

func createCave():
	var _spawnAreas = {
		1: Vector2(2,2),
		2: Vector2(2,14),
		3: Vector2(22,2),
		4: Vector2(22,14),
		5: Vector2(42,2),
		6: Vector2(42,14),
	}
	
	for _spawnArea in _spawnAreas.values():
		spawnPoints.append(Vector2(randi() % 15 + _spawnArea.x, randi() % 8 + int(_spawnArea.y)))

func connectSpawnAreas():
	pathFindCave(grid, tiles)
	
	calculateCavePath(spawnPoints[0], spawnPoints[1])
	calculateCavePath(spawnPoints[2], spawnPoints[3])
	calculateCavePath(spawnPoints[4], spawnPoints[5])
	
	var _endPoint = option(spawnPoints[1], spawnPoints[2], spawnPoints[3])
	drawPath(calculateCavePath(spawnPoints[0], _endPoint))
	_endPoint = option(spawnPoints[0], spawnPoints[2], spawnPoints[3])
	drawPath(calculateCavePath(spawnPoints[1], _endPoint))
	_endPoint = option(spawnPoints[2], spawnPoints[2], spawnPoints[3], spawnPoints[3])
	if randi() % 1 + 0 == 1:
		drawPath(calculateCavePath(spawnPoints[0], _endPoint))
	else:
		drawPath(calculateCavePath(spawnPoints[1], _endPoint))
	
	_endPoint = option(spawnPoints[0], spawnPoints[1], spawnPoints[4], spawnPoints[5])
	drawPath(calculateCavePath(spawnPoints[2], _endPoint))
	drawPath(calculateCavePath(spawnPoints[3], _endPoint))
	
	_endPoint = option(spawnPoints[2], spawnPoints[3], spawnPoints[5])
	drawPath(calculateCavePath(spawnPoints[4], _endPoint))
	_endPoint = option(spawnPoints[2], spawnPoints[3], spawnPoints[4])
	drawPath(calculateCavePath(spawnPoints[5], _endPoint))
	_endPoint = option(spawnPoints[2], spawnPoints[2], spawnPoints[3], spawnPoints[3])
	if randi() % 1 + 0 == 1:
		drawPath(calculateCavePath(spawnPoints[4], _endPoint))
	else:
		drawPath(calculateCavePath(spawnPoints[5], _endPoint))

func expandSpawnAreas():
	var _positions = []
	
	for spawnPoint in spawnPoints:
		# Get the rectangle bounding the circle
		var radiusVec = Vector2(randi() % 2 + 2, randi() % 2 + 2)
		var minPos = (Vector2() - radiusVec).floor()
		var maxPos = (spawnPoint + radiusVec).ceil()

		# Convert to integer so we can use range for loop
		var minX
		if minPos.x < 0:
			 minX = 0
		else:
			 minX = int(minPos.x)
		var maxX = int(maxPos.x)
		if maxPos.x >= Globals.gridSize.x:
			 maxX = Globals.gridSize.x
		else:
			 maxX = int(maxPos.x)
		var minY
		if minPos.y < 0:
			 minY = 0
		else:
			 minY = int(minPos.y)
		var maxY
		if maxPos.y >= Globals.gridSize.y:
			 maxY = Globals.gridSize.y
		else:
			 maxY = int(maxPos.y)

		# Gather all points that are within the radius
		for x in range(minX, maxX):
			for y in range(minY, maxY):
				if Vector2(x, y).distance_to(spawnPoint) < radiusVec.x and Vector2(x, y).distance_to(spawnPoint) < radiusVec.y:
					_positions.append(Vector2(x, y))
	
	draw(_positions)

func fattenCorridors():
	pass

func option(_first, _second_, _third, _fourth = null):
	if _fourth == null:
		var random = randi() % 2 + 0
		if random == 0:
			return _first
		if random == 1:
			return _second_
		if random == 2:
			return _third
	else:
		var random = randi() % 3 + 0
		if random == 0:
			return _first
		if random == 1:
			return _second_
		if random == 2:
			return _third
		if random == 3:
			return _fourth

func drawPath(_path):
	var _lastPoint = null
	var _pathRadius = randi() % 3 + 2
	for point in _path:
		grid[point.x][point.y].tile = tiles.FLOOR
		spawnableFloors.append(Vector2(point.x, point.y))
		if _lastPoint == null:
			_lastPoint = point
		var _direction = point - _lastPoint
		if _direction == Vector2(1,0) or _direction == Vector2(-1,0):
			for number in range(_pathRadius):
				if point.y + number < Globals.gridSize.y:
					grid[point.x][point.y + number].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x, point.y + number))
				if point.y - number >= 0:
					grid[point.x][point.y - number].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x, point.y - number))
		elif _direction == Vector2(1,-1):
			for number in range(_pathRadius):
				if point.y - int(number / 2) >= 0:
					grid[point.x][point.y - int(number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x, point.y - int(number / 2)))
				if point.x + int(number / 2) < Globals.gridSize.x:
					grid[point.x + int(number / 2)][point.y].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x + int(number / 2), point.y))
				if point.x - int(number / 2) >= 0 and point.y - int(number / 2) >= 0:
					grid[point.x - int(number / 2)][point.y - int(number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x - int(number / 2), point.y - int(number / 2)))
				if point.x + int (number / 2) < Globals.gridSize.x and point.y + int(number / 2) < Globals.gridSize.y:
					grid[point.x + int(number / 2)][point.y + int(number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x + int(number / 2), point.y + int(number / 2)))
		elif _direction == Vector2(-1,1):
			for number in range(_pathRadius):
				if point.y + (number / 2) < Globals.gridSize.y:
					grid[point.x][point.y + (number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x, point.y + (number / 2)))
				if point.x - (number / 2) >= 0:
					grid[point.x - (number / 2)][point.y].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x - (number / 2), point.y))
				if point.x - (number / 2) >= 0 and point.y - (number / 2) >= 0:
					grid[point.x - (number / 2)][point.y - (number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x - (number / 2), point.y - (number / 2)))
				if point.x + (number / 2) < Globals.gridSize.x and point.y + (number / 2) < Globals.gridSize.y:
					grid[point.x + (number / 2)][point.y + (number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x + (number / 2), point.y + (number / 2)))
		elif _direction == Vector2(-1,-1):
			for number in range(_pathRadius):
				if point.x - (number / 2) >= 0:
					grid[point.x - (number / 2)][point.y].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x - (number / 2), point.y))
				if point.y - (number / 2) >= 0:
					grid[point.x][point.y - (number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x, point.y - (number / 2)))
				if point.x - (number / 2) >= 0 and point.y + (number / 2) < Globals.gridSize.y:
					grid[point.x - (number / 2)][point.y + (number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x - (number / 2), point.y + (number / 2)))
				if point.x + (number / 2) < Globals.gridSize.x and point.y - (number / 2) >= 0:
					grid[point.x + (number / 2)][point.y - (number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x + (number / 2), point.y - (number / 2)))
		elif _direction == Vector2(1,1):
			for number in range(_pathRadius):
				if point.x + (number / 2) < Globals.gridSize.y:
					grid[point.x - (number / 2)][point.y].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x - (number / 2), point.y))
				if point.y + (number / 2) < Globals.gridSize.y:
					grid[point.x][point.y - (number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x, point.y - (number / 2)))
				if point.x - (number / 2) >= 0 and point.y + (number / 2) < Globals.gridSize.y:
					grid[point.x - (number / 2)][point.y + (number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x - (number / 2), point.y + (number / 2)))
				if point.x + (number / 2) < Globals.gridSize.x and point.y - (number / 2) >= 0:
					grid[point.x + (number / 2)][point.y - (number / 2)].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x + (number / 2), point.y - (number / 2)))
		elif _direction == Vector2(0,1) or _direction == Vector2(0,-1):
			for number in range(_pathRadius):
				if point.x + number < Globals.gridSize.x:
					grid[point.x + number][point.y].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x + number, point.y))
				if point.x - number >= 0:
					grid[point.x - number][point.y].tile = tiles.FLOOR
					spawnableFloors.append(Vector2(point.x - number, point.y))
		if randi() % 6 == 1:
			if _pathRadius < 4:
				_pathRadius += 1
		elif randi() % 6 == 1:
			if _pathRadius > 2:
				_pathRadius -= 1
		_lastPoint = point

func draw(_path):
	for point in _path:
		grid[point.x][point.y].tile = tiles.FLOOR
		spawnableFloors.append(Vector2(point.x, point.y))
