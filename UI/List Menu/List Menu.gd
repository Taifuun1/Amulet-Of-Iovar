extends Control

onready var listItem = preload("res://UI/List Menu/List Menu Item.tscn")

var items = []
#var selectedItems = []

#var chooseOnClick = false

func create():
	name = "ListMenu"
	hide()

func showListMenuList(_title, _items):
	$Title.text = _title
	items = _items
	for _item in items:
		var newItem = listItem.instance()
#		var _item = get_node("/root/World/Critters/{id}".format({ "id": item }))
		newItem.setValues(_item)
		$ListMenuContainer/ListMenuContent.add_child(newItem)
	show()

func hideListMenuList():
	for _item in $ListMenuContainer/ListMenuContent.get_children():
		_item.queue_free()
	items = []
#	selectedItems = []
	hide()

func _on_List_Menu_Item_Clicked(_id):
#	if $"/root/World".currentGameState == $"/root/World".gameState.READ:
	$"/root/World/Critters/0".dealWithScrollOfGenocide(_id)
	$"/root/World".processGameTurn()
#	return

#func setValues(_title, _critters):
#	$Title.text = str(_title)
#	for _critterName in _critters:
#		var _critter = $"/root/World/Critters/Critters".getCritterByName(_critterName)
#		add_icon_item(load("res://Assets/Critters/{race}{critterName}".format({ "race": _critter.race, "critterName": _critter.critterName })), _critter.critterName)
