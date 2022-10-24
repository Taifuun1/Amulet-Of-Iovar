extends Control

onready var containerItem = preload("res://UI/Container/Container Item.tscn")

var storageItem

var containerItems = []
var inventoryItems = []

func create():
	name = "Container"
	hide()

func showContainerList(_id, _containerTitle, _containerItems, _inventoryItems):
	storageItem = get_node("/root/World/Items/{itemId}".format({ "itemId": _id }))
	$ContainerTitle.text = _containerTitle
	containerItems = _containerItems
	inventoryItems = _inventoryItems
	for _itemId in containerItems:
		if _id != _itemId:
			createContainerItem(get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })), "Container")
	for _itemId in inventoryItems:
		if _id != _itemId:
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
		containerItems.erase(_id)
		inventoryItems.append(_id)
		createContainerItem(_item, "Inventory")
		removeContainerItem(_id, "Container")
	elif inventoryItems.has(_id):
		inventoryItems.erase(_id)
		containerItems.append(_id)
		createContainerItem(_item, "Container")
		removeContainerItem(_id, "Inventory")
