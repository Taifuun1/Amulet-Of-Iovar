extends HBoxContainer

var itemName
var changeMenuItems

func setValues(_name, _changeMenuItems = false):
	itemName = _name
	name = str(_name)
	
	$Name.text = _name
	
	changeMenuItems = _changeMenuItems

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$"../../../../.."._on_List_Menu_Item_Clicked(itemName, changeMenuItems)
