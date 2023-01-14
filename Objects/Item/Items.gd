extends Node

onready var item = preload("res://Objects/Item/Item.tscn")

var amulets = preload("res://Objects/Item/Amulets/Amulets.gd").new()
var armor = preload("res://Objects/Item/Armor/Armor.gd").new()
var belt = preload("res://Objects/Item/Belts/Belts.gd").new()
var cloak = preload("res://Objects/Item/Cloaks/Cloaks.gd").new()
var gauntlets = preload("res://Objects/Item/Gauntlets/Gauntlets.gd").new()
var comestibles = preload("res://Objects/Item/Comestibles/Comestibles.gd").new()
var gems = preload("res://Objects/Item/Gems/Gems.gd").new()
var potions = preload("res://Objects/Item/Potions/Potions.gd").new()
var rings = preload("res://Objects/Item/Rings/Rings.gd").new()
var runes = preload("res://Objects/Item/Runes/Runes.gd").new()
var scrolls = preload("res://Objects/Item/Scrolls/Scrolls.gd").new()
var tools = preload("res://Objects/Item/Tools/Tools.gd").new()
var wands = preload("res://Objects/Item/Wands/Wands.gd").new()
var weapons = preload("res://Objects/Item/Weapons/Weapons.gd").new()

var miscellaneous = preload("res://Objects/Item/Miscellaneous/Miscellaneous.gd").new()

var randomItemList = preload("res://Objects/Item/RandomItemList.gd").new()
var itemGeneration = preload("res://Objects/Item/ItemGeneration.gd").new()

var mutex

var items = {}
var miscellaneousItems = []

var randomizedItemsByRarity = []

func create():
	mutex = Mutex.new()
	name = "Items"
	
	items["amulet"] = amulets.amulets
	items["armor"] = armor.armor
	items["belt"] = belt.belt
	items["cloak"] = cloak.cloak
	items["gauntlets"] = gauntlets.gauntlets
	items["comestible"] = comestibles.comestibles
	items["gem"] = gems.gems
	items["potion"] = potions.potions
	items["ring"] = rings.rings
	items["rune"] = runes.runes
	items["scroll"] = scrolls.scrolls
	items["tool"] = tools.tools
	items["wand"] = wands.wands
	items["weapon"] = weapons.weapons
	
	for _type in items:
		for _rarity in items[_type]:
			for _index in items[_type][_rarity].size():
				items[_type][_rarity][_index].rarity = _rarity
	
	miscellaneousItems = miscellaneous.miscellaneous
	
	randomizeItemsByRarity()

func loadItems(_items):
	mutex = Mutex.new()
	name = "Items"
	
	for _type in _items.items:
		items[_type] = {  }
		for _rarity in _items.items[_type]:
			items[_type][_rarity] = []
			for _index in _items.items[_type][_rarity].size():
				items[_type][_rarity].append(_items.items[_type][_rarity][_index])
				items[_type][_rarity][_index].texture = load(items[_type][_rarity][_index].texture)
				items[_type][_rarity][_index].unidentifiedTexture = load(items[_type][_rarity][_index].unidentifiedTexture)
	
	miscellaneousItems = miscellaneous.miscellaneous
	
	randomizeItemsByRarity()



#######################
### Item generation ###
#######################

func createItem(_item, _position = null, _amount = 1, _toInventory = false, _extraData = {  }, _level = $"/root/World".level, _spawnNew = true):
	mutex.lock()
	
	var _id
	var _itemPosition
	if _position == null and !_toInventory:
		_itemPosition = _level.spawnableItemTiles[randi() % (_level.spawnableItemTiles.size())]
	else:
		_itemPosition = _position
	
	var newItem = item.instance()
	
	$"/root/World/Items".add_child(newItem, true)
	
	if typeof(_item) == TYPE_STRING:
		if _item.matchn("goldPieces"):
			_id = newItem.createItem(miscellaneousItems["goldPieces"], _extraData, _amount)
		elif _item.matchn("amulet of iovar"):
			_id = newItem.createItem(miscellaneousItems["Amulet of Iovar"], _extraData, 1)
		elif _item.matchn("corpse"):
			_id = newItem.createItem(miscellaneousItems["corpse"], _extraData, 1)
		elif _item.matchn("box"):
			_id = newItem.createItem(miscellaneousItems["box"], _extraData, 1)
		elif _item.matchn("chest"):
			_id = newItem.createItem(miscellaneousItems["chest"], _extraData, 1)
		else:
			_id = newItem.createItem(getItemByName(_item), _extraData)
	else:
		_id = newItem.createItem(_item, _extraData, _amount, _spawnNew)
	
	if _toInventory:
		$"/root/World/Critters/0".addToInventory([newItem.id])
	elif _level != null:
		_level.grid[_itemPosition.x][_itemPosition.y].items.append(newItem.id)
	
	mutex.unlock()
	
	return _id

