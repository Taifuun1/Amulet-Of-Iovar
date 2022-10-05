extends BaseLevel

onready var storageAreaSpawn = preload("res://Level Generation/Premade Levels/Storage Area/StorageAreaSpawns.gd").new()

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	pathFind(Globals.blockedTiles)
	enemyPathfinding(grid)
	
	cleanOutPremadeTilemap()
	
	return self

func createDungeon():
	getGenerationGrid()
	getSpawnableFloors(["FLOOR_WOOD_BRICK"])
	
	var _groups = get_groups()
	if _groups[0] == "Storage Area 1":
		stairs = {
			"downStair": Vector2(30,11),
			"upStair": Vector2(20,14)
		}
		placePresetItems(storageAreaSpawn.storageAreaSpawn1, self)
	elif _groups[0] == "Storage Area 2":
		stairs = {
			"downStair": Vector2(30,2),
			"upStair": Vector2(30,16)
		}
		placePresetItems(storageAreaSpawn.storageAreaSpawn2, self)
