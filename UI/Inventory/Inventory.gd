extends CanvasLayer

onready var inventoryItem = preload("res://UI/Inventory/InventoryItem.tscn")

var inventory = []

func create():
	name = "Inventory"
	$InventoryContainer.hide()

func addToInventory(_item):
	inventory.append(_item)
	return

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

func dropFromInventory(_item):
	inventory.erase(_item)
	return

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
	for item in inventory:
		var _newItem = inventoryItem.instance()
		var _item = get_node("/root/World/Items/{id}".format({ "id": item }))
		_newItem.setValues(_item)
		_newItem.get_node("Checked").connect("pressed", self, "_on_Inventory_List_Clicked", [{ "id": _item.id }])
		$InventoryContainer/InventoryList.add_child(_newItem)
	$InventoryContainer.show()

func hideInventory():
	for item in $InventoryContainer/InventoryList.get_children():
		item.queue_free()
	$InventoryContainer.hide()

func getItemsOfType(_types):
	var _items = []
	for _type in _types:
		for _item in inventory:
			if get_node("/root/World/Items/{id}".format({ "id": _item })).type.matchn(_type):
				_items.append(_item)
	return _items

func checkIfItemInInventoryByName(_itemName):
	for _item in inventory:
		if get_node("/root/World/Items/{id}".format({ "id": _item })).identifiedItemName.matchn(_itemName):
			return true
	return false
