extends MarginContainer

onready var inventoryItem = preload("res://UI/InventoryItem/InventoryItem.tscn")

var isPlayerInventory = false

var inventory = []

func create(_isPlayer = false):
	name = "Inventory"
	isPlayerInventory = _isPlayer
	hide()

func getInventory():
	return inventory

func addToInventory(_item):
#	for item in inventory:
#		if item.itemName == _item.itemName:
#			if item.stackable:
#				item.amount += 1
#			else:
#				inventory.append(_item)
#			return
	inventory.append(_item)
	return
	
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
#	for item in inventory:
#		if item.itemName == _item.itemName:
#			if item.stackable and item.amount != 1:
#				item.amount -= 1
#			else:
#				inventory.erase(_item)
#			return
	
	inventory.remove(_item)
	return
	
#	if !inventory[inventory.find(_item)]:
#		inventory.inventory.find
#	else:
#		pass

func showInventoryList():
	for item in inventory:
		var newItem = inventoryItem.instance()
		var _item = get_node("/root/World/Items/{id}".format({ "id": item }))
		newItem.setValues(_item)
#		newItem.id = _item.id
#		newItem.name = str(_item.id)
#		newItem.get_node("Name").text = _item.itemName
#		newItem.get_node("Alignment").text = _item.alignment
#		if newItem.enchantment == true:
#			newItem.get_node("Enchantment").text = str(_item.enchantment)
		newItem.get_node("Checked").connect("pressed", self, "_on_Inventory_List_Clicked", [{ "id": _item.id }])
		$InventoryList.add_child(newItem)
	show()

func hideInventoryList():
	for item in $InventoryList.get_children():
		item.queue_free()
	hide()
