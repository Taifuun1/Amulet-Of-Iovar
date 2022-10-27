extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	for _i in range(10):
		addInputs("Mines of Tidoh", get_script().get_path().get_base_dir() + "/Inputs")
		createMinesOfTidoh()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("WALL_CAVE")
		fillGridWithGeneratedGrid()
		connectLargeDisconnectedAreas()
		getSpawnableTiles(
			["FLOOR_CAVE"],
			["FLOOR_CAVE"],
			["FLOOR_CAVE"],
			true
		)
		placeStairs()
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate mines of tidoh")

func createMinesOfTidoh():
	for _i in range(40):
		if generateMap(randi() % 5):
			if getUsedCells() > 1750:
				return
		resetGeneration()

func connectLargeDisconnectedAreas():
	# Get areas
	for x in grid.size():
		for y in grid[0].size():
			if grid[x][y].tile == Globals.tiles.FLOOR_CAVE and !isTileAlreadyInAnArea(Vector2(x, y)):
				areas.append(getArea(Vector2(x, y), "FLOOR_CAVE"))
	
	# Connect large areas
	var _unconnectedAreas = []
#	updateTilemapToGrid()
	pathFindWeightedPath([], [{ "tile": "WALL_CAVE", "weighting": 15 }])
	for _area in areas:
		if _area.size() > 75:
			_unconnectedAreas.append(_area)
	for _area in _unconnectedAreas:
		for _otherArea in _unconnectedAreas:
			if _area != _otherArea:
				var _path = calculateWeightedPath(_area[randi() % _area.size()], _otherArea[randi() % _otherArea.size()])
				for _tile in _path:
					if grid[_tile.x][_tile.y].tile == Globals.tiles.WALL_CAVE:
						grid[_tile.x][_tile.y].tile = Globals.tiles.FLOOR_CAVE
#				updateTilemapToGrid()
				pathFindWeightedPath([], [{ "tile": "WALL_CAVE", "weighting": 15 }])
