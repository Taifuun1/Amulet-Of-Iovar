extends BaseLevel

onready var iovarsLairSpawns = preload("res://Level Generation/Premade Levels/Iovars Lair/IovarsLairSpawns.gd").new()

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
		[
			"GRASS",
			"GRASS_LIGHT",
			"GRASS_YELLOW",
			"ROAD_GRASS",
			"FLOOR_WOOD_BRICK",
			"FLOOR_WOOD_SMALL",
			"FLOOR_STONE_BRICK",
			"FLOOR_CAVE",
			"FLOOR_CAVE_DEEP",
			"FLOOR_DRAGONS_PEAK",
			"CORRIDOR_SAND"
		],
		[
			"GRASS",
			"GRASS_YELLOW",
			"FLOOR_BRICK_SMALL"
		],
		[]
	)
	
	var _groups = get_groups()
	if _groups[0].matchn("Iovars Lair 1"):
		stairs = {
			"upStair": Vector2(52,10)
		}
		placePresetItems(iovarsLairSpawns.iovarsLairSpawn1, self)
		placePresetCritters(iovarsLairSpawns.iovarsLairSpawn1, self)
	elif _groups[0].matchn("Iovars Lair 2"):
		stairs = {
			"upStair": Vector2(33,2)
		}
		placePresetItems(iovarsLairSpawns.iovarsLairSpawn2, self)
		placePresetCritters(iovarsLairSpawns.iovarsLairSpawn2, self)
