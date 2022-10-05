extends BaseLevel

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	pathFind(Globals.blockedTiles)
	enemyPathfinding(grid)
	
	cleanOutPremadeTilemap()
	
	return self

func createDungeon():
	stairs = {
		"downStair": Vector2(46,14),
		"upStair": Vector2(13,21)
	}
	getGenerationGrid()
	getSpawnableFloors(["FLOOR_BRICK_SMALL", "FLOOR_STONE_BRICK"])
#	for _i in range(10):
#		createCave()
#		connectSpawnAreas()
#		expandSpawnAreas()
#		fattenCorridors()
#		placeStairs()
#		if areAllStairsConnected():
#			return
#		resetLevel()
#	push_error("Cant create premade mining outpost")
