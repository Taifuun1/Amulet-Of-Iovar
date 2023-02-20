extends BaseCritter
class_name Player

onready var inventory = preload("res://UI/Inventory/Inventory.tscn").instance()

var playerClasses = load("res://Objects/Player/PlayableClasses.gd").new()
var spellData = load("res://Objects/Data/SpellsData.gd").new()
var statusEffectsData = load("res://Objects/Data/StatusEffectsData.gd").new()
var critterSpellData = load("res://Objects/Data/SpellsCritterSpellsData.gd").new()

var playerVisibility = {
	"distance": -1,
	"duration": -1
}

var experiencePoints = 0
var experienceNeededForPreviousLevelGainAmount = 0
var experienceNeededForLevelGainAmount = 20

var hpIncrease = 0
var mpIncrease = 0
var strengthIncrease = 0
var legerityIncrease = 0
var balanceIncrease = 0
var beliefIncrease = 0
var visageIncrease = 0
var wisdomIncrease = 0

var calories
var previousCalories

var goldPieces

var statusStates = {
	"hunger": {
		"current": 0,
		"previous": 0
	},
	"weight": {
		"current": 0,
		"previous": 0
	}
}

var maxCarryWeight = {
	"overEncumbured": 0,
	"burdened": 1,
	"flattened": 2
}
var carryWeightBounds = {
	"min": 0,
	"max": 1
}

var turnsUntilAction = 0

var attackNeutral = false
var autoMine = false

var armorSetStunCount = 1

var selectedItem = null
var itemsTurnedOn = []

var skills = {
	"sword": {
		"experience": 0,
		"level": 0,
		"skillcap": 0
	},
	"two-hander": {
		"experience": 0,
		"level": 0,
		"skillcap": 0
	},
	"dagger": {
		"experience": 0,
		"level": 0,
		"skillcap": 0
	},
	"mace": {
		"experience": 0,
		"level": 0,
		"skillcap": 0
	},
	"flail": {
		"experience": 0,
		"level": 0,
		"skillcap": 0
	},
	"dualWield": {
		"experience": 0,
		"level": 0,
		"skillcap": 0
	}
}

var neutralClasses

func create(_data = null):
	id = 0
	name = str(0)
	
	var _playerData
	
	if _data == null:
		_playerData = playerClasses[(StartingData.selectedClass[0].to_lower() + StartingData.selectedClass.substr(1,-1)).replace(" ", "")]
	else:
		_playerData = _data
	add_child(inventory)
	if _playerData.has("inventory"):
		inventory.create(_playerData.inventory)
	else:
		inventory.create()
	
	critterName = _playerData.critterName
	if _playerData.has("playerClass"):
		critterClass = _playerData.playerClass
	else:
		critterClass = (StartingData.selectedClass[0].to_lower() + StartingData.selectedClass.substr(1,-1)).replace(" ", "")
	race = _playerData.race
	justice = _playerData.justice
	
	if _playerData.has("level"):
		level = _playerData.level
	else:
		level = 1
	if _playerData.has("experiencePoints"):
		experiencePoints = _playerData.experiencePoints
	if _playerData.has("experienceNeededForPreviousLevelGainAmount"):
		experienceNeededForPreviousLevelGainAmount = _playerData.experienceNeededForPreviousLevelGainAmount
	if _playerData.has("experienceNeededForLevelGainAmount"):
		experienceNeededForLevelGainAmount = _playerData.experienceNeededForLevelGainAmount
	
	hp = _playerData.hp
	mp = _playerData.mp
	if _playerData.has("basehp"):
		basehp = _playerData.basehp
	else:
		basehp = _playerData.hp
	if _playerData.has("basemp"):
		basemp = _playerData.basemp
	else:
		basemp = _playerData.mp
	if _playerData.has("maxhp"):
		maxhp = _playerData.maxhp
	else:
		maxhp = _playerData.hp
	if _playerData.has("maxmp"):
		maxmp = _playerData.maxmp
	else:
		maxmp = _playerData.mp
	shields = 0
	
	stats.strength = float(_playerData.stats.strength)
	stats.legerity = float(_playerData.stats.legerity)
	stats.balance = float(_playerData.stats.balance)
	stats.belief = float(_playerData.stats.belief)
	stats.visage = float(_playerData.stats.visage)
	stats.wisdom = float(_playerData.stats.wisdom)
	if _playerData.has("baseStats"):
		baseStats = _playerData.baseStats
	else:
		baseStats = stats.duplicate(true)
	
	hpIncrease = _playerData.hpIncrease
	mpIncrease = _playerData.mpIncrease
	strengthIncrease = _playerData.strengthIncrease
	legerityIncrease = _playerData.legerityIncrease
	balanceIncrease = _playerData.balanceIncrease
	beliefIncrease = _playerData.beliefIncrease
	visageIncrease = _playerData.visageIncrease
	wisdomIncrease = _playerData.wisdomIncrease
	
	if _playerData.has("statusEffects"):
		statusEffects = _playerData.statusEffects
	
	if _playerData.has("playerVisibility"):
		playerVisibility = _playerData.playerVisibility
	if _playerData.has("itemsTurnedOn"):
		itemsTurnedOn = _playerData.itemsTurnedOn
	
	skills = _playerData.skills
	
	ac = $"/root/World/UI/UITheme/Equipment".getArmorClass()
	magicac = $"/root/World/UI/UITheme/Equipment".getMagicArmorClass()
	currentHit = 0
	hits = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
	
	resistances = _playerData.resistances
	if _playerData.has("equipmentResistances"):
		equipmentResistances = _playerData.equipmentResistances
	
	if _playerData.has("calories"):
		calories = _playerData.calories
	else:
		calories = 1500
	previousCalories = calories
	
	goldPieces = _playerData.goldPieces
	
	if _playerData.has("autoMine"):
		autoMine = _playerData.autoMine
	if _playerData.has("attackNeutral"):
		attackNeutral = _playerData.attackNeutral
	
	neutralClasses = _playerData.neutralClasses
	
	if _playerData.has("items"):
		for _item in _playerData.items.keys():
			var _itemId = $"/root/World/Items/Items".createItem(_item, null, _playerData.items[_item], true, { "piety": "formal" })
	
	var _texture
	if typeof(_playerData.texture) == TYPE_STRING:
		_texture = load(_playerData.texture)
	else:
		_texture = _playerData.texture
	
	$PlayerSprite.texture = _texture
	$Tooltip/TooltipContainer.updateTooltip(critterName, playerClasses[critterClass].skill, _texture)



