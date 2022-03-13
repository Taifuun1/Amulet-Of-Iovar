extends Node

var gridSize = Vector2(60, 24)

var race
var alignment

var level
var skillPoints = {
	"Strength": 1,
	"Legerity": 1,
	"Balance": 1,
	"Belief": 1,
	"Trincin": 1,
	"Wisdom": 1
}

var currentDungeonLevel = 1

var levelId = 0
var itemId = 0
var critterId = 1
