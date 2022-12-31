extends BaseCritter

var spell = load("res://Objects/Spell/CritterSpell.tscn")

var spellData = load("res://Objects/Spell/SpellData.gd").new().spellData
var critterSpellData = load("res://Objects/Spell/CritterSpells.gd").new()

var levelId
var aI
var weight
var expDropAmount
var drops
var abilityHits
var currentCritterAbilityHit = null
var activationDistance = null
var etherealnessHit = false
var isMimicked = false


func createCritter(_critter, _levelId, _tooltip, _extraData = {}, _spawnNew = true):
	if _spawnNew:
		id = Globals.critterId
		Globals.critterId += 1
	else:
		id = _critter.id
	name = str(id)
	levelId = _levelId
	
	critterName = _critter.critterName
	race = _critter.race
	critterClass = _critter.class
	weight = _critter.weight
#	justice = _critter.justice
	
	stats.strength = float(_critter.stats.strength)
	stats.legerity = float(_critter.stats.legerity)
	stats.balance = float(_critter.stats.balance)
	stats.belief = float(_critter.stats.belief)
	stats.visage = float(_critter.stats.visage)
	stats.wisdom = float(_critter.stats.wisdom)
	baseStats = stats.duplicate(true)
	
	level = _critter.level
	hp = int(_critter.hp)
	mp = int(_critter.mp)
	basehp = _critter.hp
	basemp = _critter.mp
	if _critter.has("maxhp"):
		maxhp = int(_critter.maxhp)
	else:
		maxhp = int(_critter.hp)
	if _critter.has("maxmp"):
		maxmp = int(_critter.maxmp)
	else:
		maxmp = int(_critter.mp)
	shields = 0
	ac = int(_critter.ac)
	attacks = _critter.attacks
	if _critter.has("currentHit"):
		currentHit = _critter.currentHit
	else:
		currentHit = 0
	hits = _critter.hits
	
	abilities = _critter.abilities
	abilityHits = _critter.abilityHits
	if _critter.has("currentAbilityHit"):
		currentCritterAbilityHit = _critter.currentAbilityHit
	elif _critter.abilityHits.size() != 0:
		currentCritterAbilityHit = randi() % _critter.abilityHits.size()
	resistances = _critter.resistances
	
	$CritterSprite.texture = _critter.texture
	
	expDropAmount = int(_critter.expDropAmount)
	drops = _critter.drops
	
	$Tooltip/TooltipContainer.updateTooltip(critterName, _tooltip.description, _critter.texture)

