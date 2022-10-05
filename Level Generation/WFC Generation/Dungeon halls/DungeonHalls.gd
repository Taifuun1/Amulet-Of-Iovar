extends WaveFunctionCollapse

onready var weightedAstarNode = AStar2D.new()

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	pathFind(Globals.blockedTiles)
	enemyPathfinding(grid)
	
	return self

func createDungeon():
	for _i in range(10):
		addInputs("Dungeon Halls", get_script().get_path().get_base_dir() + "/Inputs")
		createDungeonHalls()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyTiles("WALL_DUNGEON", "WALL_DUNGEON")
		getAndCleanUpDungeonHallsRooms()
		getSpawnableFloors(["FLOOR_DUNGEON"])
		placeStairs()
		checkAllRoomsAreAccessible()
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate dungeon halls")

func createDungeonHalls():
	for _i in range(40):
		if generateMap(randi() % 9 + 1) and get_used_cells().size() > 1350:
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
	updateTilemapToGrid()
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
			updateTilemapToGrid()
			pathFind([Globals.tiles.WALL_DUNGEON])
			pathFindWeightedPath([], [{ "tile": "WALL_DUNGEON", "weighting": 15 }])



#######################
### Astar functions ###
#######################

# General pathfinding
func calculateWeightedPath(pathStartPosition, pathEndPosition):
	return weightedAstarNode.get_point_path(id(pathStartPosition), id(pathEndPosition))

func pathFindWeightedPath(_illegibleTiles, _pointWeighting):
	weightedAstarNode.clear()
	connectAllWeightedCells(addLegibleWeighedTiles(_illegibleTiles, _pointWeighting))

func addLegibleWeighedTiles(_illegibleTiles, _pointWeighting):
	var points = []
	for x in (grid.size()):
		for y in (grid[x].size()):
			var point = Vector2(x, y)
			if isTileIllegibleInPathfind(point, _illegibleTiles):
				continue
			else:
				var _weight = 1.0
				for _weighting in _pointWeighting:
					if grid[x][y].tile == Globals.tiles[_weighting.tile]:
						_weight = _weighting.weighting
				points.append(point)
				weightedAstarNode.add_point(id(point), point, _weight)
	return points

func connectAllWeightedCells(points):
	for point in points:
		var pointIndex = id(point)
		var pointsRelative = PoolVector2Array([
			Vector2(point.x, point.y - 1),
			Vector2(point.x + 1, point.y - 1),
			Vector2(point.x + 1, point.y),
			Vector2(point.x + 1, point.y + 1),
			Vector2(point.x, point.y + 1),
			Vector2(point.x - 1, point.y + 1),
			Vector2(point.x - 1, point.y),
			Vector2(point.x - 1, point.y - 1)
		])
		for pointRelative in pointsRelative:
			var pointRelativeIndex = id(pointRelative)
			if isOutSideTileMap(pointRelative):
				continue
			if not weightedAstarNode.has_point(pointRelativeIndex):
				continue
			weightedAstarNode.connect_points(pointIndex, pointRelativeIndex, true)
