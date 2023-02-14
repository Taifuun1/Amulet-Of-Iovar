extends Node

var id
var itemName

var type
var category
var rarity

var weight

var value
var points = null
var amount = 1

var piety
var enchantment = null

var identifiedItemName
var unidentifiedItemName
var itemTexture
var unidenfiedItemTexture
var notIdentified = {
	"name": false,
	"piety": false,
	"enchantment": false
}

var container = null
var containerWeight = null

var binds = null

var stackable

func createItem(_item, _extraData = {}, _amount = 1, _spawnNew = true):
	if _spawnNew:
		id = Globals.itemId
		Globals.itemId += 1
	else:
		id = _item.id
	name = str(id)
	
	if _item.itemName.matchn("corpse") and _item.itemName.length() == 6:
		itemName = "{critterName} {itemName}".format({ "critterName": _extraData.critterName, "itemName": "corpse"})
		unidentifiedItemName = "{critterName} {itemName}".format({ "critterName": _extraData.critterName, "itemName": "corpse"})
		notIdentified.name = true
	elif (
		_item.itemName.matchn("box") or
		_item.itemName.matchn("chest") or
		_item.type.matchn("comestible") or
		(
			GlobalItemInfo.globalItemInfo.has(_item.itemName) and
			GlobalItemInfo.globalItemInfo[_item.itemName].identified
		) or
		(
			_item.has("notIdentified") and
			_item.notIdentified.name == true
		)
	):
		itemName = _item.itemName
	else:
		itemName = _item.unidentifiedItemName
	if _item.has("identifiedItemName"):
		identifiedItemName = _item.identifiedItemName
	else:
		identifiedItemName = _item.itemName
	unidentifiedItemName = _item.unidentifiedItemName
	if _item.has("notIdentified"):
		notIdentified = _item.notIdentified
	
	type = _item.type
	category = _item.category
	if _item.has("rarity"):
		rarity = _item.rarity
	
	if _extraData.has("weight"):
		weight = _extraData.weight
	else:
		weight = int(_item.weight)
	
	if _item.has("container") and _item.container != null:
		addContainer({  }, _item.container)
	elif category != null and category.matchn("container"):
		addContainer(_extraData)
	
	value = _item.value
	if _item.has("points"):
		points = _item.points
	if typeof(_amount) == TYPE_ARRAY:
		amount = randi() % (_amount[1] - _amount[0]) + _amount[0]
	else:
		amount = int(_amount)
	
	if _item.has("piety"):
		piety = _item.piety
	elif _extraData.has("piety"):
		piety = _extraData.piety.capitalize()
	else:
		if randi() % 5 == 0:
			if randi() % 2 == 0:
				piety = "Reverent"
			else:
				piety = "Blasphemous"
		else:
			piety = "Formal"
	
	if _item.has("enchantment"):
		enchantment = _item.enchantment
	elif _item.has("enchantable") and _item.enchantable:
		if randi() % 8 == 1:
			if randi() % 2 == 1:
				enchantment = randi() % 4
			else:
				enchantment = -randi() % 4
		else:
			enchantment = 0
	else:
		enchantment = 0
	
	if typeof(_item.value) == TYPE_DICTIONARY:
		if _item.value.has("charges"):
			var charges 
			if typeof(_item.value.charges) != TYPE_ARRAY and _item.value.charges == -1:
				charges = -1
			elif typeof(_item.value.charges) != TYPE_ARRAY and _item.value.charges != -1:
				charges = _item.value.charges
			else:
				charges = randi() % int(_item.value.charges[1]) + int(_item.value.charges[0])
			if _item.value.has("turnedOn"):
				value = {
					"turnedOn": false,
					"charges": charges,
					"value": _item.value.value
				}
			elif _item.value.has("distance") and _item.value.has("dmg"):
				value = {
					"charges": charges,
					"distance": _item.value.distance,
					"dmg": _item.value.dmg
				}
			elif _item.value.has("distance"):
				value = {
					"charges": charges,
					"distance": _item.value.distance
				}
			elif _item.value.has("dmg"):
				value = {
					"charges": charges,
					"dmg": _item.value.dmg
				}
			else:
				value = {
					"charges": charges
				}
		elif _item.value.has("worn"):
			value = {
				"worn": false
			}
		elif _item.value.has("ink"):
			if typeof(_item.value.ink) == TYPE_ARRAY:
				value = {
					"ink": randi() % int(_item.value.ink[1]) + _item.value.ink[0]
				}
			else:
				value = _item.value
		elif _item.value.has("binds"):
			binds = {
				"type": _item.value.binds,
				"state": "Unbound"
			}
			if _item.value.binds.matchn("inventory"):
				binds.state = "Bound"
	
	stackable = _item.stackable
	
	if _item.itemName.matchn("goldPieces"):
		if _item.amount < 48:
			$ItemSprite.texture = load("res://Assets/Miscellaneous/GoldPiecesLow.png")
		elif _item.amount < 320:
			$ItemSprite.texture = _item.texture
		else:
			$ItemSprite.texture = load("res://Assets/Miscellaneous/GoldPiecesHigh.png")
		return
	
	if typeof(_item.texture) == TYPE_STRING:
		itemTexture = load(_item.texture)
		unidenfiedItemTexture = load(_item.unidentifiedTexture)
	else:
		itemTexture = _item.texture
		unidenfiedItemTexture = _item.unidentifiedTexture
	if (
		GlobalItemInfo.globalItemInfo.has(_item.itemName) and
		GlobalItemInfo.globalItemInfo[_item.itemName].identified
	):
		$ItemSprite.texture = itemTexture
	else:
		$ItemSprite.texture = unidenfiedItemTexture
	
	return id



