extends Node

onready var gameConsole = $"/root/World/UI/GameConsole"
onready var gameStats = $"/root/World/UI/GameStats"

var gridSize = Vector2(60, 24)

enum tiles { 
	EMPTY
	CORRIDOR
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
	WALL_SAND
	WALL_BRICK_SAND
	FLOOR_SAND
	DOWN_STAIR_SAND
	UP_STAIR_SAND
	WALL_BOARD
}


enum interactables {
	LOCKED
	HIDDEN_ITEM
}

var currentDungeonLevel = 1
var currentDungeonLevelName = "Dungeon hallways 1"

var levelId = 1
var itemId = 0
var critterId = 1
