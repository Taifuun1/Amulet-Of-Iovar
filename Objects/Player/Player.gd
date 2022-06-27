extends BaseCritter

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
	ac = $"/root/World/UI/Equipment".getArmorClass()
	currentHit = 0
	hits = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
	
	abilities = []
	resistances = []
	
	updatePlayerStats()
	
	calories = 1000
	previousCalories = calories
	
	$PlayerSprite.texture = load("res://Assets/Classes/Mercenary.png")

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
			checkIfItemsHere(_level, _tileToMoveTo)
		else:
			return false
	elif _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.DOOR_CLOSED:
		_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile = Globals.tiles.DOOR_OPEN
		_level.addPointToEnemyPathding(_tileToMoveTo, _level.grid)
	else:
		moveCritter(_playerTile, _tileToMoveTo, 0, _level)
		checkIfItemsHere(_level, _tileToMoveTo)

func checkIfItemsHere(_level, _tileToMoveTo):
	if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].items.size() > 10:
		Globals.gameConsole.addLog("There are alot of items here.")
	elif _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].items.size() > 1:
		Globals.gameConsole.addLog("You see some items here.")
	elif !_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].items.empty():
		Globals.gameConsole.addLog("You see {item}.".format({ "item": get_node("/root/World/Items/{item}".format({ "item": _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].items.back() })).itemName }))

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
			$Inventory.addToInventory(get_node("/root/World/Items/{id}".format({ "id": _item })).id)
			get_node("/root/World/Items/{id}".format({ "id": _item })).hide()
			return

func dropItems(_playerTile, _items, _grid):
	var itemsLog = []
	if _items.size() != 0:
		for _item in _items:
			dropItem(_playerTile, _item, _grid)
			itemsLog.append("You drop {item}.".format({ "item": get_node("/root/World/Items/{id}".format({ "id": _item })).itemName }))
	var itemsLogString = PoolStringArray(itemsLog).join(" ")
	Globals.gameConsole.addLog(itemsLogString)

func dropItem(_playerTile, _item, _grid):
	_grid[_playerTile.x][_playerTile.y].items.append(_item)
	$Inventory.dropFromInventory(_item)
	get_node("/root/World/Items/{id}".format({ "id": _item })).show()
	$"/root/World/UI/Equipment".checkIfWearingEquipment(_item)



####################
### Player stats ###
####################

func processPlayerSpecificEffects():
	calories -= 1
	if previousCalories <= 400 and calories > 400:
		Globals.gameConsole.addLog("You are no longer hungry.")
	elif previousCalories <= 200 and calories > 200 and calories < 400:
		Globals.gameConsole.addLog("You only feel hungry.")
	elif previousCalories <= 100 and calories > 100 and calories < 200:
		Globals.gameConsole.addLog("You are still very hungry.")
	
	if previousCalories >= 400 and calories < 400 and calories > 200:
		Globals.gameConsole.addLog("You are beginning to feel hungry.")
	elif previousCalories >= 200 and calories < 200 and calories > 100:
		Globals.gameConsole.addLog("You feel very hungry.")
	elif previousCalories >= 100 and calories < 100 and calories > 0:
		Globals.gameConsole.addLog("You are starving!")
	elif calories <= 0:
		Globals.gameConsole.addLog("You die...")
	previousCalories = calories
	
	if statusEffects["blindness"] > 0:
		playerVisibility = -1
	
	for _item in itemsTurnedOn:
		match _item.identifiedItemName.to_lower():
			"candle":
				if _item.value.charges > 0:
					_item.value.charges -= 1
				else:
					if playerVisibility != 0:
						playerVisibility = -1
					_item.value.turnedOn = false
					itemsTurnedOn.erase(_item)
					Globals.gameConsole.addLog("Your candle has run out of wax.")
			"oil lamp":
				if _item.value.charges > 0:
					_item.value.charges -= 1
				else:
					if playerVisibility != 0:
						playerVisibility = -1
					_item.value.turnedOn = false
					itemsTurnedOn.erase(_item)
					Globals.gameConsole.addLog("Your lamp has run out of oil.")
			_:
				Globals.gameConsole.addLog("Thats not something that can be turned on.")

