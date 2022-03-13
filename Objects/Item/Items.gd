extends Node



func create():
	name = "Items"

func getItemByName(_itemName):
	for item in items.values():
		if item.itemName == _itemName:
			return item

func getItemById(_id):
	for id in items.keys():
		if id == _id:
			return items[id]

var items = {
	0: {
		"itemName": "Iron sword",
		"unidentifiedItemName": "Grey sword",
		"type": "Weapon",
		"useValue": 3,
		"enchantment": true,
		"stackable": false,
		"unIdentifiedTexture": load("res://Assets/IronSword.png"),
		"texture": load("res://Assets/IronSword.png")
	},
	1: {
		"itemName": "Iron Shield",
		"unidentifiedItemName": "Grey shield",
		"useValue": 2,
		"enchantment": true,
		"stackable": false,
		"unIdentifiedTexture": load("res://Assets/IronSword.png"),
		"texture": load("res://Assets/IronSword.png")
	},
	2: {
		"itemName": "Water bottle",
		"unidentifiedItemName": "Clear potion",
		"useValue": null,
		"enchantment": false,
		"stackable": true,
		"unIdentifiedTexture": load("res://Assets/IronSword.png"),
		"texture": load("res://Assets/IronSword.png")
	}
}
