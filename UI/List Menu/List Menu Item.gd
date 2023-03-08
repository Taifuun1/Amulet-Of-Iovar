extends HBoxContainer

var itemName
var changeMenuItems

func setValues(_name, _changeMenuItems = false, _otherText = null):
	itemName = _name
	name = str(_name)
	
	$Name.text = _name[0].to_upper() + _name.substr(1,-1)
	if _otherText != null:
		$OtherText.text = str(_otherText)
	
	changeMenuItems = _changeMenuItems

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$"../../../.."._on_List_Menu_Item_Clicked(itemName, changeMenuItems)
