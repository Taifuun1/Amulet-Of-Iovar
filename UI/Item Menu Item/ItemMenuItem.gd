extends PanelContainer

var menuItemType

var id
var itemName
var unidentifiedItemName
var type
var piety
var enchantment
var stackable

func setValues(_item, _menuItemType, _hideChecked = false):
	id = _item.id
	name = str(_item.id)
	itemName = _item.itemName
	menuItemType = _menuItemType
	
	if _hideChecked:
		$ItemMenuItemContainer/CheckAndNameContainer/Check.hide()
	if _item.notIdentified.name or (GlobalItemInfo.globalItemInfo.has(_item.identifiedItemName) and GlobalItemInfo.globalItemInfo[_item.identifiedItemName].identified == true):
		$ItemMenuItemContainer/CheckAndNameContainer/Name.createRichTextLabel(_item.itemName, _item.rarity)
	else:
		$ItemMenuItemContainer/CheckAndNameContainer/Name.createRichTextLabel(_item.itemName)
	if _item.notIdentified.piety:
		$ItemMenuItemContainer/Piety.createRichTextLabel(_item.piety)
	else:
		$ItemMenuItemContainer/Piety.createRichTextLabel("?")
	if _item.notIdentified.enchantment:
		$ItemMenuItemContainer/Enchantment.createRichTextLabel(str(_item.enchantment))
	else:
		$ItemMenuItemContainer/Enchantment.createRichTextLabel("?")
	if _item.amount != null:
		$ItemMenuItemContainer/Amount.createRichTextLabel(str(_item.amount))
	else:
		$ItemMenuItemContainer/Amount.createRichTextLabel("?")


func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if menuItemType.matchn("item management"):
			if itemName.matchn("scroll of genocide"):
				$"../../../.."._on_Item_Management_List_Clicked(id, false)
			else:
				$"../../../.."._on_Item_Management_List_Clicked(id)
		else:
			$"../../../../.."._on_Container_List_Clicked(id)

func _on_ItemMenuItem_mouse_entered():
	var _panelStylebox = get_stylebox("panel").duplicate()
	_panelStylebox.set_border_color(Color("253f7c"))
	add_stylebox_override("panel", _panelStylebox)

func _on_ItemMenuItem_mouse_exited():
	var _panelStylebox = get_stylebox("panel").duplicate()
	_panelStylebox.set_border_color(Color("00000000"))
	add_stylebox_override("panel", _panelStylebox)
