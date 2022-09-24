extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	enemyPathfinding(grid)
	
	return self

func createDungeon():
	for _i in range(10):
		addInputs("The Great Shadows", get_script().get_path().get_base_dir() + "/Inputs")
		createTheGreatShadows()
		trimGenerationEdges()
		getGenerationGrid()
		changeReplaceables(["GRASS_DEAD_TREE"])
		fillEmptyTiles("GRASS_DARK")
		getSpawnableFloors(["GRASS_DARK"])
		placeStairs()
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate the great shadows")

func createTheGreatShadows():
	for _i in range(40):
		if generateMap() and get_used_cells().size() > 1350:
			return
		resetGeneration()
