extends GenericLevel

func createNewLevel():
	createGrid()
	pathFind([])
	
	createVacationResort()
	
	doFinalPathfinding()
	
	return self

func createVacationResort():
	for _in in range(10):
		createSea()
		createResortShack()
		getSpawnableTiles(
			["SAND", "SEA", "FLOOR_SAND"],
			["SAND", "FLOOR_SAND"],
			["SAND", "FLOOR_SAND"]
		)
		placeStairs("SAND")
		if areAllStairsConnected():
			return
		resetLevel()
	push_error("Can't create vacation resort")

func createSea():
	var _connectionPoints = []
	var _seaSide
	var _randomDiggablesChance = 46
	
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
					if randi() % _randomDiggablesChance == 0:
						grid[x][y].interactable = Globals.interactables.HIDDEN_ITEM
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
					if randi() % _randomDiggablesChance == 0:
						grid[x][y].interactable = Globals.interactables.HIDDEN_ITEM
			_isSeaTile = !_isSeaTile
	
	for _point in _path:
		if !randi() % 4 == 0:
			grid[_point.x][_point.y].tile = Globals.tiles.SEA
			grid[_point.x][_point.y].interactable = null
		else:
			grid[_point.x][_point.y].tile = Globals.tiles.SAND
			if randi() % _randomDiggablesChance == 0:
				grid[_point.x][_point.y].interactable = Globals.interactables.HIDDEN_ITEM
		if _seaSide == "north":
			if randi() % 6 == 0:
				grid[_point.x][_point.y - 1].tile = Globals.tiles.SAND
				if randi() % _randomDiggablesChance == 0:
					grid[_point.x][_point.y - 1].interactable = Globals.interactables.HIDDEN_ITEM
			else:
				grid[_point.x][_point.y - 1].tile = Globals.tiles.SEA
				grid[_point.x][_point.y - 1].interactable = null
			if !randi() % 6 == 0:
				grid[_point.x][_point.y + 1].tile = Globals.tiles.SAND
				if randi() % _randomDiggablesChance == 0:
					grid[_point.x][_point.y + 1].interactable = Globals.interactables.HIDDEN_ITEM
			else:
				grid[_point.x][_point.y + 1].tile = Globals.tiles.SEA
				grid[_point.x][_point.y + 1].interactable = null
		elif _seaSide == "south":
			if !randi() % 6 == 0:
				grid[_point.x][_point.y - 1].tile = Globals.tiles.SAND
				if randi() % _randomDiggablesChance == 0:
					grid[_point.x][_point.y - 1].interactable = Globals.interactables.HIDDEN_ITEM
			else:
				grid[_point.x][_point.y - 1].tile = Globals.tiles.SEA
				grid[_point.x][_point.y - 1].interactable = null
			if randi() % 6 == 0:
				grid[_point.x][_point.y + 1].tile = Globals.tiles.SAND
				if randi() % _randomDiggablesChance == 0:
					grid[_point.x][_point.y + 1].interactable = Globals.interactables.HIDDEN_ITEM
			else:
				grid[_point.x][_point.y + 1].tile = Globals.tiles.SEA
				grid[_point.x][_point.y + 1].interactable = null
		elif _seaSide == "west":
			if randi() % 6 == 0:
				grid[_point.x - 1][_point.y].tile = Globals.tiles.SAND
				if randi() % _randomDiggablesChance == 0:
					grid[_point.x - 1][_point.y].interactable = Globals.interactables.HIDDEN_ITEM
			else:
				grid[_point.x - 1][_point.y].tile = Globals.tiles.SEA
				grid[_point.x - 1][_point.y].interactable = null
			if !randi() % 6 == 0:
				grid[_point.x + 1][_point.y].tile = Globals.tiles.SAND
				if randi() % _randomDiggablesChance == 0:
					grid[_point.x + 1][_point.y].interactable = Globals.interactables.HIDDEN_ITEM
			else:
				grid[_point.x + 1][_point.y].tile = Globals.tiles.SEA
				grid[_point.x + 1][_point.y].interactable = null
		elif _seaSide == "east":
			if !randi() % 6 == 0:
				grid[_point.x - 1][_point.y].tile = Globals.tiles.SAND
				if randi() % _randomDiggablesChance == 0:
					grid[_point.x - 1][_point.y].interactable = Globals.interactables.HIDDEN_ITEM
			else:
				grid[_point.x - 1][_point.y].tile = Globals.tiles.SEA
				grid[_point.x - 1][_point.y].interactable = null
			if randi() % 6 == 0:
				grid[_point.x + 1][_point.y].tile = Globals.tiles.SAND
				if randi() % _randomDiggablesChance == 0:
					grid[_point.x + 1][_point.y].interactable = Globals.interactables.HIDDEN_ITEM
			else:
				grid[_point.x + 1][_point.y].tile = Globals.tiles.SEA
				grid[_point.x + 1][_point.y].interactable = null

func createResortShack():
	var _legibleRoomTiles = getAllLegibleRoomLocations([Globals.tiles.SAND], Vector2(4,4), Vector2(8,8))
	var _room = _legibleRoomTiles[randi() % _legibleRoomTiles.size()]
	placeRoom(_room.position, _room.size, { "wall": "WALL_BOARD", "floor": "FLOOR_SAND" })
	placeDoors([1,1])
