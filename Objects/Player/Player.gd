extends BaseCritter
class_name Player

var inventory = load("res://UI/Inventory/Inventory.tscn").instance()

var playerVisibility = -1

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

var itemsTurnedOn = []

var skills = {
	"sword": {
		"skill": 0,
		"skillCap": 0
	},
	"twohandedSword": {
		"skill": 0,
		"skillCap": 0
	},
	"dagger": {
		"skill": 0,
		"skillCap": 0
	},
	"mace": {
		"skill": 0,
		"skillCap": 0
	},
	"flail": {
		"skill": 0,
		"skillCap": 0
	}
}

var neutralCritters = ["Sugar ant", "Shopkeeper"]

func create(_class):
	id = 0
	name = str(0)
	
	add_child(inventory)
	$Inventory.create()
	
	var _playerClass = load("res://Objects/Player/PlayableClasses.gd").new()[_class]
	
	critterName = "Player"
	race = "Human"
	alignment = "Neutral"
	
	stats.strength = _playerClass.strength
	stats.legerity = _playerClass.legerity
	stats.balance = _playerClass.balance
	stats.belief = _playerClass.belief
	stats.visage = _playerClass.visage
	stats.wisdom = _playerClass.wisdom
	
	hpIncrease = _playerClass.hpIncrease
	mpIncrease = _playerClass.mpIncrease
	strengthIncrease = _playerClass.strengthIncrease
	legerityIncrease = _playerClass.legerityIncrease
	balanceIncrease = _playerClass.balanceIncrease
	beliefIncrease = _playerClass.beliefIncrease
	visageIncrease = _playerClass.visageIncrease
	wisdomIncrease = _playerClass.wisdomIncrease
	
	skills = _playerClass.skills
	
	level = 1
	hp = _playerClass.hp
	mp = _playerClass.mp
	basehp = _playerClass.hp
	basemp = _playerClass.mp
	maxhp = _playerClass.hp
	maxmp = _playerClass.mp
	ac = $"/root/World/UI/UITheme/Equipment".getArmorClass()
	currentHit = 0
	hits = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
	
	abilities = []
	resistances = []
	
	calories = 1000
	previousCalories = calories
	
	$PlayerSprite.texture = load("res://Assets/Classes/Mercenary.png")



#####################################
### Player basic action functions ###
#####################################

func processPlayerAction(_playerTile, _tileToMoveTo, _items, _level):
	if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].critter != null:
		var _critter = get_node("/root/World/Critters/{critter}".format({ "critter": _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].critter }))
		if _critter.aI.aI == "Aggressive":
			if hits[currentHit] == 1:
				var _didCritterDespawn = _critter.takeDamage(attacks, _tileToMoveTo, _items, _level)
				if _didCritterDespawn != null:
					addExp(_didCritterDespawn)
			else:
				Globals.gameConsole.addLog("You miss!")
			if currentHit == 15:
				currentHit = 0
			currentHit += 1
		elif _critter.aI.aI == "Neutral":
			moveCritter(_playerTile, _tileToMoveTo, 0, _level, _critter.id)
			Globals.gameConsole.addLog("You swap places with the {critter}.".format({ "critter": _critter.critterName }))
			checkIfThereIsSomethingOnTheGroundHere(_level, _tileToMoveTo)
		else:
			return false
	elif _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.DOOR_CLOSED:
		if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].interactable == Globals.interactables.LOCKED:
			Globals.gameConsole.addLog("The door won't budge!")
		else:
			_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile = Globals.tiles.DOOR_OPEN
			_level.addPointToEnemyPathding(_tileToMoveTo, _level.grid)
	else:
		if checkIfStatusEffectIsInEffect("fumbling") and randi() % 4 == 0:
			Globals.gameConsole.addLog("You fumble on your feet.")
		else:
			moveCritter(_playerTile, _tileToMoveTo, 0, _level)
			checkIfThereIsSomethingOnTheGroundHere(_level, _tileToMoveTo)

func takeDamage(_attacks, _crittername):
	var _attacksLog = []
	if _attacks.size() != 0:
		for _attack in _attacks:
			var armorReduction = _attack - ( ac / 3 )
			if armorReduction <= 1 and armorReduction >= -2:
				hp -= 1
				_attacksLog.append("{crittername} hits you for 1 damage.".format({ "crittername": _crittername }))
			elif armorReduction < -2:
				_attacksLog.append("{crittername}s attack bounces off!".format({ "crittername": _crittername }))
			else:
				hp -= armorReduction
				_attacksLog.append("{crittername} hits you for {dmg} damage.".format({ "crittername": _crittername, "dmg": armorReduction }))
			if hp <= 0:
				_attacksLog.append("You die...")
				break
		var _attacksLogString = PoolStringArray(_attacksLog).join(" ")
		Globals.gameConsole.addLog(_attacksLogString)
	else:
		Globals.gameConsole.addLog("{critter} looks unsure!".format({ "critter": _crittername }))