func createAi(_aI = "aggressive", _aggroDistance = -1, _activationDistance = null):
	var _critterAi = load("res://Objects/AI/AI.tscn").instance()
	_critterAi.create(_aI, _aggroDistance, _activationDistance)
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
	if statusEffects.stun > 0:
		Globals.gameConsole.addLog("The {critter} cant move!".format({ "critter": critterName.capitalize() }))
		return false
	
	var _path = []
	var _distanceFromPlayer = []
	
	# Get critter distance from player
	_distanceFromPlayer = _level.calculatePath(_critterTile, _playerTile)
	# Get critter move
	if _critterTile != null and typeof(_critterTile) != TYPE_BOOL:
		_path = aI.getCritterMove(_critterTile, _playerTile, _level)
	
	if typeof(_path) == TYPE_BOOL or isMimicked:
		return false
	
	if currentCritterAbilityHit != null:
		if currentCritterAbilityHit == abilityHits.size() - 1:
			currentCritterAbilityHit = 0
		else:
			currentCritterAbilityHit += 1
	
	var _pickedAbility
	if abilityHits.size() != 0 and abilityHits[currentCritterAbilityHit] == 1 and abilities.size() != 0:
		var _abilities = []
		for _ability in abilities:
			if _ability.has("chance"):
				for _abilityChance in _ability.chance:
					_abilities.append(_ability)
		if _abilities.size() != 0:
			_pickedAbility = _abilities[randi() % _abilities.size()]
			_pickedAbility.data = critterSpellData[_pickedAbility.abilityName]
		if _pickedAbility != null and _distanceFromPlayer.size() <= _pickedAbility.data.distance and _distanceFromPlayer.size() != 0:
			if !_pickedAbility.abilityType.matchn("skill") and mp - _pickedAbility.data.mp < 0:
				if randi() % 10 == 0:
					Globals.gameConsole.addLog("{critter} tries to cast a spell but nothing happens!".format({ "critter": critterName }))
					return false
			else:
				match _pickedAbility.abilityType:
					"rangedSpell":
						var _tiles = []
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
						if statusEffects.blindness > 0 or statusEffects.blindness == -1:
							_directions = _directions[randi() % _directions.size()]
						var _critters = []
						for _direction in _directions:
							_tiles = []
							var _distance = 0
							for _i in _pickedAbility.data.distance:
								_distance += 1
								var _tile = _critterTile + (_direction * _distance)
								if _level.isOutSideTileMap(_tile) or !Globals.isTileFree(_tile, _level.grid) or _level.grid[_tile.x][_tile.y].tile == Globals.tiles.DOOR_CLOSED:
									break
								_tiles.append([{ "tile": _tile, "angle": spellData.spellDirections[_direction].angle }])
								match _pickedAbility.abilityName:
									"rockThrow", "crackerThrow", "fleirpoint", "fleirnado", "frostpoint", "frostBite", "thunderPoint", "thundersplit", "voidBlast":
										if _level.grid[_tile.x][_tile.y].critter == 0:
											yield(get_tree(), "idle_frame")
											var _newSpell = spell.instance()
											var _color = "#000"
											if _pickedAbility.data.attacks[0].magicDmg.element != null:
												_color = spellData[_pickedAbility.data.attacks[0].magicDmg.element].color
											_newSpell.create(_tiles, {
												"texture": load("res://Assets/Spells/Bolt.png"),
												"color": _color,
												"spellDamage": _pickedAbility.data.attacks
												}
											)
											$"/root/World/Animations".add_child(_newSpell)
											# warning-ignore:return_value_discarded
											$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).connect("critterAnimationDone", $"/root/World", "_on_Critter_Animation_done")
											$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).animateCycle()
#											$"/root/World".currentGameState = $"/root/World".gameState.OUT_OF_PLAYERS_HANDS
											var _critterNode = get_node("/root/World/Critters/{critterId}".format({ "critterId": _level.grid[_tile.x][_tile.y].critter }))
											if (
												_critterNode.checkIfStatusEffectIsInEffect("backscattering") and
												_pickedAbility.abilityName.matchn("rockThrow")
											):
												Globals.gameConsole.addLog("Magic field around {critterName} deflects the {spell}!".format({ "critterName": _critterNode.critterName.capitalize(), "spell": _pickedAbility.data.name }))
												return false
											Globals.gameConsole.addLog("{critterName} casts {spell}!".format({ "critterName": critterName.capitalize(), "spell": _pickedAbility.data.name }))
											_critterNode.takeDamage(_pickedAbility.data.attacks, _tile, critterName)
											if !_pickedAbility.abilityType.matchn("skill"):
												mp -= _pickedAbility.data.mp
											return true
									"dragonBreath", "fleirBreath", "frostBreath", "thunderBreath", "gleeieerBreath", "toxixBreath", "elderDragonBreath":
										if _level.grid[_tile.x][_tile.y].critter != null:
											_critters.append(_level.grid[_tile.x][_tile.y].critter)
							if _critters.has(0) or statusEffects.blindness > 0 or statusEffects.blindness == -1:
								break
							else:
								_critters.clear()
						
						if _critters.size() == 0:
							return false
						if statusEffects.blindness > 0:
							Globals.gameConsole.addLog("{critterName} casts {spell} in a random direction!".format({ "critterName": critterName.capitalize(), "spell": _pickedAbility.data.name }))
						else:
							Globals.gameConsole.addLog("{critterName} casts {spell}!".format({ "critterName": critterName.capitalize(), "spell": _pickedAbility.data.name }))
						
						yield(get_tree(), "idle_frame")
						var _newSpell = spell.instance()
						var _color = "#000"
						if _pickedAbility.data.attacks[0].magicDmg.element != null:
							_color = spellData[_pickedAbility.data.attacks[0].magicDmg.element].color
						_newSpell.create(_tiles, {
							"texture": load("res://Assets/Spells/Bolt.png"),
							"color": _color,
							"spellDamage": _pickedAbility.data.attacks
							}
						)
						$"/root/World/Animations".add_child(_newSpell)
						# warning-ignore:return_value_discarded
						$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).connect("critterAnimationDone", $"/root/World", "_on_Critter_Animation_done")
						$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).animateCycle()
