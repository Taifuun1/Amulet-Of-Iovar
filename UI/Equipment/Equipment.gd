extends Control

var equipmentItem = load("res://UI/Equipment/Equipment Item.tscn")

const equipmentUITemplatePaths = {
	"lefthand": "res://Assets/UI/EquipmentHand.png",
	"righthand": "res://Assets/UI/EquipmentHand.png",
	"amulet": "res://Assets/UI/EquipmentAmulet.png",
	"ring1": "res://Assets/UI/EquipmentRing.png",
	"ring2": "res://Assets/UI/EquipmentRing.png",
	"helmet": "res://Assets/UI/EquipmentHelmet.png",
	"cloak": "res://Assets/UI/EquipmentCloak.png",
	"plate": "res://Assets/UI/EquipmentPlate.png",
	"gauntlets": "res://Assets/UI/EquipmentGauntlets.png",
	"belt": "res://Assets/UI/EquipmentBelt.png",
	"greaves": "res://Assets/UI/EquipmentGreaves.png",
	"boots": "res://Assets/UI/EquipmentBoots.png"
}

var hands = {
	"lefthand": null,
	"righthand": null
}

var accessories = {
	"amulet": null,
	"ring1": null,
	"ring2": null
}

var equipment = {
	"helmet": null,
	"cloak": null,
	"plate": null,
	"gauntlets": null,
	"belt": null,
	"greaves": null,
	"boots": null
}

var armorSets = {
	"frost": {
		"allPieces": false,
		"pieces": {
			"Cold breeze": false,
			"Frozen mail": false,
			"Chilly boots": false
		}
	},
	"fleir": {
		"allPieces": false,
		"pieces": {
			"Burning gauntlets": false,
			"Burning shield": false,
			"Burning mail chausses": false
		}
	},
	"thunder": {
		"allPieces": false,
		"pieces": {
			"Thunderous roar": false,
			"Thunder mail": false,
			"Thunder greaves": false
		}
	},
	"gleeie'er": {
		"allPieces": false,
		"pieces": {
			"Mossy helmet": false,
			"Garden gloves": false,
			"Slithery belt": false
		}
	},
	"toxix": {
		"allPieces": false,
		"pieces": {
			"Fumy cloth": false,
			"Venom riders": false
		}
	}
}

var dualWielding = false

var hoveredEquipment = null

func sortEquipment(_equipmentIdA, _equipmentIdB):
	if get_node("/root/World/Items/{itemId}".format({ "itemId": _equipmentIdA })).itemName < get_node("/root/World/Items/{itemId}".format({ "itemId": _equipmentIdB })).itemName:
		return true
	return false

func create():
	name = "Equipment"
	hide()

