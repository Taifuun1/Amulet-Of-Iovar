extends HBoxContainer

var id
var itemName
var unidentifiedItemName
var type
var itemAlignment
var enchantment
var stackable

func setValues(_item):
	id = _item.id
	name = str(_item.id)
	
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
		$"/root/World/UI/UITheme/ItemManagement"._on_Item_Management_List_Clicked(id)
