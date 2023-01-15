extends HBoxContainer

var menuItemType

var id
var itemName
var unidentifiedItemName
var type
var itemAlignment
var enchantment
var stackable

func setValues(_item, _menuItemType, _hideChecked = false):
	id = _item.id
	name = str(_item.id)
	itemName = _item.itemName
	menuItemType = _menuItemType
	
	if _hideChecked:
		$Check.hide()
	if _item.notIdentified.name or (GlobalItemInfo.globalItemInfo.has(_item.identifiedItemName) and GlobalItemInfo.globalItemInfo[_item.identifiedItemName].identified == true):
		$Name.createRichTextLabel(_item.itemName, _item.rarity)
	else:
		$Name.createRichTextLabel(_item.itemName)
	if _item.notIdentified.alignment:
		$Alignment.createRichTextLabel(_item.alignment)
	else:
		$Alignment.createRichTextLabel("Unknown")
	if _item.notIdentified.enchantment:
		$Enchantment.createRichTextLabel(str(_item.enchantment))
	else:
		$Enchantment.createRichTextLabel("Unknown")
	if _item.amount != null:
		$Amount.createRichTextLabel(str(_item.amount))
	else:
		$Amount.createRichTextLabel("Unknown")

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if menuItemType.matchn("item management"):
			if itemName.matchn("scroll of genocide"):
				$"../../../.."._on_Item_Management_List_Clicked(id, false)
			else:
				$"../../../.."._on_Item_Management_List_Clicked(id)
		else:
			$"../../../../.."._on_Container_List_Clicked(id)
