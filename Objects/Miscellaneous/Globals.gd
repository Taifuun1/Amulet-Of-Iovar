extends Node

onready var gameConsole = $"/root/World/UI/GameConsole"
onready var gameStats = $"/root/World/UI/GameStats"

var gridSize = Vector2(60, 24)

var race
var alignment

var currentDungeonLevel = 1

var levelId = 1
var itemId = 0
var critterId = 1
