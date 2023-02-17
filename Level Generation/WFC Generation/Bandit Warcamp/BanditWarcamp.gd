extends WaveFunctionCollapse

func createNewLevel():
	createGrid()
	pathFind([])
	
	addInputs("Bandit Warcamp", get_script().get_path().get_base_dir() + "/Inputs")
	createDungeon()
	removeInputs()
	
	doFinalPathfinding()
	
	return self

func createDungeon():
	for _i in range(10):
		createBanditWarcamp()
		trimGenerationEdges()
		getGenerationGrid()
		fillEmptyGenerationTiles("GRASS")
		fillGridWithGeneratedGrid()
		getAndCleanUpRooms([
			{
				"floor": "FLOOR_WOOD_BRICK",
				"wall": "WALL_WOOD_PLANK"
			},
			{
				"floor": "FLOOR_STONE_BRICK",
				"wall": "WALL_STONE_BRICK"
			}
		])
		removeSmallRooms()
		getSpawnableTiles(
			["GRASS", "FLOOR_STONE_BRICK", "FLOOR_WOOD_BRICK"],
			["FLOOR_STONE_BRICK", "FLOOR_WOOD_BRICK"],
			["GRASS"]
		)
		placeStairs()
		placeDoors({
			"min": 1,
			"max": 1
		}, true)
		if areAllStairsConnected():
			placeContainers({
				"box": {
					"amount": randi() % 6 + 2
				},
				"chest": {
					"amount": randi() % 2
				}
			})
			return
		resetLevel()
		resetGeneration()
	push_error("Couldn't generate bandit warcamp")

func createBanditWarcamp():
	for _i in range(40):
		if generateMap(randi() % 5 + 3) and getUsedCells() > 1750:
			return
		resetGeneration()

func removeSmallRooms():
	var _newRooms = []
	for _room in rooms:
		if _room.floors.size() < 4:
			for _floor in _room.floors:
				if randi() % 12 == 0:
					grid[_floor.x][_floor.y].tile = Globals.tiles.GRASS_TREE
				else:
					grid[_floor.x][_floor.y].tile = Globals.tiles.GRASS
			for _floor in _room.walls:
				if randi() % 12 == 0:
					grid[_floor.x][_floor.y].tile = Globals.tiles.GRASS_TREE
				else:
					grid[_floor.x][_floor.y].tile = Globals.tiles.GRASS
		else:
			_newRooms.append(_room)
	rooms = _newRooms
