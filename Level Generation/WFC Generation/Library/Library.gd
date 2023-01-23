extends WaveFunctionCollapse

onready var librarySpawns = preload("res://Level Generation/WFC Generation/Library/LibrarySpawns.gd").new()

func createNewLevel(_stairData = []):
	createGrid()
	pathFind([])
	
	addInputs("Library", get_script().get_path().get_base_dir() + "/Inputs")
	createDungeon(_stairData)
	removeInputs()
	
	doFinalPathfinding()
	
	return self

func createDungeon(_stairData):
	for _i in range(10):
		var _bossRoomCenter = null
		createLibrary()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("CORRIDOR_SAND")
		fillGridWithGeneratedGrid()
		changeReplaceables(["BOOKCASE1", "BOOKCASE2", "BOOKCASE3"])
		if _stairData.has("noDownStair"):
			_bossRoomCenter = generateBossRoom()
			librarySpawns.librarySpawns[0].tiles = _bossRoomCenter
			placePresetCritters(librarySpawns.librarySpawns, self)
		placeSpiderWebs()
		getSpawnableTiles(
			["CORRIDOR_SAND"],
			["CORRIDOR_SAND"],
			["CORRIDOR_SAND"]
		)
		placeStairs("DUNGEON", _stairData)
		if areAllStairsConnected():
			placeContainers({
				"box": {
					"amount": randi() % 2
				},
				"chest": {
					"amount": randi() % 6
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
	push_error("Couldn't generate library")

func createLibrary():
	for _i in range(40):
		if generateMap(randi() % 11) and getUsedCells() > 1750:
			return
		resetGeneration()

func generateBossRoom():
	var _randomTile = Vector2(randi() % int(Globals.gridSize.x), randi() % int(Globals.gridSize.y))
	for x in range(_randomTile.x - 4, _randomTile.x + 5):
		for y in range(_randomTile.y - 4, _randomTile.y + 5):
			if isOutSideTileMap(Vector2(x,y)):
				continue
			if (
				x == _randomTile.x - 4 or
				x == _randomTile.x + 4 or
				y == _randomTile.y - 4 or
				y == _randomTile.y + 4
			):
				if (
					x == _randomTile.x - 4 and
					(
						grid[x - 1][y].tile == Globals.tiles.WALL_BOARD or
						grid[x - 1][y].tile == Globals.tiles.BOOKCASE1 or
						grid[x - 1][y].tile == Globals.tiles.BOOKCASE2 or
						grid[x - 1][y].tile == Globals.tiles.BOOKCASE3
					)
				):
					grid[x][y].tile = Globals.tiles.WALL_BOARD
				elif (
					x == _randomTile.x + 4 and
					(
						grid[x + 1][y].tile == Globals.tiles.WALL_BOARD or
						grid[x + 1][y].tile == Globals.tiles.BOOKCASE1 or
						grid[x + 1][y].tile == Globals.tiles.BOOKCASE2 or
						grid[x + 1][y].tile == Globals.tiles.BOOKCASE3
					)
				):
					grid[x][y].tile = Globals.tiles.WALL_BOARD
				elif (
					y == _randomTile.y - 4 and
					(
						grid[x][y - 1].tile == Globals.tiles.WALL_BOARD or
						grid[x][y - 1].tile == Globals.tiles.BOOKCASE1 or
						grid[x][y - 1].tile == Globals.tiles.BOOKCASE2 or
						grid[x][y - 1].tile == Globals.tiles.BOOKCASE3
					)
				):
					grid[x][y].tile = Globals.tiles.WALL_BOARD
				elif (
					y == _randomTile.y + 4 and
					(
						grid[x][y + 1].tile == Globals.tiles.WALL_BOARD or
						grid[x][y + 1].tile == Globals.tiles.BOOKCASE1 or
						grid[x][y + 1].tile == Globals.tiles.BOOKCASE2 or
						grid[x][y + 1].tile == Globals.tiles.BOOKCASE3
					)
				):
					grid[x][y].tile = Globals.tiles.WALL_BOARD
				else:
					grid[x][y].tile = Globals.tiles.CORRIDOR_SAND
			else:
				grid[x][y].tile = Globals.tiles.FLOOR_BRICK_SMALL
	return _randomTile

func placeSpiderWebs():
	for _i in range(randi() % 301 + 0):
		var _tile = Vector2(randi() % int(Globals.gridSize.x), randi() % int(Globals.gridSize.y))
		if Globals.isTileFree(_tile, grid) and grid[_tile.x][_tile.y].tile != Globals.tiles.DOOR_CLOSED:
			grid[_tile.x][_tile.y].interactable = Globals.interactables.SPIDER_WEB