###########################################
### Weapon damage calculation functions ###
###########################################

func getAttacks(_stats):
	var _attacks = []
	var _damageIncrease = calculateWeaponAttackIncrease(_stats)
	var _critterClass = $"/root/World/Critters/0".critterClass
	for _d in range(value.d + _damageIncrease.d):
		var _newDamage = value.dmg.duplicate(true)
		var _newBonusDamage = value.bonusDmg.duplicate(true)
		var _newMagicDamage = value.magicDmg.duplicate(true)
		if _critterClass.matchn("exterminator") and _newMagicDamage.element != null and _newMagicDamage.element.matchn("fleir"):
			_newMagicDamage.dmg[0] += 2
			_newMagicDamage.dmg[1] += 2
		elif _critterClass.matchn("freedom fighter") and _newMagicDamage.element != null and _newMagicDamage.element.matchn("gleeie'er"):
			_newMagicDamage.dmg[0] += 2
			_newMagicDamage.dmg[1] += 2
		elif _critterClass.matchn("rogue") and _newMagicDamage.element != null and _newMagicDamage.element.matchn("toxix"):
			_newMagicDamage.dmg[0] += 1
			_newMagicDamage.dmg[1] += 1
		if _critterClass.matchn("rogue") and category.matchn("dagger"):
			_newBonusDamage.classBonusDamage = 1
		var _earioMagicType = $"/root/World/UI/UITheme/Runes".isOnlyEarioEquipped()
		if typeof(_earioMagicType) != TYPE_BOOL and (_newMagicDamage.element == null or _newMagicDamage.element.matchn(_earioMagicType)):
			_newMagicDamage.dmg[0] += 1
			_newMagicDamage.dmg[1] += 1
			_newMagicDamage.element = _earioMagicType.capitalize()
		_attacks.append(
			{
				"dmg": [_newDamage[0] + _damageIncrease.dmg, _newDamage[1] + _damageIncrease.dmg],
				"bonusDmg": _newBonusDamage,
				"armorPen": value.armorPen,
				"magicDmg": _newMagicDamage
			}
		)
	return _attacks

