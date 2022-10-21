extends BaseLevel

onready var tidohMinesEndtSpawns = preload("res://Level Generation/Premade Levels/Tidoh Mines End/TidohMinesEndSpawns.gd").new()

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
	
	var _groups = get_groups()
	if _groups[0] == "Tidoh Mines End 1":
		stairs = {
			"upStair": Vector2(21,12)
		}
		placePresetItems(tidohMinesEndtSpawns.tidohMinesEndSpawn1, self)
		placePresetCritters(tidohMinesEndtSpawns.tidohMinesEndSpawn1, self)
	if _groups[0] == "Tidoh Mines End 2":
		stairs = {
			"upStair": Vector2(28,11)
		}
		placePresetItems(tidohMinesEndtSpawns.tidohMinesEndSpawn2, self)
		placePresetCritters(tidohMinesEndtSpawns.tidohMinesEndSpawn2, self)
