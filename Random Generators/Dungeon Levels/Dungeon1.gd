extends AStarPath

var dungeonType = "dungeon1"

var level
var grid = []
var rooms = []
var spawnableFloors = []
var stairs = {}

var critters = []

func setName():
	level = Globals.levelId
	name = str(Globals.levelId)
	Globals.levelId += 1

func createNewLevel(_isDouble = false):
	# Create rooms with doors and staircases
	for _x in range(Globals.gridSize.x):
		grid.append([])
		for _y in range(Globals.gridSize.y):
			grid[_x].append({
				"tile": Globals.tiles.EMPTY,
				"critter": null,
				"items": []
			})
	
	var response = createDungeon(_isDouble)
	if response.error != null:
		return {
			"error": response.error
		}
	
	# Create corridors
	pathFindCorridors(grid)
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
				if grid[point.x][point.y].tile != Globals.tiles.DOOR:
					grid[point.x][point.y].tile = Globals.tiles.CORRIDOR
	
	enemyPathFinding(grid)
	
	return self

func createDungeon(_isDouble = false):
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
						grid[x][y].tile = Globals.tiles.FLOOR
						spawnableFloors.append(Vector2(x, y))
				for x in range(int(roomPlacement.x) - (int(roomSize.x) / 2), int(roomPlacement.x) + (int(roomSize.x) / 2)):
					for y in range(int(roomPlacement.y) - (int(roomSize.y) / 2), int(roomPlacement.y) + (int(roomSize.y) / 2)):
						if grid[x][y].tile != Globals.tiles.FLOOR:
							grid[x][y].tile = Globals.tiles.WALL
				if !placeDoors({
					"roomPlacement": roomPlacement,
					"roomSize": roomSize,
				}):
					continue
				break
			else:
				continue
	stairs = placeStairs(grid, spawnableFloors, _isDouble)
	return {
		"error": null
	}

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
		grid[placement.x][placement.y].tile = Globals.tiles.DOOR
		rooms.back().append(placement)
	return true

func checkIfRoomIsInvalid(roomPlacement, roomSize):
	for x in range(int(roomPlacement.x) - ((int(roomSize.x) / 2) + 1), int(roomPlacement.x) + ((int(roomSize.x) / 2) + 1)):
		for y in range(int(roomPlacement.y) - ((int(roomSize.y) / 2) + 1), int(roomPlacement.y) + ((int(roomSize.y) / 2) + 1)):
			if grid[x][y].tile == Globals.tiles.FLOOR or grid[x][y].tile == Globals.tiles.WALL:
				return true
	return false