func _process(_delta):
	if Input.is_action_just_released("RIGHT_CLICK") and hoveredEquipment != null:
		var _item
		if (
			hoveredEquipment.matchn("lefthand") or
			hoveredEquipment.matchn("righthand")
		):
			if hands[hoveredEquipment.to_lower()] != null:
				_item = get_node("/root/World/Items/{id}".format({ "id": hands[hoveredEquipment.to_lower()] }))
		elif (
				hoveredEquipment.matchn("ring1") or
				hoveredEquipment.matchn("ring2") or
				hoveredEquipment.matchn("amulet")
		):
			if accessories[hoveredEquipment.to_lower()] != null:
				_item = get_node("/root/World/Items/{id}".format({ "id": accessories[hoveredEquipment.to_lower()] }))
		elif (
			hoveredEquipment.matchn("helmet") or
			hoveredEquipment.matchn("cloak") or
			hoveredEquipment.matchn("plate") or
			hoveredEquipment.matchn("gauntlets") or
			hoveredEquipment.matchn("belt") or
			hoveredEquipment.matchn("greaves") or
			hoveredEquipment.matchn("boots")
		):
			if equipment[hoveredEquipment.to_lower()] != null:
				_item = get_node("/root/World/Items/{id}".format({ "id": equipment[hoveredEquipment.to_lower()] }))
		if _item != null:
			var _matchingType = checkIfMatchingEquipmentAndSlot(_item.type, _item.category)
			var _changed = false
			if _matchingType == null:
				return
			elif _item.binds != null and _item.binds.type.matchn("equipment") and _item.binds.state.matchn("bound"):
				Globals.gameConsole.addLog("The {item} is bound to you.".format({ "item": _item.itemName }))
			elif _matchingType.matchn("weapon"):
				if _item.category.matchn("two-hander"):
					if hands["lefthand"] == hands["righthand"] and hands["lefthand"] != null and hands["righthand"] != null:
						hands["lefthand"] = null
						hands["righthand"] = null
						$"EquipmentContainer/LeftHand/Sprite".texture = load(equipmentUITemplatePaths[hoveredEquipment.to_lower()])
						$"EquipmentContainer/RightHand/Sprite".texture = load(equipmentUITemplatePaths[hoveredEquipment.to_lower()])
						_changed = true
				else:
					if hands[hoveredEquipment.to_lower()] != null:
						_changed = true
					hands[hoveredEquipment.to_lower()] = null
					get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = load(equipmentUITemplatePaths[hoveredEquipment.to_lower()])
				if (
					hands.lefthand == null or
					hands.righthand == null or
					hands.lefthand == hands.righthand or
					get_node("/root/World/Items/{itemId}".format({ "itemId": hands.lefthand })).category.matchn("shield") or
					get_node("/root/World/Items/{itemId}".format({ "itemId": hands.righthand })).category.matchn("shield")
				):
					dualWielding = false
			elif _matchingType.matchn("armor"):
				if equipment[hoveredEquipment.to_lower()] != null:
					_changed = true
				equipment[hoveredEquipment.to_lower()] = null
				get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = load(equipmentUITemplatePaths[hoveredEquipment.to_lower()])
				checkWhatIsWorn(_item)
			elif _matchingType.matchn("accessory"):
				if accessories[hoveredEquipment.to_lower()] != null:
					_changed = true
				accessories[hoveredEquipment.to_lower()] = null
				get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = load(equipmentUITemplatePaths[hoveredEquipment.to_lower()])
				checkWhatIsWorn(_item)
			if _item.category.matchn("amulet"):
				var panelStylebox = get_node("EquipmentContainer/{equipment}".format({ "equipment": hoveredEquipment })).get_stylebox("panel").duplicate()
				panelStylebox.set_border_width_all(0)
				panelStylebox.set_border_color(Color(1, 0, 0, 0))
				get_node("EquipmentContainer/{equipment}".format({ "equipment": hoveredEquipment })).add_stylebox_override("panel", panelStylebox)
			
			checkArmorSetPieces()
			$"/root/World/Critters/0".calculateEquipmentStats()
			$"/root/World/Critters/0".checkAllIdentification(true)
			if _changed:
				$"/root/World".processGameTurn()

func showEquipment(_items):
	_items.sort_custom(self, "sortEquipment")
	for _item in _items:
		var _newItem = equipmentItem.instance()
		_newItem.setValues(get_node("/root/World/Items/{item}".format({ "item": _item })))
		$ItemsContainer/ItemsContentContainer/ItemList.add_child(_newItem)
	show()

func hideEquipment():
	for _item in $ItemsContainer/ItemsContentContainer/ItemList.get_children():
		_item.queue_free()
	hide()

