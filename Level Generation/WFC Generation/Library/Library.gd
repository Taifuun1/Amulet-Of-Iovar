extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	pathFind(Globals.blockedTiles)
	enemyPathfinding(grid)
	
	return self

func createDungeon():
	for _i in range(10):
		addInputs("Library", get_script().get_path().get_base_dir() + "/Inputs")
		createLibrary()
		trimGenerationEdges()
		getGenerationGrid()
		changeReplaceables(["BOOKCASE1", "BOOKCASE2", "BOOKCASE3"])
		fillEmptyTiles("CORRIDOR_SAND")
		getSpawnableTiles(
			["CORRIDOR_SAND"],
			["CORRIDOR_SAND"],
			["CORRIDOR_SAND"]
		)
		placeStairs()
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate library")

func createLibrary():
	for _i in range(40):
		if generateMap(randi() % 11) and get_used_cells().size() > 1350:
			return
		resetGeneration()
