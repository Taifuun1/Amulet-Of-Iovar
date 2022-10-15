extends BaseCritter

var aI = load("res://Objects/AI/AI.tscn").instance()

var levelId
var weight
var expDropAmount
var drops
var activationDistance = null


func createCritter(_critter, _levelId, _extraData = {}):
	id = Globals.critterId
	name = str(id)
	Globals.critterId += 1
	levelId = _levelId
	
	critterName = _critter.critterName
	race = _critter.race
	critterClass = _critter.class
	weight = _critter.weight
	alignment = _critter.alignment
	
	if _extraData.has("isDeactivated"):
		aI.aI = "Deactivated"
		activationDistance = _extraData.isDeactivated
	else:
		aI.aI = _critter.aI
	
	stats.strength = _critter.stats.strength
	stats.legerity = _critter.stats.legerity
	stats.balance = _critter.stats.balance
	stats.belief = _critter.stats.belief
	stats.visage = _critter.stats.visage
	stats.wisdom = _critter.stats.wisdom
	
	level = 1
	hp = _critter.hp
	mp = _critter.mp
	basehp = _critter.hp
	basemp = _critter.mp
	maxhp = _critter.hp
	maxmp = _critter.mp
	ac = _critter.ac
	attacks = [ stats.strength * 1 / 2 ]
	currentHit = 0
	hits = _critter.hits
	
	abilities = _critter.abilities
	resistances = _critter.resistances
	
	$CritterSprite.texture = _critter.texture
	
	expDropAmount = _critter.expDropAmount
	drops = _critter.drops

func isCritterAwakened(_critterTile, _playerTile, _level):
	if activationDistance != null:
		if _level.calculatePath(_critterTile, _playerTile).size() <= activationDistance:
			awakeCritter()
			$"/root/World/UI/UITheme/DialogMenu".setText(critterName)

func awakeCritter(_level = $"/root/World".level):
	aI.aI = "Aggressive"
	activationDistance = null
	for _critter in _level.critters:
		if get_node("/root/World/Critters/{critter}".format({ "critter": _critter })).aI.aI.matchn("Deactivated"):
			get_node("/root/World/Critters/{critter}".format({ "critter": _critter })).awakeCritter()

func processCritterAction(_critterTile, _playerTile, _critter, _level):
	if statusEffects["stun"] > 0:
		Globals.gameConsole.addLog("The {critter} cant move!".format({ "critter": critterName.capitalize() }))
		return false
	else:
		var _path = []
		
		# Get critter move
		if _critterTile != null and typeof(_critterTile) != TYPE_BOOL:
			_path = aI.getCritterMove(_critterTile, _playerTile, _level)
		if _path.size() > 1:
			# Tile to move to
			var _moveCritterTo = _path[1]
			
			# Confused check
			if statusEffects["confusion"] > 0 and randi() % 3 == 0:
				var _randomOpenTiles = level.checkAdjacentTilesForOpenSpace(_critterTile)
				_randomOpenTiles.shuffle()
				_moveCritterTo = _randomOpenTiles[0]
			
			# Player hit check
			if _level.grid[_moveCritterTo.x][_moveCritterTo.y].critter == 0:
				if hits[currentHit] == 1:
					$"/root/World/Critters/0".takeDamage(attacks, critterName, _moveCritterTo)
					return true
				else:
					Globals.gameConsole.addLog("{critter} misses!".format({ "critter": critterName.capitalize() }))
				if currentHit == 15:
					currentHit = 0
				currentHit += 1
			# Movement check
			elif _level.grid[_moveCritterTo.x][_moveCritterTo.y].critter == null:
				moveCritter(_critterTile, _moveCritterTo, _critter, _level)
				_level.addPointToEnemyPathding(_critterTile)
				_level.removePointFromEnemyPathfinding(_moveCritterTo)
			else:
				return false

