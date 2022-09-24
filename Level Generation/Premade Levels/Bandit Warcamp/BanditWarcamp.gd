extends BaseLevel

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	enemyPathfinding(grid)
	
	cleanOutPremadeTilemap()
	
	return self

func createDungeon():
	stairs = {
		"downStair": Vector2(57,21),
		"upStair": Vector2(2,10)
	}
	getGenerationGrid()
	getSpawnableFloors(["GRASS", "GRASS_DARK", "GRASS_LIGHT", "FLOOR_BRICK"])
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