#####################################
### Player basic action functions ###
#####################################

func processPlayerAction(_playerTile, _tileToMoveTo, _items, _level):
	if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].critter != null:
		var _critter = get_node("/root/World/Critters/{critter}".format({ "critter": _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].critter }))
		if _critter.aI.aI.matchn("Aggressive") or _critter.aI.aI.matchn("Slow Aggressive") or _critter.aI.aI.matchn("Mimicking") or attackNeutral:
			if checkIfCritterHasEffect(_critter):
				return
			
			# On enemy hit
			if hits[currentHit] == 1:
				var _didCritterDespawn = _critter.takeDamage(attacks, _tileToMoveTo, critterName)
				if armorSetStunCount == 4:
					armorSetStunCount = 1
				else:
					armorSetStunCount += 1
				if _didCritterDespawn != null:
					addExp(_didCritterDespawn)
				
				# Onhit abilities
				if _critter.abilities.size() != 0:
					var _onHitAbility = null
					for _ability in _critter.abilities:
						if _ability.abilityName.matchn("toxixSplash"):
							_onHitAbility = _ability
							_onHitAbility.data = critterSpellData[_onHitAbility.abilityName]
							takeDamage(_onHitAbility.data.attacks, _playerTile, _critter.critterName)
							break
				
				# Skill experience
				if (
					$"/root/World/UI/UITheme/Equipment".hands.lefthand == $"/root/World/UI/UITheme/Equipment".hands.righthand and
					$"/root/World/UI/UITheme/Equipment".hands.lefthand != null and
					$"/root/World/UI/UITheme/Equipment".hands.righthand != null
				):
					skills[get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/UITheme/Equipment".hands.lefthand })).category.to_lower()].experience += 1
				else:
					if $"/root/World/UI/UITheme/Equipment".hands.lefthand != null and !get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/UITheme/Equipment".hands.lefthand })).category.matchn("shield"):
						skills[get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/UITheme/Equipment".hands.lefthand })).category.to_lower()].experience += 1
					if $"/root/World/UI/UITheme/Equipment".hands.righthand != null and !get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/UITheme/Equipment".hands.righthand })).category.matchn("shield"):
						skills[get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/UITheme/Equipment".hands.righthand })).category.to_lower()].experience += 1
					if $"/root/World/UI/UITheme/Equipment".dualWielding:
						skills.dualWield.experience += 1
			else:
				Globals.gameConsole.addLog("You miss!")
			
			if currentHit == 15:
				currentHit = 0
			currentHit += 1
			checkSkillExperience()
		elif _critter.aI.aI.matchn("neutral") or _critter.aI.aI.matchn("miner"):
			moveCritter(_playerTile, _tileToMoveTo, 0, _level, _critter.id)
			Globals.gameConsole.addLog("You swap places with the {critter}.".format({ "critter": _critter.critterName }))
			checkIfThereIsSomethingOnTheGroundHere(_tileToMoveTo, _level)
		else:
			return false
	elif _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.DOOR_CLOSED:
		if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].interactable == Globals.interactables.LOCKED:
			Globals.gameConsole.addLog("The door is locked.")
		else:
			_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile = Globals.tiles.DOOR_OPEN
			_level.addPointToEnemyPathding(_tileToMoveTo)
	elif (
		_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.EMPTY or
		_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.WALL_CAVE or
		_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.WALL_CAVE_DEEP
	):
		if $Inventory.checkIfItemInInventoryByName("pickaxe") and autoMine:
			if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.EMPTY:
				_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile = Globals.tiles.FLOOR_CAVE
			elif _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.WALL_CAVE:
				_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile = Globals.tiles.FLOOR_CAVE
			elif _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.WALL_CAVE_DEEP:
				_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile = Globals.tiles.FLOOR_CAVE_DEEP
			_level.addPointToEnemyPathding(_tileToMoveTo)
			_level.addPointToPathPathding(_tileToMoveTo)
			Globals.gameConsole.addLog("You mine the cave wall.")
			if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].interactable == Globals.interactables.GEMS:
				if critterClass.matchn("archeologist") and randi() % 2:
					$"/root/World/Items/Items".createItem($"/root/World/Items/Items".items.gem.rare[randi() % $"/root/World/Items/Items".items.gem.rare.size()], _tileToMoveTo, randi() % 4 + 1, false, { "piety": "Formal" })
					Globals.gameConsole.addLog("You find several gems in the wall!")
				else:
					$"/root/World/Items/Items".createItem($"/root/World/Items/Items".items.gem.rare[randi() % $"/root/World/Items/Items".items.gem.rare.size()], _tileToMoveTo, 1, false, { "piety": "Formal" })
					Globals.gameConsole.addLog("You find a gem in the wall.")
				_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].interactable = null
	else:
		if checkIfStatusEffectIsInEffect("fumbling") and randi() % 7 == 0:
			Globals.gameConsole.addLog("You fumble on your feet.")
		elif _level.grid[_playerTile.x][_playerTile.y].interactable == Globals.interactables.SPIDER_WEB:
			if randi() % 3 == 0:
				_level.grid[_playerTile.x][_playerTile.y].interactable = null
				Globals.gameConsole.addLog("You free yourself from the spider web.")
