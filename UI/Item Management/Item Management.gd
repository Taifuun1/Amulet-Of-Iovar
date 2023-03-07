extends Control

onready var menuItem = preload("res://UI/Item Menu Item/Item Menu Item.tscn")

var items = []
var selectedItems = []

var chooseOnClick = false

func sortItems(a, b):
	if get_node("/root/World/Items/{itemId}".format({ "itemId": a })).itemName < get_node("/root/World/Items/{itemId}".format({ "itemId": b })).itemName:
		return true
	return false

func create():
	name = "ItemManagement"
	hide()

func showItemManagementList(_title, _chooseOnClick = true):
	$ItemManagementContainer/TitleContainer/Title.text = _title
	chooseOnClick = _chooseOnClick
	items.sort_custom(self, "sortItems")
	for item in items:
		var newItem = menuItem.instance()
		var _item = get_node("/root/World/Items/{id}".format({ "id": item }))
		$ItemManagementContainer/ItemManagementListScrollContainer/ItemManagementList.add_child(newItem)
		newItem.setValues(_item, "Item management", _chooseOnClick)
	show()

func hideItemManagementList():
	for _item in $ItemManagementContainer/ItemManagementListScrollContainer/ItemManagementList.get_children():
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
		elif $"/root/World".currentGameState == $"/root/World".gameState.READ:
			$"/root/World/Critters/0".readItem(_id)
			if !_processGameTurn:
				return
		elif $"/root/World".currentGameState == $"/root/World".gameState.QUAFF:
			$"/root/World/Critters/0".quaffItem(_id)
		elif $"/root/World".currentGameState == $"/root/World".gameState.CONSUME:
			$"/root/World/Critters/0".consumeItem(_id)
		elif $"/root/World".currentGameState == $"/root/World".gameState.ZAP:
			$"/root/World/Critters/0".selectedItem = _id
			var _zappedItem = get_node("/root/World/Items/{itemId}".format({ "itemId": _id }))
			if !_zappedItem.identifiedItemName.matchn("wand of light") and !_zappedItem.identifiedItemName.matchn("wand of summon critter"):
				$"/root/World".closeMenu(false, true)
				return
			$"/root/World/Critters/0".zapItem(Vector2())
			$"/root/World".closeMenu()
			return
		elif $"/root/World".currentGameState == $"/root/World".gameState.THROW:
			$"/root/World/Critters/0".selectedItem = _id
			$"/root/World".closeMenu(false, true)
			return
		elif $"/root/World".currentGameState == $"/root/World".gameState.DIP_ITEM:
			$"/root/World/Critters/0".selectedItem = _id
			$"/root/World/Critters/0".dipItem(_id)
			return
		elif $"/root/World".currentGameState == $"/root/World".gameState.DIP:
			$"/root/World/Critters/0".dipItem(_id)
			return
		elif $"/root/World".currentGameState == $"/root/World".gameState.USE:
			$"/root/World/Critters/0".useItem(_id)
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _id }))
			if _item.identifiedItemName.matchn("marker") or _item.identifiedItemName.matchn("magic marker"):
				$"/root/World/UI/UITheme/ItemManagement".hideItemManagementList()
				return
		$"/root/World".processGameTurn()
		return
	
	var clickedItem = get_node("ItemManagementContainer/ItemManagementListScrollContainer/ItemManagementList/{id}".format({ "id": _id }))
	var isRemoved = false
	for _item in range(selectedItems.duplicate().size()):
		if selectedItems[_item] == clickedItem.id:
			selectedItems.remove(_item)
			isRemoved = true
			clickedItem.get_node("CheckAndNameContainer/Check").pressed = false
			break
	if !isRemoved:
		selectedItems.append(_id)
		clickedItem.get_node("CheckAndNameContainer/Check").pressed = true
