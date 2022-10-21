extends BaseCritter

var spellData = load("res://Objects/Spell/SpellData.gd").new()
var critterSpellData = load("res://Objects/Spell/CritterSpells.gd").new()

var levelId
var aI
var weight
var expDropAmount
var drops
var abilityHits
var currentCritterAbilityHit
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
	shields = 0
	ac = _critter.ac
	attacks = _critter.attacks
	currentHit = 0
	hits = _critter.hits
	
	abilities = _critter.abilities
	abilityHits = _critter.abilityHits
	if _critter.abilityHits.size() != 0:
		currentCritterAbilityHit = randi() % _critter.abilityHits.size()
	resistances = _critter.resistances
	
	$CritterSprite.texture = _critter.texture
	
	expDropAmount = _critter.expDropAmount
	drops = _critter.drops

func createAi(_aI = "aggressive", _activationDistance = null):
	var _critterAi = load("res://Objects/AI/AI.tscn").instance()
	_critterAi.create(_aI, _activationDistance)
	add_child(_critterAi)
	aI = $aI

func isCritterAwakened(_critterTile, _playerTile, _level):
	if aI.activationDistance != null:
		if _level.calculatePath(_critterTile, _playerTile).size() <= aI.activationDistance:
			awakeCritter()
			$"/root/World/UI/UITheme/DialogMenu".setText(critterName)

func awakeCritter(_level = $"/root/World".level):
	aI.aI = "Aggressive"
	aI.activationDistance = null
	for _critter in _level.critters:
		if get_node("/root/World/Critters/{critter}".format({ "critter": _critter })).aI.aI.matchn("Deactivated"):
			get_node("/root/World/Critters/{critter}".format({ "critter": _critter })).awakeCritter()

