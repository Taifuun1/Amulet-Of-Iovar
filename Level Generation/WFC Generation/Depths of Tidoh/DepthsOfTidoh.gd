extends WaveFunctionCollapse

onready var depthsOfTidohSpawns = preload("res://Level Generation/WFC Generation/Depths of Tidoh/DepthsOfTidohSpawns.gd").new()

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	for _i in range(10):
		addInputs("Depths of Tidoh", get_script().get_path().get_base_dir() + "/Inputs")
		createDepthsOfTidoh()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("WALL_CAVE_DEEP")
		fillGridWithGeneratedGrid()
		addLootToSmallDisconnectedAreas()
		placeRandomInteractables(["gems"])
		getSpawnableTiles(
			["FLOOR_CAVE_DEEP"],
			["FLOOR_CAVE_DEEP"],
			["FLOOR_CAVE_DEEP"],
			true
		)
		placeStairs()
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate mines of tidoh")

func createDepthsOfTidoh():
	for _i in range(40):
		if generateMap(randi() % 2 + 3) and getUsedCells() > 1750:
			return
		resetGeneration()

func addLootToSmallDisconnectedAreas():
	# Get areas
	for x in grid.size():
		for y in grid[0].size():
			if grid[x][y].tile == Globals.tiles.FLOOR_CAVE_DEEP and !isTileAlreadyInAnArea(Vector2(x, y)):
				areas.append(getArea(Vector2(x, y), "FLOOR_CAVE_DEEP"))
	
	# Add loot to small areas
	var _smallAreas = []
	var _depthsOfTidohSpawns = []
	pathFind([Globals.tiles.WALL_DUNGEON])
	for _area in areas:
		if _area.size() <= 75:
			_smallAreas.append(_area)
	for _area in _smallAreas:
		var _tile = _area[randi() % _area.size()]
		var _spawn = depthsOfTidohSpawns.depthsOfTidohSpawns[0].duplicate(true)
		_spawn.tiles = _tile
		_depthsOfTidohSpawns.append(_spawn)
	placePresetItems(_depthsOfTidohSpawns, self)
