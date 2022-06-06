extends BaseCritter

var strengthIncrease = 0
var legerityIncrease = 0
var balanceIncrease = 0
var beliefIncrease = 0
var visageIncrease = 0
var wisdomIncrease = 0

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

func create(_class):
	id = 0
	name = str(0)
	
	add_child(inventory)
	$Inventory.create()
	
	var _playerClass = load("res://Objects/Player/PlayableClasses.gd").new()[_class]
	
	critterName = "Player"
	race = "Human"
	alignment = "Neutral"
	
	strength = _playerClass.strength
	legerity = _playerClass.legerity
	balance = _playerClass.balance
	belief = _playerClass.belief
	visage = _playerClass.visage
	wisdom = _playerClass.wisdom
	
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
	ac = $"/root/World/UI/Equipment".getArmorClass()
	currentHit = 0
	hits = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
	
	abilities = []
	resistances = []
	
	updatePlayerStats(_playerClass.hp, _playerClass.mp, 1)
	
	$PlayerSprite.texture = load("res://Assets/Classes/Mercenary.png")

func processPlayerAction(_playerTile, _tileToMoveTo, _items, _level):
	if(_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].critter != null):
		var _critter = get_node("/root/World/Critters/{critter}".format({ "critter": _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].critter }))
		if _critter.aI.aI == "Aggressive":
			if hits[currentHit] == 1:
				if $"/root/World/UI/Equipment".hands["lefthand"] != null or $"/root/World/UI/Equipment".hands["righthand"] != null:
					var _attacks = []
					if $"/root/World/UI/Equipment".hands["lefthand"] != null and $"/root/World/UI/Equipment".hands["lefthand"] == $"/root/World/UI/Equipment".hands["righthand"] != null:
						_attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/Equipment".hands["lefthand"] })).getAttacks())
					else:
						if $"/root/World/UI/Equipment".hands["lefthand"] != null:
							_attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/Equipment".hands["lefthand"] })).getAttacks())
						if $"/root/World/UI/Equipment".hands["righthand"] != null:
							_attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/Equipment".hands["righthand"] })).getAttacks())
					_critter.takeDamage(_attacks, _tileToMoveTo, _items, _level)
				else:
					_critter.takeDamage([strength * 1 / 2], _tileToMoveTo, _items, _level)
			else:
				Globals.gameConsole.addLog("You miss!")
			if currentHit == 15:
				currentHit = 0
			currentHit += 1
		elif _critter.aI.aI == "Neutral":
			_level.grid[_playerTile.x][_playerTile.y].critter = _critter.id
			_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].critter = 0
			Globals.gameConsole.addLog("You switch places with the {critter}.".format({ "critter": _critter.critterName }))
		else:
			return false
	else:
		moveCritter(_playerTile, _tileToMoveTo, 0, _level)
		if _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].items.size() > 10:
			Globals.gameConsole.addLog("There are alot of items here.")
		elif _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].items.size() > 1:
			Globals.gameConsole.addLog("You see some items here.")
		elif !_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].items.empty():
			Globals.gameConsole.addLog("You see {item}.".format({ "item": get_node("/root/World/Items/{item}".format({ "item": _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].items.back() })).itemName }))

func updatePlayerStats(maxhp = null, maxmp = null, dungeonLevel = null):
	Globals.gameStats.updateStats({
		maxhp = maxhp,
		hp = hp,
		maxmp = maxmp,
		mp = mp,
		level = level,
		critterName = critterName,
		race = race,
		alignment = alignment,
		ac = ac,
		attacks = attacks,
		currentHit = currentHit,
		hits = hits,
		dungeonLevel = dungeonLevel
	})

func calculateEquipment():
	# Armor class
	ac = $"/root/World/UI/Equipment".getArmorClass()
	
#	# Melee damage and hits
#	if $"/root/World/UI/Equipment".hands["lefthand"] == null and $"/root/World/UI/Equipment".hands["righthand"] == null:
#		attacks = [ strength * 1 / 3 ]
#		return
#	elif (
#		$"/root/World/UI/Equipment".hands["lefthand"] != null and
#		$"/root/World/UI/Equipment".hands["lefthand"] == $"/root/World/UI/Equipment".hands["righthand"]
#	):
#		attacks = [ ( strength * 1 / 3 ) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).getTotalUseValue()]
#		return
#	else:
#		attacks.clear()
#		attacks["melee"] = strength * 1 / 3
#		var left = get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] }))
#		var right = get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["righthand"] }))
#		match left.category:
#			"Sword":
#				attacks["sword"] = .getTotalUseValue()
#			"Two-handed sword":
#				attacks["sword"] = (strength * 1 / 3) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).getTotalUseValue()
#			"Dagger":
#				attacks["sword"] = (strength * 1 / 3) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).getTotalUseValue()
#			"Mace":
#				attacks["sword"] = (strength * 1 / 3) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).getTotalUseValue()
#			"Flail":
#				attacks["sword"] = (strength * 1 / 3) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).getTotalUseValue()
#		if (
#			$"/root/World/UI/Equipment".hands["lefthand"] != null and
#			get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).type == "Weapon"
#		):
#			attacks.append(( strength * 1 / 3 ) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).getTotalUseValue())
#			if(get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).category == "Dagger"):
#				attacks.append(( strength * 1 / 3 ) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).getTotalUseValue())
#			elif(get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).category == "Flail"):
#				attacks.append(( strength * 1 / 3 ) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).getTotalUseValue())
#				attacks.append(( strength * 1 / 3 ) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["lefthand"] })).getTotalUseValue())
#		if (
#			$"/root/World/UI/Equipment".hands["righthand"] != null and
#			get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["righthand"] })).type == "Weapon"
#		):
#			attacks.append(( strength * 1 / 3 ) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["righthand"] })).getTotalUseValue())
#			if(get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["righthand"] })).category == "Dagger"):
#				attacks.append(( strength * 1 / 3 ) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["righthand"] })).getTotalUseValue())
#			elif(get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["righthand"] })).category == "Flail"):
#				attacks.append(( strength * 1 / 3 ) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["righthand"] })).getTotalUseValue())
#				attacks.append(( strength * 1 / 3 ) + get_node("/root/World/Items/{item}".format({ "item": $"/root/World/UI/Equipment".hands["righthand"] })).getTotalUseValue())
#		if attacks.empty():
#			attacks.append(1)

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

func readItem(_id):
	var _readItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	if _readItem.type.matchn("scroll"):
		Globals.gameConsole.addLog("You read a {itemName}.".format({ "itemName": _readItem.itemName }))
		match _readItem.identifiedItemName.to_lower():
			"scroll of identify":
				if (
					GlobalItemInfo.globalItemInfo.has(_readItem.identifiedItemName) and
					GlobalItemInfo.globalItemInfo[_readItem.identifiedItemName].identified == false
				):
					GlobalItemInfo.globalItemInfo[_readItem.identifiedItemName].identified = true
					Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _readItem.identifiedItemName, "unidentifiedItemName": _readItem.unidentifiedItemName }))
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
					for _item in $"/root/World/Items".get_children():
						if _item.name == "Items":
							continue
						_item.checkItemIdentification()
				$"/root/World/Critters/0/Inventory".inventory.erase(_id)
				get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
			_:
				Globals.gameConsole.addLog("Thats not a scroll...")
	$"/root/World".closeMenu()