#				if randi() % 8 == 0:
#					Globals.gameConsole.addLog("Spider jumps out from the spider web! (UN_IMPL)")
			else:
				Globals.gameConsole.addLog("You are still stuck in the spider web.")
		else:
			moveCritter(_playerTile, _tileToMoveTo, 0, _level)
			checkIfThereIsSomethingOnTheGroundHere(_tileToMoveTo, _level)

func takeDamage(_attacks, _critterTile, _critterName):
	var _attacksLog = []
	if _attacks.size() != 0:
		for _attack in _attacks:
			var _damage = calculateDmg(_attack)
			
			if checkIfItemsTurnedOnHasItem("cloak of magical ambiguity") and _damage.dmg <= 0 and _damage.magicDmg > 0:
				if _damage.magicDmg - 1 < 0:
					_damage.magicDmg = 0
				else:
					_damage.magicDmg -= 1
			
			var _damageNumber = damageNumber.instance()
			var _damageText
			var _damageColor = "#000"
			if _damage.dmg < 1 and _damage.dmg >= -2:
				_damageText = 1 + _damage.magicDmg
			elif _damage.dmg < -2:
				_damageText = 0
			else:
				_damageText = _damage.dmg + _damage.magicDmg
			if _damage.magicDmg != 0 and _attack.magicDmg.element != null:
				_damageColor = spellData.spellData[_attack.magicDmg.element.to_lower()].color
			_damageNumber.create(_critterTile, _damageText, _damageColor)
			$"/root/World/Texts".add_child(_damageNumber)
			
			# Magic spell
			if _damage.dmg <= 0 and _damage.magicDmg > 0:
				hp -= _damage.magicDmg
				_attacksLog.append("{critterName} gets hit for {magicDmg} {element} damage!".format({ "critterName": critterName, "magicDmg": _damage.magicDmg, "element": _attack.magicDmg.element }))
				if _attack.magicDmg.element != null and _attack.magicDmg.element.matchn("toxix") and statusEffects.toxix != -1:
					statusEffects.toxix += 3
				if _attack.magicDmg.element != null and _attack.magicDmg.element.matchn("fleir") and statusEffects.onFleir != -1:
					statusEffects.onFleir = 3
			# Physical attack
			else:
				# Physical damage
				if _damage.dmg < 1 and _damage.dmg >= -2:
					hp -= 1
					_attacksLog.append("{critterName} hits you for 1 damage.".format({ "critterName": _critterName }))
				elif _damage.dmg < -2:
					_attacksLog.append("{critterName}s attack bounces off!".format({ "critterName": _critterName }))
				else:
					hp -= _damage.dmg
					_attacksLog.append("{critterName} hits you for {dmg} damage.".format({ "critterName": _critterName, "dmg": _damage.dmg + _damage.magicDmg }))
				
				# Magic damage
				if _damage.magicDmg != 0:
					hp -= _damage.magicDmg
					_attacksLog.append(" ({magicDmg} {element} damage)".format({ "magicDmg": _damage.magicDmg, "element": _attack.magicDmg.element }))
					if _attack.magicDmg.element != null and _attack.magicDmg.element.matchn("toxix") and statusEffects.toxix != -1:
						statusEffects.toxix += 3
					if _attack.magicDmg.element != null and _attack.magicDmg.element.matchn("fleir") and statusEffects.onFleir != -1:
						statusEffects.onFleir = 3
			
			# Damage taken game stats
			if _damageText > GlobalGameStats.gameStats["Highest damage taken"]:
				GlobalGameStats.gameStats["Highest damage taken"] = _damageText
			GlobalGameStats.gameStats["Damage taken"] += _damageText
		var _attacksLogString = PoolStringArray(_attacksLog).join(" ")
		Globals.gameConsole.addLog(_attacksLogString)
	else:
		Globals.gameConsole.addLog("{critterName} looks unsure!".format({ "critterName": _critterName }))

func pickUpItems(_playerTile, _items, _grid):
	var _itemsLog = []
	if _items.size() != 0:
		for _itemId in _items:
			pickUpItem(_playerTile, _itemId, _grid)
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
			if _item.amount > 1:
				_itemsLog.append("You pickup {amount} {itemName}.".format({ "amount": _item.amount, "itemName": _item.itemName }))
			else:
				_itemsLog.append("You pickup {itemName}.".format({ "itemName": _item.itemName }))
	var _itemsLogString = PoolStringArray(_itemsLog).join(" ")
	if !_itemsLogString.empty():
		Globals.gameConsole.addLog(_itemsLogString)
	$"/root/World".hideObjectsWhenDrawingNextFrame = true

