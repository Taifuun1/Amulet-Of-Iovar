extends BaseCritter

var aI = load("res://Objects/AI/AI.tscn").instance()

func createCritter(_critter, _extraData = {}):
	id = Globals.critterId
	name = str(id)
	Globals.critterId += 1
	
	add_child(inventory)
	$Inventory.create()
	
	critterName = _critter.critterName
	race = _critter.race
	alignment = _critter.alignment
	
	aI.aI = _critter.aI
	
	strength = _critter.stats.strength
	legerity = _critter.stats.legerity
	balance = _critter.stats.balance
	belief = _critter.stats.belief
	visage = _critter.stats.visage
	wisdom = _critter.stats.wisdom
	
	level = 1
	hp = _critter.hp
	mp = _critter.mp
	basehp = _critter.hp
	basemp = _critter.mp
	maxhp = _critter.hp
	maxmp = _critter.mp
	ac = _critter.ac
	attacks = [ strength * 1 / 2 ]
	currentHit = 0
	hits = _critter.hits
	
	abilities = _critter.abilities
	resistances = _critter.resistances
	
	$CritterSprite.texture = _critter.texture

func processCritterAction(_critterTile, _playerTile, _critter, _level):
	var _path = aI.getCritterMove(_critterTile, _playerTile, _level)
	if _path.size() != 0:
		var _to = _path[1]
		if _level.grid[_to.x][_to.y].critter == 0:
			if hits[currentHit] == 1:
				$"/root/World/Critters/0".takeDamage(attacks, critterName)
			else:
				Globals.gameConsole.addLog("{critter} misses!".format({ "critter": critterName.capitalize() }))
			if currentHit == 15:
				currentHit = 0
			currentHit += 1
		elif _level.grid[_to.x][_to.y].critter == null:
			moveCritter(_critterTile, _to, _critter, _level)
		else:
			return false

func takeDamage(_attacks, _critterTile, _items, _level):
	var _attacksLog = []
	if _attacks.size() != 0:
		for _attack in _attacks:
			var _damageAfterArmorReduction = calculateDmg(_attack)
			if _damageAfterArmorReduction <= 1 and _damageAfterArmorReduction >= -2:
				hp -= 1
				_attacksLog.append("You hit the {critter} for 1 damage...".format({ "critter": critterName }))
			elif _damageAfterArmorReduction < -2:
				_attacksLog.append("Your attack bounces off!")
			else:
				hp -= _damageAfterArmorReduction
				_attacksLog.append("You hit the {critter} for {dmg} damage.".format({ "critter": critterName, "dmg": _damageAfterArmorReduction }))
			if hp <= 0:
				despawn(_critterTile, _items, _level)
				_attacksLog.append("The {critter} dies!".format({ "critter": critterName }))
				break
		var _attacksLogString = PoolStringArray(_attacksLog).join(" ")
		Globals.gameConsole.addLog(_attacksLogString)
	else:
		Globals.gameConsole.addLog("Looks like you cant attack...")

func calculateDmg(_attack):
	return (((randi() % (_attack.dmg[1] - _attack.dmg[0]) + _attack.dmg[0]) + _attack.enchantment) + _attack.bonusDmg.dmg) - ( ac / 3 )

func despawn(_critterTile, _items, _level):
	var _corpse = load("res://Objects/Item/Item.tscn").instance()
	_corpse.createCorpse(critterName, _items)
	$"/root/World/Items".add_child(_corpse)
	_level.grid[_critterTile.x][_critterTile.y].items.append(_corpse.id)
	_level.grid[_critterTile.x][_critterTile.y].critter = null
	_level.critters.erase(id)
	queue_free()