func calculateWeaponAttackIncrease(_stats):
	var _playerSkills = $"/root/World/Critters/0".skills
	var _critterClass = $"/root/World/Critters/0".critterClass
	var _dualWielding =$"/root/World/UI/UITheme/Equipment".dualWielding
	if category.matchn("sword"):
		var _dmg
		var _additionalDamage = 0
		var _d = 0
		
		if _critterClass.matchn("mercenary"):
			_additionalDamage += 1
		
		if _playerSkills.sword.level == 3:
			_additionalDamage += 3
		elif _playerSkills.sword.level == 2:
			_additionalDamage += 2
		elif _playerSkills.sword.level == 1:
			_additionalDamage += 1
		
		_dmg = int(_stats.balance / 7 + _additionalDamage)
		
		if _dualWielding and _playerSkills["dualWield"].level < 2:
			_dmg -= 4
		elif _dualWielding and _playerSkills["dualWield"].level < 3:
			_dmg -= 3
		elif _dualWielding and _playerSkills["dualWield"].level == 3:
			_dmg -= 2
		
		return {
			"dmg": _dmg,
			"d": _d
		}
	if category.matchn("two-hander"):
		var _dmg
		var _additionalDamage = 0
		
		if _critterClass.matchn("mercenary"):
			_additionalDamage += 1
		
		if _playerSkills["two-hander"].level == 3:
			_additionalDamage += 5
		elif _playerSkills["two-hander"].level == 2:
			_additionalDamage += 2
		elif _playerSkills["two-hander"].level == 0:
			_additionalDamage -= 2
		
		_dmg = int(_stats.strength / 10 + _additionalDamage)
		
		return {
			"dmg": _dmg,
			"d": 0
		}
	if category.matchn("dagger"):
		var _dmg
		var _additionalDamage = 0
		var _d = 0
		
		if _critterClass.matchn("mercenary"):
			_additionalDamage += 1
		
		if _playerSkills.dagger.level == 3:
			_additionalDamage += 1
			_d += 1
		elif _playerSkills.dagger.level == 2:
			_additionalDamage += 1
		elif _playerSkills.dagger.level == 0:
			_additionalDamage -= 1
		
		if _stats.legerity > 29:
			_d += 2
		elif _stats.legerity > 19:
			_d += 1
		
		_dmg = int(_stats.legerity / 8 + _additionalDamage)
		
		if _dualWielding and _playerSkills["dualWield"].level < 1:
			_dmg -= 3
		elif _dualWielding and _playerSkills["dualWield"].level < 2:
			_dmg -= 2
		elif _dualWielding and _playerSkills["dualWield"].level < 3:
			_dmg -= 1
		
		return {
			"dmg": _dmg,
			"d": _d
		}
	if category.matchn("mace"):
		var _dmg
		var _additionalDamage = 0
		
		if _critterClass.matchn("mercenary"):
			_additionalDamage += 1
		
		if _playerSkills.mace.level == 3:
			_additionalDamage += 6
		elif _playerSkills.mace.level == 2:
			_additionalDamage += 3
		elif _playerSkills.mace.level == 1:
			_additionalDamage += 1
		elif _playerSkills.mace.level == 0:
			_additionalDamage -= 1
		
		_dmg = int((_stats.strength / 8) + (_stats.balance / 8) + _additionalDamage)
		
		if _dualWielding and _playerSkills["dualWield"].level < 2:
			_dmg -= 5
		elif _dualWielding and _playerSkills["dualWield"].level < 3:
			_dmg -= 4
		elif _dualWielding and _playerSkills["dualWield"].level == 3:
			_dmg -= 3
		
		return {
			"dmg": _dmg,
			"d": 0
		}
	if category.matchn("flail"):
		var _dmg
		var _additionalDamage = 0
		var _d = 0
		
		if _critterClass.matchn("mercenary"):
			_additionalDamage += 1
		
		if _playerSkills.flail.level == 3:
			_d += 2
		elif _playerSkills.flail.level == 2:
			_d += 1
		elif _playerSkills.flail.level == 0:
			_d -= 1
		
		if _stats.legerity > 31:
			_d += 3
		elif _stats.legerity > 22:
			_d += 2
		elif _stats.legerity > 15:
			_d += 1
		
		_dmg = int(_stats.legerity / 15 + _additionalDamage)
		
		if _dualWielding and _playerSkills["dualWield"].level < 2:
			_dmg -= 3
		elif _dualWielding and _playerSkills["dualWield"].level < 3:
			_dmg -= 2
		elif _dualWielding and _playerSkills["dualWield"].level == 3:
			_dmg -= 1
		
		return {
			"dmg": _dmg,
			"d": _d
		}



###############################
### Miscellaneous functions ###
###############################

func getTexture():
	return $ItemSprite.texture

func checkItemIdentification():
	if GlobalItemInfo.globalItemInfo.has(identifiedItemName) and GlobalItemInfo.globalItemInfo[identifiedItemName].identified == true:
		itemName = identifiedItemName
		$ItemSprite.texture = itemTexture

func identifyItem(_identifyName, _identifyPiety, _identifyEnchantment):
	if _identifyName:
		itemName = identifiedItemName
		$ItemSprite.texture = itemTexture
		notIdentified.name = true
		if (
			GlobalItemInfo.globalItemInfo.has(identifiedItemName) and
			!GlobalItemInfo.globalItemInfo[identifiedItemName].identified
		):
			GlobalItemInfo.globalItemInfo[identifiedItemName].identified = true
	if _identifyPiety:
		notIdentified.piety = true
	if _identifyEnchantment:
		notIdentified.enchantment = true

func addContainer(_extraData = {  }, _containerContents = []):
	container = _containerContents
	containerWeight = weight
	
	if _extraData.has("randomSpawn") and _extraData.randomSpawn == true:
		if randi() % 9 == 0:
			for _index in randi() % 3 + 1:
				container.append($"/root/World/Items/Items".createItem($"/root/World/Items/Items".getRandomItem(true), Vector2(0,0), 1, false, {  }, null))
		elif randi() % 2 == 0:
			container.append($"/root/World/Items/Items".createItem($"/root/World/Items/Items".getRandomItem(true), Vector2(0,0), 1, false, {  }, null))
		if randi() % 3 == 0:
			container.append($"/root/World/Items/Items".createItem("goldPieces", Vector2(0,0), randi() % 57 + 1, false, {  }, null))
	elif _extraData.has("specificSpawn"):
		container.append($"/root/World/Items/Items".createItem($"/root/World/Items/Items".getRandomItemByItemTypes(_extraData.specificSpawn, true), Vector2(0,0), 1, false, {  }, null))

func getItemSaveData():
	return {
		id = id,
		itemName = itemName,
		type = type,
		category = category,
		rarity = rarity,
		weight = weight,
		value = value,
		points = points,
		amount = amount,
		piety = piety,
		enchantment = enchantment,
		identifiedItemName = identifiedItemName,
		unidentifiedItemName = unidentifiedItemName,
		texture = itemTexture.get_path(),
		unidentifiedTexture = unidenfiedItemTexture.get_path(),
		notIdentified = notIdentified,
		container = container,
		containerWeight = containerWeight,
		binds = binds,
		stackable = stackable
	}
