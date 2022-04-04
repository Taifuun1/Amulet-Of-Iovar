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
var baseDamage
var attacks
var currentHit
var hits

var strength
var legerity
var balance
var belief
var sagacity
var wisdom

var strengthIncrease = 1
var legerityIncrease = 1
var balanceIncrease = 1
var beliefIncrease = 1
var sagacityIncrease = 1
var wisdomIncrease = 1

var abilities
var resistances

var statusEffects = []

func createCritter(_critter, _extraData = {}):
	id = Globals.critterId
	name = str(id)
	Globals.critterId += 1
	
	add_child(inventory)
	$Inventory.create()
	
	critterName = _critter.critterName
	race = _critter.race
	alignment = _critter.alignment
	
	strength = _critter.stats.strength
	legerity = _critter.stats.legerity
	balance = _critter.stats.balance
	belief = _critter.stats.belief
	sagacity = _critter.stats.sagacity
	wisdom = _critter.stats.wisdom
	
	level = 1
	hp = _critter.hp
	mp = _critter.mp
	ac = _critter.ac
	baseDamage = _critter.baseDamage
	attacks = [( baseDamage + ( strength * ( 1 / 3 ) ) )]
	currentHit = 0
	hits = _critter.hits
	
	abilities = _critter.abilities
	resistances = _critter.resistances
	
	$CritterSprite.texture = _critter.texture

func moveCritter(_moveFrom, _moveTo, _critter, _level):
	_level.grid[_moveFrom.x][_moveFrom.y].critter = null
	_level.grid[_moveTo.x][_moveTo.y].critter = _critter
