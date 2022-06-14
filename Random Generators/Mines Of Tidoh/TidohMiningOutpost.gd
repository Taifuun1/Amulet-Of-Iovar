extends BaseLevel

#var rooms = [
#	[],
#	[]
#]

#var stairs = {
#	"downStair": null,
#	"secondDownStair": null,
#	"upStair": null
#}

var outpostDoors = [
	[],
	[]
]

var outpostArea = {
	1: Vector2(16, 2),
	2: Vector2(43, 21)
}
var caveAreas = [
	[
		Vector2(1, 1),
		Vector2(1, 13)
	],
	[
		Vector2(47, 1),
		Vector2(47, 13)
	]
]

func createNewLevel():
	rooms.append([])
	rooms.append([])
	
	stairs = {
		"downStair": null,
		"secondDownStair": null,
		"upStair": null
	}
	
	# Create rooms with doors and staircases
	for _x in range(Globals.gridSize.x):
		grid.append([])
		for _y in range(Globals.gridSize.y):
			grid[_x].append({
				"tile": Globals.tiles.EMPTY,
				"critter": null,
				"items": []
			})
	
	createOutpostAreas()
	createCaveAreas()
	
	pathFindCorridors(grid)
	for side in range(rooms.size()):
		for room in rooms[side]:
			for door in room:
				var outpostEndpointDoor = outpostDoors[side][0]
				var path = calculateCorridorsPath(door, outpostEndpointDoor)
				for point in path:
					if grid[point.x][point.y].tile != Globals.tiles.DOOR:
						grid[point.x][point.y].tile = Globals.tiles.CORRIDOR
	
	enemyPathFinding(grid)
	
	return self

func createOutpostAreas():
	for _x in range(Globals.gridSize.x):
		for _y in range(Globals.gridSize.y):
			if (
				(
					_x == outpostArea[1].x - 1 and
					(
						_y >= outpostArea[1].y - 1 and
						_y <= outpostArea[2].y + 1
					)
				) or
				(
					_x == outpostArea[2].x + 1 and
					(
						_y >= outpostArea[1].y - 1 and
						_y <= outpostArea[2].y + 1
					)
				) or
				(
					_y == outpostArea[1].y - 1 and
					(
						_x >= outpostArea[1].x - 1 and
						_x <= outpostArea[2].x + 1
					)
				) or
				(
					_y == outpostArea[2].y + 1 and
					(
						_x >= outpostArea[1].x - 1 and
						_x <= outpostArea[2].x + 1
					)
				)
			):
				grid[_x][_y].tile = Globals.tiles.SIDEWALK
			else:
				grid[_x][_y].tile = Globals.tiles.EMPTY
	
	for _y in range(Globals.gridSize.y):
		grid[outpostArea[1].x - 2][_y].tile = Globals.tiles.WALL
	
	for _y in range(Globals.gridSize.y):
		grid[outpostArea[2].x + 2][_y].tile = Globals.tiles.WALL
	
	for _x in range(outpostArea[1].x - 1, outpostArea[2].x + 2):
		grid[_x][0].tile = Globals.tiles.WALL
	
	for _x in range(outpostArea[1].x - 1, outpostArea[2].x + 2):
		grid[_x][Globals.gridSize.y - 1].tile = Globals.tiles.WALL
	
	for _y in range(outpostArea[1].y, outpostArea[2].y):
		for _x in range(outpostArea[1].x, outpostArea[2].x):
			if grid[_x][_y].tile == Globals.tiles.EMPTY:
				var _fullAreaSize = checkIfAreaIsViableForRoom(_x, _y)
				if _fullAreaSize:
					var _areaX = int(_fullAreaSize.x - 3)
					var _areaY = int(_fullAreaSize.y - 3)
					var _areaSize = Vector2(randi() % _areaX + 3, randi() % _areaY + 3)
					for _areaSizeX in range(_x, _x + _areaSize.x + 1):
						for _areaSizeY in range(_y, _y + _areaSize.y + 1):
							if (
								(
									_areaSizeX == _x and 
									(
										_areaSizeY >= _y and
										_areaSizeY <= _y + _areaSize.y
									)
								) or
								(
									_areaSizeX == _x + _areaSize.x and 
									(
										_areaSizeY >= _y and
										_areaSizeY <= _y + _areaSize.y
									)
								) or
								(
									_areaSizeY == _y and 
									(
										_areaSizeX >= _x and
										_areaSizeX <= _x + _areaSize.x
									)
								) or
								(
									_areaSizeY == _y + _areaSize.y and 
									(
										_areaSizeX >= _x and
										_areaSizeX <= _x + _areaSize.x
									)
								)
							):
								grid[_areaSizeX][_areaSizeY].tile = Globals.tiles.WALL
							else:
								grid[_areaSizeX][_areaSizeY].tile = Globals.tiles.FLOOR
					for _areaSizeX in range(_x - 1, _x + _areaSize.x + 2):
						for _areaSizeY in range(_y - 1, _y + _areaSize.y + 2):
							if (
								(
									_areaSizeX == _x + _areaSize.x + 1 and 
									(
										_areaSizeY >= _y and
										_areaSizeY <= _y + _areaSize.y + 1
									)
								) or
								(
									_areaSizeX == _x - 1 and 
									(
										_areaSizeY >= _y and
										_areaSizeY <= _y + _areaSize.y + 1
									)
								) or
								(
									_areaSizeY == _y + _areaSize.y + 1 and 
									(
										_areaSizeX >= _x and
										_areaSizeX <= _x + _areaSize.x + 1
									)
								) or
								(
									_areaSizeY == _y - 1 and 
									(
										_areaSizeX >= _x and
										_areaSizeX <= _x + _areaSize.x + 1
									)
								)
							):
								grid[_areaSizeX][_areaSizeY].tile = Globals.tiles.SIDEWALK
	
	placeOutpostDoors()
	
	fillOutpostEmptySpaces()

