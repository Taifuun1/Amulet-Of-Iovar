extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	addInputs("Dragons Peak", get_script().get_path().get_base_dir() + "/Inputs")
	createDungeon()
	removeInputs()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	for _i in range(10):
		createDragonsPeak()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("WALL_DRAGONS_PEAK")
		fillGridWithGeneratedGrid()
		removeSmallWallFormations()
		getSpawnableTiles(
			["FLOOR_DRAGONS_PEAK"],
			["FLOOR_DRAGONS_PEAK"],
			["FLOOR_DRAGONS_PEAK"]
		)
		placeStairs()
		if areAllStairsConnected():
			placeContainers({
				"chest": {
					"amount": randi() % 2
				}
			})
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate dragons peak")

func createDragonsPeak():
	for _i in range(40):
		if generateMap(randi() % 5) and getUsedCells() > 1750:
			return
		resetGeneration()

func removeSmallWallFormations():
	# Get areas
	for x in grid.size():
		for y in grid[0].size():
			if grid[x][y].tile == Globals.tiles.WALL_DRAGONS_PEAK and !isTileAlreadyInAnArea(Vector2(x, y)):
				areas.append(getArea(Vector2(x, y), "WALL_DRAGONS_PEAK"))
	
	# Remove small wall formations
	var _smallWallFormations = []
	for _area in areas:
		if _area.size() <= 4:
			_smallWallFormations.append(_area.duplicate(true))
			areas.erase(_area)
	for _area in _smallWallFormations:
		for _tile in _area:
			grid[_tile.x][_tile.y].tile = Globals.tiles.FLOOR_DRAGONS_PEAK