func pickUpItem(_playerTile, _itemId, _grid):
	for _itemOnGround in range(_grid[_playerTile.x][_playerTile.y].items.size()):
		if _grid[_playerTile.x][_playerTile.y].items[_itemOnGround] == _itemId:
			var _item = get_node("/root/World/Items/{id}".format({ "id": _itemId }))
			_grid[_playerTile.x][_playerTile.y].items.remove(_itemOnGround)
			if _item.itemName.matchn("Gold pieces"):
				goldPieces += _item.amount
				_item.queue_free()
			else:
				addToInventory([_itemId])
				_item.hide()
			return

func dropItems(_playerTile, _items, _grid):
	var _itemsLog = []
	if _items.size() != 0:
		for _id in _items:
			var _item = get_node("/root/World/Items/{id}".format({ "id": _id }))
			_itemsLog.append(dropItem(_playerTile, _item, _grid))
	var _itemsLogString = PoolStringArray(_itemsLog).join(" ")
	if !_itemsLogString.empty():
		Globals.gameConsole.addLog(_itemsLogString)
	$"/root/World".hideObjectsWhenDrawingNextFrame = true

func dropItem(_playerTile, _item, _grid):
	var _dropLog = []
	if _item.binds != null and _item.binds.state.matchn("bound"):
		_dropLog.append("The {item} is bound to you.".format({ "item": _item.itemName }))
	else:
		_grid[_playerTile.x][_playerTile.y].items.append(_item.id)
		$Inventory.removeFromInventory(_item)
		$"/root/World/UI/UITheme/Equipment".takeOfEquipmentWhenDroppingItem(_item.id)
		$"/root/World/UI/UITheme/Runes".takeOfRuneWhenDroppingItem(_item.id)
		_dropLog.append("You drop {item}.".format({ "item": _item.itemName }))
		if _grid[_playerTile.x][_playerTile.y].interactable == Globals.interactables.ALTAR:
			if (
				_item.identifiedItemName.matchn("amulet of iovar") and
				$"/root/World".level.dungeonLevelName.matchn("church") and
				_playerTile == Vector2(53, 11)
			):
				$"/root/World".closeMenu()
				$"/root/World".currentGameState = $"/root/World".gameState.GAME_OVER
				$"/root/World".gameOver = true
				GlobalGameStats.gameStats["Times ascended"] += 1
				$"/root/World/UI/UITheme/Game Over Stats".setValues("You ascend!", getGameOverStats(), true)
				$"/root/World/UI/UITheme/Game Over Stats".show()
				yield(get_tree().create_timer(0.01), "timeout")
			_item.identifyItem(false, true, false)
			if _item.piety.matchn("reverent"):
				_dropLog.append("The {item} flashes with a white light.".format({ "item": _item.itemName }))
			elif _item.piety.matchn("blasphemous"):
				_dropLog.append("The {item} flashes with a black light.".format({ "item": _item.itemName }))
	var _dropLogString = PoolStringArray(_dropLog).join(" ")
	return _dropLogString

func addToInventory(_items):
	for _itemId in _items:
		var _item = get_node("/root/World/Items/{id}".format({ "id": _itemId }))
		$Inventory.addToInventory(_item)
		if _item.binds != null and _item.binds.type.matchn("inventory"):
			_item.binds = {
				"type": _item.value.binds,
				"state": "Bound"
			}



####################################
### Player stat update functions ###
####################################

