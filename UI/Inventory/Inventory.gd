extends CanvasLayer

onready var inventoryItem = preload("res://UI/Inventory/Inventory Item.tscn")

var inventory = []
var currentWeight = 0


func create(_inventory = []):
	name = "Inventory"
	$InventoryBackground.hide()
	layer = 10
	inventory = _inventory
	
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/AmuletContainer/Amulets.createRichTextLabel("Amulets", "amulet")
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ArmorContainer/Armor.createRichTextLabel("Armor", "armor")
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ComestibleContainer/Comestible.createRichTextLabel("Comestibles", "comestible")
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/GemContainer/Gem.createRichTextLabel("Gems", "gem")
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/MiscellaneousContainer/Miscellaneous.createRichTextLabel("Miscellaneous", "miscellaneous")
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/PotionContainer/Potion.createRichTextLabel("Potions", "potion")
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/RingContainer/Ring.createRichTextLabel("Rings", "ring")
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/RuneContainer/Rune.createRichTextLabel("Runes", "rune")
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ScrollContainer/Scroll.createRichTextLabel("Scrolls", "scroll")
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ToolContainer/Tool.createRichTextLabel("Tools", "tool")
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/WandContainer/Wand.createRichTextLabel("Wands", "wand")
	$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/WeaponContainer/Weapon.createRichTextLabel("Weapons", "weapon")

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
		if get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).type.matchn("corpse"):
			get_node("InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/{itemType}Container".format({ "itemType": "Miscellaneous" })).add_child(_newItem)
		else:
			get_node("InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/{itemType}Container".format({ "itemType": get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).type })).add_child(_newItem)
		_newItem.setValues(get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })))
	
	for _typeContainer in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent.get_children():
		_typeContainer.show()
	
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/AmuletContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/AmuletContainer.hide()
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ArmorContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ArmorContainer.hide()
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ComestibleContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ComestibleContainer.hide()
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/GemContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/GemContainer.hide()
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/MiscellaneousContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/MiscellaneousContainer.hide()
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/PotionContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/PotionContainer.hide()
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/RingContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/RingContainer.hide()
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/RuneContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/RuneContainer.hide()
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ScrollContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ScrollContainer.hide()
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ToolContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ToolContainer.hide()
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/WandContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/WandContainer.hide()
	if $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/WeaponContainer.get_child_count() == 1:
		$InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/WeaponContainer.hide()
	$InventoryBackground.show()

func hideInventory():
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/AmuletContainer.get_children():
		if !_item.name.matchn("Amulet"):
			_item.queue_free()
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ArmorContainer.get_children():
		if !_item.name.matchn("Armor"):
			_item.queue_free()
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ComestibleContainer.get_children():
		if !_item.name.matchn("Comestible"):
			_item.queue_free()
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/GemContainer.get_children():
		if !_item.name.matchn("Gem"):
			_item.queue_free()
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/MiscellaneousContainer.get_children():
		if !_item.name.matchn("Miscellaneous"):
			_item.queue_free()
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/PotionContainer.get_children():
		if !_item.name.matchn("Potion"):
			_item.queue_free()
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/RingContainer.get_children():
		if !_item.name.matchn("Ring"):
			_item.queue_free()
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/RuneContainer.get_children():
		if !_item.name.matchn("Rune"):
			_item.queue_free()
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ScrollContainer.get_children():
		if !_item.name.matchn("Scroll"):
			_item.queue_free()
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/ToolContainer.get_children():
		if !_item.name.matchn("Tool"):
			_item.queue_free()
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/WandContainer.get_children():
		if !_item.name.matchn("Wand"):
			_item.queue_free()
	for _item in $InventoryBackground/InventoryContainer/InventoryListContainer/InventoryListContent/WeaponContainer.get_children():
		if !_item.name.matchn("Weapon"):
			_item.queue_free()
	$InventoryBackground.hide()

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
