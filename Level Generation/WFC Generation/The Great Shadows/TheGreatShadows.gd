extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	addInputs("The Great Shadows", get_script().get_path().get_base_dir() + "/Inputs")
	createDungeon()
	removeInputs()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	for _i in range(10):
		createTheGreatShadows()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("GRASS_DARK")
		fillGridWithGeneratedGrid()
		changeReplaceables(["GRASS_DEAD_TREE"])
		makeForestOpenings()
		getSpawnableTiles(
			["GRASS_DARK"],
			["GRASS_DARK"],
			["GRASS_DARK"]
		)
		placeStairs()
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate the great shadows")

func createTheGreatShadows():
	for _i in range(40):
		if generateMap() and getUsedCells() > 1750:
			return
		resetGeneration()

func makeForestOpenings():
	var _randomSpots = []
	for _index in range(4):
		_randomSpots.append(Vector2(randi() % int(Globals.gridSize.x), randi() % int(Globals.gridSize.y)))
	for _randomSpot in _randomSpots:
		for x in range(_randomSpot.x - (randi() % 2 + 2), _randomSpot.x + (randi() % 2 + 3)):
			for y in range(_randomSpot.y - (randi() % 2 + 2), _randomSpot.y + (randi() % 2 + 3)):
				if !isOutSideTileMap(Vector2(x,y)):
					grid[x][y].tile = Globals.tiles.GRASS_DARK
