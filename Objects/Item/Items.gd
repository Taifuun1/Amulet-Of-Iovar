extends Node

onready var item = preload("res://Objects/Item/Item.tscn")

var amulets = preload("res://Objects/Item/Amulets/Amulets.gd").new()
var armors = preload("res://Objects/Item/Armor/Armor.gd").new()
var comestibles = preload("res://Objects/Item/Comestibles/Comestibles.gd").new()
var potions = preload("res://Objects/Item/Potions/Potions.gd").new()
var rings = preload("res://Objects/Item/Rings/Rings.gd").new()
var scrolls = preload("res://Objects/Item/Scrolls/Scrolls.gd").new()
var tools = preload("res://Objects/Item/Tools/Tools.gd").new()
var wands = preload("res://Objects/Item/Wands/Wands.gd").new()
var weapons = preload("res://Objects/Item/Weapons/Weapons.gd").new()

var miscellaneous = preload("res://Objects/Item/Miscellaneous/Miscellaneous.gd").new()

var randomItemList = preload("res://Objects/Item/RandomItemList.gd").new()
var itemGeneration = preload("res://Objects/Item/ItemGeneration.gd").new()

var items = {}
var miscellaneousItems = []

func create():
	name = "Items"
	items["amulet"] = amulets.amulets
	items["armor"] = armors.armors
	items["comestible"] = comestibles.comestibles
	items["potion"] = potions.potions
	items["ring"] = rings.rings
	items["scroll"] = scrolls.scrolls
	items["tool"] = tools.tools
	items["wand"] = wands.wands
	items["weapon"] = weapons.weapons
	
	miscellaneousItems = miscellaneous.miscellaneous.other



#######################
### Item generation ###
#######################

func createItem(_item, _position = null, _toInventory = false, _level = $"/root/World".level):
	var _itemPosition
	if _position == null:
		_itemPosition = _level.spawnableFloors[randi() % (_level.spawnableFloors.size())]
	else:
		_itemPosition = _position
	
	var newItem = item.instance()
	if typeof(_item) == TYPE_STRING:
		newItem.createItem(getItemByName(_item))
	else:
		newItem.createItem(_item)
	if _toInventory:
		$"/root/World/Critters/0/Inventory".addToInventory(newItem)
	else:
		_level.grid[_itemPosition.x][_itemPosition.y].items.append(newItem.id)
	$"/root/World/Items".add_child(newItem, true)

func generateItemsForLevel(_level):
	var _itemGeneration = itemGeneration.itemGeneration[_level.dungeonType]
	var _items = []
	
	for _i in range(_itemGeneration.amount):
		var _item = returnRandomItemForItemGeneration(_itemGeneration)
		if _item != null:
			_items.append(_item)
	
	for _item in _items:
		if _item != null:
			var gridPosition = _level.spawnableFloors[randi() % (_level.spawnableFloors.size())]
			var newItem = item.instance()
#			if randomItemLists.has(_item.type):
#				newItem.createItem(_item, "_extraData")
#			else:
			newItem.createItem(_item)
			_level.grid[gridPosition.x][gridPosition.y].items.append(newItem.id)
			$"/root/World/Items".add_child(newItem, true)

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



########################
### Helper functions ###
########################

func getItemByName(_itemName, _type = null, _rarity = null):
	if _type != null and _rarity != null:
		for _item in items[_type][_rarity]:
			if _item.itemName.matchn(_itemName):
				return _item
	else:
		for _types in items.values():
			for _rarity in _types.values():
				for _item in _rarity:
					if _item.itemName.matchn(_itemName):
						return _item

func returnRandomItem(_type = null):
	if _type == null:
		var _randomType = items.keys()[randi() % items.keys().size()]
		var _rarity = items[_randomType].keys()[randi() % items[_randomType].keys().size()]
		var _pick = randi() % items[_randomType][_rarity].size()
		return items[_randomType][_rarity][_pick]
	else:
		var _rarity = items[_type].keys()[randi() % items[_type].keys().size()]
		return items[_type][_rarity][randi() % items[_type][_rarity].size()]



###############################
### Miscellaneous functions ###
###############################

func randomizeRandomItems():
	var _randomItemList = randomItemList.randomItemList.duplicate(true)
	var _shuffledItems = {
		"amulet": {},
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
							_item.unIdentifiedTexture = _shuffledItems[_itemType][_item.itemName].texture
