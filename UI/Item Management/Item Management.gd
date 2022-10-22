extends Control

onready var inventoryItem = preload("res://UI/Item Management/Item Management Item.tscn")

var items = []
var selectedItems = []

var chooseOnClick = false

func create():
	name = "ItemManagement"
	hide()

func showItemManagementList(_chooseOnClick = false):
	chooseOnClick = _chooseOnClick
	for item in items:
		var newItem = inventoryItem.instance()
		var _item = get_node("/root/World/Items/{id}".format({ "id": item }))
		newItem.setValues(_item)
		$ItemManagementList.add_child(newItem)
	show()

func hideItemManagementList():
	for _item in $ItemManagementList.get_children():
		_item.queue_free()
	items = []
	selectedItems = []
	hide()

func _on_Item_Management_List_Clicked(_id, _processGameTurn = true):
	if chooseOnClick:
		if $"/root/World".currentGameState == $"/root/World".gameState.READ:
			$"/root/World/Critters/0".readItem(_id)
			if _processGameTurn:
				$"/root/World".processGameTurn()
			return
		if $"/root/World".currentGameState == $"/root/World".gameState.QUAFF:
			$"/root/World/Critters/0".quaffItem(_id)
			$"/root/World".processGameTurn()
			return
		if $"/root/World".currentGameState == $"/root/World".gameState.CONSUME:
			$"/root/World/Critters/0".consumeItem(_id)
			$"/root/World".processGameTurn()
			return
		if $"/root/World".currentGameState == $"/root/World".gameState.ZAP:
			$"/root/World/Critters/0".selectedItem = _id
			$"/root/World".closeMenu(false, true)
			return
		if $"/root/World".currentGameState == $"/root/World".gameState.USE:
			$"/root/World/Critters/0".useItem(_id)
			$"/root/World".processGameTurn()
			return
	
	var clickedItem = get_node("ItemManagementList/{id}".format({ "id": _id }))
	var isRemoved = false
	for _item in range(selectedItems.size()):
		if selectedItems[_item] == clickedItem.id:
			selectedItems.remove(_item)
			isRemoved = true
			clickedItem.get_node("Checked").pressed = false
			break
	if !isRemoved:
		selectedItems.append(_id)
		clickedItem.get_node("Checked").pressed = true