func generateItemsForLevel(_level):
	if itemGeneration.itemGeneration.has(_level.dungeonType):
		var _itemGeneration = itemGeneration.itemGeneration[_level.dungeonType]
		var _items = []
		
		for _i in range(_itemGeneration.amount):
			var _item = returnRandomItemForItemGeneration(_itemGeneration)
			if _item != null:
				_items.append(_item)
		
		for _item in _items:
			if _item != null:
				var gridPosition = _level.spawnableItemTiles[randi() % (_level.spawnableItemTiles.size())]
				mutex.lock()
				var newItem = item.instance()
				newItem.createItem(_item)
				_level.grid[gridPosition.x][gridPosition.y].items.append(newItem.id)
				$"/root/World/Items".add_child(newItem, true)
				mutex.unlock()



############################
### Randomizer functions ###
############################

func getRandomItem(_randomByRarity = true):
	var _items = []
	if _randomByRarity:
		return randomizedItemsByRarity[randi() % randomizedItemsByRarity.size()]
	else:
		var _randomType = items.keys()[randi() % items.keys().size()]
		var _rarity = items[_randomType].keys()[randi() % items[_randomType].keys().size()]
		var _pick = randi() % items[_randomType][_rarity].size()
		return items[_randomType][_rarity][_pick]

func getRandomItemByItemTypes(_types, _randomByRarity = false):
	var _items = []
	if _randomByRarity:
		for _type in _types.keys():
			for _rarity in _types[_type]:
				for _item in items[_type][_rarity]:
					if _rarity == "common":
						for _i in range(75):
							_items.append(_item)
					elif _rarity == "uncommon":
						for _i in range(25):
							_items.append(_item)
					if _rarity == "rare":
						for _i in range(10):
							_items.append(_item)
					if _rarity == "legendary":
						for _i in range(1):
							_items.append(_item)
	else:
		for _type in _types.keys():
			for _rarity in _types[_type]:
				for _item in items[_type][_rarity]:
					_items.append(_item)
	return _items[randi() % _items.size()]

func returnRandomItemForItemGeneration(_itemGeneration):
	var type
	var rarity
	
	var randomType = []
	for _key in _itemGeneration["type"].keys():
		for _i in range(_itemGeneration["type"][_key]):
			randomType.append(_key)
	for _nmb in range(1000 - randomType.size()):
		randomType.append(null)
	
	var randomRarity = []
	for _key in _itemGeneration["rarity"].keys():
		for _i in range(_itemGeneration["rarity"][_key]):
			randomRarity.append(_key)
	for _nmb in range(1000 - randomRarity.size()):
		randomRarity.append(null)
	
	type = randomType[randi() % 1000]
	rarity = randomRarity[randi() % 1000]
	
	if type != null and items[type].has(rarity):
		return items[type][rarity][randi() % items[type][rarity].size()]
	else:
		return null

func randomizeItemsByRarity():
	for _type in items:
		for _rarity in items[_type]:
			for _item in items[_type][_rarity]:
				if _rarity == "common":
					for _i in range(75):
						randomizedItemsByRarity.append(_item)
				elif _rarity == "uncommon":
					for _i in range(25):
						randomizedItemsByRarity.append(_item)
				if _rarity == "rare":
					for _i in range(10):
						randomizedItemsByRarity.append(_item)
				if _rarity == "legendary":
					for _i in range(1):
						randomizedItemsByRarity.append(_item)

