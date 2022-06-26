extends BaseLevel

func createNewLevel(_isDouble = false):
	createGrid()
	
	createDungeon(_isDouble)
	
	enemyPathfinding(grid)
	
	return self

func createDungeon(_isDouble):
	createRooms()
	placeStairs("DUNGEON", _isDouble)
	connectRooms()

func createRooms():
	for _roomCount in range(randi() % 2 + 5):
		var _legibleRoomTiles = getAllLegibleRoomLocations([Globals.tiles.EMPTY], Vector2(4,4), Vector2(9,9))
		var _room = _legibleRoomTiles[randi() % _legibleRoomTiles.size()]
		placeRoom(_room.position, _room.size, { "wall": "WALL_DUNGEON", "floor": "FLOOR_DUNGEON" }, true)
		placeDoors([1,3])

func connectRooms():
	pathfindDungeonCorridors()
	
	for _i in range(20):
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
						grid[point.x][point.y].tile = Globals.tiles.CORRIDOR
		pathFind([Globals.tiles.EMPTY, Globals.tiles.WALL_DUNGEON])
		if calculatePath(getTilePosition(Globals.tiles.UP_STAIR_DUNGEON), getTilePosition(Globals.tiles.DOWN_STAIR_DUNGEON)).size() == 0:
			for x in range(grid.size()):
				for y in range(grid[x].size()):
					if grid[x][y].tile == Globals.tiles.CORRIDOR:
						grid[x][y].tile = Globals.tiles.EMPTY
		else:
			return
	
	push_error("Dungeon 1 generation failed, can't connect rooms")