#						$"/root/World".currentGameState = $"/root/World".gameState.OUT_OF_PLAYERS_HANDS
						
						for _critter in _critters:
							var _critterNode = get_node("/root/World/Critters/{critterId}".format({ "critterId": _critter }))
							if _critterNode.checkIfStatusEffectIsInEffect("backscattering") and _pickedAbility.abilityName.matchn("dragonBreath"):
								Globals.gameConsole.addLog("Magic field around {critterName} deflects the {spell}!".format({ "critterName": _critterNode.critterName.capitalize(), "spell": _pickedAbility.data.name }))
								continue
							_critterNode.takeDamage(_pickedAbility.data.attacks, _level.getCritterTile(_critter), critterName)
						if !_pickedAbility.abilityType.matchn("skill"):
							mp -= _pickedAbility.data.mp
						if _critters.has(0):
							return true
					"selfCastSpell":
						match _pickedAbility.abilityName:
							"createShield":
								if shields > 17:
									shields = 20
									Globals.gameConsole.addLog("{critter}s aura reverberates!".format({ "critter": critterName.capitalize() }))
								else:
									shields += 3
									Globals.gameConsole.addLog("{critter}s aura grows stronger!".format({ "critter": critterName.capitalize() }))
								if !_pickedAbility.abilityType.matchn("skill"):
									mp -= _pickedAbility.data.mp
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
								if !_pickedAbility.abilityType.matchn("skill"):
									mp -= _pickedAbility.data.mp
								Globals.gameConsole.addLog("{critter} sharpens its sword. SKKRRrrr!".format({ "critter": critterName.capitalize() }))
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
								if !_pickedAbility.abilityType.matchn("skill"):
									mp -= _pickedAbility.data.mp
								Globals.gameConsole.addLog("Fire appears around {critterName} casts!".format({ "critterName": critterName.capitalize() }))
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
									$"/root/World/Critters/Critters".spawnRandomCritter(_tile, false)
								if !_pickedAbility.abilityType.matchn("skill"):
									mp -= _pickedAbility.data.mp
								Globals.gameConsole.addLog("{critter} summons critters!".format({ "critter": critterName.capitalize() }))
								return false
	
	for _ability in abilities:
		if _path.size() > 1:
			match _ability.abilityType:
				"skill":
					match _ability.abilityName:
						"mining":
							var _tileToMoveTo = _path[1]
							if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.EMPTY or _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.WALL_CAVE:
								_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile = Globals.tiles.FLOOR_CAVE
								_level.addPointToEnemyPathding(_tileToMoveTo)
								_level.addPointToPathPathding(_tileToMoveTo)
								_level.addPointToWeightedPathding(_tileToMoveTo)
								if _level.calculatePath(_critterTile, _playerTile).size() != 0 and _level.calculatePath(_critterTile, _playerTile).size() < 12:
									Globals.gameConsole.addLog("The {critterName} mines the cave wall.".format({ "critterName": critterName }))
								if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].interactable == Globals.interactables.GEMS:
#									if critterClass.matchn("archeologist") and randi() % 2:
#										$"/root/World/Items/Items".createItem($"/root/World/Items/Items".items.gem.rare[randi() % $"/root/World/Items/Items".items.gem.rare.size()], _tileToMoveTo, randi() % 4 + 1, false, { "alignment": "Uncursed" })
#										Globals.gameConsole.addLog("You find several gems in the wall!")
									$"/root/World/Items/Items".createItem($"/root/World/Items/Items".items.gem.rare[randi() % $"/root/World/Items/Items".items.gem.rare.size()], _tileToMoveTo, 1, false, { "alignment": "Uncursed" })
									Globals.gameConsole.addLog("The {critterName} finds a gem in the wall.".format({ "critterName": critterName }))
									_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].interactable = null
							if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.WALL_CAVE_DEEP:
								_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile = Globals.tiles.FLOOR_CAVE_DEEP
								_level.addPointToEnemyPathding(_tileToMoveTo)
								_level.addPointToPathPathding(_tileToMoveTo)
								_level.addPointToWeightedPathding(_tileToMoveTo)
								if _level.calculatePath(_critterTile, _playerTile).size() != 0 and _level.calculatePath(_critterTile, _playerTile).size() < 12:
									Globals.gameConsole.addLog("The {critterName} mines the cave wall.".format({ "critterName": critterName }))
								if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].interactable == Globals.interactables.GEMS:
