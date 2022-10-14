extends Node

var id
var itemName

var type
var category

var weight

var value
var amount = 1

var alignment
var enchantment = null

var identifiedItemName
var unidentifiedItemName
var notIdentified = {
	"alignment": false,
	"enchantment": false
}

var stackable

func createItem(_item, _extraData = {}, _amount = 1):
	id = Globals.itemId
	name = str(id)
	Globals.itemId += 1
	
	if (
		(GlobalItemInfo.globalItemInfo.has(itemName) and GlobalItemInfo.globalItemInfo[itemName].identified) or
		_item.type.to_lower() == "comestible"
	):
		itemName = _item.itemName
	else:
		itemName = _item.unidentifiedItemName
	identifiedItemName = _item.itemName
	unidentifiedItemName = _item.unidentifiedItemName
	
	type = _item.type
	category = _item.category
	
	weight = _item.weight
	
	value = _item.value
	amount = _amount
	
	if _extraData.has("alignment"):
		alignment = _extraData.alignment
	else:
		if randi() % 5 == 0:
			if randi() % 2 == 0:
				alignment = "blessed"
			else:
				alignment = "cursed"
		else:
			alignment = "uncursed"
	
	if randi() % 8 == 1:
		if randi() % 2 == 1:
			enchantment = randi() % 2
		else:
			enchantment = -randi() % 2
	else:
		enchantment = 0
	
	if typeof(_item.value) == TYPE_DICTIONARY:
		if _item.value.has("charges"):
			var charges 
			if typeof(_item.value.charges) != TYPE_ARRAY and _item.value.charges == -1:
				charges = -1
			else:
				charges = randi() % _item.value.charges[1] + _item.value.charges[0]
			if _item.value.has("turnedOn"):
				value = {
					"turnedOn": false,
					"charges": charges,
					"value": _item.value.value
				}
			else:
				value = {
					"charges": charges
				}
		elif _item.value.has("worn"):
			value = {
				"worn": false
			}
	
	stackable = _item.stackable
	
	if _item.itemName.matchn("goldPieces"):
		if _item.amount < 48:
			$ItemSprite.texture = load("res://Assets/Miscellaneous/GoldPiecesLow.png")
		elif _item.amount < 320:
			$ItemSprite.texture = _item.texture
		else:
			$ItemSprite.texture = load("res://Assets/Miscellaneous/GoldPiecesHigh.png")
		return
	$ItemSprite.texture = _item.texture



###########################################
### Weapon damage calculation functions ###
###########################################

func getAttacks(_stats):
	var attacks = []
	var damageIncrease = calculateWeaponAttackIncrease(_stats)
	for _d in range(value.d + damageIncrease.d):
		attacks.append(
			{
				"dmg": [value.dmg[0] + damageIncrease.dmg, value.dmg[1] + damageIncrease.dmg],
				"bonusDmg": value.bonusDmg.append(enchantment),
				"armorPen": value.armorPen,
				"magicDmg": value.magicDmg
			}
		)
	return attacks

func calculateWeaponAttackIncrease(_stats):
	if category.matchn("sword"):
		return {
			"dmg": _stats.balance / 3,
			"d": 0
		}
	if category.matchn("two-hander"):
		return {
			"dmg": _stats.strength / 3,
			"d": 0
		}
	if category.matchn("dagger"):
		var _d = 0
		if _stats.legerity > 25:
			_d = 2
		elif _stats.legerity > 11:
			_d = 1
		return {
			"dmg": _stats.legerity / 5,
			"d": _d
		}
	if category.matchn("mace"):
		return {
			"dmg": (_stats.strength / 4) + (_stats.balance / 4),
			"d": 0
		}
	if category.matchn("flail"):
		var _d = 0
		if _stats.legerity > 22:
			_d = 3
		elif _stats.legerity > 15:
			_d = 2
		elif _stats.legerity > 8:
			_d = 1
		return {
			"dmg": _stats.legerity / 5,
			"d": 0
		}



###############################
### Miscellaneous functions ###
###############################

func createCorpse(_critterName, _weight, _items):
	var _item = _items.miscellaneousItems.corpse
	
	id = Globals.itemId
	name = str(id)
	Globals.itemId += 1
	
	itemName = "{critterName} {itemName}".format({ "critterName": _critterName, "itemName": "corpse"})
	
	type = _item.type
	
	weight = _weight
	
	stackable = _item.stackable
	
	$ItemSprite.texture = _item.texture

func getTexture():
	return $ItemSprite.texture

func checkItemIdentification():
	if GlobalItemInfo.globalItemInfo.has(identifiedItemName) and GlobalItemInfo.globalItemInfo[identifiedItemName].identified == true:
		itemName = identifiedItemName
		notIdentified.alignment = true
		notIdentified.enchantment = true

func identifyItem(_identifyName, _identifyAlignment, _identifyEnchantment):
	if _identifyName:
		itemName = identifiedItemName
	if _identifyAlignment:
		notIdentified.alignment = true
	if _identifyEnchantment:
		notIdentified.enchantment = true
