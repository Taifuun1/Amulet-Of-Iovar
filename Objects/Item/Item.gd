extends Node

var gridPosition

var id
var itemName

var type
var category

var value

var alignment
var enchantment = null

var stackable

var unidentifiedItemName
var notIdentified = {
	"use": false,
	"alignment": false,
	"enchantment": false
}

func createItem(_item, extraData = {}):
	id = Globals.itemId
	name = str(id)
	Globals.itemId += 1
	
	if _item.itemName == "Corpse":
		itemName = "{critterName} {itemName}".format({ "critterName": extraData.critterName, "itemName": _item.itemName})
	else:
		itemName = _item.itemName
	
	type = _item.type
	category = _item.category
	
	value = _item.value
	
	if randi() % 5 + 0 == 5:
		if randi() % 2 == 1:
			alignment = "Blessed"
		else:
			alignment = "Cursed"
	else:
		alignment = "Neutral"
	
	if randi() % 8 == 1:
		if randi() % 2 == 1:
			enchantment = randi() % 2
		else:
			enchantment = -randi() % 2
	else:
		enchantment = 0
	
	stackable = _item.stackable
	
	unidentifiedItemName = _item.unidentifiedItemName
	
	$ItemSprite.texture = _item.texture

func createItemByName(_itemName, _items, extraData = {}):
	var _item = _items.getItemByName(_itemName, "miscellaneous", "other")
	
	id = Globals.itemId
	name = str(id)
	Globals.itemId += 1
	
	if _item.itemName == "Corpse":
		itemName = "{critterName} {itemName}".format({ "critterName": extraData.critterName, "itemName": _item.itemName})
	else:
		itemName = _item.itemName
	
	type = _item.type
	category = _item.category
	
	value = _item.value
	
	if randi() % 5 + 0 == 5:
		if randi() % 2 == 1:
			alignment = "Blessed"
		else:
			alignment = "Cursed"
	else:
		alignment = "Neutral"
	
	if enchantment:
		if randi() % 8 == 1:
			if randi() % 2 == 1:
				enchantment = randi() % 2
			else:
				enchantment = -randi() % 2
		else:
			enchantment = 0
	
	stackable = _item.stackable
	
	unidentifiedItemName = _item.unidentifiedItemName
	
	$ItemSprite.texture = _item.texture

func getTotalUseValue():
	return value + enchantment

func getTexture():
	return $ItemSprite.texture
