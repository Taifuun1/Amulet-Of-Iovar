extends Control

onready var containerItem = preload("res://UI/Container/Container Item.tscn")

var containerItemNode

var containerItems = []
var inventoryItems = []

func create():
	name = "Container"
	hide()

func showContainerList(_id, _containerTitle, _containerItems, _inventoryItems):
	containerItemNode = get_node("/root/World/Items/{itemId}".format({ "itemId": _id }))
	$ContainerTitle.text = _containerTitle
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
	for _item in $ContainerList.get_children():
		_item.queue_free()
	for _item in $InventoryList.get_children():
		_item.queue_free()
	containerItems = []
	inventoryItems = []
	hide()

func createContainerItem(_item, _listType):
	var newItem = containerItem.instance()
	newItem.setValues(_item)
	get_node("{listType}List".format({ "listType": _listType })).add_child(newItem)

func removeContainerItem(_itemId, _listType):
	get_node("{listType}List/{itemId}".format({ "listType": _listType, "itemId": _itemId })).queue_free()

func _on_Container_List_Clicked(_id):
	var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _id }))
	if containerItems.has(_id):
		if containerItemNode.binds.state.matchn("bound"):
			Globals.gameConsole.addLog("{storageItem} doesn't let you remove the {itemName} while its bound!".format({ "storageItem": containerItemNode.itemName, "itemName": _item.itemName}))
			return
		if $"/root/World/Critters/0".inventory.checkIfStackableItemInInventory(_item, "add"):
			containerItems.erase(_id)
			return
		containerItems.erase(_id)
		inventoryItems.append(_id)
		createContainerItem(_item, "Inventory")
		removeContainerItem(_id, "Container")
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
		createContainerItem(_item, "Container")
		removeContainerItem(_id, "Inventory")
		$"/root/World/UI/UITheme/Equipment".takeOfEquipmentWhenDroppingItem(_id)
		if containerItemNode.identifiedItemName.matchn("bag of holding"):
			containerItemNode.containerWeight += _item.weight - _item.weight / 3
		elif containerItemNode.identifiedItemName.matchn("bag of weight"):
			containerItemNode.containerWeight += _item.weight + _item.weight / 3
		else:
			containerItemNode.containerWeight += _item.weight
	$"/root/World/Critters/0".inventory.updateWeight()
