extends Node

var id
var itemName
var unidentifiedItemName
var type
var alignment
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
