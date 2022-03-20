extends Node

var gridPosition

var id
var itemName
var unidentifiedItemName

var type
var useValue
var alignment
var enchantment

var stackable

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
	unidentifiedItemName = _item.unidentifiedItemName
	stackable = _item.stackable
	type = _item.type
	useValue = _item.value
	
	alignment = "blessed"
	enchantment = randi() % 2
	
	$ItemSprite.texture = _item.texture

func createItemByName(_itemName, _items, extraData = {}):
	var item = _items.getItemByName(_itemName)
	
	id = Globals.itemId
	name = str(id)
	Globals.itemId += 1
	
	if item.itemName == "Corpse":
		itemName = "{critterName} {itemName}".format({ "critterName": extraData.critterName, "itemName": item.itemName})
	else:
		itemName = item.itemName
	unidentifiedItemName = item.unidentifiedItemName
	stackable = item.stackable
	type = item.type
	useValue = item.value
	
	alignment = "blessed"
	enchantment = randi() % 2
	
	$ItemSprite.texture = item.texture

func getTotalUseValue():
	return useValue + enchantment
