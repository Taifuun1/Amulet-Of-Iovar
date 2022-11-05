extends BaseLevel

onready var churchSpawns = preload("res://Level Generation/Premade Levels/Church/ChurchSpawns.gd").new()

func createNewLevel():
	createGrid()
	pathFind([])
	
	createDungeon()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	getGenerationGrid()
	getSpawnableTiles(
		["GRASS", "SIDEWALK", "CORRIDOR_STONE"],
		[],
		[]
	)
	
	stairs = {
		"downStair": Vector2(2,11)
	}
	placePresetCritters(churchSpawns.churchSpawn, self)
	
	grid[53][11].interactable = Globals.interactables.ALTAR
