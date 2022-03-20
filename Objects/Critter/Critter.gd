extends Node2D

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

var abilities
var resistances

var statusEffects = []

var ai = null

var despawning = false

func createCritter(_critter, _extraData = {}):
	id = Globals.critterId
	name = str(id)
	Globals.critterId += 1
	
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
	
	abilities = _critter.abilities
	resistances = _critter.resistances
	
	$CritterSprite.texture = _critter.texture

func createCritterByName(_critterName, _critters):
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
	
	abilities = critter.abilities
	resistances = critter.resistances
	
	$CritterSprite.texture = critter.texture

func moveCritter():
	pass

func calculateHitDmg():
	return strength

func hitCritter(_dmg):
	hp -= _dmg
	despawning = true
	if hp <= 0:
		return "dead"

func despawn(_critterTile, _corpse, _grid, _critter):
	_corpse.createItemByName("Corpse", $"/root/World/Items/Items", { "critterName": _critter.critterName })
	_grid[_critterTile.x][_critterTile.y].items.append(_corpse.id)
	$"/root/World/Items".add_child(_corpse)
	_grid[_critterTile.x][_critterTile.y].critter = null
	queue_free()
