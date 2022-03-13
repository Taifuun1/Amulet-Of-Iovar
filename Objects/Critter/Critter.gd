extends Sprite

var inventory = load("res://UI/Inventory/Inventory.tscn").instance()

var id

var critterName
var race
var alignment

var strength
var legerity
var balance
var belief
var sagacity
var wisdom

var level
var hp
var mp
var resistances

var statusEffects = []

var ai = null

func createCritter(_critterName, _critters):
	var critter = _critters.getCritterByName(_critterName)
	
	id = Globals.critterId
	name = str(id)
	Globals.critterId += 1
	
	critterName = critter.critterName
	race = critter.race
	alignment = critter.alignment
	
	strength = critter.stats.strength
	legerity = critter.stats.legerity
	balance = critter.stats.balance
	belief = critter.stats.belief
	sagacity = critter.stats.sagacity
	wisdom = critter.stats.wisdom
	
	level = 1
	hp = critter.hp
	mp = critter.mp
	
	resistances = critter.resistances
	
	texture = critter.texture

func calculateHitDmg():
	return strength

func hitCritter(_dmg):
	print(_dmg)
	hp -= _dmg
	print("hp")
	print(hp)
