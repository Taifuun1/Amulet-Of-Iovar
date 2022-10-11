extends WaveFunctionCollapse

func createNewLevel(_isLast = false):
	createGrid()
	pathFind([])
	
	createDungeon(_isLast)
	
	pathFind(Globals.blockedTiles)
	enemyPathfinding(grid)
	
	return self

func createDungeon(_isLast):
	for _i in range(10):
		var _bossRoomCenter = null
		addInputs("Library", get_script().get_path().get_base_dir() + "/Inputs")
		createLibrary()
		trimGenerationEdges()
		getGenerationGrid()
		changeReplaceables(["BOOKCASE1", "BOOKCASE2", "BOOKCASE3"])
		fillEmptyTiles("CORRIDOR_SAND")
		if _isLast:
			_bossRoomCenter = generateBossRoom()
		getSpawnableTiles(
			["CORRIDOR_SAND"],
			["CORRIDOR_SAND"],
			["CORRIDOR_SAND"]
		)
		placeStairs()
		if areAllStairsConnected():
			if _bossRoomCenter != null:
				pathFind([Globals.blockedTiles])
				if calculatePath(stairs.downStair, _bossRoomCenter) == 0:
					continue
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate library")

func createLibrary():
	for _i in range(40):
		if generateMap(randi() % 11) and get_used_cells().size() > 1350:
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
