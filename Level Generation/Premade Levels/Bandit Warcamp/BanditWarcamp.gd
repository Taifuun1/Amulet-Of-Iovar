extends BaseLevel

onready var banditWarcampSpawns = preload("res://Level Generation/Premade Levels/Bandit Warcamp/BanditWarcampSpawns.gd").new()

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	getGenerationGrid()
	getSpawnableTiles(
		["GRASS", "GRASS_DARK", "GRASS_LIGHT", "FLOOR_BRICK_SMALL", "ROAD_GRASS", "FLOOR_BRICK_SMALL", "FLOOR_STONE_BRICK"],
		["GRASS", "GRASS_DARK", "GRASS_LIGHT", "FLOOR_BRICK_SMALL", "FLOOR_STONE_BRICK"],
		["GRASS", "GRASS_DARK", "GRASS_LIGHT", "ROAD_GRASS"]
	)
	
	var _groups = get_groups()
	if _groups[0] == "Bandit Warcamp 1":
		stairs = {
			"downStair": Vector2(56,21),
			"upStair": Vector2(2,10)
		}
		placePresetItems(banditWarcampSpawns.banditWarcampSpawn1, self)
		placePresetCritters(banditWarcampSpawns.banditWarcampSpawn1, self)
	if _groups[0] == "Bandit Warcamp 2":
		stairs = {
			"downStair": Vector2(5,5),
			"upStair": Vector2(51,17)
		}
		placePresetItems(banditWarcampSpawns.banditWarcampSpawn2, self)
		placePresetCritters(banditWarcampSpawns.banditWarcampSpawn2, self)
