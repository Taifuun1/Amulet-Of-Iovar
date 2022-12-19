extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	removeInputs()
	
	doFinalPathfinding()
	
	return self

func createDungeon(_patchType = "carrot"):
	for _i in range(10):
		# Farm land generation
		if _patchType.matchn("carrot") or _patchType.matchn("fruit"):
			addInputs("Patch", get_script().get_path().get_base_dir() + "/Farm Land")
#			elif :
#				addInputs("Patch", get_script().get_path().get_base_dir() + "/Fruit Patch")
			createPatch()
			trimGenerationEdges()
			getGenerationGrid()
			fillEmptyGenerationTiles("GRASS")
			fillGridWithGeneratedGrid()
			resetGeneration()
			removeInputs()
		
		
		# Forest generation
		if randi() % 2 == 0:
			addInputs("Patch", get_script().get_path().get_base_dir() + "/Forest Sparse")
		else:
			addInputs("Patch", get_script().get_path().get_base_dir() + "/Forest Thick")
		createPatch()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("GRASS")
		if randi() % 2 == 0:
			generateForest("thirds", _patchType)
		else:
			generateForest("splotches", _patchType)
		resetGeneration()
		removeInputs()
		
		
		# Soil areas
		getSoilAreas()
		
		
		# Buildings generation
		addInputs("Patch", get_script().get_path().get_base_dir() + "/Buildings")
		createPatch()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("GRASS")
		generateBuildings()
		resetGeneration()
		removeInputs()
		
		
		# Soil area items and interactables
		generateSoilAreaInteractablesAndItems(_patchType)
		
		
		placeDoors({
			"min": 1,
			"max": 1
		})
		getSpawnableTiles(
			["GRASS", "SOIL", "FLOOR_WOOD_BRICK"],
			["GRASS", "FLOOR_WOOD_BRICK"],
			["GRASS", "SOIL", "FLOOR_WOOD_BRICK"]
		)
		placeStairs()
		if areAllStairsConnected():
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate mines of tidoh")

func createPatch():
	for _i in range(40):
		if generateMap(randi() % 5) and getUsedCells() > 1750:
			return
		resetGeneration()

func generateForest(_splitType, _patchType):
	if _patchType.matchn("forest"):
		fillGridWithGeneratedGrid()
		return
	if _splitType.matchn("thirds"):
		var _splits = randi() % 2 + 1
		var _tilesFromSide = 20 * _splits
		if randi() % 2 == 0:
			placeTilesInArea({
				"side": "west",
				"tilesFromSide": _tilesFromSide
			})
		else:
			placeTilesInArea({
				"side": "east",
				"tilesFromSide": _tilesFromSide
			})
	elif _splitType.matchn("splotches"):
		var _splits = (randi() % 3 + 1) + 2
		var _splotches = []
		for _split in _splits:
			_splotches.append({
				"spot": Vector2(randi() % int(Globals.gridSize.x), randi() % int(Globals.gridSize.y)),
				"distance": randi() % 10 + 4
			})
		placeTilesInArea({
			"splotches": _splotches
		})

func getSoilAreas():
	# Get areas
	for x in grid.size():
		for y in grid[0].size():
			if grid[x][y].tile == Globals.tiles.SOIL and !isTileAlreadyInAnArea(Vector2(x, y)):
				areas.append(getArea(Vector2(x, y), "SOIL"))
	
	# Remove smaller areas
	for _area in areas.duplicate(true):
		if _area.size() <= 5:
			for _tile in _area:
				grid[_tile.x][_tile.y].tile = Globals.tiles.GRASS
			areas.erase(_area)

func generateBuildings():
	getAndCleanUpGeneratedRooms([
		{
			"floor": "FLOOR_WOOD_BRICK",
			"wall": "WALL_WOOD_PLANK"
		}
	])
	if rooms != null and rooms.size() > 0:
		var _pickedRooms = []
		var rooms = rooms.duplicate(true)
		for _roomCount in randi() % 4 + 2:
			_pickedRooms.append(rooms.pop_at(randi() % rooms.size()))
		rooms = _pickedRooms
		for _room in rooms:
			for _floor in _room.floors:
				if isTileAlreadyInAnArea(_floor):
					for _area in areas.duplicate(true):
						if _area.has(_floor):
							for _tile in _area:
								grid[_tile.x][_tile.y].tile = Globals.tiles.GRASS
							areas.erase(_area)
							break
				grid[_floor.x][_floor.y].tile = Globals.tiles.FLOOR_WOOD_BRICK
			for _wall in _room.walls:
				if isTileAlreadyInAnArea(_wall):
					for _area in areas.duplicate(true):
						if _area.has(_wall):
							for _tile in _area:
								grid[_tile.x][_tile.y].tile = Globals.tiles.GRASS
							areas.erase(_area)
							break
				var _soilTiles = checkAdjacentTilesForTile(_wall, ["SOIL"])
				for _soilTile in _soilTiles:
					for _area in areas.duplicate(true):
						if _area.has(_soilTile):
							for _tile in _area:
								grid[_tile.x][_tile.y].tile = Globals.tiles.GRASS
							areas.erase(_area)
							break
				grid[_wall.x][_wall.y].tile = Globals.tiles.WALL_WOOD_PLANK

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
	
	# Clean up missing walls
	for _room in rooms:
		for _floorTile in _room.floors:
			for _tileType in _tileTypes:
				if generatedGrid[_floorTile.x][_floorTile.y].tile == Globals.tiles[_tileType.floor]:
					for _adjacentTile in checkAdjacentTilesForTileInGenerated(_floorTile, [_tileType.floor, _tileType.wall], false):
						generatedGrid[_adjacentTile.x][_adjacentTile.y].tile = Globals.tiles[_tileType.wall]
	
	# Get walls
	for _room in rooms:
		var _walls = []
		for _floorTile in _room.floors:
			for _tileType in _tileTypes:
				for _adjacentTile in checkAdjacentTilesForTileInGenerated(_floorTile, [_tileType.wall]):
					_walls.append(_adjacentTile)
		_room.walls = _walls
	
	# Remove small rooms
	var _removedRooms = []
	for _roomIndex in rooms.duplicate(true).size():
		if rooms[_roomIndex].floors.size() < 4:
			_removedRooms.append(rooms[_roomIndex])
	for _room in _removedRooms:
		for _floor in _room.floors:
			generatedGrid[_floor.x][_floor.y].tile = Globals.tiles.GRASS
		for _wall in _room.walls:
			generatedGrid[_wall.x][_wall.y].tile = Globals.tiles.GRASS
		rooms.erase(_room)

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

func generateSoilAreaInteractablesAndItems(_patchType):
	for _area in areas:
		var _areaRandomness = randi() % 101
		for _tile in _area:
			if randi() % 61 < _areaRandomness:
				if _patchType.matchn("carrot"):
					if randi() % 12 == 0:
						grid[_tile.x][_tile.y].interactable = Globals.interactables.PLANT_TOMATO
					elif randi() % 8 == 0:
						grid[_tile.x][_tile.y].interactable = Globals.interactables.PLANT_BEAN
					elif randi() % 4 == 0:
						grid[_tile.x][_tile.y].interactable = Globals.interactables.PLANT
					else:
						grid[_tile.x][_tile.y].interactable = Globals.interactables.PLANT_CARROT
				elif _patchType.matchn("fruit"):
					if randi() % 3 == 0:
						grid[_tile.x][_tile.y].interactable = Globals.interactables.PLANT_ORANGE
