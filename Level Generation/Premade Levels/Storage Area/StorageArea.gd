extends BaseLevel

onready var storageAreaSpawns = preload("res://Level Generation/Premade Levels/Storage Area/StorageAreaSpawns.gd").new()

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
		["GRASS", "FLOOR_WOOD_BRICK"],
		[],
		[]
	)
	
	var _groups = get_groups()
	if _groups[0] == "Storage Area 1":
		stairs = {
			"downStair": Vector2(30,11),
			"upStair": Vector2(20,14)
		}
		placePresetItems(storageAreaSpawns.storageAreaSpawn1, self)
	elif _groups[0] == "Storage Area 2":
		stairs = {
			"downStair": Vector2(30,2),
			"upStair": Vector2(30,16)
		}
		placePresetItems(storageAreaSpawns.storageAreaSpawn2, self)
