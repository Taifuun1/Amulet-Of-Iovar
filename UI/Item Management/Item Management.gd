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
		$ItemManagementListScrollContainer/ItemManagementList.add_child(newItem)
	show()

func hideItemManagementList():
	for _item in $ItemManagementListScrollContainer/ItemManagementList.get_children():
		_item.queue_free()
	items = []
	selectedItems = []
	hide()

func _on_Item_Management_List_Clicked(_id, _processGameTurn = true):
	if chooseOnClick:
		if $"/root/World".currentGameState == $"/root/World".gameState.PICK_LOOTABLE:
			$"/root/World/UI/UITheme/ItemManagement".hideItemManagementList()
			$"/root/World".currentGameState = $"/root/World".gameState.LOOT
			var _containerItem = get_node("/root/World/Items/{itemId}".format({ "itemId": _id }))
			$"/root/World/UI/UITheme/Container".showContainerList(_id, _containerItem.itemName, _containerItem.container, $"/root/World/Critters/0/Inventory".inventory)
			return
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
			var _zappedItem = get_node("/root/World/Items/{itemId}".format({ "itemId": _id }))
			if _zappedItem.identifiedItemName.matchn("wand of light") or _zappedItem.identifiedItemName.matchn("wand of summon critter"):
				$"/root/World/Critters/0".zapItem(Vector2())
				$"/root/World".closeMenu()
				$"/root/World".processGameTurn()
				return
			$"/root/World".closeMenu(false, true)
			return
		if $"/root/World".currentGameState == $"/root/World".gameState.DIP_ITEM:
			$"/root/World/Critters/0".selectedItem = _id
			$"/root/World/Critters/0".dipItem(_id)
			return
		if $"/root/World".currentGameState == $"/root/World".gameState.DIP:
			$"/root/World/Critters/0".dipItem(_id)
			$"/root/World".processGameTurn()
			return
		if $"/root/World".currentGameState == $"/root/World".gameState.USE:
			$"/root/World/Critters/0".useItem(_id)
			$"/root/World".processGameTurn()
			return
	
	var clickedItem = get_node("ItemManagementListScrollContainer/ItemManagementList/{id}".format({ "id": _id }))
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
