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
	itemName = _item.itemName
	
	$Name.createRichTextLabel(_item.itemName, _item.rarity)
	if _item.notIdentified.alignment:
		$Alignment.createRichTextLabel(_item.alignment)
	else:
		$Alignment.createRichTextLabel("Unknown")
	if _item.notIdentified.enchantment:
		$Enchantment.createRichTextLabel(str(_item.enchantment))
	else:
		$Enchantment.createRichTextLabel("Unknown")

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$"../../../../.."._on_Container_List_Clicked(id)