func randomizeRandomItems():
	var _randomItemList = randomItemList.randomItemList.duplicate(true)
	var _shuffledItems = {
		"amulet": {},
		"belt": {},
		"cloak": {},
		"gauntlets": {},
		"potion": {},
		"ring": {},
		"scroll": {},
		"wand": {}
	}
	
	for _itemType in _randomItemList:
		for _i in _randomItemList[_itemType].type.size():
			var _type = _randomItemList[_itemType].type[randi() % _randomItemList[_itemType].type.size()]
			var _appearance = _randomItemList[_itemType].appearance[randi() % _randomItemList[_itemType].appearance.size()]
			var _itemName = _itemType.capitalize() + " of " + _type
			var _unidentifiedItemName
			var _textureLoadPath
			if _itemType == "scroll":
				_unidentifiedItemName = _itemType.capitalize() + " labeled " + _appearance
				_textureLoadPath = "res://Assets/Miscellaneous/Scroll.png".format({
					"appearance": _appearance.capitalize().replace(" ", ""),
					"itemType": _itemType.capitalize()
				})
			elif _itemType == "gauntlets":
				_unidentifiedItemName = _appearance + " " + _itemType.capitalize()
				_textureLoadPath = "res://Assets/{itemType}/{itemType}{appearance}.png".format({
					"appearance": _appearance.capitalize().replace(" ", ""),
					"itemType": _itemType.capitalize()
				})
			else:
				_unidentifiedItemName = _appearance + " " + _itemType.capitalize()
				_textureLoadPath = "res://Assets/{itemType}s/{itemType}{appearance}.png".format({
					"appearance": _appearance.capitalize().replace(" ", ""),
					"itemType": _itemType.capitalize()
				})
			_shuffledItems[_itemType][_itemName] = {
				"unidentifiedItemName": _unidentifiedItemName,
				"texture": load(_textureLoadPath)
			}
			_randomItemList[_itemType].type.erase(_type)
			_randomItemList[_itemType].appearance.erase(_appearance)
	
	for _itemType in items:
		if _shuffledItems.has(_itemType):
			for _rarity in items[_itemType]:
				for _item in items[_itemType][_rarity]:
					if _shuffledItems[_itemType].has(_item.itemName):
						_item.unidentifiedItemName = _shuffledItems[_itemType][_item.itemName].unidentifiedItemName
						if !_itemType.matchn("scroll"):
							_item.texture = _shuffledItems[_itemType][_item.itemName].texture
							_item.unidentifiedTexture = _shuffledItems[_itemType][_item.itemName].texture



########################
### Helper functions ###
########################

func getItemByName(_itemName):
	for _types in items.values():
		for _rarity in _types.values():
			for _item in _rarity:
				if _item.itemName.matchn(_itemName) and _item.itemName.length() == _itemName.length():
					return _item

func removeItem(_itemId, _position = null, _removeFromInventory = true, _grid = $"/root/World".level.grid):
	mutex.lock()
	var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
	if _position != null:
		_grid[_position.x][_position.y].items.erase(_itemId)
	if _removeFromInventory:
		$"/root/World/Critters/0/Inventory".removeFromInventory(_item)
		$"/root/World/UI/UITheme/Equipment".takeOfEquipmentWhenDroppingItem(_item.id)
		$"/root/World/UI/UITheme/Runes".takeOfRuneWhenDroppingItem(_item.id)
	_item.queue_free()
	mutex.unlock()

func checkAllItemsIdentification():
	for _item in $"/root/World/Items".get_children():
		if _item.name.matchn("Items"):
			continue
		_item.checkItemIdentification()

func getItemsSaveData():
	var _items = {  }
	
	for _type in items:
		_items[_type] = {  }
		for _rarity in items[_type]:
			_items[_type][_rarity] = []
			for _index in items[_type][_rarity].size():
				_items[_type][_rarity].append(items[_type][_rarity][_index])
				_items[_type][_rarity][_index].texture = _items[_type][_rarity][_index].texture.get_path()
				_items[_type][_rarity][_index].unidentifiedTexture = _items[_type][_rarity][_index].unidentifiedTexture.get_path()
	
	return {
		items = _items
	}
