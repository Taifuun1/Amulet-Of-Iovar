extends CanvasLayer

onready var inventoryItem = preload("res://UI/Inventory/Inventory Item.tscn")

var inventory = []
var currentWeight = 0


func create():
	name = "Inventory"
	$InventoryContainer.hide()
	
	layer = 10

func addToInventory(_item):
	if !checkIfStackableItemInInventory(_item, "add"):
		inventory.append(_item.id)
	updateWeight()

#	for item in inventory:
#		if item.itemName == _item.itemName:
#			if item.stackable:
#				item.amount += 1
#			else:
#				inventory.append(_item)
#			return
	
#	$Inventory
#	var isInInventory = inventory.has(_item)
#	if !isInInventory:
#		inventory.append({
#			"{item}".format({ "item": _item }): 1
#		})
#	else:
#		inventory[inventory.find(_item)] += 1
#	if isPlayerInventory:
#		Globals.inventory = inventory

func removeFromInventory(_item):
	if !checkIfStackableItemInInventory(_item, "substract"):
		inventory.erase(_item.id)
	updateWeight()

#	for item in inventory:
#		if item.itemName == _item.itemName:
#			if item.stackable and item.amount != 1:
#				item.amount -= 1
#			else:
#				inventory.erase(_item)
#			return
	
#	if !inventory[inventory.find(_item)]:
#		inventory.inventory.find
#	else:
#		pass

func showInventory():
	for _itemId in inventory:
		var _newItem = inventoryItem.instance()
		_newItem.setValues(get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })))
		$InventoryContainer/InventoryListMargin/InventoryListContainer/ListMenuContent.add_child(_newItem)
	$InventoryContainer.show()

func hideInventory():
	for item in $InventoryContainer/InventoryListMargin/InventoryListContainer/ListMenuContent.get_children():
		item.queue_free()
	$InventoryContainer.hide()

func getItemsOfType(_types, _category = null, _miscellaneousTypes = null):
	var _items = []
	for _type in _types:
		for _itemId in inventory:
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
			if _item.type.matchn(_type):
				_items.append(_itemId)
			elif _miscellaneousTypes != null:
				for _miscellaneousType in _miscellaneousTypes:
					if _item.type.matchn(_miscellaneousType):
						_items.append(_itemId)
	if _category:
		for _itemId in _items.duplicate(true):
			if get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).category == null or !get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).category.matchn(_category):
				_items.erase(_itemId)
	return _items

func checkIfItemInInventoryByName(_itemName):
	for _itemId in inventory:
		if get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).identifiedItemName.matchn(_itemName):
			return true
	return false

func updateWeight():
	currentWeight = 0
	for _itemId in inventory:
		var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
		if _item.containerWeight != null:
			currentWeight += _item.containerWeight
		else:
			currentWeight += _item.weight
	$"..".calculateWeightStats()
	$"..".updatePlayerStats()

func checkIfStackableItemInInventory(_item, _operation):
	for _itemId in inventory:
		var _inventoryItem = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
		if _inventoryItem.identifiedItemName.matchn(_item.identifiedItemName) and _inventoryItem.stackable and _inventoryItem.alignment.matchn(_item.alignment):
			if _operation.match("add"):
				_inventoryItem.amount += _item.amount
			elif _operation.match("substract"):
				_inventoryItem.amount -= _item.amount
			updateWeight()
			return true
	return false
