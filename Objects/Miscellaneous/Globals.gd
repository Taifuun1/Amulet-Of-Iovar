extends Node

onready var gameConsole = $"/root/World/UI/GameConsole"
onready var gameStats = $"/root/World/UI/GameStats"

var gridSize = Vector2(60, 24)

enum tiles { 
	EMPTY
	CORRIDOR
	WALL
	FLOOR
	SIDEWALK
	DOWN_STAIR
	UP_STAIR
	GRASS
	DOOR
}

var currentDungeonLevel = 1

var levelId = 1
var itemId = 0
var critterId = 1