func setEquipment(_id):
	var _item = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _matchingType = checkIfMatchingEquipmentAndSlot(_item.type, _item.category)
	if _matchingType == null:
		return
	
	var _oldItem
	if _matchingType.matchn("weapon") and hands[hoveredEquipment.to_lower()] != null:
		_oldItem = get_node("/root/World/Items/{id}".format({ "id": hands[hoveredEquipment.to_lower()] }))
	elif _matchingType.matchn("accessory") and accessories[hoveredEquipment.to_lower()] != null:
		_oldItem = get_node("/root/World/Items/{id}".format({ "id": accessories[hoveredEquipment.to_lower()] }))
	elif _matchingType.matchn("armor") and equipment[hoveredEquipment.to_lower()] != null:
		_oldItem = get_node("/root/World/Items/{id}".format({ "id": equipment[hoveredEquipment.to_lower()] }))
	
	if _oldItem != null and _oldItem.binds != null and _oldItem.binds.type.matchn("equipment") and _oldItem.binds.state.matchn("bound"):
		Globals.gameConsole.addLog("The {item} is bound to you.".format({ "item": _oldItem.itemName }))
		return
	elif _matchingType.matchn("weapon"):
		if hands["lefthand"] == hands["righthand"] and hands["lefthand"] != null and hands["righthand"] != null:
			hands["lefthand"] = null
			hands["righthand"] = null
			$"EquipmentContainer/LeftHand/Sprite".texture = load(equipmentUITemplatePaths["lefthand"])
			$"EquipmentContainer/RightHand/Sprite".texture = load(equipmentUITemplatePaths["righthand"])
		if _item.category.matchn("Two-hander"):
			hands["lefthand"] = _item.id
			hands["righthand"] = _item.id
			$"EquipmentContainer/LeftHand/Sprite".texture = _item.getTexture()
			$"EquipmentContainer/RightHand/Sprite".texture = _item.getTexture()
		elif hands["lefthand"] != _item.id and hands["righthand"] != _item.id:
			hands[hoveredEquipment.to_lower()] = _item.id
			get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
			if _oldItem != null:
				checkWhatIsWorn(_oldItem)
			checkWhatIsWorn(_item)
	elif _matchingType.matchn("accessory"):
		var _alreadyEquipped = false
		for _accessory in accessories:
			if accessories[_accessory] != null and accessories[_accessory] == _item.id:
				_alreadyEquipped = true
		if !_alreadyEquipped:
			accessories[hoveredEquipment.to_lower()] = _item.id
			get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
			if _oldItem != null:
				checkWhatIsWorn(_oldItem)
			checkWhatIsWorn(_item)
	elif _matchingType.matchn("armor"):
		equipment[hoveredEquipment.to_lower()] = _item.id
		get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
		if _oldItem != null:
			checkWhatIsWorn(_oldItem)
		checkWhatIsWorn(_item)
	for _listItem in $ItemsContainer/ItemsContentContainer/ItemList.get_children():
		if _item.itemName.matchn(_listItem.item.itemName):
			_listItem.updateValues(_item.itemName)
	if _item.binds != null and _item.binds.type.matchn("equipment"):
		_item.binds = {
			"type": _item.value.binds,
			"state": "Bound"
		}
#		var panelStylebox = get_node("EquipmentContainer/{equipment}".format({ "equipment": hoveredEquipment })).get_stylebox("panel").duplicate()
#		panelStylebox.set_border_width_all(1)
#		panelStylebox.set_border_color(Color(1, 0, 0))
#		get_node("EquipmentContainer/{equipment}".format({ "equipment": hoveredEquipment })).add_stylebox_override("panel", panelStylebox)
	if $"/root/World/Critters/0".attacks.size() == 0:
		$"/root/World/Critters/0".attacks = [
			{
				"dmg": [int(1 + $"/root/World/Critters/0".stats.strength / 6), int(1 + $"/root/World/Critters/0".stats.strength / 6)],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		]
	if (
		hands.lefthand != null and
		hands.righthand != null and
		hands.lefthand != hands.righthand and
		!get_node("/root/World/Items/{itemId}".format({ "itemId": hands.lefthand })).category.matchn("shield") and
		!get_node("/root/World/Items/{itemId}".format({ "itemId": hands.righthand })).category.matchn("shield")
	):
		dualWielding = true
	checkArmorSetPieces()
	$"/root/World/Critters/0".calculateEquipmentStats()
	$"/root/World/Critters/0".checkAllIdentification(true)
	$"/root/World".processGameTurn()

func takeOfEquipmentWhenDroppingItem(_id):
	checkIfEquipmentNeedsToBeUnequipped(_id)
	checkArmorSetPieces()
	$"/root/World/Critters/0".calculateEquipmentStats()
	$"/root/World/Critters/0".checkAllIdentification(true)

func checkIfEquipmentNeedsToBeUnequipped(_id):
	var _item = get_node("/root/World/Items/{id}".format({ "id": _id }))
	if _item.binds != null and _item.binds.type.matchn("equipment") and _item.binds.state.matchn("bound"):
		Globals.gameConsole.addLog("The {item} is bound to you.".format({ "item": _item.itemName }))
		return
	if hands["lefthand"] == hands["righthand"] and hands["lefthand"] != null and hands["righthand"] != null and hands["righthand"] == _id and hands["lefthand"] == _id:
		hands["lefthand"] = null
		hands["righthand"] = null
		$"EquipmentContainer/LeftHand/Sprite".texture = load(equipmentUITemplatePaths["lefthand"])
		$"EquipmentContainer/RightHand/Sprite".texture = load(equipmentUITemplatePaths["righthand"])
	for _hand in hands.keys():
		if hands[_hand] == _id:
			hands[_hand] = null
			if _hand == "righthand":
				get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,4) + _hand[5].to_upper() + _hand.substr(6,-1) })).texture = load(equipmentUITemplatePaths[_hand.to_lower()])
			else:
				get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,3) + _hand[4].to_upper() + _hand.substr(5,-1) })).texture = load(equipmentUITemplatePaths[_hand.to_lower()])
			if (
				hands.lefthand == null or
				hands.righthand == null or
				hands.lefthand == hands.righthand or
				get_node("/root/World/Items/{itemId}".format({ "itemId": hands.lefthand })).category.matchn("shield") or
				get_node("/root/World/Items/{itemId}".format({ "itemId": hands.righthand })).category.matchn("shield")
			):
				dualWielding = false
			return
	for _accessory in accessories.keys():
		if accessories[_accessory] == _id:
			accessories[_accessory] = null
			get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": _accessory[0].to_upper() + _accessory.substr(1,-1) })).texture = load(equipmentUITemplatePaths[_accessory.to_lower()])
			checkWhatIsWorn(_item)
			return
	for _equipment in equipment.keys():
		if equipment[_equipment] == _id:
			equipment[_equipment] = null
			get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": _equipment.capitalize() })).texture = load(equipmentUITemplatePaths[_equipment.to_lower()])
			checkWhatIsWorn(_item)
			return

