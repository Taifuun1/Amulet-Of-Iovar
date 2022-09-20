extends Beach

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	createResortShack()
	
	enemyPathfinding(grid)
	
	return self

func createResortShack():
	var _legibleRoomTiles = getAllLegibleRoomLocations([Globals.tiles.SAND], Vector2(4,4), Vector2(8,8))
	var _room = _legibleRoomTiles[randi() % _legibleRoomTiles.size()]
	placeRoom(_room.position, _room.size, { "wall": "WALL_BOARD", "floor": "FLOOR_SAND" }, false)
	placeDoors([1,1])
