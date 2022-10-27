extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	for _i in range(10):
		addInputs("Fortress", get_script().get_path().get_base_dir() + "/Inputs")
		createFortress()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("CORRIDOR_STONE")
		fillGridWithGeneratedGrid()
		changeReplaceables(["ROAD_DUNGEON"])
		getAndCleanUpRooms([
			{
				"floor": "FLOOR_STONE_BRICK",
				"wall": "WALL_STONE_BRICK"
			},
		])
		getSpawnableTiles(
			["CORRIDOR_STONE", "ROAD_DUNGEON", "FLOOR_STONE_BRICK"],
			["FLOOR_STONE_BRICK"],
			["CORRIDOR_STONE", "ROAD_DUNGEON", "FLOOR_STONE_BRICK"]
		)
		placeStairs()
		checkAllRoomsAreAccessible()
		addSomeDoors()
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate fortress")

func createFortress():
	for _i in range(40):
		if generateMap(randi() % 4) and getUsedCells() > 1750:
			return
		resetGeneration()

func checkAllRoomsAreAccessible():
	# Check if rooms are accessible
#	updateTilemapToGrid()
	pathFind([Globals.tiles.WALL_STONE_BRICK])
	pathFindWeightedPath([], [{ "tile": "WALL_STONE_BRICK", "weighting": 15 }])
	var _rooms = []
	for _room in rooms:
		if calculatePath(stairs.downStair, _room.floors[0]).size() == 0 and _room.floors.size() > 32:
			_rooms.append(_room)
	
	for _room in _rooms:
		if calculatePath(stairs.downStair, _room.floors[0]).size() == 0:
			var _path = calculateWeightedPath(stairs.downStair, _room.floors[randi() % _room.floors.size()])
			for _tile in _path:
				if grid[_tile.x][_tile.y].tile == Globals.tiles.WALL_STONE_BRICK:
					grid[_tile.x][_tile.y].tile = Globals.tiles.DOOR_CLOSED
					_room.walls.erase(_tile)
#			updateTilemapToGrid()
			pathFind([Globals.tiles.WALL_STONE_BRICK])
			pathFindWeightedPath([], [{ "tile": "WALL_STONE_BRICK", "weighting": 15 }])

func addSomeDoors():
	for _room in rooms:
		var _doors = 0
		if _room.floors.size() <= 8:
			continue
		elif _room.floors.size() <= 64:
			_doors = 1
		elif _room.floors.size() <= 128:
			_doors = 2
		else:
			_doors = 3
		for _index in range(_doors):
			var _tile = _room.walls[randi() % _room.walls.size()]
			grid[_tile.x][_tile.y].tile = Globals.tiles.DOOR_CLOSED
			_room.walls.erase(_tile)
