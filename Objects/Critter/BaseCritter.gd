extends Node2D
class_name BaseCritter

var inventory = load("res://UI/Inventory/Inventory.tscn").instance()

var id

var critterName
var race
var critterClass
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

var statusEffects = {
	"stun": 0,
	"confusion": 0,
	"hungerification": 0,
	"slow digestion": 0,
	"regen": 0,
	"fumbling": 0,
	"sleep": 0,
	"blindness": 0,
	"invisibility": 0
}

var hpRegenTimer = 0
var mpRegenTimer = 0

func moveCritter(_moveFrom, _moveTo, _movingCritter, _level, _movedCritter = null):
	if _movedCritter == null:
		_level.grid[_moveFrom.x][_moveFrom.y].critter = null
		_level.grid[_moveTo.x][_moveTo.y].critter = _movingCritter
	else:
		_level.grid[_moveFrom.x][_moveFrom.y].critter = _movedCritter
		_level.grid[_moveTo.x][_moveTo.y].critter = _movingCritter

func processCritterEffects():
	for _status in statusEffects.keys():
		if statusEffects[_status] > 0:
			statusEffects[_status] -= 1
	
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
