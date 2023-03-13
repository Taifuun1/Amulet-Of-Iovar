extends Control

onready var containerItem = preload("res://UI/Item Menu Item/Item Menu Item.tscn")

var containerItemNode

var containerItems = []
var inventoryItems = []

func sortItems(a, b):
	if get_node("/root/World/Items/{itemId}".format({ "itemId": a })).itemName < get_node("/root/World/Items/{itemId}".format({ "itemId": b })).itemName:
		return true
	return false


func create():
	name = "Container"
	hide()

func showContainerList(_id, _containerTitle, _containerItems, _inventoryItems):
	_containerItems.sort_custom(self, "sortItems")
	_inventoryItems.sort_custom(self, "sortItems")
	containerItemNode = get_node("/root/World/Items/{itemId}".format({ "itemId": _id }))
	$DividerContainer/ContainerContainer/ContainerTitle.text = _containerTitle
	containerItems = _containerItems
	inventoryItems = _inventoryItems
	for _itemId in containerItems:
		if (_id != _itemId and get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).category == null) or !get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).category.matchn("container"):
			createContainerItem(get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })), "Container")
	for _itemId in inventoryItems:
		var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
		if (_id != _itemId and get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).category == null) or !get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).category.matchn("container"):
			createContainerItem(get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })), "Inventory")
	show()

func hideContainerList():
	for _item in $DividerContainer/ContainerContainer/ContainerListScroll/ContainerList.get_children():
		_item.queue_free()
	for _item in $DividerContainer/InventoryContainer/InventoryListScroll/InventoryList.get_children():
		_item.queue_free()
	containerItems = []
	inventoryItems = []
	hide()

func createContainerItem(_item, _listType):
	var newItem = containerItem.instance()
	get_node("DividerContainer/{listType}Container/{listType}ListScroll/{listType}List".format({ "listType": _listType })).add_child(newItem)
	newItem.setValues(_item, "Container", true)

func removeContainerItem(_itemId, _listType):
	get_node("DividerContainer/{listType}Container/{listType}ListScroll/{listType}List/{itemId}".format({ "listType": _listType, "itemId": _itemId })).queue_free()

func _on_Container_List_Clicked(_id):
	var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _id }))
	if containerItems.has(_id):
		if containerItemNode.binds != null and containerItemNode.binds.state.matchn("bound"):
			Globals.gameConsole.addLog("{storageItem} doesn't let you remove the {itemName} while its bound!".format({ "storageItem": containerItemNode.itemName, "itemName": _item.itemName}))
			return
		if _item.itemName.matchn("Gold pieces"):
			$"/root/World/Critters/0".goldPieces += _item.amount
			containerItems.erase(_id)
			removeContainerItem(_id, "Container")
			return
		if $"/root/World/Critters/0".inventory.checkIfStackableItemInInventory(_item, "add"):
			containerItems.erase(_id)
			removeContainerItem(_id, "Container")
			return
		containerItems.erase(_id)
		inventoryItems.append(_id)
		removeContainerItem(_id, "Container")
		createContainerItem(_item, "Inventory")
		if containerItemNode.identifiedItemName.matchn("bag of holding"):
			containerItemNode.containerWeight -= _item.weight - _item.weight / 3
		elif containerItemNode.identifiedItemName.matchn("bag of weight"):
			containerItemNode.containerWeight -= _item.weight + _item.weight / 3
		else:
			containerItemNode.containerWeight -= _item.weight
	elif inventoryItems.has(_id):
		if $"/root/World/Critters/0".inventory.checkIfStackableItemInInventory(_item, "substract"):
			inventoryItems.erase(_id)
			return
		inventoryItems.erase(_id)
		containerItems.append(_id)
		removeContainerItem(_id, "Inventory")
		createContainerItem(_item, "Container")
		$"/root/World/UI/UITheme/Equipment".takeOfEquipmentWhenDroppingItem(_id)
		$"/root/World/UI/UITheme/Runes".takeOfRuneWhenDroppingItem(_id)
		if containerItemNode.identifiedItemName.matchn("bag of holding"):
			containerItemNode.containerWeight += _item.weight - _item.weight / 3
		elif containerItemNode.identifiedItemName.matchn("bag of weight"):
			containerItemNode.containerWeight += _item.weight + _item.weight / 3
		else:
			containerItemNode.containerWeight += _item.weight
	$"/root/World".updateUI()
