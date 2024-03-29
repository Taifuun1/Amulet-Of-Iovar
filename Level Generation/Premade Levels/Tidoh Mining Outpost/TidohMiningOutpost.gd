extends BaseLevel

onready var tidohMiningOutpostSpawns = preload("res://Level Generation/Premade Levels/Tidoh Mining Outpost/TidohMiningOutpostSpawns.gd").new()

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	getGenerationGrid()
	getSpawnableTiles(
		["GRASS", "GRASS_LIGHT", "SIDEWALK", "FLOOR_DUNGEON", "FLOOR_CAVE"],
		["FLOOR_DUNGEON", "FLOOR_CAVE"],
		["GRASS", "FLOOR_CAVE"]
	)
	
	var _groups = get_groups()
	if _groups[0] == "Tidoh Mining Outpost 1":
		stairs = {
			"downStair": Vector2(1,4),
			"upStair": Vector2(26,11)
		}
		placePresetItems(tidohMiningOutpostSpawns.tidohMiningOutpostSpawn1, self)
		grid[1][11].interactable = Globals.interactables.ALTAR
	if _groups[0] == "Tidoh Mining Outpost 2":
		stairs = {
			"downStair": Vector2(55,20),
			"upStair": Vector2(4,2)
		}
		placePresetItems(tidohMiningOutpostSpawns.tidohMiningOutpostSpawn2, self)
		grid[26][3].interactable = Globals.interactables.ALTAR
