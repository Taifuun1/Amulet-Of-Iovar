extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	enemyPathfinding(grid)
	
	return self

func createDungeon():
	for _i in range(10):
		addInputs("Labyrinth", get_script().get_path().get_base_dir() + "/Inputs")
		createLabyrinth()
		trimGenerationEdges()
		getGenerationGrid()
		getSpawnableFloors(["CORRIDOR_DUNGEON"])
		placeStairs()
		if areAllStairsConnected():
			return
		resetLevel()
	push_error("Couldn't generate labyrinth")

func createLabyrinth():
	for _i in range(40):
		if generateMap() and get_used_cells().size() > 1350:
			return
		resetGeneration()
