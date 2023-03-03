extends Beach

func createNewLevel():
	createGrid()
	pathFind([])
	
	createBeach()
	
	doFinalPathfinding()
	
	return self

func createBeach():
	for _in in range(10):
		createSea()
		createResortShack()
		getSpawnableTiles(
			["SAND", "SEA", "FLOOR_SAND"],
			["SAND", "FLOOR_SAND"],
			["SAND", "FLOOR_SAND"]
		)
		placeStairs("SAND")
		if areAllStairsConnected():
			return
		resetLevel()
	push_error("Can't create beach")

func createResortShack():
	var _legibleRoomTiles = getAllLegibleRoomLocations([Globals.tiles.SAND], Vector2(4,4), Vector2(8,8))
	var _room = _legibleRoomTiles[randi() % _legibleRoomTiles.size()]
	placeRoom(_room.position, _room.size, { "wall": "WALL_BOARD", "floor": "FLOOR_SAND" })
	placeDoors([1,1])
