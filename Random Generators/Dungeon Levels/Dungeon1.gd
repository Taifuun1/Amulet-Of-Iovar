extends BaseLevel

var isDouble

func createNewLevel(_isDouble = false):
	isDouble = _isDouble
	
	createGrid()
	
	createDungeon()
	
	enemyPathfinding(grid)
	
	return self

func createDungeon():
	createRooms()
	
	# Create corridors
	pathfindDungeonCorridors()
	for room in rooms:
		for door in room:
			var randomEndPointRoom
			var endPointDoor
			while(true):
				randomEndPointRoom = rooms[randi() % rooms.size()]
				endPointDoor = randomEndPointRoom[randi() % randomEndPointRoom.size()]
				if(door != endPointDoor and randomEndPointRoom != room):
					break
			var path = calculateCorridorsPath(door, endPointDoor)
			for point in path:
				if grid[point.x][point.y].tile != Globals.tiles.CLOSED_DOOR:
					grid[point.x][point.y].tile = Globals.tiles.CORRIDOR
	
	placeStairs("DUNGEON", isDouble)

func createRooms():
	for _room in range(randi() % 2 + 5):
		for _createAttempts in range(100):
			var roomPlacement = Vector2(randi() % (int(Globals.gridSize.x) - 1) + 1, randi() % (int(Globals.gridSize.y) - 1) + 1)
			var roomSize = Vector2(randi() % 8 + 6, randi() % 8 + 6)
			if (
				(
					int(roomPlacement.x) - (int(roomSize.x / 2) + 1) > 0 and
					int(roomPlacement.x) + (int(roomSize.x / 2)) < Globals.gridSize.x and
					int(roomPlacement.y) - (int(roomSize.y / 2) + 1) > 0 and
					int(roomPlacement.y) + (int(roomSize.y / 2)) < Globals.gridSize.y
				)
			):
				if checkIfRoomIsInvalid(roomPlacement, roomSize):
					continue
				for x in range(int(roomPlacement.x) - ((int(roomSize.x) / 2) - 1), int(roomPlacement.x) + ((int(roomSize.x) / 2) - 1)):
					for y in range(int(roomPlacement.y) - ((int(roomSize.y) / 2) - 1), int(roomPlacement.y) + ((int(roomSize.y) / 2) - 1)):
						grid[x][y].tile = Globals.tiles.FLOOR_DUNGEON
						spawnableFloors.append(Vector2(x, y))
				for x in range(int(roomPlacement.x) - (int(roomSize.x) / 2), int(roomPlacement.x) + (int(roomSize.x) / 2)):
					for y in range(int(roomPlacement.y) - (int(roomSize.y) / 2), int(roomPlacement.y) + (int(roomSize.y) / 2)):
						if grid[x][y].tile != Globals.tiles.FLOOR_DUNGEON:
							grid[x][y].tile = Globals.tiles.WALL_DUNGEON
				if !placeDoors({
					"roomPlacement": roomPlacement,
					"roomSize": roomSize,
				}):
					continue
				break
			else:
				continue

func placeDoors(room):
	var placement
	rooms.append([])
	for _door in range(randi() % 3 + 1):
		if randi() % 2 == 1:
			if randi() % 2 == 1:
				placement = Vector2(randi() % (int(room.roomSize.x) - 3) + (int(room.roomPlacement.x) - ((int(room.roomSize.x) / 2) - 1)), int(room.roomPlacement.y) - (int(room.roomSize.y) / 2))
			else:
				placement = Vector2(randi() % (int(room.roomSize.x) - 3) + (int(room.roomPlacement.x) - ((int(room.roomSize.x) / 2) - 1)), int(room.roomPlacement.y) + ((int(room.roomSize.y) / 2) - 1))
		else:
			if randi() % 2 == 1:
				placement = Vector2(int(room.roomPlacement.x) - (int(room.roomSize.x) / 2), randi() % (int(room.roomSize.y) - 3) + (int(room.roomPlacement.y) - ((int(room.roomSize.y) / 2) - 1)))
			else:
				placement = Vector2(int(room.roomPlacement.x) + ((int(room.roomSize.x) / 2) - 1), randi() % (int(room.roomSize.y) - 3) + (int(room.roomPlacement.y) - ((int(room.roomSize.y) / 2) - 1)))
		grid[placement.x][placement.y].tile = Globals.tiles.CLOSED_DOOR
		rooms.back().append(placement)
	return true

func checkIfRoomIsInvalid(roomPlacement, roomSize):
	for x in range(int(roomPlacement.x) - ((int(roomSize.x) / 2) + 1), int(roomPlacement.x) + ((int(roomSize.x) / 2) + 1)):
		for y in range(int(roomPlacement.y) - ((int(roomSize.y) / 2) + 1), int(roomPlacement.y) + ((int(roomSize.y) / 2) + 1)):
			if grid[x][y].tile == Globals.tiles.FLOOR_DUNGEON or grid[x][y].tile == Globals.tiles.WALL_DUNGEON:
				return true
	return false
