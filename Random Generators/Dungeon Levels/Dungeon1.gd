extends AStarPath

var tiles

var dungeonType = "dungeon1"

var grid = []
var rooms = []
var spawnableFloors = []

var critters = []

func setName():
	var level = Globals.levelId
	name = str(Globals.levelId)
	Globals.levelId += 1
	return level

func createNewLevel(_tiles, _isFirstLevel = false):
	tiles = _tiles
	
	# Create rooms with doors and staircases
	for _x in range(Globals.gridSize.x):
		grid.append([])
		for _y in range(Globals.gridSize.y):
			grid[_x].append({
				"tile": tiles.EMPTY,
				"critter": null,
				"items": []
			})
	
	var response = createDungeon()
	if response.error != null:
		return {
			"error": response.error
		}
	
	# Create corridors
	pathFind(grid, tiles)
	for room in rooms:
		for door in room:
			var randomEndPointRoom
			var endPointDoor
			while(true):
				randomEndPointRoom = rooms[randi() % rooms.size()]
				endPointDoor = randomEndPointRoom[randi() % randomEndPointRoom.size()]
				if(door != endPointDoor):
					break
			var path = calculatePath(door, endPointDoor)
			for point in path:
				if grid[point.x][point.y].tile != tiles.DOOR:
					grid[point.x][point.y].tile = tiles.CORRIDOR
	
	return grid.duplicate()

func createDungeon():
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
						grid[x][y].tile = tiles.FLOOR
						spawnableFloors.append(Vector2(x, y))
				for x in range(int(roomPlacement.x) - (int(roomSize.x) / 2), int(roomPlacement.x) + (int(roomSize.x) / 2)):
					for y in range(int(roomPlacement.y) - (int(roomSize.y) / 2), int(roomPlacement.y) + (int(roomSize.y) / 2)):
						if grid[x][y].tile != tiles.FLOOR:
							grid[x][y].tile = tiles.WALL
				if !placeDoors({
					"roomPlacement": roomPlacement,
					"roomSize": roomSize,
				}):
					continue
				break
			else:
				continue
	placeStairs(false)
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
		grid[placement.x][placement.y].tile = tiles.DOOR
		rooms.back().append(placement)
	return true

func placeStairs(_isDouble):
	var double = _isDouble
	for _i in range(100):
		var x = randi() % (grid.size() - 1)
		var y = randi() % (grid[x].size() - 1)
		if(grid[x][y].tile == tiles.FLOOR):
			grid[x][y].tile = tiles.DOWN_STAIR
			if double:
				double = false
				continue
			else:
				break
	for _i in range(100):
		var x = randi() % grid.size()
		var y = randi() % grid[x].size()
		if(grid[x][y].tile == tiles.FLOOR):
			grid[x][y].tile = tiles.UP_STAIR
			break

func checkIfRoomIsInvalid(roomPlacement, roomSize):
	for x in range(int(roomPlacement.x) - ((int(roomSize.x) / 2) + 1), int(roomPlacement.x) + ((int(roomSize.x) / 2) + 1)):
		for y in range(int(roomPlacement.y) - ((int(roomSize.y) / 2) + 1), int(roomPlacement.y) + ((int(roomSize.y) / 2) + 1)):
			if grid[x][y].tile == tiles.FLOOR or grid[x][y].tile == tiles.WALL:
				return true
	return false
