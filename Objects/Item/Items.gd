extends Node

onready var item = preload("res://Objects/Item/Item.tscn")

var weapons = preload("res://Objects/Item/Weapons/Weapons.gd").new()
var armor = preload("res://Objects/Item/Armor/Armor.gd").new()
var rings = preload("res://Objects/Item/Rings/Rings.gd").new()
var tools = preload("res://Objects/Item/Tools/Tools.gd").new()
var miscellaneous = preload("res://Objects/Item/Miscellaneous/Miscellaneous.gd").new()

var itemGeneration = {
	"dungeon1": {
		"floor": {
			"type": {
				"weapons": 300,
				"armor": 300,
				"rings": 100,
				"tools": 150,
				"miscellaneous": 150
			},
			"rarity": {
				"common": 800,
				"uncommon": 100,
				"rare": 50,
				"mythical": 40,
				"artefact": 10
			}
		},
		"custom": null
	}
}

var items = {}

func create():
	name = "Items"
	items["weapons"] = weapons.weapons
	items["armor"] = armor.armor
	items["rings"] = rings.rings
	items["tools"] = tools.tools
	items["miscellaneous"] = miscellaneous.miscellaneous

func generateItemsForLevel(_level):
	var _itemGeneration = itemGeneration[_level.dungeonType]
	var _items = []
	
	for _i in range(randi() % 10 + 10):
		_items.append(returnRandomItem(_itemGeneration["floor"]))
	
	for _item in _items:
		if _item != null:
			var gridPosition = _level.spawnableFloors[randi() % _level.spawnableFloors.size() - 1]
			var newItem = item.instance()
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
	type = randomType[randi() % 1000]
	
	var randomRarity = []
	for _key in _itemGeneration["rarity"].keys():
		for _i in range(_itemGeneration["rarity"][_key]):
			randomRarity.append(_key)
	rarity = randomRarity[randi() % 1000]
	
	if items[type].has(rarity):
		return items[type][rarity][randi() % items[type][rarity].size() - 1]
	else:
		return null

func getItemByName(_itemName, _type = null):
	for types in items.values():
		for rarity in types.values():
			for _item in rarity:
				if _item.itemName == _itemName:
					return _item
