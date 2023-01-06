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
	if _item.amount:
		$Amount.createRichTextLabel(str(_item.amount))