func processPlayerSpecificEffects():
	############
	## Hunger ##
	############
	previousCalories = calories
	
	if calories > -50:
		if checkIfStatusEffectIsInEffect("fast digestion"):
			calories -= 3
		elif checkIfStatusEffectIsInEffect("slow digestion"):
			calories -= 1
		else:
			calories -= 2
	
	statusStates.hunger.previous = statusStates.hunger.current
	
	####################
	## Status effects ##
	####################
	if playerVisibility.duration > 0:
		playerVisibility.duration -= 1
	else:
		playerVisibility.distance = -1
	
	if checkIfStatusEffectIsInEffect("blindness"):
		playerVisibility.distance = 0
	elif !checkIfLightSourceIsTurnedOn() and playerVisibility.duration == 0:
		if playerVisibility.distance > 0:
			Globals.gameConsole.addLog("Your vision changes.")
		playerVisibility.distance = -1
	
	###################
	## Status states ##
	###################
	
	print(baseStats)
	if statusStates.hunger.current == 1 and statusStates.hunger.previous == 0:
		baseStats.strength -= 1
	elif statusStates.hunger.current == 2 and statusStates.hunger.previous == 0:
		baseStats.strength -= 1
		baseStats.balance -= 1
	elif statusStates.hunger.current == 3 and statusStates.hunger.previous == 0:
		baseStats.strength -= 2
		baseStats.legerity -= 1
		baseStats.balance -= 1
	elif statusStates.hunger.current == 0 and statusStates.hunger.previous == 1:
		baseStats.strength += 1
	elif statusStates.hunger.current == 2 and statusStates.hunger.previous == 1:
		baseStats.balance -= 1
	elif statusStates.hunger.current == 3 and statusStates.hunger.previous == 1:
		baseStats.strength -= 1
		baseStats.legerity -= 1
		baseStats.balance -= 1
	elif statusStates.hunger.current == 0 and statusStates.hunger.previous == 2:
		baseStats.strength += 1
		baseStats.balance += 1
	elif statusStates.hunger.current == 1 and statusStates.hunger.previous == 2:
		baseStats.balance += 1
	elif statusStates.hunger.current == 3 and statusStates.hunger.previous == 2:
		baseStats.strength -= 1
		baseStats.legerity -= 1
	elif statusStates.hunger.current == 0 and statusStates.hunger.previous == 3:
		baseStats.strength += 2
		baseStats.legerity += 1
		baseStats.balance += 1
	elif statusStates.hunger.current == 1 and statusStates.hunger.previous == 3:
		baseStats.strength += 1
		baseStats.legerity += 1
		baseStats.balance += 1
	elif statusStates.hunger.current == 2 and statusStates.hunger.previous == 3:
		baseStats.strength += 1
		baseStats.legerity += 1
	print(baseStats)
	
	########
	## UI ##
	########

	processPlayerUIChanges()
	
	################
	## Worn items ##
	################
	equipmentResistances = []
	for _itemId in itemsTurnedOn:
		var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
		match _item.identifiedItemName.to_lower():
			"amulet of seeing":
				statusEffects["seeing"] = -1
			"amulet of strangulation":
				hp -= 5
				Globals.gameConsole.addLog("You are strangled by the amulet!")
			"amulet of toxix":
				statusEffects["toxix"] = -1
			"amulet of sleep":
				if statusEffects["sleep"] == 0 and randi() % 21 == 0:
					statusEffects["sleep"] = randi() % 6 + 2
			"amulet of backscattering":
				statusEffects["backscattering"] = -1
			"ring of fast digestion":
				statusEffects["fast digestion"] = -1
			"ring of slow digestion":
				statusEffects["slow digestion"] = -1
			"ring of regen":
				statusEffects["regen"] = -1
			"ring of fumbling":
				statusEffects["fumbling"] = -1
			"blue dragon scale mail", "frozen mail":
				equipmentResistances.append("frost")
			"red dragon scale mail":
				equipmentResistances.append("fleir")
			"yellow dragon scale mail", "thunder mail":
				equipmentResistances.append("thunder")
			"green dragon scale mail":
				equipmentResistances.append("gleeie'er")
			"violet dragon scale mail":
				equipmentResistances.append("toxix")
			"candle":
				if _item.value.charges > 0:
					_item.value.charges -= 1
					if playerVisibility.distance != 0:
						playerVisibility.distance = _item.value.value
				else:
					if playerVisibility.distance != 0:
						playerVisibility.distance = -1
						Globals.gameConsole.addLog("Your candle has run out of wax.")
					_item.value.turnedOn = false
					itemsTurnedOn.erase(_itemId)
			"oil lamp":
				if _item.value.charges > 0:
					_item.value.charges -= 1
					if playerVisibility.distance != 0:
						playerVisibility.distance = _item.value.value
				else:
					if playerVisibility.distance != 0:
						playerVisibility.distance = -1
						Globals.gameConsole.addLog("Your lamp has run out of oil.")
					_item.value.turnedOn = false
					itemsTurnedOn.erase(_itemId)
			"magic lamp":
				if playerVisibility.distance != 0:
					playerVisibility.distance = _item.value.value

