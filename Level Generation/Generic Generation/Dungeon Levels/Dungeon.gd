extends GenericLevel

func createNewLevel(_secondStair = null):
	createGrid()
	
	createDungeon(_secondStair)
	
	doFinalPathfinding()
	
	return self

func createDungeon(_secondStair):
	for _i in range(10):
		createRooms()
		getSpawnableTiles(
			["FLOOR_DUNGEON", "CORRIDOR_DUNGEON"],
			["FLOOR_DUNGEON"],
			["FLOOR_DUNGEON", "CORRIDOR_DUNGEON"]
		)
		placeStairs("DUNGEON", _secondStair)
		connectRooms()
		if areAllStairsConnected():
			placeRandomInteractables(["altar"])
			return
		resetLevel()
	push_error("Cant create dungeon")

func createRooms():
	for _roomCount in range(randi() % 2 + 5):
		var _legibleRoomTiles = getAllLegibleRoomLocations([Globals.tiles.EMPTY], Vector2(4,4), Vector2(9,9))
		if !_legibleRoomTiles.empty():
			var _room = _legibleRoomTiles[randi() % _legibleRoomTiles.size()]
			placeRoom(_room.position, _room.size, { "wall": "WALL_DUNGEON", "floor": "FLOOR_DUNGEON" })
			placeDoors([1,3])

func connectRooms():
	pathfindDungeonCorridors()
	
	for room in rooms:
		for door in room.doors:
			var randomEndPointRoom
			var endPointDoor
			while(true):
				randomEndPointRoom = rooms[randi() % rooms.size()]
				endPointDoor = randomEndPointRoom.doors[randi() % randomEndPointRoom.doors.size()]
				if(door != endPointDoor and randomEndPointRoom != room):
					break
			var path = calculateCorridorsPath(door, endPointDoor)
			for point in path:
				if grid[point.x][point.y].tile != Globals.tiles.DOOR_CLOSED and grid[point.x][point.y].tile != Globals.tiles.DOOR_OPEN:
					grid[point.x][point.y].tile = Globals.tiles.CORRIDOR_DUNGEON
