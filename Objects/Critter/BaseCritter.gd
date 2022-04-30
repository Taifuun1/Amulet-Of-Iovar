extends Node2D
class_name BaseCritter

var inventory = load("res://UI/Inventory/Inventory.tscn").instance()

var id

var critterName
var race
var alignment

var level
var hp
var mp
var ac
var attacks
var currentHit
var hits

var strength
var legerity
var balance
var belief
var visage
var wisdom

var abilities
var resistances

var statusEffects = []

func moveCritter(_moveFrom, _moveTo, _critter, _level):
	_level.grid[_moveFrom.x][_moveFrom.y].critter = null
	_level.grid[_moveTo.x][_moveTo.y].critter = _critter
