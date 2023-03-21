extends Control

onready var menuItem = preload("res://UI/Item Menu Item/ItemMenuItem.tscn")

var items = []
var selectedItems = []

var chooseOnClick = false
var allSelected = false

func sortItems(a, b):
	if get_node("/root/World/Items/{itemId}".format({ "itemId": a })).itemName < get_node("/root/World/Items/{itemId}".format({ "itemId": b })).itemName:
		return true
	return false


func create():
	name = "ItemManagement"
	hide()

func _input(_event):
	if Input.is_action_just_pressed("SELECT_ALL") and visible and !chooseOnClick:
		for _itemId in items:
			toggleItemChecked(_itemId, !allSelected)
		allSelected = !allSelected

func showItemManagementList(_title, _chooseOnClick = true):
	$ItemManagementContainer/TitleContainer/Title.text = _title
	chooseOnClick = _chooseOnClick
	allSelected = false
	items.sort_custom(self, "sortItems")
	for itemId in items:
		var newItem = menuItem.instance()
		var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": itemId }))
		$ItemManagementContainer/ItemManagementListScrollContainer/ItemManagementList.add_child(newItem)
		newItem.setValues(_item, "Item management", _chooseOnClick)
	show()

func hideItemManagementList():
	for _item in $ItemManagementContainer/ItemManagementListScrollContainer/ItemManagementList.get_children():
		_item.queue_free()
	items = []
	selectedItems = []
	hide()

func _on_Item_Management_List_Clicked(_itemId, _processGameTurn = true):
	if chooseOnClick:
		if $"/root/World".currentGameState == $"/root/World".gameState.PICK_LOOTABLE:
			$"/root/World/UI/UITheme/ItemManagement".hideItemManagementList()
			$"/root/World".currentGameState = $"/root/World".gameState.LOOT
			var _containerItem = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
			$"/root/World/UI/UITheme/Container".showContainerList(_itemId, _containerItem.itemName, _containerItem.container, $"/root/World/Critters/0/Inventory".inventory) 
			return
		elif $"/root/World".currentGameState == $"/root/World".gameState.READ:
			$"/root/World/Critters/0".readItem(_itemId)
			if !_processGameTurn:
				return
		elif $"/root/World".currentGameState == $"/root/World".gameState.QUAFF:
			$"/root/World/Critters/0".quaffItem(_itemId)
		elif $"/root/World".currentGameState == $"/root/World".gameState.CONSUME:
			$"/root/World/Critters/0".consumeItem(_itemId)
		elif $"/root/World".currentGameState == $"/root/World".gameState.ZAP:
			$"/root/World/Critters/0".selectedItem = _itemId
			var _zappedItem = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
			if !_zappedItem.identifiedItemName.matchn("wand of light") and !_zappedItem.identifiedItemName.matchn("wand of summon critter"):
				$"/root/World".closeMenu(false, true)
				return
			$"/root/World/Critters/0".zapItem(Vector2())
			$"/root/World".closeMenu()
			return
		elif $"/root/World".currentGameState == $"/root/World".gameState.THROW:
			$"/root/World/Critters/0".selectedItem = _itemId
			$"/root/World".closeMenu(false, true)
			return
		elif $"/root/World".currentGameState == $"/root/World".gameState.DIP_ITEM:
			$"/root/World/Critters/0".selectedItem = _itemId
			$"/root/World/Critters/0".dipItem(_itemId)
			return
		elif $"/root/World".currentGameState == $"/root/World".gameState.DIP:
			$"/root/World/Critters/0".dipItem(_itemId)
			return
		elif $"/root/World".currentGameState == $"/root/World".gameState.USE:
			$"/root/World/Critters/0".useItem(_itemId)
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
			if _item.identifiedItemName.matchn("marker") or _item.identifiedItemName.matchn("magic marker"):
				$"/root/World/UI/UITheme/ItemManagement".hideItemManagementList()
				return
		$"/root/World".processGameTurn()
		return
	
	toggleItemChecked(_itemId)

func toggleItemChecked(_itemId, _checkTo = null):
	var clickedItem = get_node("ItemManagementContainer/ItemManagementListScrollContainer/ItemManagementList/{itemId}".format({ "itemId": _itemId }))
	if _checkTo == null:
		if clickedItem.get_node("CheckAndNameContainer/Check").pressed:
			selectedItems.erase(_itemId)
		else:
			selectedItems.append(_itemId)
		clickedItem.get_node("CheckAndNameContainer/Check").pressed = !clickedItem.get_node("CheckAndNameContainer/Check").pressed
	else:
		if _checkTo and !clickedItem.get_node("CheckAndNameContainer/Check").pressed:
			selectedItems.append(_itemId)
		elif !_checkTo and clickedItem.get_node("CheckAndNameContainer/Check").pressed:
			selectedItems.erase(_itemId)
		clickedItem.get_node("CheckAndNameContainer/Check").pressed = _checkTo