func fillOutpostEmptySpaces():
	for _x in range(outpostArea[1].x, outpostArea[2].x + 1):
		for _y in range(outpostArea[1].y, outpostArea[2].y + 1):
			if grid[_x][_y].tile == Globals.tiles.EMPTY:
				var _fullArea = checkIfAreaIsViableForPark(_x, _y)
				if _fullArea.viable:
					for _areaSizeX in range(_x, _x + _fullArea.length.x):
						for _areaSizeY in range(_y, _y + _fullArea.length.y):
							grid[_areaSizeX][_areaSizeY].tile = Globals.tiles.GRASS
				else:
					for _areaSizeX in range(_x, _x + _fullArea.length.x):
						for _areaSizeY in range(_y, _y + _fullArea.length.y):
							grid[_areaSizeX][_areaSizeY].tile = Globals.tiles.SIDEWALK

func checkIfAreaIsViableForPark(_x, _y):
	var lengthX = 0
	var lengthY = 0
	lengthX = getAreaXSideLength(_x, _y, 50)
	lengthY = getAreaYSideLength(_x, _y, 50)
	if (lengthX >= 4 and lengthY >= 2) or (lengthX >= 2 and lengthY >= 4):
		return {
			"viable": true,
			"length": Vector2(lengthX, lengthY)
		}
	return {
		"viable": false,
		"length": Vector2(lengthX, lengthY)
	}

func checkIfAreaIsViableForRoom(_x, _y):
	var lengthX = 0
	var lengthY = 0
	var maxLengthX = 16
	var maxLengthY = 12
	if outpostArea[2].x - _x < 16 and outpostArea[2].x - _x > 7:
		maxLengthX = outpostArea[2].x - _x + 1
	if outpostArea[2].y - _y < 12 and outpostArea[2].y - _y > 3:
		maxLengthY = outpostArea[2].y - _y + 1
	lengthX = getAreaXSideLength(_x, _y, maxLengthX)
	lengthY = getAreaYSideLength(_x, _y, maxLengthY)
	
	if lengthX >= 4 and lengthY >= 4:
		return Vector2(lengthX, lengthY)
	return null

func getAreaXSideLength(_x, _y, maxLength):
	var length = 0
	for _areaX in range(_x, _x + maxLength):
		if grid[_areaX][_y].tile == Globals.tiles.WALL or grid[_areaX][_y].tile == Globals.tiles.SIDEWALK or length == maxLength:
			return length
		length += 1
	return length

func getAreaYSideLength(_x, _y, maxLength):
	var length = 0
	for _areaY in range(_y, _y + maxLength):
		length += 1
		if grid[_x][_areaY].tile == Globals.tiles.WALL or grid[_x][_areaY].tile == Globals.tiles.SIDEWALK or grid[_x][_areaY].tile == Globals.tiles.FLOOR or length == 8:
			if _areaY == 22 or grid[_x][_areaY].tile == Globals.tiles.WALL or grid[_x][_areaY].tile == Globals.tiles.SIDEWALK:
				length -= 1
			return length
	return length