func getArmorClass():
	var _ac = 0
	if equipment["helmet"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["helmet"] }))
		if _item.value.armorClass.has("physical"):
			_ac += _item.value.armorClass.physical + _item.enchantment
	if equipment["cloak"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["cloak"] }))
		if _item.value.armorClass.has("physical"):
			_ac += _item.value.armorClass.physical + _item.enchantment
	if equipment["plate"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["plate"] }))
		if _item.value.armorClass.has("physical"):
			_ac += _item.value.armorClass.physical + _item.enchantment
	if equipment["gauntlets"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["gauntlets"] }))
		if _item.value.armorClass.has("physical"):
			_ac += _item.value.armorClass.physical + _item.enchantment
	if equipment["greaves"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["greaves"] }))
		if _item.value.armorClass.has("physical"):
			_ac += _item.value.armorClass.physical + _item.enchantment
	if equipment["boots"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["boots"] }))
		if _item.value.armorClass.has("physical"):
			_ac += _item.value.armorClass.physical + _item.enchantment
	if hands["lefthand"] != null and get_node("/root/World/Items/{id}".format({ "id": hands["lefthand"] })).category.matchn("shield"):
		var _item = get_node("/root/World/Items/{id}".format({ "id": hands["lefthand"] }))
		if _item.value.armorClass.has("physical"):
			_ac += _item.value.armorClass.physical + _item.enchantment
	if hands["righthand"] != null and get_node("/root/World/Items/{id}".format({ "id": hands["righthand"] })).category.matchn("shield"):
		var _item = get_node("/root/World/Items/{id}".format({ "id": hands["righthand"] }))
		if _item.value.armorClass.has("physical"):
			_ac += _item.value.armorClass.physical + _item.enchantment
	if accessories["ring1"] != null and get_node("/root/World/Items/{id}".format({ "id": accessories["ring1"] })).category.matchn("ring"):
		if get_node("/root/World/Items/{id}".format({ "id": accessories["ring1"] })).identifiedItemName.matchn("ring of protection"):
			_ac += get_node("/root/World/Items/{id}".format({ "id": accessories["ring1"] })).value
	if accessories["ring2"] != null and get_node("/root/World/Items/{id}".format({ "id": accessories["ring2"] })).category.matchn("ring"):
		if get_node("/root/World/Items/{id}".format({ "id": accessories["ring2"] })).identifiedItemName.matchn("ring of protection"):
			_ac += get_node("/root/World/Items/{id}".format({ "id": accessories["ring2"] })).value
	return _ac

