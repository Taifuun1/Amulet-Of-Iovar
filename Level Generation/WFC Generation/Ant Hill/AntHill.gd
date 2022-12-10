extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	removeInputs()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	for _i in range(10):
		# Farm land generation
		addInputs("Ant Hill", get_script().get_path().get_base_dir() + "/Patch")
		createAntHill()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("GRASS")
		fillGridWithGeneratedGrid()
		resetGeneration()
		removeInputs()
		
		
		# Forest generation
		addInputs("Ant Hill", get_script().get_path().get_base_dir() + "/Forest")
		createAntHill()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("GRASS")
		generateForest()
		resetGeneration()
		removeInputs()
		
		
		# Soil tiles
		getSoilTiles()
		
		
		# Soil interactables
		generateSoilAreaInteractablesAndItems()
		
		
		placeDoors({
			"min": 1,
			"max": 1
		})
		getSpawnableTiles(
			["GRASS", "SOIL", "FLOOR_WOOD_BRICK"],
			["GRASS", "FLOOR_WOOD_BRICK"],
			["GRASS", "SOIL", "FLOOR_WOOD_BRICK"]
		)
		placeStairs()
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate anthill")

func createAntHill():
	for _i in range(40):
		if generateMap(randi() % 5) and getUsedCells() > 1750:
			return
		resetGeneration()

func generateForest():
	var _splits = (randi() % 3 + 2) + 10
	var _splotches = []
	for _split in _splits:
		_splotches.append({
			"spot": Vector2(randi() % int(Globals.gridSize.x), randi() % int(Globals.gridSize.y)),
			"distance": randi() % 6 + 6
		})
	placeTilesInArea({ "splotches": _splotches }, "SOIL")

func getSoilTiles():
	additionalData.soilTiles = []
	for x in grid.size():
		for y in grid[0].size():
			if grid[x][y].tile == Globals.tiles.SOIL and !additionalData.soilTiles.has(Vector2(x, y)):
				additionalData.soilTiles.append(Vector2(x, y))

func generateSoilAreaInteractablesAndItems():
	var _anthillCount = randi() % 4 + 2
	for _tile in additionalData.soilTiles:
		if randi() % 21 == 0 and _anthillCount > 0:
			grid[_tile.x][_tile.y].interactable = Globals.interactables.ANT_HILL
			_anthillCount -= 1
		elif randi() % 8 == 0:
			grid[_tile.x][_tile.y].interactable = Globals.interactables.PLANT
