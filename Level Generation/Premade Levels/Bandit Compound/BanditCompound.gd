extends BaseLevel

onready var banditCompoundSpawns = preload("res://Level Generation/Premade Levels/Bandit Compound/BanditCompoundSpawns.gd").new()

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	getGenerationGrid()
	getSpawnableTiles(
		["GRASS", "ROAD_GRASS", "FLOOR_BRICK_SMALL", "FLOOR_STONE_BRICK"],
		["GRASS", "FLOOR_BRICK_SMALL", "FLOOR_STONE_BRICK"],
		["GRASS", "ROAD_GRASS"]
	)
	
	var _groups = get_groups()
	if _groups[0] == "Bandit Compound 1":
		stairs = {
			"downStair": Vector2(46,14),
			"upStair": Vector2(13,21)
		}
		placePresetItems(banditCompoundSpawns.banditCompoundSpawn1, self)
		placePresetCritters(banditCompoundSpawns.banditCompoundSpawn1, self)
	if _groups[0] == "Bandit Compound 2":
		stairs = {
			"downStair": Vector2(1,8),
			"upStair": Vector2(57,17)
		}
		placePresetItems(banditCompoundSpawns.banditCompoundSpawn2, self)
		placePresetCritters(banditCompoundSpawns.banditCompoundSpawn2, self)

