extends BaseLevel

onready var elderDragonsLairSpawns = preload("res://Level Generation/Premade Levels/Elder Dragons Lair/ElderDragonsLairSpawns.gd").new()

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	getGenerationGrid()
	
	var _groups = get_groups()
	if _groups[0] == "Elder Dragons Lair 1":
		getSpawnableTiles(
			["GRASS_YELLOW", "GRASS_LIGHT", "FLOOR_DRAGONS_PEAK"],
			["GRASS_YELLOW", "GRASS_LIGHT"],
			[]
		)
		stairs = {
			"downStair": Vector2(7,16)
		}
		placePresetItems(elderDragonsLairSpawns.elderDragonsLairSpawn1, self)
	elif _groups[0] == "Elder Dragons Lair 2":
		getSpawnableTiles(
			["FLOOR_CAVE_DEEP", "FLOOR_DRAGONS_PEAK"],
			["FLOOR_CAVE_DEEP"],
			[]
		)
		stairs = {
			"downStair": Vector2(55,22)
		}
		placePresetItems(elderDragonsLairSpawns.elderDragonsLairSpawn2, self)
