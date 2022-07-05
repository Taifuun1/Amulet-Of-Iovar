extends Node

var itemName

func setValues(_name):
	itemName = _name
	name = str(_name)
	
	$Name.text = _name

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$"/root/World/UITheme/UI/ListMenu"._on_List_Menu_Item_Clicked(itemName)
