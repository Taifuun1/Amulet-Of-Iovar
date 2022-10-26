extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	for _i in range(10):
		addInputs("Bandit Warcamp", get_script().get_path().get_base_dir() + "/Inputs")
		createBanditWarcamp()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("GRASS")
		fillGridWithGeneratedGrid()
		getAndCleanUpRooms([
			{
				"floor": "FLOOR_WOOD_BRICK",
				"wall": "WALL_WOOD_PLANK"
			},
			{
				"floor": "FLOOR_STONE_BRICK",
				"wall": "WALL_STONE_BRICK"
			}
		])
		getSpawnableTiles(
			["GRASS", "FLOOR_STONE_BRICK", "FLOOR_WOOD_BRICK"],
			["FLOOR_STONE_BRICK", "FLOOR_WOOD_BRICK"],
			["GRASS"]
		)
		placeStairs()
		placeDoors({
			"min": 1,
			"max": 1
		})
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate bandit warcamp")

func createBanditWarcamp():
	for _i in range(40):
		if generateMap(randi() % 5 + 3) and getUsedCells() > 1750:
			return
		resetGeneration()
