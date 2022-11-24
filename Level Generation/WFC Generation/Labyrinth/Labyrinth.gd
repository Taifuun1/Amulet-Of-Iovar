extends WaveFunctionCollapse

onready var labyrinthSpawns = preload("res://Level Generation/WFC Generation/Labyrinth/LabyrinthSpawns.gd").new()

func createNewLevel(_isLast = false):
	createGrid()
	pathFind([])
	
	createDungeon(_isLast)
	
	doFinalPathfinding()
	
	return self

func createDungeon(_isLast):
	for _i in range(10):
		var _bossRoomCenter = null
		addInputs("Labyrinth", get_script().get_path().get_base_dir() + "/Inputs")
		createLabyrinth()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("CORRIDOR_DUNGEON")
		fillGridWithGeneratedGrid()
		if _isLast:
			_bossRoomCenter = generateBossRoom()
			labyrinthSpawns.labyrinthSpawns[0].tiles = _bossRoomCenter
			placePresetCritters(labyrinthSpawns.labyrinthSpawns, self)
		getSpawnableTiles(
			["CORRIDOR_DUNGEON"],
			["CORRIDOR_DUNGEON"],
			["CORRIDOR_DUNGEON"]
		)
		placeStairs()
		if areAllStairsConnected():
			if _bossRoomCenter != null:
				pathFind([Globals.blockedTiles])
			if calculatePath(stairs.downStair, _bossRoomCenter) != 0:
				return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate labyrinth")

func createLabyrinth():
	for _i in range(40):
		if generateMap() and getUsedCells() > 1750:
			return
		resetGeneration()

func generateBossRoom():
	var _randomTile = Vector2(randi() % int(Globals.gridSize.x), randi() % int(Globals.gridSize.y))
	for x in range(_randomTile.x - 4, _randomTile.x + 5):
		for y in range(_randomTile.y - 4, _randomTile.y + 5):
			if isOutSideTileMap(Vector2(x,y)):
				continue
			elif (
				x == _randomTile.x - 4 and
				grid[x - 1][y].tile == Globals.tiles.EMPTY
			):
				grid[x][y].tile = Globals.tiles.WALL_DUNGEON
			elif (
				x == _randomTile.x + 4 and
				grid[x + 1][y].tile == Globals.tiles.EMPTY
			):
				grid[x][y].tile = Globals.tiles.WALL_DUNGEON
			elif (
				y == _randomTile.y - 4 and
				grid[x][y - 1].tile == Globals.tiles.EMPTY
			):
				grid[x][y].tile = Globals.tiles.WALL_DUNGEON
			elif (
				y == _randomTile.y + 4 and
				grid[x][y + 1].tile == Globals.tiles.EMPTY
			):
				grid[x][y].tile = Globals.tiles.WALL_DUNGEON
			else:
				grid[x][y].tile = Globals.tiles.CORRIDOR_DUNGEON
	return _randomTile
