extends Node

var gameConsole
var gameStats

var mutex = Mutex.new()

var gridSize = Vector2(60, 24)

enum tiles {
	EMPTY
	CORRIDOR_DUNGEON
	WALL_DUNGEON
	FLOOR_DUNGEON
	SIDEWALK
	DOWN_STAIR_DUNGEON
	UP_STAIR_DUNGEON
	DOOR_CLOSED
	DOOR_OPEN
	GRASS_SIMPLE
	SEA
	SAND
	SOIL
	WALL_SAND
	WALL_BRICK_SAND
	FLOOR_SAND
	DOWN_STAIR_SAND
	UP_STAIR_SAND
	CORRIDOR_SAND
	WALL_BOARD
	WALL_BRICK_LARGE
	BOOKCASE1
	BOOKCASE2
	BOOKCASE3
	GRASS
	GRASS_TREE
	GRASS_DARK
	GRASS_LIGHT
	GRASS_YELLOW
	REPLACEABLE1
	REPLACEABLE2
	REPLACEABLE3
	REPLACEABLE4
	REPLACEABLE5
	ROAD_DUNGEON
	VILLAGE_WALL_HORIZONTAL
	VILLAGE_WALL_CORNER
	VILLAGE_WALL_VERTICAL
	ROAD_GRASS
	WALL_BRICK_SMALL
	FLOOR_BRICK_SMALL
	VILLAGE_WALL_HALFWALL
	FLOOR_WOOD_BRICK
	GRASS_DEAD_TREE
	WALL_STONE_BRICK
	WALL_WOOD_PLANK
	FLOOR_STONE_BRICK
	WALL_CAVE
	WALL_DRAGONS_PEAK
	WALL_CAVE_DEEP
	FLOOR_CAVE
	FLOOR_DRAGONS_PEAK
	FLOOR_CAVE_DEEP
	CORRIDOR_STONE
}

var blockedTiles = [
	tiles.EMPTY,
	tiles.WALL_DUNGEON,
	tiles.WALL_SAND,
	tiles.WALL_BRICK_SAND,
	tiles.WALL_BOARD,
	tiles.WALL_BRICK_LARGE,
	tiles.BOOKCASE1,
	tiles.BOOKCASE2,
	tiles.BOOKCASE3,
	tiles.GRASS_TREE,
	tiles.REPLACEABLE1,
	tiles.REPLACEABLE2,
	tiles.REPLACEABLE3,
	tiles.REPLACEABLE4,
	tiles.REPLACEABLE5,
	tiles.VILLAGE_WALL_HORIZONTAL,
	tiles.VILLAGE_WALL_CORNER,
	tiles.VILLAGE_WALL_VERTICAL,
	tiles.WALL_BRICK_SMALL,
	tiles.VILLAGE_WALL_HALFWALL,
	tiles.GRASS_DEAD_TREE,
	tiles.WALL_STONE_BRICK,
	tiles.WALL_WOOD_PLANK,
	tiles.WALL_CAVE,
	tiles.WALL_DRAGONS_PEAK,
	tiles.WALL_CAVE_DEEP
]

enum interactables {
	LOCKED
	HIDDEN_ITEM
	ALTAR
	PLANT
	PLANT_CARROT
	PLANT_TOMATO
	PLANT_BEAN
	PLANT_ORANGE
	ANT_HILL
	SPIDER_WEB
	GEMS
	DIGGABLE
}

var currentDungeonLevel = 1
var currentDungeonLevelName = "Dungeon 1"
var generatedLevels = 0

var levelId = 1
var itemId = 0
var critterId = 1

func isTileFree(_tile, grid):
	for blockingTile in blockedTiles:
		if (
			_tile.x < 0 or
			_tile.y < 0 or
			_tile.x >= int(gridSize.x) or
			_tile.y >= int(gridSize.y) or
			grid[_tile.x][_tile.y].tile == blockingTile
		):
			return false
	return true

func isItemIdentified(_item):
	if (
		GlobalItemInfo.globalItemInfo.has(_item.identifiedItemName) and
		GlobalItemInfo.globalItemInfo[_item.identifiedItemName].identified == false
	):
		GlobalItemInfo.globalItemInfo[_item.identifiedItemName].identified = true
		Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _item.identifiedItemName, "unidentifiedItemName": _item.unidentifiedItemName }))

func loadGlobalsData(_data):
	currentDungeonLevel = int(_data.currentDungeonLevel)
	currentDungeonLevelName = _data.currentDungeonLevelName
	generatedLevels = int(_data.generatedLevels)
	levelId = int(_data.levelId)
	itemId = int(_data.itemId)
	critterId = int(_data.critterId)

func getGlobalsSaveData():
	return {
		currentDungeonLevel = currentDungeonLevel,
		currentDungeonLevelName = currentDungeonLevelName,
		generatedLevels = generatedLevels,
		levelId = levelId,
		itemId = itemId,
		critterId = critterId
	}
