extends CanvasLayer

onready var inventoryItem = preload("res://UI/Inventory/Inventory Item.tscn")

var inventory = []
var currentWeight = 0


func create(_inventory = []):
	name = "Inventory"
	$InventoryContainer.hide()
	layer = 10
	inventory = _inventory

func addToInventory(_item):
	if !checkIfStackableItemInInventory(_item, "add"):
		inventory.append(_item.id)
		updateWeight()

func removeFromInventory(_item):
	if !checkIfStackableItemInInventory(_item, "substract"):
		inventory.erase(_item.id)
		updateWeight()

func showInventory():
	for _itemId in inventory:
		var _newItem = inventoryItem.instance()
		_newItem.setValues(get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })))
		$InventoryContainer/InventoryListMargin/InventoryListContainer/ListMenuContent.add_child(_newItem)
	$InventoryContainer.show()

func hideInventory():
	for item in $InventoryContainer/InventoryListMargin/InventoryListContainer/ListMenuContent.get_children():
		item.queue_free()
	$InventoryContainer.hide()

func getItemsOfType(_types, _category = null, _miscellaneousTypes = null):
	var _items = []
	for _type in _types:
		for _itemId in inventory:
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
			if _item.type.matchn(_type):
				_items.append(_itemId)
			elif _miscellaneousTypes != null:
				for _miscellaneousType in _miscellaneousTypes:
					if _item.type.matchn(_miscellaneousType):
						_items.append(_itemId)
	if _category:
		for _itemId in _items.duplicate(true):
			if get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).category == null or !get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).category.matchn(_category):
				_items.erase(_itemId)
	return _items

func getPoints():
	var _points = {  }
	var _totalPoints = 0
	for _item in inventory:
		var _itemNode = get_node("/root/World/Items/{itemId}".format({ "itemId": _item }))
		if _itemNode.container != null:
			for _containerItem in _itemNode.container:
				var _containerItemNode = get_node("/root/World/Items/{itemId}".format({ "itemId": _containerItem }))
				if _containerItemNode != null and _containerItemNode.points != null:
					if _points.has(_containerItemNode.identifiedItemName):
						_points[_containerItemNode.identifiedItemName] = {
							"rarity": _itemNode.rarity,
							"points": _points[_containerItemNode.identifiedItemName].points + _containerItemNode.points,
							"amount": _points[_containerItemNode.identifiedItemName].amount + _containerItemNode.amount
						}
					else:
						_points[_containerItemNode.identifiedItemName] = {
							"rarity": _containerItemNode.rarity,
							"points": _containerItemNode.points,
							"amount": _containerItemNode.amount
						}
					_totalPoints += _containerItemNode.amount * _containerItemNode.points
		if _itemNode.points != null:
			if _points.has(_itemNode.identifiedItemName):
				_points[_itemNode.identifiedItemName] = {
					"rarity": _itemNode.rarity,
					"points": _points[_itemNode.identifiedItemName].points + _itemNode.points,
					"amount": _points[_itemNode.identifiedItemName].amount + _itemNode.amount
				}
			else:
				_points[_itemNode.identifiedItemName] = {
					"rarity": _itemNode.rarity,
					"points": _itemNode.points,
					"amount": _itemNode.amount
				}
			_totalPoints += _itemNode.amount * _itemNode.points
	return {
		"totalPoints": _totalPoints,
		"points": _points
	}

func getInventoryItems():
	var _inventoryItems = {  }
	for _item in inventory:
		var _itemNode = get_node("/root/World/Items/{itemId}".format({ "itemId": _item }))
		_inventoryItems[_itemNode.identifiedItemName] = { "item": {  } }
		_inventoryItems[_itemNode.identifiedItemName].item.rarity = _itemNode.rarity
		if _itemNode.container != null:
			_inventoryItems[_itemNode.identifiedItemName].items = {  }
			for _containerItem in _itemNode.container:
				var _containerItemNode = get_node("/root/World/Items/{itemId}".format({ "itemId": _containerItem }))
#				_inventoryItems[_containerItemNode.identifiedItemName].items[_containerItemNode.identifiedItemName] = {  }
				_inventoryItems[_itemNode.identifiedItemName].items[_containerItemNode.identifiedItemName] = { "rarity": null }
				_inventoryItems[_itemNode.identifiedItemName].items[_containerItemNode.identifiedItemName].rarity = _containerItemNode.rarity
	return _inventoryItems

func updateWeight():
	currentWeight = 0
	for _itemId in inventory:
		var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
		if _item.containerWeight != null:
			currentWeight += _item.containerWeight
		else:
			currentWeight += _item.weight
	$"..".calculateWeightStats()
	$"..".updatePlayerStats()

func checkIfItemInInventoryByName(_itemName):
	for _itemId in inventory:
		if get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).identifiedItemName.matchn(_itemName):
			return true
	return false

func checkIfStackableItemInInventory(_item, _operation):
	for _itemId in inventory:
		var _inventoryItem = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
		if _inventoryItem.identifiedItemName.matchn(_item.identifiedItemName) and _inventoryItem.alignment.matchn(_item.alignment):
			if !_inventoryItem.stackable:
				return false
			elif _operation.match("add"):
				_inventoryItem.amount += _item.amount
			elif _operation.match("substract"):
				if _inventoryItem.amount == 1:
					return false
				_inventoryItem.amount -= _item.amount
			updateWeight()
			return true
	return false