func processPlayerUIChanges():
	# Deal with status effects in the UI
	for _statusEffect in statusEffects.keys():
		if checkIfStatusEffectIsInEffect(_statusEffect):
			if !$"/root/World/UI/UITheme/GameStats".isStatusEffectInGameStats(_statusEffect):
				$"/root/World/UI/UITheme/GameStats".addStatusEffect(_statusEffect)
				var _damageNumber = damageNumber.instance()
				_damageNumber.create($"/root/World".level.getCritterTile(0), _statusEffect.capitalize(), statusEffectsData.statusEffectsData[_statusEffect].color)
				$"/root/World/Texts".add_child(_damageNumber)
		else:
			if $"/root/World/UI/UITheme/GameStats".isStatusEffectInGameStats(_statusEffect):
				$"/root/World/UI/UITheme/GameStats".removeStatusEffect(_statusEffect)
	
	# Deal with status states in UI
	var _currentHungerStateType = null
	var _currentWeightStateType = null
	var _previousHungerStateType = null
	var _previousWeightStateType = null
	for _statusState in statusStates:
		if _statusState.matchn("hunger"):
			if statusStates[_statusState].current == 1:
				_currentHungerStateType = "hungry"
			elif statusStates[_statusState].current == 2:
				_currentHungerStateType = "malnourished"
			elif statusStates[_statusState].current == 3:
				_currentHungerStateType = "famished"
			if statusStates[_statusState].previous == 1:
				_previousHungerStateType = "hungry"
			elif statusStates[_statusState].previous == 2:
				_previousHungerStateType = "malnourished"
			elif statusStates[_statusState].previous == 3:
				_previousHungerStateType = "famished"
			if (statusStates[_statusState].current > 0 or statusStates[_statusState].current == -1) and _currentHungerStateType != null:
				if !$"/root/World/UI/UITheme/GameStats".isStatusEffectInGameStats(_currentHungerStateType):
					$"/root/World/UI/UITheme/GameStats".addStatusEffect(_currentHungerStateType)
					var _damageNumber = damageNumber.instance()
					_damageNumber.create($"/root/World".level.getCritterTile(0), _currentHungerStateType.capitalize(), statusEffectsData.statusEffectsData[_currentHungerStateType].color)
					$"/root/World/Texts".add_child(_damageNumber)
			if (
				(_previousHungerStateType != null and _currentHungerStateType != null and !_previousHungerStateType.matchn(_currentHungerStateType)) or
				(_previousHungerStateType != null and _currentHungerStateType == null)
			):
				if $"/root/World/UI/UITheme/GameStats".isStatusEffectInGameStats(_previousHungerStateType):
					$"/root/World/UI/UITheme/GameStats".removeStatusEffect(_previousHungerStateType)
		elif _statusState.matchn("weight"):
			if statusStates[_statusState].current == 1:
				_currentWeightStateType = "overencumbured"
			elif statusStates[_statusState].current == 2:
				_currentWeightStateType = "burdened"
			elif statusStates[_statusState].current == 3:
				_currentWeightStateType = "flattened"
			if statusStates[_statusState].previous == 1:
				_previousWeightStateType = "overencumbured"
			elif statusStates[_statusState].previous == 2:
				_previousWeightStateType = "burdened"
			elif statusStates[_statusState].previous == 3:
				_previousWeightStateType = "flattened"
			if (statusStates[_statusState].current > 0 or statusStates[_statusState].current == -1) and _currentWeightStateType != null:
				if !$"/root/World/UI/UITheme/GameStats".isStatusEffectInGameStats(_currentWeightStateType):
					$"/root/World/UI/UITheme/GameStats".addStatusEffect(_currentWeightStateType)
					var _damageNumber = damageNumber.instance()
					_damageNumber.create($"/root/World".level.getCritterTile(0), _currentWeightStateType.capitalize(), statusEffectsData.statusEffectsData[_currentWeightStateType].color)
					$"/root/World/Texts".add_child(_damageNumber)
			if (
				(_previousWeightStateType != null and _currentWeightStateType != null and !_previousWeightStateType.matchn(_currentWeightStateType)) or
				(_previousWeightStateType != null and _currentWeightStateType == null)
			):
				if $"/root/World/UI/UITheme/GameStats".isStatusEffectInGameStats(_previousWeightStateType):
					$"/root/World/UI/UITheme/GameStats".removeStatusEffect(_previousWeightStateType)
	
	# Deal with status effect and status state stat changes
	var _stats = baseStats.duplicate(true)
	for _statusEffect in statusEffects.keys():
		if statusEffects[_statusEffect] > 0 and statusEffectsData.statusEffectsData[_statusEffect].has("effects"):
			for _stat in statusEffectsData.statusEffectsData[_statusEffect].effects:
				_stats[_stat] += statusEffectsData.statusEffectsData[_statusEffect].effects[_stat]
	if _currentWeightStateType != null and statusEffectsData.statusEffectsData[_currentWeightStateType].has("effects"):
		for _stat in statusEffectsData.statusEffectsData[_currentWeightStateType].effects:
			_stats[_stat] += statusEffectsData.statusEffectsData[_currentWeightStateType].effects[_stat]
	if _currentWeightStateType != null and statusEffectsData.statusEffectsData[_currentWeightStateType].has("effects"):
		for _stat in statusEffectsData.statusEffectsData[_currentWeightStateType].effects:
			_stats[_stat] += statusEffectsData.statusEffectsData[_currentWeightStateType].effects[_stat]
	
	stats = _stats

func calculateHungerStats():
	if calories >= 800:
		statusStates.hunger.current = 0
	elif calories >= 200 and calories < 800:
		statusStates.hunger.current = 1
	elif calories >= 0 and calories < 200:
		statusStates.hunger.current = 2
	elif calories < 0:
		statusStates.hunger.current = 3
		
	# Check if player becomes less hungry
	if previousCalories < 800 and calories >= 800:
		Globals.gameConsole.addLog("You are no longer hungry.")
	elif previousCalories < 400 and calories >= 400 and calories < 800:
		Globals.gameConsole.addLog("You only feel hungry.")
	elif previousCalories < 200 and calories >= 200 and calories < 400:
		Globals.gameConsole.addLog("You are still very hungry.")
	elif previousCalories < 0 and calories >= 0:
		Globals.gameConsole.addLog("You are still starving!")
	
	# Check if player becomes more hungry
	if previousCalories >= 800 and calories < 800 and calories >= 400:
		Globals.gameConsole.addLog("You are beginning to feel hungry.")
	elif previousCalories >= 400 and calories < 400 and calories >= 200:
		Globals.gameConsole.addLog("You feel very hungry.")
	elif previousCalories >= 200 and calories < 200 and calories > 0:
		Globals.gameConsole.addLog("You are starving!")
	elif calories <= 0:
		hp -= 2
		if previousCalories > 0:
			Globals.gameConsole.addLog("You are famished!")

func calculateWeightStats():
	maxCarryWeight = {
		"overEncumbured": int(stats.strength / 4 * 3) * 60,
		"burdened": int(stats.strength / 4 * 3) * 80,
		"flattened": int(stats.strength / 4 * 3) * 100
	}
	
	var _weight = $Inventory.currentWeight
	
	statusStates.weight.previous = statusStates.weight.current
	
	if _weight <= maxCarryWeight.overEncumbured:
		statusStates.weight.current = 0
		turnsUntilAction = 0
	elif _weight > maxCarryWeight.overEncumbured and _weight <= maxCarryWeight.burdened:
		statusStates.weight.current = 1
		turnsUntilAction = 1
	elif _weight > maxCarryWeight.burdened and _weight <= maxCarryWeight.flattened:
		statusStates.weight.current = 2
		turnsUntilAction = 2
	elif _weight > maxCarryWeight.flattened:
		statusStates.weight.current = 3
		turnsUntilAction = 3
	
	if _weight > 0 and _weight <= maxCarryWeight.overEncumbured:
		carryWeightBounds = {
			"min": 0,
			"max": maxCarryWeight.overEncumbured
		}
	elif _weight > maxCarryWeight.overEncumbured and _weight <= maxCarryWeight.burdened:
		carryWeightBounds = {
			"min": maxCarryWeight.overEncumbured,
			"max": maxCarryWeight.burdened
		}
	elif _weight > maxCarryWeight.burdened and _weight <= maxCarryWeight.flattened:
		carryWeightBounds = {
			"min": maxCarryWeight.burdened,
			"max": maxCarryWeight.flattened
		}
	elif _weight > maxCarryWeight.flattened:
		carryWeightBounds = {
			"min": maxCarryWeight.flattened,
			"max": 99999
		}