func getMagicArmorClass():
	var _magicac = 0
	if equipment["helmet"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["helmet"] }))
		if _item.value.armorClass.has("magic"):
			_magicac += _item.value.armorClass.magic + _item.enchantment
	if equipment["cloak"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["cloak"] }))
		if _item.value.armorClass.has("magic"):
			_magicac += _item.value.armorClass.magic + _item.enchantment
	if equipment["plate"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["plate"] }))
		if _item.value.armorClass.has("magic"):
			_magicac += _item.value.armorClass.magic + _item.enchantment
	if equipment["gauntlets"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["gauntlets"] }))
		if _item.value.armorClass.has("magic"):
			_magicac += _item.value.armorClass.magic + _item.enchantment
	if equipment["greaves"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["greaves"] }))
		if _item.value.armorClass.has("magic"):
			_magicac += _item.value.armorClass.magic + _item.enchantment
	if equipment["boots"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["boots"] }))
		if _item.value.armorClass.has("magic"):
			_magicac += _item.value.armorClass.magic + _item.enchantment
	if hands["lefthand"] != null and get_node("/root/World/Items/{id}".format({ "id": hands["lefthand"] })).category.matchn("shield"):
		var _item = get_node("/root/World/Items/{id}".format({ "id": hands["lefthand"] }))
		if _item.value.armorClass.has("magic"):
			_magicac += _item.value.armorClass.magic + _item.enchantment
	if hands["righthand"] != null and get_node("/root/World/Items/{id}".format({ "id": hands["righthand"] })).category.matchn("shield"):
		var _item = get_node("/root/World/Items/{id}".format({ "id": hands["righthand"] }))
		if _item.value.armorClass.has("magic"):
			_magicac += _item.value.armorClass.magic + _item.enchantment
	return _magicac

func checkArmorSetPieces():
	for _set in armorSets:
		var _allArmorSetPiecesWorn = true
		for _piece in armorSets[_set].pieces:
			var _armorPieceWorn = false
			armorSets[_set].pieces[_piece] = false
			for _itemId in hands.values():
				if _itemId != null and get_node("/root/World/Items/{id}".format({ "id": _itemId })).identifiedItemName.matchn(_piece):
					armorSets[_set].pieces[_piece] = true
					_armorPieceWorn = true
			for _itemId in accessories.values():
				if _itemId != null and get_node("/root/World/Items/{id}".format({ "id": _itemId })).identifiedItemName.matchn(_piece):
					armorSets[_set].pieces[_piece] = true
					_armorPieceWorn = true
			for _itemId in equipment.values():
				if _itemId != null and get_node("/root/World/Items/{id}".format({ "id": _itemId })).identifiedItemName.matchn(_piece):
					armorSets[_set].pieces[_piece] = true
					_armorPieceWorn = true
			if !_armorPieceWorn:
				_allArmorSetPiecesWorn = false
		armorSets[_set].allPieces = _allArmorSetPiecesWorn
		if armorSets[_set].allPieces:
			if _set.matchn("frost"):
				Globals.gameConsole.addLog("The frozen armor steams with cold!")
			if _set.matchn("fleir"):
				Globals.gameConsole.addLog("The burning armor flares!")
			if _set.matchn("thunder"):
				Globals.gameConsole.addLog("The sizzly armor crackles!")
			if _set.matchn("gleeie'er"):
				Globals.gameConsole.addLog("The mossy armor looks livelier!")
			if _set.matchn("toxix"):
				Globals.gameConsole.addLog("The slithery armor fizzles aggressively!")