func pickUpItems(_playerTile, _items, _grid):
	var itemsLog = []
	if _items.size() != 0:
		for _item in _items:
			pickUpItem(_playerTile, _item, _grid)
			itemsLog.append("You pickup {item}.".format({ "item": get_node("/root/World/Items/{id}".format({ "id": _item })).itemName }))
	var itemsLogString = PoolStringArray(itemsLog).join(" ")
	Globals.gameConsole.addLog(itemsLogString)

func pickUpItem(_playerTile, _item, _grid):
	for _itemOnGround in range(_grid[_playerTile.x][_playerTile.y].items.size()):
		if _grid[_playerTile.x][_playerTile.y].items[_itemOnGround] == _item:
			_grid[_playerTile.x][_playerTile.y].items.remove(_itemOnGround)
			$Inventory.addToInventory(get_node("/root/World/Items/{id}".format({ "id": _item })))
			get_node("/root/World/Items/{id}".format({ "id": _item })).hide()
			return

func dropItems(_playerTile, _items, _grid):
	var _itemsLog = []
	if _items.size() != 0:
		for _id in _items:
			var _item = get_node("/root/World/Items/{id}".format({ "id": _id }))
			_itemsLog.append(dropItem(_playerTile, _item, _grid))
	var _itemsLogString = PoolStringArray(_itemsLog).join(" ")
	Globals.gameConsole.addLog(_itemsLogString)

func dropItem(_playerTile, _item, _grid):
	var _dropLog = []
	_grid[_playerTile.x][_playerTile.y].items.append(_item.id)
	$Inventory.dropFromInventory(_item)
	get_node("/root/World/Items/{id}".format({ "id": _item.id })).show()
	$"/root/World/UI/UITheme/Equipment".takeOfEquipmentWhenDroppingItem(_item.id)
	$"/root/World/UI/UITheme/Runes".takeOfRuneWhenDroppingItem(_item.id)
	_dropLog.append("You drop {item}.".format({ "item": _item.itemName }))
	if _grid[_playerTile.x][_playerTile.y].interactable == Globals.interactables.ALTAR:
		_item.identifyItem(false, true, false)
		if _item.alignment.matchn("blessed"):
			_dropLog.append("The {item} flashes with a white light.".format({ "item": _item.itemName }))
		elif _item.alignment.matchn("cursed"):
			_dropLog.append("The {item} flashes with a black light.".format({ "item": _item.itemName }))
	var _dropLogString = PoolStringArray(_dropLog).join(" ")
	return _dropLogString



####################################
### Player stat update functions ###
####################################

func processPlayerSpecificEffects():
	############
	## Hunger ##
	############
	previousCalories = calories
	if checkIfStatusEffectIsInEffect("hunger"):
		calories -= 3
	elif checkIfStatusEffectIsInEffect("slow digestion"):
		calories -= 1
	else:
		calories -= 2
	
	# Check if player becomes less hungry
	if previousCalories <= 400 and calories > 400:
		Globals.gameConsole.addLog("You are no longer hungry.")
	elif previousCalories <= 200 and calories > 200 and calories < 400:
		Globals.gameConsole.addLog("You only feel hungry.")
	elif previousCalories <= 100 and calories > 100 and calories < 200:
		Globals.gameConsole.addLog("You are still very hungry.")
	
	# Check if player becomes more hungry
	if previousCalories >= 400 and calories < 400 and calories > 200:
		Globals.gameConsole.addLog("You are beginning to feel hungry.")
	elif previousCalories >= 200 and calories < 200 and calories > 100:
		Globals.gameConsole.addLog("You feel very hungry.")
	elif previousCalories >= 100 and calories < 100 and calories > 0:
		Globals.gameConsole.addLog("You are starving!")
	elif calories <= 0:
		Globals.gameConsole.addLog("You die...")
	
	############
	## Weight ##
	############
	calculateWeightStats()
	
	####################
	## Status effects ##
	####################
	if checkIfStatusEffectIsInEffect("blindness"):
		playerVisibility = 0
	elif !checkIfLightSourceIsTurnedOn():
		playerVisibility = -1
	
	# Deal with status effects in the UI
	for _statusEffect in statusEffects.keys():
		if (statusEffects[_statusEffect] > 0 or statusEffects[_statusEffect] == -1):
			if !$"/root/World/UI/UITheme/GameStats".isStatusEffectInGameStats(_statusEffect):
				$"/root/World/UI/UITheme/GameStats".addStatusEffect(_statusEffect)
		else:
			if $"/root/World/UI/UITheme/GameStats".isStatusEffectInGameStats(_statusEffect):
				$"/root/World/UI/UITheme/GameStats".removeStatusEffect(_statusEffect)
	
	###########
	## Tools ##
	###########
	for _item in itemsTurnedOn:
		match _item.identifiedItemName.to_lower():
			"candle":
				if _item.value.charges > 0:
					_item.value.charges -= 1
					if playerVisibility != 0:
						playerVisibility = _item.value.value
				else:
					if playerVisibility != 0:
						playerVisibility = -1
						Globals.gameConsole.addLog("Your candle has run out of wax.")
					_item.value.turnedOn = false
					itemsTurnedOn.erase(_item)
			"oil lamp":
				if _item.value.charges > 0:
					_item.value.charges -= 1
					if playerVisibility != 0:
						playerVisibility = _item.value.value
				else:
					if playerVisibility != 0:
						playerVisibility = -1
						Globals.gameConsole.addLog("Your lamp has run out of oil.")
					_item.value.turnedOn = false
					itemsTurnedOn.erase(_item)
			"magic lamp":
				if playerVisibility != 0:
					playerVisibility = _item.value.value