func createCaveAreas():
	var _side = randi() % 2
	createCaveArea(_side, Globals.tiles.UP_STAIR)
	if _side == 1:
		createCaveArea(0, Globals.tiles.DOWN_STAIR)
	else:
		createCaveArea(1, Globals.tiles.DOWN_STAIR)

func createCaveArea(_side, _stair):
	var _rooms = randi() % 2 + 1
	if _rooms == 1:
		var _roomPlacement = Vector2(randi() % 3 + caveAreas[_side][0].x, randi() % 2 + caveAreas[_side][0].y )
		var _roomSize = Vector2(randi() % 3 + 7, randi() % 12 + 10 )
		var _availableStairFloors = createRoom(_roomPlacement, _roomSize)
		placeDoors({
			"roomPlacement": _roomPlacement,
			"roomSize": _roomSize,
		}, _side)
		placeStair(_availableStairFloors, _stair)
	else:
		for _room in range(_rooms):
			var _roomPlacement = Vector2(randi() % 5 + caveAreas[_side][_room].x, randi() % 4 + caveAreas[_side][_room].y )
			var _roomSize = Vector2(randi() % 3 + 4, randi() % 1 + 4 )
			var _availableStairFloors = createRoom(_roomPlacement, _roomSize)
			placeDoors({
				"roomPlacement": _roomPlacement,
				"roomSize": _roomSize,
			}, _side)
			if _room + 1 == 1:
				placeStair(_availableStairFloors, _stair)

func createRoom(_roomPlacement, _roomSize):
	var _availableStairFloors = []
	for x in range(int(_roomPlacement.x) + 1, int(_roomPlacement.x) + (int(_roomSize.x) - 1)):
		for y in range(int(_roomPlacement.y) + 1, int(_roomPlacement.y) + (int(_roomSize.y) - 1)):
			grid[x][y].tile = Globals.tiles.FLOOR
			_availableStairFloors.append(Vector2(x,y))
			spawnableFloors.append(Vector2(x,y))
	for x in range(int(_roomPlacement.x), int(_roomPlacement.x) + int(_roomSize.x)):
		for y in range(int(_roomPlacement.y), int(_roomPlacement.y) + int(_roomSize.y)):
			if grid[x][y].tile != Globals.tiles.FLOOR:
				grid[x][y].tile = Globals.tiles.WALL
	return _availableStairFloors

func placeStair(_availableStairFloors, _stair):
	var _randomFloor = _availableStairFloors[randi() % _availableStairFloors.size()]
	grid[_randomFloor.x][_randomFloor.y].tile = _stair
	if _stair == Globals.tiles.UP_STAIR:
		stairs.upStair = _randomFloor
	elif _stair == Globals.tiles.DOWN_STAIR:
		stairs.downStair = _randomFloor

func placeDoors(room, _side):
	var placement
	rooms[_side].append([])
	for _door in range(randi() % 2 + 1):
		if randi() % 2 == 1:
			if randi() % 2 == 1:
				placement = Vector2(randi() % int(room.roomSize.x - 2) + int(room.roomPlacement.x + 1), int(room.roomPlacement.y))
			else:
				placement = Vector2(randi() % int(room.roomSize.x - 2) + int(room.roomPlacement.x + 1), int(room.roomPlacement.y) + int(room.roomSize.y - 1))
		else:
			if randi() % 2 == 1:
				placement = Vector2(int(room.roomPlacement.x), randi() % int(room.roomSize.y - 2) + int(room.roomPlacement.y + 1))
			else:
				placement = Vector2(int(room.roomPlacement.x) + int(room.roomSize.x - 1), randi() % int(room.roomSize.y - 2) + int(room.roomPlacement.y + 1))
		grid[placement.x][placement.y].tile = Globals.tiles.DOOR
		rooms[_side].back().append(placement)

func placeOutpostDoors():
	for _door in range(2):
		var _y = randi() % int(outpostArea[2].y) + outpostArea[1].y
		var _x = outpostArea[_door + 1].x
		if _door == 0:
			grid[_x - 2][_y].tile = Globals.tiles.DOOR
			outpostDoors[0].append(Vector2(_x - 2, _y))
		else:
			grid[_x + 2][_y].tile = Globals.tiles.DOOR
			outpostDoors[1].append(Vector2(_x + 2, _y))
