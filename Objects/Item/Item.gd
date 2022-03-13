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

func createItemByName(_itemName, _items):
	var item = _items.getItemByName(_itemName)
	
	id = Globals.itemId
	name = str(id)
	Globals.itemId += 1
	
	itemName = item.itemName
	unidentifiedItemName = item.unidentifiedItemName
	stackable = item.stackable
	type = item.type
	useValue = item.useValue
	
	alignment = "blessed"
	enchantment = randi() % 2
	
	get_node("ItemSprite").texture = item.texture

func setPosition(_position):
	gridPosition = _position

func setId(_id):
	id = _id

func getTotalUseValue():
	return useValue + enchantment
