extends WaveFunctionCollapse

func createNewLevel():
	createGrid(Globals.tiles.GRASS)
	pathFind([])
	
	createDungeon()
	removeInputs()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	for _i in range(10):
		# Forest generation
		addInputs("Abandoned Outpost", get_script().get_path().get_base_dir() + "/Forest")
		createAbandonedOutpost()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("GRASS")
		generateForest()
		resetGeneration()
		removeInputs()
		
		
		# Outpost building generation
		addInputs("Abandoned Outpost", get_script().get_path().get_base_dir() + "/AbandonedOutpost")
		createAbandonedOutpost()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("GRASS")
		generateOutpostBuilding()
		resetGeneration()
		removeInputs()
		
		
		# Random diggables
		getGrassTiles()
		generateDiggables()
		
		
		placeDoors({
			"min": 1,
			"max": 1
		})
		getSpawnableTiles(
			["GRASS", "FLOOR_STONE_BRICK"],
			["GRASS", "FLOOR_STONE_BRICK"],
			["GRASS", "FLOOR_STONE_BRICK"]
		)
		placeStairs()
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate abandoned outpost")

func createAbandonedOutpost():
	for _i in range(40):
		if generateMap(10) and getUsedCells() > 1750:
			return
		resetGeneration()

func generateForest():
	var _splits = (randi() % 3 + 2) + 10
	var _splotches = []
	for _split in _splits:
		_splotches.append({
			"spot": Vector2(randi() % int(Globals.gridSize.x), randi() % int(Globals.gridSize.y)),
			"distance": randi() % 6 + 6
		})
	placeTilesInArea({ "splotches": _splotches })

func generateOutpostBuilding():
	getAndCleanUpGeneratedRooms([
		{
			"floor": "FLOOR_STONE_BRICK",
			"wall": "WALL_STONE_BRICK"
		}
	])
	var _selectedRoom = rooms[randi() % rooms.size()]
	rooms = [_selectedRoom]
	var _floorChance = randi() % 3 + 3
	for _wall in _selectedRoom.walls:
		grid[_wall.x][_wall.y].tile = Globals.tiles.WALL_STONE_BRICK
	for _floor in _selectedRoom.floors:
		if randi() % 4 + 2 < _floorChance:
			grid[_floor.x][_floor.y].tile = Globals.tiles.FLOOR_STONE_BRICK
			if randi() % 8 == 0:
				$"/root/World/Items/Items".createItem($"/root/World/Items/Items".getRandomItem(false), _floor, 1, false, {  }, self)
			if randi() % 20:
				placeContainers({
					"chest": {
						"amount": 1,
						"tile": _floor
					}
				})
		else:
			grid[_floor.x][_floor.y].tile = Globals.tiles.GRASS

func getAndCleanUpGeneratedRooms(_tileTypes):
	# Get floors
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			for _tileType in _tileTypes:
				if generatedGrid[x][y].tile == Globals.tiles[_tileType.floor] and !isTileAlreadyInAGeneratedRoom(Vector2(x,y)):
					rooms.append({
						"floors": getGeneratedRoom(Vector2(x, y), _tileType),
						"walls": []
					})
					break
	
	# Get walls
	for _room in rooms:
		var _walls = []
		for _floorTile in _room.floors:
			for _tileType in _tileTypes:
				for _adjacentTile in checkAdjacentTilesForTileInGenerated(_floorTile, [_tileType.wall]):
					_walls.append(_adjacentTile)
		_room.walls = _walls
	
	# Remove small rooms
	var _indexCount = 0
	for _roomIndex in rooms.duplicate(true).size() - 1:
		if rooms[_roomIndex - _indexCount].floors.size() < 8:
			rooms.remove(_roomIndex - _indexCount)
			_indexCount += 1

func getGeneratedRoom(_tile, _tileType):
	var _roomTiles = [_tile]
	var _adjacentTiles = checkAdjacentTilesForTileInGenerated(_tile, [_tileType.floor])
	_roomTiles.append_array(_adjacentTiles)
	while !_adjacentTiles.empty():
		for _adjacentTile in checkAdjacentTilesForTileInGenerated(_adjacentTiles.pop_back(), [_tileType.floor]):
			if !_roomTiles.has(_adjacentTile):
				_adjacentTiles.append(_adjacentTile)
				_roomTiles.append(_adjacentTile)
	return _roomTiles

func isTileAlreadyInAGeneratedRoom(_tile):
	for _room in rooms:
		for _floor in _room.floors:
			if _floor == _tile:
				return true
		for _wall in _room.walls:
			if _wall == _tile:
				return true
	return false

func checkAdjacentTilesForTileInGenerated(_tile, _tileTypes, _checkForTile = true):
	var _tiles = []
	var _directions = [
		Vector2(-1, -1),
		Vector2(0, -1),
		Vector2(1, -1),
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(0, 1),
		Vector2(-1, 1),
		Vector2(-1, 0)
	]
	for _direction in _directions:
		var _checkedTilePosition = Vector2(_tile.x + _direction.x, _tile.y + _direction.y)
		if !isOutSideTileMap(_checkedTilePosition):
			if isTileOneOfTypesInGenerated(_checkedTilePosition, _tileTypes) and _checkForTile:
				_tiles.append(_checkedTilePosition)
			elif !isTileOneOfTypesInGenerated(_checkedTilePosition, _tileTypes) and !_checkForTile:
				_tiles.append(_checkedTilePosition)
	return _tiles

func isTileOneOfTypesInGenerated(_checkedTilePosition, _tileTypes):
	for _tileType in _tileTypes:
		if generatedGrid[_checkedTilePosition.x][_checkedTilePosition.y].tile == Globals.tiles[_tileType]:
			return true
	return false

func getGrassTiles():
	additionalData.grassTiles = []
	for x in grid.size():
		for y in grid[0].size():
			if grid[x][y].tile == Globals.tiles.GRASS and !additionalData.grassTiles.has(Vector2(x, y)):
				additionalData.grassTiles.append(Vector2(x, y))

func generateDiggables():
	var _diggables = randi() % 4 + 3
	for _tile in additionalData.grassTiles:
		if randi() % 25 == 0 and _diggables > 0:
			grid[_tile.x][_tile.y].interactable = Globals.interactables.DIGGABLE
			_diggables -= 1
