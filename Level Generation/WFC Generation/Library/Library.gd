extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	enemyPathfinding(grid)
	
	return self

func createDungeon():
	for _i in range(10):
		addInputs("Library", get_script().get_path().get_base_dir() + "/Inputs")
		createLibrary()
		trimGenerationEdges()
		getGenerationGrid()
		changeReplaceables(["BOOKCASE1", "BOOKCASE2", "BOOKCASE3"])
		getSpawnableFloors(["FLOOR_BOARD"])
		placeStairs()
		if areAllStairsConnected():
			return
		resetLevel()
	push_error("Couldn't generate library")

func createLibrary():
	for _i in range(40):
		if generateMap(randi() % 11) and get_used_cells().size() > 1350:
			return
		resetGeneration()
