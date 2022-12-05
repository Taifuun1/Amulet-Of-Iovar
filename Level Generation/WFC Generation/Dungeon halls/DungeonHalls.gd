extends WaveFunctionCollapse

func createNewLevel(_secondStair = null):
	createGrid()
	
	addInputs("Dungeon Halls", get_script().get_path().get_base_dir() + "/Inputs")
	createDungeon(_secondStair)
	removeInputs()
	
	doFinalPathfinding()
	
	return self

func createDungeon(_secondStair):
	for _i in range(10):
		pathFind([])
		createDungeonHalls()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("WALL_DUNGEON", "WALL_DUNGEON")
		fillGridWithGeneratedGrid()
		getAndCleanUpDungeonHallsRooms()
		getSpawnableTiles(
			["FLOOR_DUNGEON", "CORRIDOR_DUNGEON"],
			["FLOOR_DUNGEON"],
			["FLOOR_DUNGEON", "CORRIDOR_DUNGEON"]
		)
		placeStairs("DUNGEON", _secondStair)
		checkAllRoomsAreAccessible()
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate dungeon halls")

func createDungeonHalls():
	for _i in range(40):
		if generateMap(randi() % 9 + 1) and getUsedCells() > 1750:
			return
		resetGeneration()

func getAndCleanUpDungeonHallsRooms():
	# Clean up walls
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if grid[x][y].tile == Globals.tiles.FLOOR_DUNGEON:
				var _corridors = checkAdjacentTilesForTile(Vector2(x, y), ["CORRIDOR_DUNGEON"])
				if !_corridors.empty():
					var _doors = checkAdjacentTilesForTile(Vector2(x, y), ["DOOR_CLOSED"])
					if _doors.empty():
						grid[x][y].tile = Globals.tiles.WALL_DUNGEON
					else:
						for _corridorTile in _corridors:
							grid[_corridorTile.x][_corridorTile.y].tile = Globals.tiles.WALL_DUNGEON
	
	# Get floors
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if grid[x][y].tile == Globals.tiles.FLOOR_DUNGEON and !isTileAlreadyInARoom(Vector2(x,y)):
				var _room = getRoom(Vector2(x, y), {
					"floor": "FLOOR_DUNGEON",
					"wall": "WALL_DUNGEON"
				})
				if _room.size() < 4:
					for _tile in _room:
						var _foundDoors = checkAdjacentTilesForTile(Vector2(x, y), ["DOOR_CLOSED"])
						for _door in _foundDoors:
							grid[_door.x][_door.y].tile = Globals.tiles.WALL_DUNGEON
						grid[_tile.x][_tile.y].tile = Globals.tiles.WALL_DUNGEON
				else:
					rooms.append({
						"floors": _room,
						"walls": []
					})
	
	# Get walls
	for _room in rooms:
		var _walls = []
		for _floorTile in _room.floors:
			var _adjacentTiles = checkAdjacentTilesForTile(_floorTile, ["WALL_DUNGEON"])
			for _adjacentTile in _adjacentTiles:
				_walls.append(_adjacentTile)
		_room.walls = _walls

func checkAllRoomsAreAccessible():
	# Check if rooms are accessible
#	updateTilemapToGrid()
	pathFind([Globals.tiles.WALL_DUNGEON])
	pathFindWeightedPath([], [{ "tile": "WALL_DUNGEON", "weighting": 15 }])
	var _rooms = []
	for _room in rooms:
		if calculatePath(stairs.downStair, _room.floors[0]).size() == 0:
			_rooms.append(_room)
		else:
			continue
	
	for _room in _rooms:
		if calculatePath(stairs.downStair, _room.floors[0]).size() == 0:
			var _path = calculateWeightedPath(stairs.downStair, _room.floors[0])
			for _tile in _path:
				if grid[_tile.x][_tile.y].tile == Globals.tiles.WALL_DUNGEON:
					grid[_tile.x][_tile.y].tile = Globals.tiles.DOOR_CLOSED
#			updateTilemapToGrid()
			pathFind([Globals.tiles.WALL_DUNGEON])
			pathFindWeightedPath([], [{ "tile": "WALL_DUNGEON", "weighting": 15 }])
