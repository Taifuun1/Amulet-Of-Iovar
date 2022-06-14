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
var basehp
var basemp
var maxhp
var maxmp
var ac
var attacks
var currentHit
var hits

var stats = {
	"strength": 0,
	"legerity": 0,
	"balance": 0,
	"belief": 0,
	"visage": 0,
	"wisdom": 0
}

var abilities
var resistances

var statusEffects = []

var hpRegenTimer = 0
var mpRegenTimer = 0

func moveCritter(_moveFrom, _moveTo, _critter, _level):
	_level.grid[_moveFrom.x][_moveFrom.y].critter = null
	_level.grid[_moveTo.x][_moveTo.y].critter = _critter

func processEffects():
	if hpRegenTimer > 25 - ( stats.legerity / 2 ):
		if hp < maxhp:
			hp += 1
		hpRegenTimer = 0
	else:
		hpRegenTimer += 1
	
	if mpRegenTimer > 25 - ( stats.belief / 2 ):
		if mp < maxmp:
			mp += 1
		mpRegenTimer = 0
	else:
		mpRegenTimer += 1