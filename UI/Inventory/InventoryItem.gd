extends Node

var id
var itemName
var unidentifiedItemName
var type
var piety
var enchantment
var stackable

func setValues(_item):
	id = _item.id
	name = str(_item.id)
	
	if (
		(
			GlobalItemInfo.globalItemInfo.has(_item.identifiedItemName) and
			GlobalItemInfo.globalItemInfo[_item.identifiedItemName].identified == true
		) or
		_item.notIdentified.name
	):
		$Name.createRichTextLabel(_item.itemName, _item.rarity)
	else:
		$Name.createRichTextLabel(_item.itemName)
	if _item.notIdentified.piety:
		$Piety.createRichTextLabel(_item.piety)
	else:
		$Piety.createRichTextLabel("?")
	if _item.notIdentified.enchantment:
		$Enchantment.createRichTextLabel(str(_item.enchantment))
	else:
		$Enchantment.createRichTextLabel("?")
	if _item.amount:
		$Amount.createRichTextLabel(str(_item.amount))
