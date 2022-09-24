extends Node

onready var gameConsole = $"/root/World/UI/UITheme/GameConsole"
onready var gameStats = $"/root/World/UI/UITheme/GameStats"

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
	GRASS
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
	FLOOR_BRICK
	GRASS_DEAD_TREE
}


enum interactables {
	LOCKED
	HIDDEN_ITEM
	ALTAR
}

var currentDungeonLevel = 1
var currentDungeonLevelName = "Dungeon hallways 1"
var generatedLevels = 0

var levelId = 1
var itemId = 0
var critterId = 1

func isTileFree(_tileToMoveTo, grid):
	if (
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.EMPTY and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.WALL_DUNGEON and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.WALL_SAND and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.WALL_BRICK_SAND and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.WALL_BOARD and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.WALL_BRICK_LARGE and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.BOOKCASE1 and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.BOOKCASE2 and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.BOOKCASE3 and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.GRASS_TREE and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.REPLACEABLE1 and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.REPLACEABLE2 and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.REPLACEABLE3 and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.REPLACEABLE4 and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.REPLACEABLE5 and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.VILLAGE_WALL_HORIZONTAL and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.VILLAGE_WALL_CORNER and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.VILLAGE_WALL_VERTICAL and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.WALL_BRICK_SMALL and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.VILLAGE_WALL_HALFWALL and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.GRASS_DEAD_TREE
	):
		return true
	return false
