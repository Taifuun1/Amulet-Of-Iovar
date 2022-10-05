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
		"downStair": Vector2(55,20),
		"upStair": Vector2(4,2)
	}
	getGenerationGrid()
	getSpawnableFloors(["CORRIDOR_DUNGEON"])
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
