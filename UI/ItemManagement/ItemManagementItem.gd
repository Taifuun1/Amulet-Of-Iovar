extends Node

var id
var gridPosition
var itemName
var unidentifiedItemName
var type
var alignment
var enchantment
var stackable

var notIdentified = {
	"use": false,
	"alignment": false,
	"enchantment": false
}

func setValues(_item):
	id = _item.id
	name = str(_item.id)
	
	$Name.text = _item.itemName
	$Alignment.text = _item.alignment
	if _item.enchantment != null:
		$Enchantment.text = str(_item.enchantment)

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$"/root/World/UI/ItemManagement"._on_Item_Management_List_Clicked(id)