func calculateEquipmentStats():
	# Armor class
	ac = $"/root/World/UI/UITheme/Equipment".getArmorClass()
	
	# Magic armor class
	magicac = $"/root/World/UI/UITheme/Equipment".getMagicArmorClass()
	
	# Attacks
	attacks = []
	if (
		$"/root/World/UI/UITheme/Equipment".hands["lefthand"] != null and
		$"/root/World/UI/UITheme/Equipment".hands["lefthand"] == $"/root/World/UI/UITheme/Equipment".hands["righthand"]
	):
		attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/UITheme/Equipment".hands["lefthand"] })).getAttacks(stats))
	elif (
		$"/root/World/UI/UITheme/Equipment".hands["lefthand"] != null or
		$"/root/World/UI/UITheme/Equipment".hands["righthand"] != null
	):
		if (
			$"/root/World/UI/UITheme/Equipment".hands["lefthand"] != null and
			!get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/UITheme/Equipment".hands["lefthand"] })).category.matchn("shield")
		):
			attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/UITheme/Equipment".hands["lefthand"] })).getAttacks(stats))
		if (
			$"/root/World/UI/UITheme/Equipment".hands["righthand"] != null and
			!get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/UITheme/Equipment".hands["righthand"] })).category.matchn("shield")
		):
			attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/UITheme/Equipment".hands["righthand"] })).getAttacks(stats))
	if attacks.size() == 0:
		attacks = [
			{
				"dmg": [int(1 + stats.strength / 6), int(1 + stats.strength / 6)],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		]

func addExp(_expAmount):
	experiencePoints += _expAmount
	while true:
		if experiencePoints >= experienceNeededForLevelGainAmount and level < 20:
			gainLevel()
		else:
			break

func gainLevel():
	level += 1
	
	maxhp += hpIncrease + int(baseStats.balance / 5)
	maxmp += mpIncrease + int(baseStats.wisdom / 5)
	if hp + hpIncrease + int(baseStats.balance / 5) >= maxhp:
		hp = maxhp
	else:
		hp += hpIncrease + int(baseStats.balance / 5)
	if mp + mpIncrease + int(baseStats.wisdom / 5) >= maxmp:
		mp = maxmp
	else:
		mp += mpIncrease + int(baseStats.wisdom / 5)
	baseStats.strength += strengthIncrease
	baseStats.legerity += legerityIncrease
	baseStats.balance += balanceIncrease
	baseStats.belief += beliefIncrease
	baseStats.visage += visageIncrease
	baseStats.wisdom += wisdomIncrease
	
	experienceNeededForPreviousLevelGainAmount = experienceNeededForLevelGainAmount
	var _nextLevelExpGain = int(experienceNeededForLevelGainAmount + (20 * level + (experienceNeededForLevelGainAmount / 4)))
	experienceNeededForLevelGainAmount = _nextLevelExpGain
	
	Globals.gameConsole.addLog("You advance to level {level}!".format({ "level": level }))

func updatePlayerStats():
	var _totalBonusDamage = 0
	for _bonusDamage in attacks[0].bonusDmg.values():
		_totalBonusDamage += _bonusDamage
	Globals.gameStats.updateStats({
		maxhp = maxhp,
		hp = hp,
		maxmp = maxmp,
		mp = mp,
		level = level,
		experiencePoints = experiencePoints,
		experienceLevelGainAmount = experienceNeededForLevelGainAmount,
		critterName = critterName,
		race = race,
		justice = justice,
		ac = ac,
		magicac = magicac,
		attacks = {
			"attack": attacks[0],
			"hits": attacks.size(),
			"bonusDmg": _totalBonusDamage
		},
		currentHit = currentHit,
		hits = hits,
		magicAttacks = {
			"attack": $"/root/World/UI/UITheme/Runes".spellDamage[0],
			"hits": $"/root/World/UI/UITheme/Runes".spellDamage.size(),
			"bonusDmg": _totalBonusDamage
		},
		dungeonLevel = Globals.currentDungeonLevelName,
		weight = $Inventory.currentWeight,
		weightBounds = carryWeightBounds,
		strength = stats.strength,
		legerity = stats.legerity,
		balance = stats.balance,
		belief = stats.belief,
		visage = stats.visage,
		wisdom = stats.wisdom,
		goldPieces = goldPieces
	})



########################
### Helper functions ###
########################

func checkIfThereIsSomethingOnTheGroundHere(_tile, _level):
	for _itemId in _level.grid[_tile.x][_tile.y].items:
		if get_node("/root/World/Items/{item}".format({ "item": _itemId })).itemName.matchn("Gold pieces"):
			pickUpItems(_tile, [_itemId], _level.grid)
	
	if _level.grid[_tile.x][_tile.y].items.size() > 10:
		Globals.gameConsole.addLog("There are alot of items here.")
	elif _level.grid[_tile.x][_tile.y].items.size() > 1:
		Globals.gameConsole.addLog("You see some items here.")
	elif !_level.grid[_tile.x][_tile.y].items.empty():
		Globals.gameConsole.addLog("You see {item}.".format({ "item": get_node("/root/World/Items/{item}".format({ "item": _level.grid[_tile.x][_tile.y].items.back() })).itemName }))
	
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.ALTAR:
		Globals.gameConsole.addLog("You see an altar here.")
	
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.HIDDEN_ITEM or _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.DIGGABLE:
		Globals.gameConsole.addLog("There's something hidden in the ground here.")
	
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.PLANT:
		Globals.gameConsole.addLog("There's a plant here.")
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.PLANT_CARROT:
		Globals.gameConsole.addLog("There's a carrot plant here.")
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.PLANT_TOMATO:
		Globals.gameConsole.addLog("There's a tomato plant here.")
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.PLANT_BEAN:
		Globals.gameConsole.addLog("There's a bean plant here.")
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.PLANT_ORANGE:
		Globals.gameConsole.addLog("There's an orange plant here.")
	
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.ANT_HILL:
		Globals.gameConsole.addLog("There's an ant hill here.")
	
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.SPIDER_WEB:
		Globals.gameConsole.addLog("You're stuck in the spider web!")
	
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.FOUNTAIN:
		Globals.gameConsole.addLog("There's a fountain here.")

func checkAllIdentification(_items = false, _critters = false):
	if _items:
		$"/root/World/Items/Items".checkAllItemsIdentification()
	if _critters:
		$"/root/World/Critters/Critters".checkAllCrittersIdentification()

func checkIfLightSourceIsTurnedOn():
	for _itemId in itemsTurnedOn:
		var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
		if (
			_item.identifiedItemName.to_lower() == "candle" or
			_item.identifiedItemName.to_lower() == "oil lamp" or
			_item.identifiedItemName.to_lower() == "magic lamp"
		):
			return true
	return false

func checkIfCritterHasEffect(_critter):
	if _critter.critterName.matchn("floating eye") and !checkIfStatusEffectIsInEffect("blindness"):
		statusEffects.stun = 10
		Globals.gameConsole.addLog("The {critterName}s gaze stuns you!".format({ "critterName": _critter.critterName }))
		return true
	if _critter.checkIfStatusEffectIsInEffect("displacement") and randi() % 4 == 0:
		Globals.gameConsole.addLog("You miss the displaced image of {critterName}!".format({ "critterName": _critter.critterName }))
		return true
	return false

func checkSkillExperience():
	for _skill in skills:
		if skills[_skill].skillcap > skills[_skill].level and skills[_skill].experience >= 200 and skills[_skill].level == 0:
			skills[_skill].level = 1
			Globals.gameConsole.addLog("You gain a level in {skill}!".format({ "skill": _skill }))
		elif skills[_skill].skillcap > skills[_skill].level and  skills[_skill].experience >= 500 and skills[_skill].level == 1:
			skills[_skill].level = 2
			Globals.gameConsole.addLog("You gain a level in {skill}!".format({ "skill": _skill }))
		elif skills[_skill].skillcap > skills[_skill].level and  skills[_skill].experience >= 1200 and skills[_skill].level == 2:
			skills[_skill].level = 3
			Globals.gameConsole.addLog("You master the {skill}!".format({ "skill": _skill }))

func checkIfItemsTurnedOnHasItem(_itemName):
	for _itemId in itemsTurnedOn:
		if get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).identifiedItemName.matchn(_itemName):
			return true
	return false

