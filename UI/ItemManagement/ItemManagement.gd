extends MarginContainer

onready var inventoryItem = preload("res://UI/InventoryItem/InventoryItem.tscn")

var items = []
var selectedItems = []

func create():
	name = "ItemManagement"
	hide()

func setItems(_items):
	items = _items

func getSelectedItems():
	return selectedItems

func showItemManagementList():
	for item in items:
		var newItem = inventoryItem.instance()
		var _item = get_node("/root/World/Items/{id}".format({ "id": item }))
		newItem.setValues(_item)
		newItem.get_node("Checked").connect("pressed", self, "_on_Item_Management_List_Clicked", [{ "id": _item.id }])
		$ItemManagementList.add_child(newItem)
	show()

func hideItemManagementList():
	for _item in $ItemManagementList.get_children():
		_item.queue_free()
	items = []
	selectedItems = []
	hide()

func _on_Item_Management_List_Clicked(_id):
	var clickedItem = get_node("ItemManagementList/{id}".format({ "id": _id.id }))
	var isRemoved = false
	for item in range(selectedItems.size()):
		if selectedItems[item] == clickedItem.id:
			selectedItems.remove(item)
			isRemoved = true
			break
	if !isRemoved:
		selectedItems.append(_id.id)