func takeDamage(_attacks, _critterTile, _items = $"/root/World/Items/Items", _level = $"/root/World".level):
	var _didCritterDie = null
	var _attacksLog = []
	if _attacks.size() != 0:
		for _attack in _attacks:
			var _damage = calculateDmg(_attack)
			var _attackLog = ""
			
			var _damageNumber = damageNumber.instance()
			_damageNumber.create(_critterTile, _damage.dmg + _damage.magicDmg, "#00F")
			$"/root/World/Animations".add_child(_damageNumber)
			
			# Magic spell
			if _damage.dmg == 0 and _damage.magicDmg != 0:
				hp -= _damage.magicDmg
				_attackLog += "{critter} gets hit for {magicDmg} {element} damage!".format({ "critter": critterName, "magicDmg": _damage.magicDmg, "element": _attack.magicDmg.element })
			# Physical attack
			else:
				# Physical damage
				if _damage.dmg < 1 and _damage.dmg >= -2:
					hp -= 1
					_attackLog += "You hit the {critter} for 1 damage...".format({ "critter": critterName })
				elif _damage.dmg < -2:
					_attackLog += "Your attack bounces off!"
				else:
					hp -= _damage.dmg
					_attackLog += "You hit the {critter} for {dmg} damage.".format({ "critter": critterName, "dmg": _damage.dmg + _damage.magicDmg })
				
				# Magic damage
				if _damage.magicDmg != 0:
					hp -= _damage.magicDmg
					_attackLog += " ({magicDmg} {element} damage)".format({ "magicDmg": _damage.magicDmg, "element": _attack.magicDmg.element })
			
			_attacksLog.append(_attackLog)
			
			if hp <= 0:
				despawn(_critterTile)
				_didCritterDie = expDropAmount
				_attacksLog.append("The {critter} dies!".format({ "critter": critterName }))
				break
		var _attacksLogString = PoolStringArray(_attacksLog).join(" ")
		Globals.gameConsole.addLog(_attacksLogString)
		if aI.aI.matchn("Deactivated"):
			awakeCritter()
			$"/root/World/UI/UITheme/DialogMenu".setText(critterName)
	else:
		Globals.gameConsole.addLog("Looks like you cant attack...")
	return _didCritterDie

func despawn(_critterTile = null, createCorpse = true):
	var _level = get_node("/root/World/Levels/{level}".format({ "level": levelId }))
	var _gridPosition
	
	# Position
	if _critterTile == null:
		_gridPosition = _level.getCritterTile(id)
	else:
		_gridPosition = _critterTile
	
	if createCorpse:
		var _corpse = load("res://Objects/Item/Item.tscn").instance()
		_corpse.createCorpse(critterName, weight, $"/root/World/Items/Items")
		$"/root/World/Items".add_child(_corpse)
		_level.grid[_gridPosition.x][_gridPosition.y].items.append(_corpse.id)
	
	for _drop in drops:
		var _dropTries = 1
		if _drop.has("tries"):
			_dropTries = _drop.tries
		for _index in range(_dropTries):
			if randi() % 101 <= _drop.chance:
				var _minAmount = _drop.amount[0]
				var _randomChange = _drop.amount[1] - _drop.amount[0] + 1
				if _drop.amount[0] == _drop.amount[1]:
					_randomChange = 1
					_minAmount = _drop.amount[0]
				var _amount = randi() % _randomChange + _minAmount
				if typeof(_drop.names) == TYPE_ARRAY:
					$"/root/World/Items/Items".createItem(_drop.names[randi() % _drop.names.size()], _gridPosition, _amount)
				else:
					$"/root/World/Items/Items".createItem(_drop.names, _gridPosition, _amount)
	
	$"/root/World".hideObjectsWhenDrawingNextFrame = true
	_level.grid[_gridPosition.x][_gridPosition.y].critter = null
	_level.addPointToEnemyPathding(_gridPosition)
	_level.critters.erase(id)
	GlobalCritterInfo.removeCritterFromPlay(critterName)
	queue_free()
