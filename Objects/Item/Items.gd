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

var itemGeneration = {
	"dungeon1": {
		"amount": 8,
		"type": {
			"amulet": 25,
			"armor": 100,
			"comestible": 200,
			"potion": 150,
			"ring": 50,
			"scroll": 200,
			"tool": 100,
			"wand": 75,
			"weapon": 100
		},
		"rarity": {
			"common": 800,
			"uncommon": 150,
			"rare": 49,
			"legendary": 1
		}
	},
	"minesOfTidoh": {
		"amount": 10,
		"type": {
			"amulet": 25,
			"armor": 175,
			"comestible": 100,
			"potion": 0,
			"ring": 100,
			"scroll": 100,
			"tool": 250,
			"wand": 75,
			"weapon": 175
		},
		"rarity": {
			"common": 750,
			"uncommon": 150,
			"rare": 75,
			"legendary": 25
		}
	},
	"dungeon2": {
		"amount": 8,
		"type": {
			"amulet": 25,
			"armor": 100,
			"comestible": 200,
			"potion": 150,
			"ring": 50,
			"scroll": 200,
			"tool": 100,
			"wand": 75,
			"weapon": 100
		},
		"rarity": {
			"common": 800,
			"uncommon": 150,
			"rare": 49,
			"legendary": 1
		}
	},
	"beach": {
		"amount": 14,
		"type": {
			"amulet": 100,
			"armor": 150,
			"comestible": 150,
			"potion": 50,
			"ring": 150,
			"scroll": 0,
			"tool": 150,
			"wand": 100,
			"weapon": 150
		},
		"rarity": {
			"common": 500,
			"uncommon": 300,
			"rare": 150,
			"legendary": 50
		}
	},
	"dungeon3": {
		"amount": 8,
		"type": {
			"amulet": 25,
			"armor": 100,
			"comestible": 200,
			"potion": 150,
			"ring": 50,
			"scroll": 200,
			"tool": 100,
			"wand": 75,
			"weapon": 100
		},
		"rarity": {
			"common": 800,
			"uncommon": 150,
			"rare": 49,
			"legendary": 1
		}
	},
	"library": {
		"amount": 24,
		"type": {
			"amulet": 50,
			"armor": 0,
			"comestible": 50,
			"potion": 50,
			"ring": 150,
			"scroll": 500,
			"tool": 50,
			"wand": 150,
			"weapon": 0
		},
		"rarity": {
			"common": 500,
			"uncommon": 290,
			"rare": 200,
			"legendary": 10
		}
	},
	"dungeon4": {
		"amount": 8,
		"type": {
			"amulet": 25,
			"armor": 100,
			"comestible": 200,
			"potion": 150,
			"ring": 50,
			"scroll": 200,
			"tool": 100,
			"wand": 75,
			"weapon": 100
		},
		"rarity": {
			"common": 800,
			"uncommon": 150,
			"rare": 49,
			"legendary": 1
		}
	},
	"banditWarcamp": {
		"amount": 20,
		"type": {
			"amulet": 0,
			"armor": 300,
			"comestible": 200,
			"potion": 0,
			"ring": 0,
			"scroll": 0,
			"tool": 200,
			"wand": 0,
			"weapon": 300
		},
		"rarity": {
			"common": 500,
			"uncommon": 250,
			"rare": 200,
			"legendary": 50
		}
	}
}

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

func generateItemsForLevel(_level):
	var _itemGeneration = itemGeneration[_level.dungeonType]
	var _items = []
	
	for _i in range(_itemGeneration.amount):
		var _item = returnRandomItem(_itemGeneration)
		if _item != null:
			_items.append(_item)
	
	for _item in _items:
		if _item != null:
			var gridPosition = _level.spawnableFloors[randi() % (_level.spawnableFloors.size() - 1)]
			var newItem = item.instance()
#			if randomItemLists.has(_item.type):
#				newItem.createItem(_item, "_extraData")
#			else:
			newItem.createItem(_item)
			_level.grid[gridPosition.x][gridPosition.y].items.append(newItem.id)
			$"/root/World/Items".add_child(newItem, true)

func returnRandomItem(_itemGeneration):
	var type
	var rarity
	
	var randomType = []
	for _key in _itemGeneration["type"].keys():
		for _i in range(_itemGeneration["type"][_key]):
			randomType.append(_key)
	
	var randomRarity = []
	for _key in _itemGeneration["rarity"].keys():
		for _i in range(_itemGeneration["rarity"][_key]):
			randomRarity.append(_key)
	
	type = randomType[randi() % 1000]
	rarity = randomRarity[randi() % 1000]
	
	if items[type].has(rarity):
		return items[type][rarity][randi() % items[type][rarity].size() - 1]
	else:
		return null

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