func checkWhatIsWorn(_item):
	if (
		GlobalItemInfo.globalItemInfo.has(_item.identifiedItemName) and
		GlobalItemInfo.globalItemInfo[_item.identifiedItemName].identified == false
	):
		GlobalItemInfo.globalItemInfo[_item.identifiedItemName].identified = true
		_item.notIdentified.name = true
		Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _item.identifiedItemName, "unidentifiedItemName": _item.unidentifiedItemName }))
	var _playerNode = $"/root/World/Critters/0"
	match _item.identifiedItemName.to_lower():
		"amulet of seeing":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.statusEffects["seeing"] = 0
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("It feels like you can't see at all.")
			else:
				_playerNode.statusEffects["seeing"] = -1
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("You can see everything!")
		"amulet of magic power":
			if _playerNode.itemsTurnedOn.has(_item.id):
				$"/root/World/UI/UITheme/Runes".bonusMagicDmg -= 3
				_playerNode.itemsTurnedOn.erase(_item.id)
				$"/root/World/UI/UITheme/Runes".calculateMagicDamage()
				Globals.gameConsole.addLog("Your magic energy subsides.")
			else:
				$"/root/World/UI/UITheme/Runes".bonusMagicDmg += 3
				_playerNode.itemsTurnedOn.append(_item.id)
				$"/root/World/UI/UITheme/Runes".calculateMagicDamage()
				Globals.gameConsole.addLog("Your magic energy surges!")
		"amulet of life power":
			if _playerNode.itemsTurnedOn.has(_item.id):
				$"/root/World/Critters/0".maxhp -= 12
				if $"/root/World/Critters/0".hp > $"/root/World/Critters/0".maxhp:
					$"/root/World/Critters/0".hp = $"/root/World/Critters/0".maxhp
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your life energy feels weaker.")
			else:
				$"/root/World/Critters/0".maxhp += 12
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your life energy feels stronger.")
		"amulet of backscattering":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				_playerNode.statusEffects.backscattering = 0
				Globals.gameConsole.addLog("Your feel an energy field dissipate around you.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				_playerNode.statusEffects.backscattering = -1
				Globals.gameConsole.addLog("Your feel an energy field around you.")
		"amulet of strangulation":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("You can breath agane.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("The amulet strangles you!")
		"amulet of toxix":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				_playerNode.statusEffects.toxix = 0
				Globals.gameConsole.addLog("You don't feel sick anymore.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				_playerNode.statusEffects.toxix = -1
				Globals.gameConsole.addLog("You feel terrible!")
		"amulet of sleep":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				_playerNode.statusEffects.sleep = 0
				Globals.gameConsole.addLog("You don't feel sleepy anymore.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				_playerNode.statusEffects.sleep = 10
				Globals.gameConsole.addLog("Your eyelids feel heavy.")
		"ring of slow digestion":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.statusEffects["slow digestion"] = 0
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your belly feels faster.")
			else:
				_playerNode.statusEffects["slow digestion"] = -1
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your belly feels constant.")
		"ring of fast digestion":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.statusEffects["fast digestion"] = 0
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your belly feels normal.")
			else:
				_playerNode.statusEffects["fast digestion"] = -1
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your belly feels like it has a hole.")
		"ring of regen":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.statusEffects["regen"] = 0
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your skin feels more stable.")
			else:
				_playerNode.statusEffects["regen"] = -1
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your skin tingles.")
		"ring of fumbling":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.statusEffects["fumbling"] = 0
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your legs feel steady.")
			else:
				_playerNode.statusEffects["fumbling"] = -1
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your legs feel like jelly.")
		"blue dragon scale mail":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("You feel lame.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("You feel really cool.")
		"green dragon scale mail":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("You feel still.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("You feel windy.")
		"red dragon scale mail":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("You feel temperate.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("You feel fiery.")
		"yellow dragon scale mail":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("You feel cloudless.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("You feel stormy.")
		"violet dragon scale mail":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("You feel uncooked.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("You feel bubbly.")
		"justice'eer shield":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.statusEffects["backscattering"] = 0
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("You seem so dim.")
			else:
				_playerNode.statusEffects["backscattering"] = -1
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("You shine brightly!")
		"boots of magic":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your legs feel normal.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your legs feel magical.")
		"boots of fumbling":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.statusEffects["fumbling"] = 0
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("You feel like you're in control again.")
			else:
				_playerNode.statusEffects["fumbling"] = -1
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Its like your legs have a mind of their own!")
		"belt of plato":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your feel very dumb.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your feel very wise.")
		"belt of faith":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your feel like you don't believe in anything.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your feel a rapturous faith fill you.")
		"belt of symmetry":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your feel ugly.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your feel very photogenetic.")
		"toga":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("You feel very casual.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("You feel very formal.")
		"alchemists robes":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("You feel a little more sane.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("You feel like you could transmute anything.")
		"cloak of displacement":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.statusEffects["displacement"] = 0
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your feel like you're in one piece again.")
			else:
				_playerNode.statusEffects["displacement"] = -1
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your feel like you're all over the place.")
		"cloak of magical ambiguity":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("You feel magically normal.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your feel strangely ambivalent about magic.")
		"fabric gloves":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your hands feel coarse.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("The gloves feel very soft.")
		"gauntlets of devastation":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your feel like a weak sausage.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your feel like you can lift the world!")
		"gauntlets of nimbleness":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your feel a little clumsy.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your feel like an elf.")
		"gauntlets of balance":
			if _playerNode.itemsTurnedOn.has(_item.id):
				_playerNode.itemsTurnedOn.erase(_item.id)
				Globals.gameConsole.addLog("Your feel imbalanced.")
			else:
				_playerNode.itemsTurnedOn.append(_item.id)
				Globals.gameConsole.addLog("Your feel like a dwarf.")
	_playerNode.checkAllIdentification(true)

func checkIfMatchingEquipmentAndSlot(_type, _category):
	if _type.matchn("weapon"):
		if (
			(
				_category.matchn("sword") or
				_category.matchn("two-hander") or
				_category.matchn("dagger") or
				_category.matchn("mace") or
				_category.matchn("flail")
			) and
			(
				hoveredEquipment.matchn("lefthand") or
				hoveredEquipment.matchn("righthand")
			)
		):
			return "Weapon"
	elif _type.matchn("accessory"):
		if (
			_category.matchn("ring") and
			(
				hoveredEquipment.matchn("ring1") or
				hoveredEquipment.matchn("ring2")
			)
		):
			return "Accessory"
		if (
			_category.matchn("amulet") and
			hoveredEquipment.matchn("amulet")
		):
			return "Accessory"
	elif _type.matchn("armor"):
		if (
			_category.matchn("helmet") and
			hoveredEquipment.matchn("helmet")
		):
			return "Armor"
		if (
			_category.matchn("cloak") and
			hoveredEquipment.matchn("cloak")
		):
			return "Armor"
		if (
			_category.matchn("plate") and
			hoveredEquipment.matchn("plate")
		):
			return "Armor"
		if (
			_category.matchn("gauntlets") and
			hoveredEquipment.matchn("gauntlets")
		):
			return "Armor"
		if (
			_category.matchn("shield") and
			(
				hoveredEquipment.matchn("lefthand") or
				hoveredEquipment.matchn("righthand")
			)
		):
			return "Weapon"
		if (
			_category.matchn("belt") and
			hoveredEquipment.matchn("belt")
		):
			return "Armor"
		if (
			_category.matchn("greaves") and
			hoveredEquipment.matchn("greaves")
		):
			return "Armor"
		if (
			_category.matchn("boots") and
			hoveredEquipment.matchn("boots")
		):
			return "Armor"
	return null

func loadEquipmentData(_data):
	hands = _data.hands
	equipment = _data.equipment
	accessories = _data.accessories
	armorSets = _data.armorSets
	
	setEquipmentTextures()

func setEquipmentTextures():
	for _hand in hands.keys():
		if hands[_hand] != null:
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": hands[_hand] }))
			if _hand == "righthand":
				get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,4) + _hand[5].to_upper() + _hand.substr(6,-1) })).texture = _item.getTexture()
			else:
				get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,3) + _hand[4].to_upper() + _hand.substr(5,-1) })).texture = _item.getTexture()
	for _accessory in accessories.keys():
		if accessories[_accessory] != null:
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": accessories[_accessory] }))
			get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": _accessory[0].to_upper() + _accessory.substr(1,-1) })).texture = _item.getTexture()
	for _equipment in equipment.keys():
		if equipment[_equipment] != null:
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": equipment[_equipment] }))
			get_node("EquipmentContainer/{slot}/Sprite".format({ "slot": _equipment.capitalize() })).texture = _item.getTexture()

func getEquipmentSaveData():
	return {
		hands = hands,
		equipment = equipment,
		accessories = accessories,
		armorSets = armorSets
	}


########################
### Signal functions ###
########################

func _on_mouse_entered_equipment_slot(_equipmentSlot):
	hoveredEquipment = _equipmentSlot

func _on_mouse_exited_equipment_slot():
	hoveredEquipment = null

func _on_ItemContainer_gui_input(event):
	if event is InputEventScreenDrag:
		accept_event()
