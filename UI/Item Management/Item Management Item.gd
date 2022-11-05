extends HBoxContainer

var item

func setValues(_item):
	name = str(_item.id)
	item = _item
	
	$Name.text = _item.itemName
	if _item.notIdentified.alignment:
		$Alignment.text = _item.alignment
	else:
		$Alignment.text = "Unknown"
	if _item.notIdentified.enchantment:
		$Enchantment.text = str(_item.enchantment)
	else:
		$Enchantment.text = "Unknown"

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if item.itemName.matchn("scroll of genocide"):
			$"../../.."._on_Item_Management_List_Clicked(item.id, false)
		else:
			$"../../.."._on_Item_Management_List_Clicked(item.id)