func calculateEquipmentStats():
	# Armor class
	ac = $"/root/World/UI/Equipment".getArmorClass()
	
	attacks = []
	# Attacks
	if (
		$"/root/World/UI/Equipment".hands["lefthand"] != null and
		$"/root/World/UI/Equipment".hands["lefthand"] == $"/root/World/UI/Equipment".hands["righthand"]
	):
		attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/Equipment".hands["lefthand"] })).getAttacks(stats))
	elif (
		$"/root/World/UI/Equipment".hands["lefthand"] != null or
		$"/root/World/UI/Equipment".hands["righthand"] != null
	):
		if (
			$"/root/World/UI/Equipment".hands["lefthand"] != null and
			!get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/Equipment".hands["lefthand"] })).category.matchn("shield")
		):
			attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/Equipment".hands["lefthand"] })).getAttacks(stats))
		if (
			$"/root/World/UI/Equipment".hands["righthand"] != null and
			!get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/Equipment".hands["righthand"] })).category.matchn("shield")
		):
			attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/Equipment".hands["righthand"] })).getAttacks(stats))
	else:
		attacks = [
			{
				"dmg": [stats.strength * 1 / 6, 1 + stats.strength * 1 / 6],
				"enchantment": 0,
				"ap": 0,
				"bonusDmg": {
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
		strength = stats.strength,
		legerity = stats.legerity,
		balance = stats.balance,
		belief = stats.belief,
		visage = stats.visage,
		wisdom = stats.wisdom
	})



######################
### Player actions ###
######################

func readItem(_id):
	var _readItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _readItem.type.matchn("scroll"):
		Globals.gameConsole.addLog("You read a {itemName}.".format({ "itemName": _readItem.itemName }))
		if (
			GlobalItemInfo.globalItemInfo.has(_readItem.identifiedItemName) and
			GlobalItemInfo.globalItemInfo[_readItem.identifiedItemName].identified == false
		):
			GlobalItemInfo.globalItemInfo[_readItem.identifiedItemName].identified = true
			Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _readItem.identifiedItemName, "unidentifiedItemName": _readItem.unidentifiedItemName }))
		match _readItem.identifiedItemName.to_lower():
			"blank scroll":
				Globals.gameConsole.addLog("Its a blank scroll. Wow.")
			"official mail":
				Globals.gameConsole.addLog("Its a grocery list of milk, eggs and carrots. Riveting.")
				Globals.gameConsole.addLog("The mail disappears!")
			"scroll of identify":
				var _items = $"/root/World/Critters/0/Inventory".inventory.duplicate(true)
				if _items.empty():
					Globals.gameConsole.addLog("You hear strange whispers in your head. LLLLLL......")
				else:
					var _identifiableItemsInInventory = false
					if !_readItem.alignment.matchn("cursed"):
						if _readItem.alignment.matchn("blessed"):
							for _item in _items:
								var _itemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									GlobalItemInfo.globalItemInfo.has(_itemInInventory.identifiedItemName) and
									GlobalItemInfo.globalItemInfo[_itemInInventory.identifiedItemName].identified == false
								):
									_identifiableItemsInInventory = true
									GlobalItemInfo.globalItemInfo[_itemInInventory.identifiedItemName].identified = true
									_itemInInventory.notIdentified.alignment = true
									_itemInInventory.notIdentified.enchantment = true
									Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _itemInInventory.identifiedItemName, "unidentifiedItemName": _itemInInventory.unidentifiedItemName }))
						else:
							while true:
								if _items.empty():
									break
								var _item = _items[randi() % _items.size()]
								var _randomItemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									GlobalItemInfo.globalItemInfo.has(_randomItemInInventory.identifiedItemName) and
									GlobalItemInfo.globalItemInfo[_randomItemInInventory.identifiedItemName].identified == false
								):
									GlobalItemInfo.globalItemInfo[_randomItemInInventory.identifiedItemName].identified = true
									_randomItemInInventory.notIdentified.alignment = true
									_randomItemInInventory.notIdentified.enchantment = true
									Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _randomItemInInventory.identifiedItemName, "unidentifiedItemName": _randomItemInInventory.unidentifiedItemName }))
									_identifiableItemsInInventory = true
									break
								_items.erase(_item)
					if !_identifiableItemsInInventory:
						_items = $"/root/World/Critters/0/Inventory".inventory.duplicate(true)
						if _readItem.alignment.matchn("blessed"):
							for _item in _items:
								var _itemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									_itemInInventory.notIdentified.alignment or
									_itemInInventory.notIdentified.enchantment
								):
									_itemInInventory.notIdentified.alignment = true
									_itemInInventory.notIdentified.enchantment = true
									Globals.gameConsole.addLog("You know more about {itemName}.".format({ "itemName": _itemInInventory.itemName }))
						else:
							while true:
								if _items.empty():
									Globals.gameConsole.addLog("You hear strange whispers in your head. LLLLLL......")
									break
								var _item = _items[randi() % _items.size()]
								var _randomItemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									_randomItemInInventory.notIdentified.alignment or
									_randomItemInInventory.notIdentified.enchantment
								):
									_randomItemInInventory.notIdentified.alignment = true
									_randomItemInInventory.notIdentified.enchantment = true
									Globals.gameConsole.addLog("You know more about {itemName}.".format({ "itemName": _randomItemInInventory.itemName }))
									break
								_items.erase(_item)
			"scroll of create food":
				var _playerPosition = $"/root/World".level.getCritterTile(0)
				if _readItem.alignment.matchn("blessed"):
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition)
					if !_tiles.empty():
						for _tile in _tiles:
							var newItem = load("res://Objects/Item/Item.tscn").instance()
							var _rarity = $"/root/World/Items/Items".items["comestible"].keys()[randi() % $"/root/World/Items/Items".items["comestible"].keys().size() - 1]
							var _item = $"/root/World/Items/Items".items["comestible"][_rarity][randi() % $"/root/World/Items/Items".items["comestible"][_rarity].size()]
							newItem.createItem(_item)
							$"/root/World/Items".add_child(newItem, true)
							$"/root/World".level.grid[_tile.x][_tile.y].items.append(newItem.id)
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["comestible"].keys()[randi() % $"/root/World/Items/Items".items["comestible"].keys().size() - 1]
					var _item = $"/root/World/Items/Items".items["comestible"][_rarity][randi() % $"/root/World/Items/Items".items["comestible"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("A bucketload of items appears around you!")
				elif _readItem.alignment.matchn("uncursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["comestible"].keys()[randi() % $"/root/World/Items/Items".items["comestible"].keys().size() - 1]
					var _item = $"/root/World/Items/Items".items["comestible"][_rarity][randi() % $"/root/World/Items/Items".items["comestible"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("A {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.alignment.matchn("cursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					newItem.createItem($"/root/World/Items/Items".getItemByName("orange"))
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("An {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
			"scroll of create potion":
				var _playerPosition = $"/root/World".level.getCritterTile(0)
				if _readItem.alignment.matchn("blessed"):
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition)
					if !_tiles.empty():
						for _tile in _tiles:
							var newItem = load("res://Objects/Item/Item.tscn").instance()
							var _rarity = $"/root/World/Items/Items".items["potion"].keys()[randi() % $"/root/World/Items/Items".items["potion"].keys().size() - 1]
							var _item = $"/root/World/Items/Items".items["potion"][_rarity][randi() % $"/root/World/Items/Items".items["potion"][_rarity].size()]
							newItem.createItem(_item)
							$"/root/World/Items".add_child(newItem, true)
							$"/root/World".level.grid[_tile.x][_tile.y].items.append(newItem.id)
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["potion"].keys()[randi() % $"/root/World/Items/Items".items["potion"].keys().size() - 1]
					var _item = $"/root/World/Items/Items".items["potion"][_rarity][randi() % $"/root/World/Items/Items".items["potion"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("A bucketload of items appears around you!")
				elif _readItem.alignment.matchn("uncursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["potion"].keys()[randi() % $"/root/World/Items/Items".items["potion"].keys().size() - 1]
					var _item = $"/root/World/Items/Items".items["potion"][_rarity][randi() % $"/root/World/Items/Items".items["potion"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("A {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.alignment.matchn("cursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					newItem.createItem($"/root/World/Items/Items".getItemByName("potion of toxix"))
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("An {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
			"scroll of summon critter":
				var _playerPosition = $"/root/World".level.getCritterTile(0)
				if _readItem.alignment.matchn("blessed"):
					var _critter = neutralCritters[randi() % neutralCritters.size()]
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
					if !_tiles.empty():
						for _tile in _tiles:
							Globals.gameConsole.addLog("A {critterName} appears beside you. It seems friendly.".format({ "critterName": $"/root/World/Critters/Critters".spawnCritter(_critter, _tile) }))
					else:
						Globals.gameConsole.addLog("Nothing happens...")
				elif _readItem.alignment.matchn("uncursed"):
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
					if !_tiles.empty():
						for _tile in _tiles:
							Globals.gameConsole.addLog("A {critterName} appears beside you!".format({ "critterName": $"/root/World/Critters/Critters".spawnRandomCritter(_tile) }))
					else:
						Globals.gameConsole.addLog("Nothing happens...")
				elif _readItem.alignment.matchn("cursed"):
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, false, true)
					if !_tiles.empty():
						for _tile in _tiles:
							$"/root/World/Critters/Critters".spawnRandomCritter(_tile)
						Globals.gameConsole.addLog("A bucketload of critters appear around you!")
					else:
						Globals.gameConsole.addLog("Nothing happens...")
			"scroll of genocide":
				var _aliveCritters = []
				for _critterName in GlobalCritterInfo.globalCritterInfo.keys():
					if GlobalCritterInfo.globalCritterInfo[_critterName].population != 0:
						_aliveCritters.append(_critterName)
				$"/root/World/UI/ListMenu".showListMenuList("Genocide what?", _aliveCritters)
				$"/root/World/UI/ListMenu".show()
				_additionalChoices = true
			_:
				Globals.gameConsole.addLog("Thats not a scroll...")
		checkAllItemsIdentification()
		if !_readItem.identifiedItemName.to_lower().matchn("blank scroll"):
			$"/root/World/Critters/0/Inventory".inventory.erase(_id)
			get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
	$"/root/World".closeMenu(_additionalChoices)

func dealWithScrollOfGenocide(_critterName):
	for _critter in $"/root/World/Critters".get_children():
		if _critter.name == "Critters":
			continue
		if _critter.critterName == _critterName:
			_critter.despawn(null, false)
	GlobalCritterInfo.globalCritterInfo[_critterName].crittersInPlay = 0
	GlobalCritterInfo.globalCritterInfo[_critterName].population = 0
	Globals.gameConsole.addLog("{critter} has been wiped out.".format({ "critter": _critterName.capitalize() }))
	$"/root/World".closeMenu()

func quaffItem(_id):
	var _quaffedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _quaffedItem.type.matchn("potion"):
		Globals.gameConsole.addLog("You quaff a {itemName}.".format({ "itemName": _quaffedItem.itemName }))
		if (
			GlobalItemInfo.globalItemInfo.has(_quaffedItem.identifiedItemName) and
			GlobalItemInfo.globalItemInfo[_quaffedItem.identifiedItemName].identified == false
		):
			GlobalItemInfo.globalItemInfo[_quaffedItem.identifiedItemName].identified = true
			Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _quaffedItem.identifiedItemName, "unidentifiedItemName": _quaffedItem.unidentifiedItemName }))
		match _quaffedItem.identifiedItemName.to_lower():
			"water potion":
				if _quaffedItem.alignment.matchn("blessed"):
					Globals.gameConsole.addLog("This tastes fantastic!")
				if _quaffedItem.alignment.matchn("uncursed"):
					Globals.gameConsole.addLog("This tastes like water.")
				if _quaffedItem.alignment.matchn("cursed"):
					Globals.gameConsole.addLog("This doesn't taste very good. Ughhhh...")
			"soda bottle":
				if _quaffedItem.alignment.matchn("blessed"):
					Globals.gameConsole.addLog("Its orange juice! Its really good!")
				if _quaffedItem.alignment.matchn("uncursed"):
					Globals.gameConsole.addLog("Its apple juice. Tastes nice!")
				if _quaffedItem.alignment.matchn("cursed"):
					Globals.gameConsole.addLog("Its radish juice. Uggghh...")
			"potion of heal":
				var _amountToHeal = 0
				if _quaffedItem.alignment.matchn("blessed"):
					_amountToHeal = 6 + (level * 4)
					Globals.gameConsole.addLog("The {potion} heals you. That felt good!".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("uncursed"):
					_amountToHeal = 4 + (level * 3)
					Globals.gameConsole.addLog("The {potion} heals you.".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("cursed"):
					_amountToHeal = 2 + (level * 2)
					Globals.gameConsole.addLog("The {potion} heals you. That felt a little off.".format({ "potion": _quaffedItem.itemName }))
				if hp + _amountToHeal >= maxhp:
					if _quaffedItem.alignment.matchn("blessed"):
						maxhp = maxhp + 1
						Globals.gameConsole.addLog("You feel a little more vigorous.")
					hp = maxhp
				else:
					hp += _amountToHeal
			"potion of healaga":
				var _amountToHeal = 0
				if _quaffedItem.alignment.matchn("blessed"):
					_amountToHeal = 14 + (level * 8)
					Globals.gameConsole.addLog("The {potion} heals you alot. That felt good!".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("uncursed"):
					_amountToHeal = 9 + (level * 6)
					Globals.gameConsole.addLog("The {potion} heals you alot.".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("cursed"):
					_amountToHeal = 4 + (level * 4)
					Globals.gameConsole.addLog("The {potion} heals you alot. That felt a little off.".format({ "potion": _quaffedItem.itemName }))
				if hp + _amountToHeal >= maxhp:
					if _quaffedItem.alignment.matchn("blessed"):
						maxhp = maxhp + 2
						Globals.gameConsole.addLog("You feel a little more vigorous.")
					hp = maxhp
				else:
					hp += _amountToHeal
			"potion of gain level":
				if _quaffedItem.alignment.matchn("blessed"):
					addExp(experienceNeededForLevelGainAmount)
					Globals.gameConsole.addLog("You gain a level! You feel like you gained extra experience.")
				if _quaffedItem.alignment.matchn("uncursed"):
					addExp(experienceNeededForLevelGainAmount - experiencePoints)
					Globals.gameConsole.addLog("You gain a level!")
				if _quaffedItem.alignment.matchn("cursed"):
					addExp(experienceNeededForPreviousLevelGainAmount - experiencePoints)
					Globals.gameConsole.addLog("You somehow feel less experienced.")
			"potion of hunger":
				if _quaffedItem.alignment.matchn("blessed"):
					calories += 100
					Globals.gameConsole.addLog("You feel nourished.")
				if _quaffedItem.alignment.matchn("uncursed"):
					calories += -100
					Globals.gameConsole.addLog("You feel malnourished.")
				if _quaffedItem.alignment.matchn("cursed"):
					calories += -250
					Globals.gameConsole.addLog("You feel like you lost half your weight!")
			_:
				Globals.gameConsole.addLog("Thats not a potion...")
		checkAllItemsIdentification()
		$"/root/World/Critters/0/Inventory".inventory.erase(_id)
		get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
	$"/root/World".closeMenu(_additionalChoices)

func consumeItem(_id):
	var _eatenItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	if _eatenItem.type.matchn("comestible"):
		calories += _eatenItem.value
		checkAllItemsIdentification()
		$"/root/World/Critters/0/Inventory".inventory.erase(_id)
		get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
		Globals.gameConsole.addLog("You eat the {comestible}.".format({ "comestible": _eatenItem.itemName }))
	$"/root/World".closeMenu()

func zapItem(_id):
	var _zappedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _zappedItem.type.matchn("wand"):
		Globals.gameConsole.addLog("You zap the {itemName}.".format({ "itemName": _zappedItem.itemName }))
		if (
			GlobalItemInfo.globalItemInfo.has(_zappedItem.identifiedItemName) and
			GlobalItemInfo.globalItemInfo[_zappedItem.identifiedItemName].identified == false
		):
			GlobalItemInfo.globalItemInfo[_zappedItem.identifiedItemName].identified = true
			Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _zappedItem.identifiedItemName, "unidentifiedItemName": _zappedItem.unidentifiedItemName }))
		if !_zappedItem.value == 0:
			match _zappedItem.identifiedItemName.to_lower():
				"wand of summon critter":
					var _playerPosition = $"/root/World".level.getCritterTile(0)
					if _zappedItem.alignment.matchn("blessed"):
						var _critter = neutralCritters[randi() % neutralCritters.size()]
						var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
						if !_tiles.empty():
							for _tile in _tiles:
								Globals.gameConsole.addLog("A {critterName} appears beside you. It seems friendly.".format({ "critterName": $"/root/World/Critters/Critters".spawnCritter(_critter, _tile) }))
						else:
							Globals.gameConsole.addLog("Nothing happens...")
					elif _zappedItem.alignment.matchn("uncursed"):
						var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
						if !_tiles.empty():
							for _tile in _tiles:
								Globals.gameConsole.addLog("A {critterName} appears beside you!".format({ "critterName": $"/root/World/Critters/Critters".spawnRandomCritter(_tile) }))
						else:
							Globals.gameConsole.addLog("Nothing happens...")
					elif _zappedItem.alignment.matchn("cursed"):
						var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, false, true)
						if !_tiles.empty():
							for _tile in _tiles:
								$"/root/World/Critters/Critters".spawnRandomCritter(_tile)
							Globals.gameConsole.addLog("A bucketload of critters appear around you!")
						else:
							Globals.gameConsole.addLog("Nothing happens...")
				_:
					Globals.gameConsole.addLog("Thats not a wand...")
			_zappedItem.value -= 1
			checkAllItemsIdentification()
		else:
			Globals.gameConsole.addLog("The wand seems a little flaccid. There's no charges left.")
	$"/root/World".closeMenu()

func useItem(_id):
	var _usedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _usedItem.type.matchn("tool"):
		if (
			GlobalItemInfo.globalItemInfo.has(_usedItem.identifiedItemName) and
			GlobalItemInfo.globalItemInfo[_usedItem.identifiedItemName].identified == false
		):
			GlobalItemInfo.globalItemInfo[_usedItem.identifiedItemName].identified = true
			Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _usedItem.identifiedItemName, "unidentifiedItemName": _usedItem.unidentifiedItemName }))
		match _usedItem.identifiedItemName.to_lower():
			"candle":
				if playerVisibility < 1:
					if _usedItem.value.charges > 0:
						if _usedItem.value.turnedOn:
							if playerVisibility != 0:
								playerVisibility = -1
							_usedItem.value.turnedOn = false
							itemsTurnedOn.erase(_usedItem)
							Globals.gameConsole.addLog("You turn off the {itemName}.".format({ "itemName": _usedItem.itemName }))
						else:
							if playerVisibility != 0:
								playerVisibility = _usedItem.value.value
							_usedItem.value.turnedOn = true
							itemsTurnedOn.append(_usedItem)
							Globals.gameConsole.addLog("You turn on the {itemName}.".format({ "itemName": _usedItem.itemName }))
					else:
						Globals.gameConsole.addLog("Your candle is spent.")
				else:
					Globals.gameConsole.addLog("You already have a lightsource on.")
			"oil lamp":
				if playerVisibility < 1:
					if _usedItem.value.charges > 0:
						if _usedItem.value.turnedOn:
							if playerVisibility != 0:
								playerVisibility = -1
							_usedItem.value.turnedOn = false
							itemsTurnedOn.erase(_usedItem)
							Globals.gameConsole.addLog("You turn off the {itemName}.".format({ "itemName": _usedItem.itemName }))
						else:
							if playerVisibility != 0:
								playerVisibility = _usedItem.value.value
							_usedItem.value.turnedOn = true
							itemsTurnedOn.append(_usedItem)
							Globals.gameConsole.addLog("You turn on the {itemName}.".format({ "itemName": _usedItem.itemName }))
					else:
						Globals.gameConsole.addLog("Your lamp is spent.")
				else:
					Globals.gameConsole.addLog("You already have a lightsource on.")
			"magic lamp":
				if playerVisibility < 1:
					if _usedItem.value.charges > 0:
						if _usedItem.value.turnedOn:
							if playerVisibility != 0:
								playerVisibility = _usedItem.value.value
							_usedItem.value.turnedOn = false
							itemsTurnedOn.erase(_usedItem)
							Globals.gameConsole.addLog("You turn off the {itemName}.".format({ "itemName": _usedItem.itemName }))
						else:
							if playerVisibility != 0:
								playerVisibility = -1
							_usedItem.value.turnedOn = true
							itemsTurnedOn.append(_usedItem)
							Globals.gameConsole.addLog("You turn on the {itemName}.".format({ "itemName": _usedItem.itemName }))
					else:
						Globals.gameConsole.addLog("Your lamp is spent.")
				else:
					Globals.gameConsole.addLog("You already have a lightsource on.")
			_:
				Globals.gameConsole.addLog("Thats not a tool...")
		checkAllItemsIdentification()
	$"/root/World".closeMenu()



########################
### Helper functions ###
########################

func checkAllItemsIdentification():
	for _item in $"/root/World/Items".get_children():
		if _item.name == "Items":
			continue
		_item.checkItemIdentification()
