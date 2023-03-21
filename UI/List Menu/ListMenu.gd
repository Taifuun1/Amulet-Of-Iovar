extends Control

onready var listItem = preload("res://UI/List Menu/ListMenuItem.tscn")

var items = []
var usedItemName
var usedItemPiety
var additionalData


func create():
	name = "ListMenu"
	hide()

func showListMenuList(_title, _items, _usedItem = null, _changeMenuItems = false, _additionalData = null):
	$ListMenuContainer/Title.text = _title
	items = _items
	if _usedItem != null:
		usedItemName = _usedItem.identifiedItemName
		usedItemPiety = _usedItem.piety
	additionalData = _additionalData
	for _item in items:
		var newItem = listItem.instance()
#		var _item = get_node("/root/World/Critters/{id}".format({ "id": item }))
		if additionalData != null and additionalData.has("letters") and _additionalData.letters[_item] != null:
			newItem.setValues(_item, _changeMenuItems, _additionalData.letters[_item])
		else:
			newItem.setValues(_item, _changeMenuItems)
		$ListMenuContainer/ListMenuCenterContainer/ListMenuContent.add_child(newItem)
	show()

func hideListMenuList(_resetData = false):
	for _item in $ListMenuContainer/ListMenuCenterContainer/ListMenuContent.get_children():
		_item.queue_free()
	items = []
	if _resetData:
		return
	usedItemName = null
	usedItemPiety = null
	hide()

func _on_List_Menu_Item_Clicked(_name, _changeMenuItems):
	if _changeMenuItems:
		if usedItemName.matchn("wand of wishing"):
			hideListMenuList(true)
			var _items = []
			for _rarity in $"/root/World/Items/Items".items[_name]:
				for _item in $"/root/World/Items/Items".items[_name][_rarity]:
					if !_item.itemName.matchn("wand of wishing"):
						_items.append(_item.itemName)
			showListMenuList("Wish for what item?", _items)
			return
#	if $"/root/World".currentGameState == $"/root/World".gameState.READ:
	if usedItemName.matchn("scroll of genocide"):
		$"/root/World/Critters/0".dealWithScrollOfGenocide(_name, usedItemPiety)
	elif usedItemName.matchn("wand of wishing"):
		$"/root/World/Critters/0".dealWithWandOfWishing(_name, usedItemPiety)
	elif usedItemName.matchn("magic marker"):
		if !$"/root/World/Critters/0".dealWithMarker(_name, { "blankPaper": additionalData.blankPaper }):
			$"/root/World".closeMenu()
			return
	elif usedItemName.matchn("marker"):
		if !$"/root/World/Critters/0".dealWithMarker(_name, { "ink": additionalData.ink, "letters": additionalData.letters[_name], "blankPaper": additionalData.blankPaper }):
			$"/root/World".closeMenu()
			return
	$"/root/World".processGameTurn()

#func setValues(_title, _critters):
#	$Title.text = str(_title)
#	for _critterName in _critters:
#		var _critter = $"/root/World/Critters/Critters".getCritterByName(_critterName)
#		add_icon_item(load("res://Assets/Critters/{race}{critterName}".format({ "race": _critter.race, "critterName": _critter.critterName })), _critter.critterName)
