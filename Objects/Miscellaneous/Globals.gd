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
	FLOOR_BOARD
	BOOKCASE1
	BOOKCASE2
	BOOKCASE3
	REPLACEABLE
}


enum interactables {
	LOCKED
	HIDDEN_ITEM
	ALTAR
}

var currentDungeonLevel = 1
var currentDungeonLevelName = "Dungeon hallways 1"

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
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.BOOKCASE1 and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.BOOKCASE2 and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.BOOKCASE3 and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.REPLACEABLE
	):
		return true
	return false