#									if critterClass.matchn("archeologist") and randi() % 2:
#										$"/root/World/Items/Items".createItem($"/root/World/Items/Items".items.gem.rare[randi() % $"/root/World/Items/Items".items.gem.rare.size()], _tileToMoveTo, randi() % 4 + 1, false, { "alignment": "Uncursed" })
#										Globals.gameConsole.addLog("You find several gems in the wall!")
									$"/root/World/Items/Items".createItem($"/root/World/Items/Items".items.gem.rare[randi() % $"/root/World/Items/Items".items.gem.rare.size()], _tileToMoveTo, 1, false, { "alignment": "Uncursed" })
									Globals.gameConsole.addLog("The {critterName} finds a gem in the wall.".format({ "critterName": critterName }))
									_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].interactable = null
						"mimic":
							if !isMimicked and (_distanceFromPlayer.size() > 12 or _distanceFromPlayer.size() == 0) and randi() % 18 == 0:
								isMimicked = true
								$CritterSprite.texture = $"/root/World/Items/Items".getRandomItem(false).texture
								return false
	
	# Critter move
	if _path.size() > 1:
		# Tile to move to
		var _moveCritterTo = _path[1]
		
		if statusEffects.blindness > 0:
			if randi() % 2 == 0:
				var _randomOpenTiles = level.checkAdjacentTilesForOpenSpace(_critterTile)
				_randomOpenTiles.shuffle()
				_moveCritterTo = _randomOpenTiles[0]
			else:
				aI.getNeutralCritterMove()
			Globals.gameConsole.addLog("{critterName} blindly stumbles!".format({ "critterName": critterName }))
		
		# Confused check
		if statusEffects["confusion"] > 0 and randi() % 3 == 0:
			var _randomOpenTiles = level.checkAdjacentTilesForOpenSpace(_critterTile)
			_randomOpenTiles.shuffle()
			_moveCritterTo = _randomOpenTiles[0]
		
		# Player hit check
		if _level.grid[_moveCritterTo.x][_moveCritterTo.y].critter == 0:
			if currentHit == 15:
				currentHit = 0
			currentHit += 1
			if _pickedAbility == null:
				for _ability in abilities:
					if _ability.abilityType.matchn("onAttack"):
						_pickedAbility = _ability
						_pickedAbility.data = critterSpellData[_pickedAbility.abilityName]
						break
			if (
				abilityHits.size() != 0 and
				abilityHits[currentCritterAbilityHit] == 1 and
				_pickedAbility != null and
				_pickedAbility.abilityType.matchn("onAttack") and
				mp - _pickedAbility.data.mp >= 0
			):
				if (
					_pickedAbility.abilityName.matchn("selfdestruct") or
					_pickedAbility.abilityName.matchn("frostSelfdestruct") or
					_pickedAbility.abilityName.matchn("thunderSelfdestruct")
				):
					Globals.gameConsole.addLog("{critterName} {spell}s!".format({ "critterName": critterName, "spell": _pickedAbility.data.name }))
					despawn(_critterTile, false)
				elif _pickedAbility.abilityName.matchn("lifesteal"):
					if hp + 2 <= maxhp:
						hp += 2
					else:
						hp = maxhp
					Globals.gameConsole.addLog("{critterName} steals your life-energy!".format({ "critterName": critterName }))
				elif _pickedAbility.abilityName.matchn("ghostTouch"):
					if !checkIfStatusEffectIsPermanent("fumbling"):
						statusEffects.fumbling = 3
					Globals.gameConsole.addLog("{critterName} touches you. The cold makes you shiver shiver!".format({ "critterName": critterName }))
				$"/root/World/Critters/0".takeDamage(_pickedAbility.data.attacks, _moveCritterTo, critterName)
				mp -= _pickedAbility.data.mp
			elif (
				abilityHits.size() != 0 and
				abilityHits[currentCritterAbilityHit] == 1 and
				_pickedAbility != null and
				_pickedAbility.abilityType.matchn("meleeSpell") and
				mp - _pickedAbility.data.mp >= 0
			):
				Globals.gameConsole.addLog("{critterName} casts {spell}!".format({ "critterName": critterName.capitalize(), "spell": _pickedAbility.data.name }))
				$"/root/World/Critters/0".takeDamage(_pickedAbility.data.attacks, _moveCritterTo, critterName)
				mp -= _pickedAbility.data.mp
			elif hits[currentHit] == 1:
				if $"/root/World/Critters/0".checkIfStatusEffectIsInEffect("displacement") and randi() % 4 == 0:
					Globals.gameConsole.addLog("{critterName} hits your displaced image!".format({ "critterName": critterName }))
					return false
				$"/root/World/Critters/0".takeDamage(attacks, _moveCritterTo, critterName)
			else:
				Globals.gameConsole.addLog("{critter} misses!".format({ "critter": critterName }))
				return false
			return true
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
			# Armor sets
			var _activeArmorSets = {
				"frost": $"/root/World/UI/UITheme/Equipment".armorSets.frost.allPieces,
				"fleir": $"/root/World/UI/UITheme/Equipment".armorSets.fleir.allPieces,
				"thunder": $"/root/World/UI/UITheme/Equipment".armorSets.thunder.allPieces,
				"gleeie'er": $"/root/World/UI/UITheme/Equipment".armorSets["gleeie'er"].allPieces,
				"toxix": $"/root/World/UI/UITheme/Equipment".armorSets.toxix.allPieces
			}
			
			var _damage = calculateDmg(_attack, _activeArmorSets)
			var _attackLog = ""
			var _isPhysicalHit = true
			
			# Magic spell
			if _damage.dmg == 0 and _damage.magicDmg != 0:
				hp -= _damage.magicDmg
				_attackLog += "{critter} gets hit for {magicDmg} {element} damage!".format({ "critter": critterName, "magicDmg": _damage.magicDmg, "element": _attack.magicDmg.element })
			# Physical attack
			else:
				# Onhit abilities
				if abilities.size() != 0:
					var _onHitAbility = null
					for _ability in abilities:
						if _ability.abilityType.matchn("onHit"):
							_onHitAbility = _ability
