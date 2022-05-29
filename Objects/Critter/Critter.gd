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
	
	strength = _critter.stats.strength
	legerity = _critter.stats.legerity
	balance = _critter.stats.balance
	belief = _critter.stats.belief
	visage = _critter.stats.visage
	wisdom = _critter.stats.wisdom
	
	level = 1
	hp = _critter.hp
	mp = _critter.mp
	ac = _critter.ac
	attacks = [ strength * 1 / 3 ]
	currentHit = 0
	hits = _critter.hits
	
	abilities = _critter.abilities
	resistances = _critter.resistances
	
	$CritterSprite.texture = _critter.texture

func createCritterByName(_critterName, _critters):
	var _critter = _critters.getCritterByName(_critterName)
	createCritter(_critter)

func processCritterAction(_critterTile, _playerTile, _critter, _level, _tiles):
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
			var armorReduction = _attack - ( ac / 3 )
			if armorReduction <= 1 and armorReduction >= -2:
				hp -= 1
				_attacksLog.append("You hit the {critter} for 1 damage.".format({ "critter": critterName }))
			elif armorReduction < -2:
				_attacksLog.append("Your attack bounces off!")
			else:
				hp -= armorReduction
				_attacksLog.append("You hit the {critter} for {dmg} damage.".format({ "critter": critterName, "dmg": armorReduction }))
			if hp <= 0:
				despawn(_critterTile, _items, _level)
				_attacksLog.append("The {critter} dies!".format({ "critter": critterName }))
				break
		var _attacksLogString = PoolStringArray(_attacksLog).join(" ")
		Globals.gameConsole.addLog(_attacksLogString)
	else:
		Globals.gameConsole.addLog("Looks like you cant attack...")

func despawn(_critterTile, _items, _level):
	var _corpse = load("res://Objects/Item/Item.tscn").instance()
	_corpse.createCorpse(critterName, _items)
	$"/root/World/Items".add_child(_corpse)
	_level.grid[_critterTile.x][_critterTile.y].items.append(_corpse.id)
	_level.grid[_critterTile.x][_critterTile.y].critter = null
	_level.critters.erase(id)
	queue_free()
