extends WaveFunctionCollapse

onready var labyrinthSpawns = preload("res://Level Generation/WFC Generation/Labyrinth/LabyrinthSpawns.gd").new()

func createNewLevel(_stairData = []):
	createGrid()
	pathFind([])
	
	addInputs("Labyrinth", get_script().get_path().get_base_dir() + "/Inputs")
	createDungeon(_stairData)
	removeInputs()
	
	doFinalPathfinding()
	
	return self

func createDungeon(_stairData):
	for _i in range(10):
		var _bossRoomCenter = null
		createLabyrinth()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("CORRIDOR_DUNGEON")
		fillGridWithGeneratedGrid()
		if _stairData.has("noDownStair"):
			_bossRoomCenter = generateBossRoom()
			labyrinthSpawns.labyrinthSpawns[0].tiles = _bossRoomCenter
			placePresetCritters(labyrinthSpawns.labyrinthSpawns, self)
		getSpawnableTiles(
			["CORRIDOR_DUNGEON"],
			["CORRIDOR_DUNGEON"],
			["CORRIDOR_DUNGEON"]
		)
		placeStairs("DUNGEON", _stairData)
		if areAllStairsConnected():
			placeContainers({
				"chest": {
					"amount": randi() % 8
				}
			})
			if _bossRoomCenter != null:
				pathFind(Globals.blockedTiles)
				if calculatePath(stairs.upStair, _bossRoomCenter).size() != 0:
					return
			else:
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
	var _randomTile = Vector2(randi() % int(Globals.gridSize.x) + 1, randi() % int(Globals.gridSize.y) - 1)
	for x in range(_randomTile.x - 4, _randomTile.x + 5):
		for y in range(_randomTile.y - 4, _randomTile.y + 5):
			if (
				isOutSideTileMap(Vector2(x, y)) or
				isOutSideTileMap(Vector2(x - 1, y)) or
				isOutSideTileMap(Vector2(x + 1, y)) or
				isOutSideTileMap(Vector2(x, y - 1)) or
				isOutSideTileMap(Vector2(x, y + 1))
			):
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
