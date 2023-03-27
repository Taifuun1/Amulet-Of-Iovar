extends PanelContainer

var itemName
var changeMenuItems

func setValues(_name, _changeMenuItems = false, _otherText = null):
	itemName = _name
	name = str(_name)
	
	$ListMenuItemContainer/Name.text = _name[0].to_upper() + _name.substr(1,-1)
	if _otherText != null:
		$ListMenuItemContainer/OtherText.text = str(_otherText)
	
	changeMenuItems = _changeMenuItems

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$"../../../.."._on_List_Menu_Item_Clicked(itemName, changeMenuItems)


func _on_ListMenuItem_mouse_entered():
	var _panelStylebox = get_stylebox("panel").duplicate()
	_panelStylebox.set_border_color(Color("253f7c"))
	add_stylebox_override("panel", _panelStylebox)

func _on_ListMenuItem_mouse_exited():
	var _panelStylebox = get_stylebox("panel").duplicate()
	_panelStylebox.set_border_color(Color("00000000"))
	add_stylebox_override("panel", _panelStylebox)