func processCritterAction(_critterTile, _playerTile, _critter, _level):
	if statusEffects["stun"] > 0:
		Globals.gameConsole.addLog("The {critter} cant move!".format({ "critter": critterName.capitalize() }))
		return false
	
	var _path = []
	
	# Get critter move
	if _critterTile != null and typeof(_critterTile) != TYPE_BOOL:
		_path = aI.getCritterMove(_critterTile, _playerTile, _level)
	
	if currentCritterAbilityHit != null:
		if currentCritterAbilityHit == abilityHits.size() - 1:
			currentCritterAbilityHit = -1
		currentCritterAbilityHit += 1
	
	var _pickedAbility
	if abilityHits.size() != 0 and abilityHits[currentCritterAbilityHit] == 1:
		var _abilities = []
		for _ability in abilities:
			if _ability.has("chance"):
				for _abilityChance in _ability.chance:
					_abilities.append(_ability)
		if _abilities.size() != 0:
			_pickedAbility = _abilities[randi() % _abilities.size()]
			_pickedAbility.data = critterSpellData[_pickedAbility.abilityName]
		if _pickedAbility != null and _path.size() <= _pickedAbility.data.distance and _path.size() != 0:
			match _pickedAbility.abilityType:
				"rangedSpell":
					var _directions = [
						Vector2(-1, -1),
						Vector2(0, -1),
						Vector2(1, -1),
						Vector2(1, 0),
						Vector2(1, 1),
						Vector2(0, 1),
						Vector2(-1, 1),
						Vector2(-1, 0)
					]
					for _direction in _directions:
						var _critters = []
						var _distance = 0
						for _i in _pickedAbility.data.distance:
							_distance += 1
							var _tile = _critterTile + (_direction * _distance)
							if _level.isOutSideTileMap(_tile) or !Globals.isTileFree(_tile, _level.grid):
								break
							if _tile == _playerTile:
								_critters.append([_level.grid[_tile.x][_tile.y].critter, _tile])
								var _critterData = _critters.front()
								var _critterNode = get_node("/root/World/Critters/{critterId}".format({ "critterId": _critterData[0] }))
								_critterNode.takeDamage(_pickedAbility.data.attacks, _critterData[1], critterName)
								return true
							match _pickedAbility.abilityName:
								"rockThrow", "crackerThrow", "dragonBreath", "frostBreath", "gleeieerBreath", "fleirBreath", "thunderBreath", "frostBite", "fleirnado", "elderDragonBreath", "voidBlast":
									if _level.grid[_tile.x][_tile.y].critter != null:
										_critters.append([_level.grid[_tile.x][_tile.y].critter, _tile])
				"selfCastSpell":
					match _pickedAbility.abilityName:
						"createShield":
							if shields > 17:
								shields = 20
							else:
								shields += 3
							Globals.gameConsole.addLog("{critter}s aura grows stronger!".format({ "critter": critterName.capitalize() }))
							return false
						"sharpenSword":
							for _attack in attacks:
								if !_attack.bonusDmg.has("bonusDmg"):
									_attack.bonusDmg.bonusDmg = 1
								elif _attack.bonusDmg.bonusDmg < 5:
									_attack.bonusDmg.bonusDmg += 1
								else:
									Globals.gameConsole.addLog("{critter} sharpens its sword. SSHhhrrrr...".format({ "critter": critterName.capitalize() }))
									continue
							Globals.gameConsole.addLog("{critter} sharpens its sword. SKKRRrrr!".format({ "critter": critterName.capitalize() }))
							return false
						"mimicBox":
							return false
						"mimicChest":
							return false
						"displaceSelf":
							return false
				"spell":
					match _pickedAbility.abilityName:
						"fireMiasma":
							var _tiles = []
							var _legibleTiles = []
							for x in range(_critterTile.x - _pickedAbility.data.distance, _critterTile.x + _pickedAbility.data.distance + 1):
								for y in range(_critterTile.y - _pickedAbility.data.distance, _critterTile.y + _pickedAbility.data.distance + 1):
									if !_level.isOutSideTileMap(Vector2(x,y)) and Globals.isTileFree(Vector2(x,y), _level.grid):
										_legibleTiles.append(Vector2(x,y))
							if _legibleTiles.size() > 5:
								for _i in 5:
									_tiles.append(_legibleTiles.pop_at(randi() % _legibleTiles.size()))
							else:
								_tiles = _legibleTiles
							var _effect = load("res://UI/Effect/Effect.tscn")
							for _tile in _tiles:
								var _miasmaNode = _effect.instance()
								_miasmaNode.create(load("res://Assets/Spells/Gas.png"), [_pickedAbility.data.attacks[0].magicDmg.element], _tile, 0, _pickedAbility.duration)
								_miasmaNode.setTurnDuration(_pickedAbility.duration)
								$"/root/World/Effects".add_child(_miasmaNode)
								_level.grid[_tile.x][_tile.y].effects.append("fire miasma")
							return false
						"summonCritter", "summonCritters":
							var _tiles = []
							var _legibleTiles = _level.whichTilesAreOpenAndFreeOfCritters(_critterTile, _pickedAbility.data.distance)
							if _legibleTiles.size() > 5:
								for _i in randi() % 3 + 2:
									_tiles.append(_legibleTiles.pop_at(randi() % _legibleTiles.size()))
									if _pickedAbility.abilityName.matchn("summonCritter"):
										break
							else:
								_tiles = _legibleTiles
							for _tile in _tiles:
								_level.spawnRandomCritter(_tile)
							Globals.gameConsole.addLog("{critter} summons critters!".format({ "critter": critterName.capitalize() }))
							return false
	
	# Critter move
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
			if abilityHits.size() != 0 and  abilityHits[currentCritterAbilityHit] == 1 and _pickedAbility != null and _pickedAbility.abilityType.matchn("meleeSpell"):
				$"/root/World/Critters/0".takeDamage(_pickedAbility.data.attacks, _moveCritterTo, critterName)
				return true
			elif hits[currentHit] == 1:
				$"/root/World/Critters/0".takeDamage(attacks, _moveCritterTo, critterName)
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

func takeDamage(_attacks, _critterTile, _critterName = null):
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