#							_onHitAbility.data = critterSpellData[_onHitAbility.abilityName]
					if _onHitAbility != null:
						match _onHitAbility.abilityName:
							"etherealness":
								if etherealnessHit:
									_isPhysicalHit = false
									_attackLog += "Your attack passes through {critter}! ".format({ "critter": critterName })
								etherealnessHit = !etherealnessHit
							"corrosion":
								_damage.dmg -= 2
								_attackLog += "{critter}s skin dulls your attack! ".format({ "critter": critterName })
				
				if _isPhysicalHit:
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
				
				# Armor set effects
				if _activeArmorSets.frost and !checkIfStatusEffectIsInEffect("stun"):
					statusEffects.stun = 2
					_attackLog += " {critterName} is stunned from your frozen armor!".format({ "critterName":critterName })
				if _activeArmorSets.fleir and !checkIfStatusEffectIsPermanent("onFleir"):
					statusEffects.onFleir += 2
					_attackLog += " {critterName} is on fleir from your burning armor!".format({ "critterName":critterName })
				if _activeArmorSets.thunder and !checkIfStatusEffectIsInEffect("stun"):
					statusEffects.stun = 1
					_attackLog += " Bolt of lighting summoned by your armor stuns the {critterName}!".format({ "critterName":critterName })
				if _activeArmorSets["gleeie'er"] and !checkIfStatusEffectIsInEffect("confusion"):
					statusEffects.confusion = 5
					_attackLog += " {critterName} is confused by your flamboyant armor!".format({ "critterName":critterName })
				if _activeArmorSets.toxix and !checkIfStatusEffectIsPermanent("toxix"):
					statusEffects.toxix += 4
					_attackLog += " {critterName} is poisoned by your slick armor!".format({ "critterName":critterName })
			
			var _damageNumber = damageNumber.instance()
			var _damageText
			var _damageColor = "#000"
			if (_damage.dmg == 0 and _damage.magicDmg != 0) or !_isPhysicalHit:
				_damageText = _damage.magicDmg
			elif _damage.dmg < 1 and _damage.dmg >= -2:
				_damageText = 1 + _damage.magicDmg
			elif _damage.dmg < -2:
				_damageText = 0
			else:
				_damageText = _damage.dmg + _damage.magicDmg
			if _damage.magicDmg != 0 and _attack.magicDmg.element != null:
				_damageColor = spellData[_attack.magicDmg.element.to_lower()].color
			_damageNumber.create(_critterTile, _damageText, _damageColor)
			$"/root/World/Texts".add_child(_damageNumber)
			
			_attacksLog.append(_attackLog)
			
			# Damage dealt game stats
			if _damageText > GlobalGameStats.gameStats["Highest damage dealt"]:
				GlobalGameStats.gameStats["Highest damage dealt"] = _damageText
			GlobalGameStats.gameStats["Times attacked"] += 1
			GlobalGameStats.gameStats["Damage dealt"] += _damageText
			
			if hp <= 0:
				despawn(_critterTile)
				_didCritterDie = expDropAmount
				_attacksLog.append("The {critter} dies!".format({ "critter": critterName }))
				GlobalGameStats.critters[critterName].killCount += 1
				break
		var _attacksLogString = PoolStringArray(_attacksLog).join(" ")
		Globals.gameConsole.addLog(_attacksLogString)
		if aI.aI.matchn("Deactivated"):
			awakeCritter()
			$"/root/World/UI/UITheme/DialogMenu".setText(critterName)
		if isMimicked:
			isMimicked = false
			$CritterSprite.texture = $"/root/World/Critters/Critters".getCritterByName(critterName).texture
			Globals.gameConsole.addLog("The item is a mimic!")
		if statusEffects.sleep > 0:
			statusEffects.sleep = 0
			Globals.gameConsole.addLog("The {critterName} wakes up!".format({ "critterName": critterName }))
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
	
	if GlobalGameConsoleMessages.globalGameConsoleMessages.has(critterName):
		Globals.gameConsole.addLog(GlobalGameConsoleMessages.getRandomMessageByType(critterName, "despawn"))
	
	if createCorpse:
		$"/root/World/Items/Items".createItem("corpse", _gridPosition, 1, false, { "weight": weight, "critterName": critterName })
	
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
				var _amount = randi() % int(_randomChange) + int(_minAmount)
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

func addCritterBackToPopulation(_critterTile, _level):
	_level.grid[_critterTile.x][_critterTile.y].critter = null
	_level.addPointToEnemyPathding(_critterTile)
	_level.critters.erase(id)
	GlobalCritterInfo.addCritterBackToPopulation(critterName)
	call_deferred("queue_free")

func checkCritterIdentification(_data):
	if _data.knowledge:
		$Tooltip/TooltipContainer.updateTooltip(critterName, _data.description, $CritterSprite.texture)

func getCritterSaveData():
	var _critterData = {
		levelId = levelId,
		aI = {
			aI = aI.aI,
			aggroDistance = aI.aggroDistance,
			activationDistance = aI.activationDistance
		},
		weight = weight,
		expDropAmount = expDropAmount,
		drops = drops,
		abilityHits = abilityHits,
		currentCritterAbilityHit = currentCritterAbilityHit,
		texture = $CritterSprite.texture.get_path()
	}
	_critterData.merge(getBaseCritterSaveData())
	return _critterData



########################
### Signal functions ###
########################

func _on_Critter_mouse_entered():
	$Tooltip/TooltipContainer.showTooltip()

func _on_Critter_mouse_exited():
	$Tooltip/TooltipContainer.hideTooltip()
