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
	basehp = _playerClass.hp
	basemp = _playerClass.mp
	maxhp = _playerClass.hp
	maxmp = _playerClass.mp
	ac = $"/root/World/UI/Equipment".getArmorClass()
	currentHit = 0
	hits = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
	
	abilities = []
	resistances = []
	
	updatePlayerStats(1)
	
	$PlayerSprite.texture = load("res://Assets/Classes/Mercenary.png")

func processPlayerAction(_playerTile, _tileToMoveTo, _items, _level):
	if(_level.grid[_tileToMoveTo.x][_tileToMoveTo.y].critter != null):
		var _critter = get_node("/root/World/Critters/{critter}".format({ "critter": _level.grid[_tileToMoveTo.x][_tileToMoveTo.y].critter }))
		if _critter.aI.aI == "Aggressive":
			if hits[currentHit] == 1:
				_critter.takeDamage(attacks, _tileToMoveTo, _items, _level)
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

func updatePlayerStats(dungeonLevel = null):
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
		dungeonLevel = dungeonLevel,
		strength = strength,
		legerity = legerity,
		balance = balance,
		belief = belief,
		visage = visage,
		wisdom = wisdom
	})

func calculateEquipmentStats():
	# Armor class
	ac = $"/root/World/UI/Equipment".getArmorClass()
	
	attacks = []
	# Attacks
	if $"/root/World/UI/Equipment".hands["lefthand"] != null and $"/root/World/UI/Equipment".hands["lefthand"] == $"/root/World/UI/Equipment".hands["righthand"]:
		attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/Equipment".hands["lefthand"] })).getAttacks())
	elif $"/root/World/UI/Equipment".hands["lefthand"] != null or $"/root/World/UI/Equipment".hands["righthand"] != null:
		if $"/root/World/UI/Equipment".hands["lefthand"] != null:
			attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/Equipment".hands["lefthand"] })).getAttacks())
		if $"/root/World/UI/Equipment".hands["righthand"] != null:
			attacks.append_array(get_node("/root/World/Items/{id}".format({ "id": $"/root/World/UI/Equipment".hands["righthand"] })).getAttacks())
	else:
		attacks = [
			{
				"dmg": [1 + (strength * 1 / 4), 3 + (strength * 1 / 4)],
				"enchantment": 0,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			}
		]

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
	$"/root/World".processGameTurn()

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
		if (
			GlobalItemInfo.globalItemInfo.has(_readItem.identifiedItemName) and
			GlobalItemInfo.globalItemInfo[_readItem.identifiedItemName].identified == false
		):
			GlobalItemInfo.globalItemInfo[_readItem.identifiedItemName].identified = true
			Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _readItem.identifiedItemName, "unidentifiedItemName": _readItem.unidentifiedItemName }))
		match _readItem.identifiedItemName.to_lower():
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
				var _playerPosition = $"/root/World".getCritterTile(0)
				if _readItem.alignment.matchn("cursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					newItem.createItem($"/root/World/Items/Items".getItemByName("orange"))
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("An {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.alignment.matchn("uncursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["comestible"].keys()[randi() % $"/root/World/Items/Items".items["comestible"].keys().size() - 1]
					var _item = $"/root/World/Items/Items".items["comestible"][_rarity][randi() % $"/root/World/Items/Items".items["comestible"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("A {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.alignment.matchn("blessed"):
					for _direction in PoolVector2Array([
						Vector2(-1, -1),
						Vector2(0, -1),
						Vector2(1, -1),
						Vector2(1, 0),
						Vector2(1, 1),
						Vector2(0, 1),
						Vector2(-1, 1),
						Vector2(-1, 0)
					]):
						if (
							$"/root/World".level.grid[_playerPosition.x + _direction.x][_playerPosition.y + _direction.y].tile != Globals.tiles.EMPTY and
							$"/root/World".level.grid[_playerPosition.x + _direction.x][_playerPosition.y + _direction.y].tile != Globals.tiles.WALL
						):
							print($"/root/World".level.grid[_playerPosition.x + _direction.x][_playerPosition.y + _direction.y])
							var newItem = load("res://Objects/Item/Item.tscn").instance()
							var _rarity = $"/root/World/Items/Items".items["comestible"].keys()[randi() % $"/root/World/Items/Items".items["comestible"].keys().size() - 1]
							var _item = $"/root/World/Items/Items".items["comestible"][_rarity][randi() % $"/root/World/Items/Items".items["comestible"][_rarity].size()]
							newItem.createItem(_item)
							$"/root/World/Items".add_child(newItem, true)
							$"/root/World".level.grid[_playerPosition.x + _direction.x][_playerPosition.y + _direction.y].items.append(newItem.id)
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["comestible"].keys()[randi() % $"/root/World/Items/Items".items["comestible"].keys().size() - 1]
					var _item = $"/root/World/Items/Items".items["comestible"][_rarity][randi() % $"/root/World/Items/Items".items["comestible"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("A bucketload of items appears around you!")
			"scroll of create potion":
				var _playerPosition = $"/root/World".getCritterTile(0)
				if _readItem.alignment.matchn("cursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					newItem.createItem($"/root/World/Items/Items".getItemByName("potion of toxix"))
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("An {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.alignment.matchn("uncursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["potion"].keys()[randi() % $"/root/World/Items/Items".items["potion"].keys().size() - 1]
					var _item = $"/root/World/Items/Items".items["potion"][_rarity][randi() % $"/root/World/Items/Items".items["potion"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("A {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.alignment.matchn("blessed"):
					for _direction in PoolVector2Array([
						Vector2(-1, -1),
						Vector2(0, -1),
						Vector2(1, -1),
						Vector2(1, 0),
						Vector2(1, 1),
						Vector2(0, 1),
						Vector2(-1, 1),
						Vector2(-1, 0)
					]):
						if (
							$"/root/World".level.grid[_playerPosition.x + _direction.x][_playerPosition.y + _direction.y].tile != Globals.tiles.EMPTY and
							$"/root/World".level.grid[_playerPosition.x + _direction.x][_playerPosition.y + _direction.y].tile != Globals.tiles.WALL
						):
							var newItem = load("res://Objects/Item/Item.tscn").instance()
							var _rarity = $"/root/World/Items/Items".items["potion"].keys()[randi() % $"/root/World/Items/Items".items["potion"].keys().size() - 1]
							var _item = $"/root/World/Items/Items".items["potion"][_rarity][randi() % $"/root/World/Items/Items".items["potion"][_rarity].size()]
							newItem.createItem(_item)
							$"/root/World/Items".add_child(newItem, true)
							$"/root/World".level.grid[_playerPosition.x + _direction.x][_playerPosition.y + _direction.y].items.append(newItem.id)
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["potion"].keys()[randi() % $"/root/World/Items/Items".items["potion"].keys().size() - 1]
					var _item = $"/root/World/Items/Items".items["potion"][_rarity][randi() % $"/root/World/Items/Items".items["potion"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("A bucketload of items appears around you!")
			_:
				Globals.gameConsole.addLog("Thats not a scroll...")
		for _item in $"/root/World/Items".get_children():
			if _item.name == "Items":
				continue
			_item.checkItemIdentification()
		$"/root/World/Critters/0/Inventory".inventory.erase(_id)
		get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
	$"/root/World".closeMenu()
