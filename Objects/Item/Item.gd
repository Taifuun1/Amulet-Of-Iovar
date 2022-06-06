extends Node

var id
var itemName

var type
var category

var value

var alignment
var enchantment = null

var identifiedItemName
var unidentifiedItemName
var notIdentified = {
	"alignment": false,
	"enchantment": false
}

var stackable

func createItem(_item, _extraData = {}):
	id = Globals.itemId
	name = str(id)
	Globals.itemId += 1
	
	if GlobalItemInfo.globalItemInfo.has(itemName) and GlobalItemInfo.globalItemInfo[itemName].identified:
		itemName = _item.itemName
	else:
		itemName = _item.unidentifiedItemName
	identifiedItemName = _item.itemName
	unidentifiedItemName = _item.unidentifiedItemName
	
	type = _item.type
	category = _item.category
	
	value = _item.value
	
	if _extraData.has("alignment"):
		alignment = _extraData.alignment
	else:
		if randi() % 5 + 0 == 5:
			if randi() % 2 == 1:
				alignment = "Blessed"
			else:
				alignment = "Cursed"
		else:
			alignment = "Neutral"
	
	if randi() % 8 == 1:
		if randi() % 2 == 1:
			enchantment = randi() % 2
		else:
			enchantment = -randi() % 2
	else:
		enchantment = 0
	
	stackable = _item.stackable
	
	$ItemSprite.texture = _item.texture

func createCorpse(_critterName, _items):
	var _item = _items.miscellaneousItems[0]
	
	id = Globals.itemId
	name = str(id)
	Globals.itemId += 1
	
	itemName = "{critterName} {itemName}".format({ "critterName": _critterName, "itemName": "corpse"})
	
	type = _item.type
	category = _item.category
	
	value = _item.value
	
	if randi() % 5 + 0 == 5:
		if randi() % 2 == 1:
			alignment = "Blessed"
		else:
			alignment = "Cursed"
	else:
		alignment = "Neutral"
	
	enchantment = 0
	
	stackable = _item.stackable
	
	$ItemSprite.texture = _item.texture

func getAttacks():
	var attacks = []
	for d in range(value.d):
		attacks.append(((randi() % value.dmg[1] + value.dmg[0]) + enchantment) + value.bonusDmg.dmg)
	return attacks

func getTexture():
	return $ItemSprite.texture

func checkItemIdentification():
	if GlobalItemInfo.globalItemInfo.has(identifiedItemName) and GlobalItemInfo.globalItemInfo[identifiedItemName].identified == true:
		itemName = identifiedItemName
		notIdentified.alignment = true
		notIdentified.enchantment = true
