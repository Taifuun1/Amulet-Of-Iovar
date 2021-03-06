extends BaseLevel
class_name Beach

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	enemyPathfinding(grid)
	
	return self

func createDungeon():
	createSea()
	placeStairs("SAND", false)

func createSea():
	var _connectionPoints = []
	var _seaSide
	
	# 60, 24
	var _edgeStartingAreas = {
		"horizontal": [
			[20, 10],
			[40, 10]
		],
		"vertical": [
			[8, 8],
		]
	}
	
	if randi() % 2 == 0:
		if randi() % 2 == 0:
			_connectionPoints.append(Vector2(
				randi() % _edgeStartingAreas["horizontal"][0][1] + _edgeStartingAreas["horizontal"][0][0],
				0
			))
			_connectionPoints.append(Vector2(
				randi() % _edgeStartingAreas["horizontal"][0][1] + _edgeStartingAreas["horizontal"][0][0],
				23
			))
		else:
			_connectionPoints.append(Vector2(
				randi() % _edgeStartingAreas["horizontal"][1][1] + _edgeStartingAreas["horizontal"][1][0],
				0
			))
			_connectionPoints.append(Vector2(
				randi() % _edgeStartingAreas["horizontal"][1][1] + _edgeStartingAreas["horizontal"][1][0],
				23
			))
		if randi() % 2 == 0:
			_seaSide = "west"
		else:
			_seaSide = "east"
	else:
		_connectionPoints.append(Vector2(
			0,
			randi() % _edgeStartingAreas["vertical"][0][1] + _edgeStartingAreas["vertical"][0][0]
		))
		_connectionPoints.append(Vector2(
			59,
			randi() % _edgeStartingAreas["vertical"][0][1] + _edgeStartingAreas["vertical"][0][0]
		))
		if randi() % 2 == 0:
			_seaSide = "north"
		else:
			_seaSide = "south"
	
	var _path = calculatePath(_connectionPoints[0], _connectionPoints[1])
	
	var _isSeaTile
	if _seaSide.matchn("west") or _seaSide.matchn("east"):
		if _seaSide == "west":
			_isSeaTile = true
		else:
			_isSeaTile = false
		for y in (grid[0].size()):
			for x in (grid.size()):
				if _path[y] == Vector2(x, y):
					_isSeaTile = !_isSeaTile
				if _isSeaTile:
					grid[x][y].tile = Globals.tiles.SEA
				else:
					grid[x][y].tile = Globals.tiles.SAND
					spawnableFloors.append(Vector2(x, y))
					if randi() % 22 == 0:
						grid[x][y].interactable = Globals.interactables.HIDDEN_ITEM
						if spawnableFloors.has(Vector2(x, y)):
							spawnableFloors.erase(Vector2(x, y))
			_isSeaTile = !_isSeaTile
	else:
		if _seaSide == "north":
			_isSeaTile = true
		else:
			_isSeaTile = false
		for x in (grid.size()):
			for y in (grid[x].size()):
				if _path[x] == Vector2(x, y):
					_isSeaTile = !_isSeaTile
				if _isSeaTile:
					grid[x][y].tile = Globals.tiles.SEA
				else:
					grid[x][y].tile = Globals.tiles.SAND
					spawnableFloors.append(Vector2(x, y))
					if randi() % 22 == 0:
						grid[x][y].interactable = Globals.interactables.HIDDEN_ITEM
						if spawnableFloors.has(Vector2(x, y)):
							spawnableFloors.erase(Vector2(x, y))
			_isSeaTile = !_isSeaTile
	
	for _point in _path:
		if !randi() % 4 == 0:
			grid[_point.x][_point.y].tile = Globals.tiles.SEA
			if spawnableFloors.has(Vector2(_point.x, _point.y)):
				spawnableFloors.erase(Vector2(_point.x, _point.y))
			grid[_point.x][_point.y].interactable = null
		else:
			grid[_point.x][_point.y].tile = Globals.tiles.SAND
			spawnableFloors.append(Vector2(_point.x, _point.y))
			if randi() % 22 == 0:
				grid[_point.x][_point.y].interactable = Globals.interactables.HIDDEN_ITEM
				if spawnableFloors.has(Vector2(_point.x, _point.y)):
					spawnableFloors.erase(Vector2(_point.x, _point.y))
		if _seaSide == "north":
			if randi() % 6 == 0:
				grid[_point.x][_point.y - 1].tile = Globals.tiles.SAND
				spawnableFloors.append(Vector2(_point.x, _point.y))
				if randi() % 22 == 0:
					grid[_point.x][_point.y - 1].interactable = Globals.interactables.HIDDEN_ITEM
					if spawnableFloors.has(Vector2(_point.x, _point.y)):
						spawnableFloors.erase(Vector2(_point.x, _point.y))
			else:
				grid[_point.x][_point.y - 1].tile = Globals.tiles.SEA
				if spawnableFloors.has(Vector2(_point.x, _point.y)):
					spawnableFloors.erase(Vector2(_point.x, _point.y))
				grid[_point.x][_point.y - 1].interactable = null
			if !randi() % 6 == 0:
				grid[_point.x][_point.y + 1].tile = Globals.tiles.SAND
				spawnableFloors.append(Vector2(_point.x, _point.y))
				if randi() % 22 == 0:
					grid[_point.x][_point.y + 1].interactable = Globals.interactables.HIDDEN_ITEM
					if spawnableFloors.has(Vector2(_point.x, _point.y)):
						spawnableFloors.erase(Vector2(_point.x, _point.y))
			else:
				grid[_point.x][_point.y + 1].tile = Globals.tiles.SEA
				if spawnableFloors.has(Vector2(_point.x, _point.y)):
					spawnableFloors.erase(Vector2(_point.x, _point.y))
				grid[_point.x][_point.y + 1].interactable = null
		elif _seaSide == "south":
			if !randi() % 6 == 0:
				grid[_point.x][_point.y - 1].tile = Globals.tiles.SAND
				spawnableFloors.append(Vector2(_point.x, _point.y))
				if randi() % 22 == 0:
					grid[_point.x][_point.y - 1].interactable = Globals.interactables.HIDDEN_ITEM
					if spawnableFloors.has(Vector2(_point.x, _point.y)):
						spawnableFloors.erase(Vector2(_point.x, _point.y))
			else:
				grid[_point.x][_point.y - 1].tile = Globals.tiles.SEA
				if spawnableFloors.has(Vector2(_point.x, _point.y)):
					spawnableFloors.erase(Vector2(_point.x, _point.y))
				grid[_point.x][_point.y - 1].interactable = null
			if randi() % 6 == 0:
				grid[_point.x][_point.y + 1].tile = Globals.tiles.SAND
				spawnableFloors.append(Vector2(_point.x, _point.y))
				if randi() % 22 == 0:
					grid[_point.x][_point.y + 1].interactable = Globals.interactables.HIDDEN_ITEM
					if spawnableFloors.has(Vector2(_point.x, _point.y)):
						spawnableFloors.erase(Vector2(_point.x, _point.y))
			else:
				grid[_point.x][_point.y + 1].tile = Globals.tiles.SEA
				if spawnableFloors.has(Vector2(_point.x, _point.y)):
					spawnableFloors.erase(Vector2(_point.x, _point.y))
				grid[_point.x][_point.y + 1].interactable = null
		elif _seaSide == "west":
			if randi() % 6 == 0:
				grid[_point.x - 1][_point.y].tile = Globals.tiles.SAND
				spawnableFloors.append(Vector2(_point.x, _point.y))
				if randi() % 22 == 0:
					grid[_point.x - 1][_point.y].interactable = Globals.interactables.HIDDEN_ITEM
					if spawnableFloors.has(Vector2(_point.x, _point.y)):
						spawnableFloors.erase(Vector2(_point.x, _point.y))
			else:
				grid[_point.x - 1][_point.y].tile = Globals.tiles.SEA
				if spawnableFloors.has(Vector2(_point.x, _point.y)):
					spawnableFloors.erase(Vector2(_point.x, _point.y))
				grid[_point.x - 1][_point.y].interactable = null
			if !randi() % 6 == 0:
				grid[_point.x + 1][_point.y].tile = Globals.tiles.SAND
				spawnableFloors.append(Vector2(_point.x, _point.y))
				if randi() % 22 == 0:
					grid[_point.x + 1][_point.y].interactable = Globals.interactables.HIDDEN_ITEM
					if spawnableFloors.has(Vector2(_point.x, _point.y)):
						spawnableFloors.erase(Vector2(_point.x, _point.y))
			else:
				grid[_point.x + 1][_point.y].tile = Globals.tiles.SEA
				if spawnableFloors.has(Vector2(_point.x, _point.y)):
					spawnableFloors.erase(Vector2(_point.x, _point.y))
				grid[_point.x + 1][_point.y].interactable = null
		elif _seaSide == "east":
			if !randi() % 6 == 0:
				grid[_point.x - 1][_point.y].tile = Globals.tiles.SAND
				spawnableFloors.append(Vector2(_point.x, _point.y))
				if randi() % 22 == 0:
					grid[_point.x - 1][_point.y].interactable = Globals.interactables.HIDDEN_ITEM
					if spawnableFloors.has(Vector2(_point.x, _point.y)):
						spawnableFloors.erase(Vector2(_point.x, _point.y))
			else:
				grid[_point.x - 1][_point.y].tile = Globals.tiles.SEA
				if spawnableFloors.has(Vector2(_point.x, _point.y)):
					spawnableFloors.erase(Vector2(_point.x, _point.y))
				grid[_point.x - 1][_point.y].interactable = null
			if randi() % 6 == 0:
				grid[_point.x + 1][_point.y].tile = Globals.tiles.SAND
				spawnableFloors.append(Vector2(_point.x, _point.y))
				if randi() % 22 == 0:
					grid[_point.x + 1][_point.y].interactable = Globals.interactables.HIDDEN_ITEM
					if spawnableFloors.has(Vector2(_point.x, _point.y)):
						spawnableFloors.erase(Vector2(_point.x, _point.y))
			else:
				grid[_point.x + 1][_point.y].tile = Globals.tiles.SEA
				if spawnableFloors.has(Vector2(_point.x, _point.y)):
					spawnableFloors.erase(Vector2(_point.x, _point.y))
				grid[_point.x + 1][_point.y].interactable = null