func getGameOverStats():
	var _stats = {  }
	
	_stats.points = $"/root/World/Critters/0/Inventory".getPoints()
	_stats.consoleLogs = $"/root/World/UI/UITheme/GameConsole".getGameConsoleSaveData()
	_stats.inventoryItems = $"/root/World/Critters/0/Inventory".getInventoryItems()
	_stats.gameStats = GlobalGameStats.getGlobalGameStats()
	_stats.gameStats.gameStats["Points"] = _stats.points.totalPoints
	_stats.playerStats = {
		"playerClass": critterClass
	}
	
	return _stats

func getCritterSaveData():
	var _critterData = {
		inventory = $Inventory.inventory,
		playerClass = critterClass,
		playerVisibility = playerVisibility,
		experiencePoints = experiencePoints,
		experienceNeededForPreviousLevelGainAmount = experienceNeededForPreviousLevelGainAmount,
		experienceNeededForLevelGainAmount = experienceNeededForLevelGainAmount,
		hpIncrease = hpIncrease,
		mpIncrease = mpIncrease,
		strengthIncrease = strengthIncrease,
		legerityIncrease = legerityIncrease,
		balanceIncrease = balanceIncrease,
		beliefIncrease = beliefIncrease,
		visageIncrease = visageIncrease,
		wisdomIncrease = wisdomIncrease,
		calories = calories,
		previousCalories = previousCalories,
		goldPieces = goldPieces,
		equipmentResistances = equipmentResistances,
		statusStates = statusStates,
		maxCarryWeight = maxCarryWeight,
		carryWeightBounds = carryWeightBounds,
		turnsUntilAction = turnsUntilAction,
		attackNeutral = attackNeutral,
		autoMine = autoMine,
		selectedItem = selectedItem,
		itemsTurnedOn = itemsTurnedOn,
		skills = skills,
		neutralClasses = neutralClasses,
		texture = $PlayerSprite.texture.get_path()
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
