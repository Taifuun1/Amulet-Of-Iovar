extends BaseLevel

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	doFinalPathfinding()
	cleanOutPremadeTilemap()
	
	return self

func createDungeon():
	getGenerationGrid()
	getSpawnableTiles(
		["GRASS", "GRASS_LIGHT", "SIDEWALK", "FLOOR_DUNGEON", "FLOOR_CAVE"],
		["FLOOR_DUNGEON", "FLOOR_CAVE"],
		["FLOOR_CAVE"]
	)
	
	stairs = {
		"downStair": Vector2(55,20),
		"upStair": Vector2(4,2)
	}
