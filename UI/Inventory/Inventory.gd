extends CanvasLayer

onready var inventoryItem = preload("res://UI/InventoryItem/InventoryItem.tscn")

var inventory = []

var isPlayerInventory

func create(_isPlayer = false):
	name = "Inventory"
	isPlayerInventory = _isPlayer
	$InventoryContainer.hide()

func getInventory():
	return inventory

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
	inventory.remove(_item)
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

func showInventoryList():
	for item in inventory:
		var newItem = inventoryItem.instance()
		var _item = get_node("/root/World/Items/{id}".format({ "id": item }))
		newItem.setValues(_item)
		newItem.get_node("Checked").connect("pressed", self, "_on_Inventory_List_Clicked", [{ "id": _item.id }])
		$InventoryContainer/InventoryList.add_child(newItem)
	$InventoryContainer.show()

func hideInventoryList():
	for item in $InventoryContainer/InventoryList.get_children():
		item.queue_free()
	$InventoryContainer.hide()