func calculateWeightStats():
	maxCarryWeight = {
		"overEncumbured": (stats.strength / 2) * 50,
		"burdened": (stats.strength / 2) * 70,
		"flattened": (stats.strength / 2) * 90
	}
	
	var _weight = $Inventory.currentWeight
	
	if _weight <= maxCarryWeight.overEncumbured:
		turnsUntilAction = 0
	elif _weight > maxCarryWeight.overEncumbured and _weight <= maxCarryWeight.burdened:
		turnsUntilAction = 1
	elif _weight > maxCarryWeight.burdened and _weight <= maxCarryWeight.flattened:
		turnsUntilAction = 2
	elif _weight > maxCarryWeight.flattened:
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
	else:
		attacks = [
			{
				"dmg": [1 + stats.strength / 6, 1 + stats.strength / 6],
				"bonusDmg": [],
				"armorPen": 0,
				"magicDmg": {
					"dmg": 0,
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
	
	maxhp += hpIncrease
	maxmp += mpIncrease
	if hp + hpIncrease >= maxhp:
		hp = maxhp
	else:
		hp += hpIncrease
	if mp + mpIncrease >= maxmp:
		mp = maxmp
	else:
		mp += mpIncrease
	stats.strength += strengthIncrease
	stats.legerity += legerityIncrease
	stats.balance += balanceIncrease
	stats.belief += beliefIncrease
	stats.visage += visageIncrease
	stats.wisdom += wisdomIncrease
	
	experienceNeededForPreviousLevelGainAmount = experienceNeededForLevelGainAmount
	experienceNeededForLevelGainAmount = experienceNeededForLevelGainAmount + (experienceNeededForLevelGainAmount / 2)
	
	Globals.gameConsole.addLog("You advance to level {level}!".format({ "level": level }))

func updatePlayerStats():
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
		alignment = alignment,
		ac = ac,
		attacks = attacks,
		currentHit = currentHit,
		hits = hits,
		dungeonLevel = Globals.currentDungeonLevelName,
		weight = $Inventory.currentWeight,
		weightBounds = carryWeightBounds,
		strength = stats.strength,
		legerity = stats.legerity,
		balance = stats.balance,
		belief = stats.belief,
		visage = stats.visage,
		wisdom = stats.wisdom
	})



########################
### Helper functions ###
########################

func checkIfThereIsSomethingOnTheGroundHere(_level, _tile):
	if _level.grid[_tile.x][_tile.y].items.size() > 10:
		Globals.gameConsole.addLog("There are alot of items here.")
	elif _level.grid[_tile.x][_tile.y].items.size() > 1:
		Globals.gameConsole.addLog("You see some items here.")
	elif !_level.grid[_tile.x][_tile.y].items.empty():
		Globals.gameConsole.addLog("You see {item}.".format({ "item": get_node("/root/World/Items/{item}".format({ "item": _level.grid[_tile.x][_tile.y].items.back() })).itemName }))
	
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.ALTAR:
		Globals.gameConsole.addLog("You see an altar here.")
		
	if _level.grid[_tile.x][_tile.y].interactable == Globals.interactables.HIDDEN_ITEM:
		Globals.gameConsole.addLog("There's something hidden in the ground here.")

func checkAllItemsIdentification():
	for _item in $"/root/World/Items".get_children():
		if _item.name == "Items":
			continue
		_item.checkItemIdentification()

func checkIfLightSourceIsTurnedOn():
	for _item in itemsTurnedOn:
		if (
			_item.identifiedItemName.to_lower() == "candle" or
			_item.identifiedItemName.to_lower() == "oil lamp"
		):
			return true
	return false
