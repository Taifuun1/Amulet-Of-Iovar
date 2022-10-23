extends Control

onready var listItem = preload("res://UI/List Menu/List Menu Item.tscn")

var items = []
var usedItemName
var usedItemAlignment


func create():
	name = "ListMenu"
	hide()

func showListMenuList(_title, _items, _usedItem = null, _changeMenuItems = false):
	$ListMenuMargin/Title.text = _title
	items = _items
	if _usedItem != null:
		usedItemName = _usedItem.identifiedItemName
		usedItemAlignment = _usedItem.alignment
	for _item in items:
		var newItem = listItem.instance()
#		var _item = get_node("/root/World/Critters/{id}".format({ "id": item }))
		newItem.setValues(_item, _changeMenuItems)
		$ListMenuMargin/ListMenuScrollMargin/ListMenuContainer/ListMenuContent.add_child(newItem)
	show()

func hideListMenuList(_resetData = false):
	for _item in $ListMenuMargin/ListMenuScrollMargin/ListMenuContainer/ListMenuContent.get_children():
		_item.queue_free()
	items = []
	if _resetData:
		return
	usedItemName = null
	usedItemAlignment = null
	hide()

func _on_List_Menu_Item_Clicked(_name, _changeMenuItems):
	if _changeMenuItems:
		if usedItemName.matchn("wand of wishing"):
			hideListMenuList(true)
			var _items = []
			for _rarity in $"/root/World/Items/Items".items[_name]:
				for _item in $"/root/World/Items/Items".items[_name][_rarity]:
					_items.append(_item.itemName)
			showListMenuList("Wish for what item?", _items)
			return
#	if $"/root/World".currentGameState == $"/root/World".gameState.READ:
	if usedItemName.matchn("scroll of genocide"):
		$"/root/World/Critters/0".dealWithScrollOfGenocide(_name, usedItemAlignment)
	elif usedItemName.matchn("wand of wishing"):
		$"/root/World/Critters/0".dealWithWandOfWishing(_name, usedItemAlignment)
	$"/root/World".processGameTurn()

#func setValues(_title, _critters):
#	$Title.text = str(_title)
#	for _critterName in _critters:
#		var _critter = $"/root/World/Critters/Critters".getCritterByName(_critterName)
#		add_icon_item(load("res://Assets/Critters/{race}{critterName}".format({ "race": _critter.race, "critterName": _critter.critterName })), _critter.critterName)
