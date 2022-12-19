extends Control

var equipmentItem = load("res://UI/Equipment/Equipment Item.tscn")

var equipmentUITemplatePaths = {
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

var hoveredEquipment = null

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
						$"EquipmentBackground/LeftHand/Sprite".texture = load(equipmentUITemplatePaths[hoveredEquipment.to_lower()])
						$"EquipmentBackground/RightHand/Sprite".texture = load(equipmentUITemplatePaths[hoveredEquipment.to_lower()])
						_changed = true
				else:
					if hands[hoveredEquipment.to_lower()] != null:
						_changed = true
					hands[hoveredEquipment.to_lower()] = null
					get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = load(equipmentUITemplatePaths[hoveredEquipment.to_lower()])
			elif _matchingType.matchn("armor"):
				if equipment[hoveredEquipment.to_lower()] != null:
					_changed = true
				equipment[hoveredEquipment.to_lower()] = null
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = load(equipmentUITemplatePaths[hoveredEquipment.to_lower()])
				if _item.category.matchn("belt"):
					checkWhatBeltIsWorn(_item)
				if _item.category.matchn("cloak"):
					checkWhatCloakIsWorn(_item)
				if _item.category.matchn("gauntlets"):
					checkWhatGauntletsAreWorn(_item)
			elif _matchingType.matchn("accessory"):
				if accessories[hoveredEquipment.to_lower()] != null:
					_changed = true
				accessories[hoveredEquipment.to_lower()] = null
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = load(equipmentUITemplatePaths[hoveredEquipment.to_lower()])
				if _item.category.matchn("ring"):
					checkWhatRingIsWorn(_item)
				if _item.category.matchn("amulet"):
					checkWhatAmuletIsWorn(_item)
			
			if _item.category.matchn("amulet"):
				var panelStylebox = get_node("EquipmentBackground/{equipment}".format({ "equipment": hoveredEquipment })).get_stylebox("panel").duplicate()
				panelStylebox.set_border_width_all(0)
				panelStylebox.set_border_color(Color(1, 0, 0, 0))
				get_node("EquipmentBackground/{equipment}".format({ "equipment": hoveredEquipment })).add_stylebox_override("panel", panelStylebox)
			
			$"/root/World/Critters/0".calculateEquipmentStats()
			$"/root/World/Critters/0".checkAllIdentification(true)
			if _changed:
				$"/root/World".processGameTurn()

func showEquipment(_items):
	for _item in _items:
		var _newItem = equipmentItem.instance()
		_newItem.setValues(get_node("/root/World/Items/{item}".format({ "item": _item })))
		$ItemsBackground/ItemContainer/ItemList.add_child(_newItem)
	show()

func hideEquipment():
	for _item in $ItemsBackground/ItemContainer/ItemList.get_children():
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
			$"EquipmentBackground/LeftHand/Sprite".texture = load(equipmentUITemplatePaths["lefthand"])
			$"EquipmentBackground/RightHand/Sprite".texture = load(equipmentUITemplatePaths["righthand"])
		if _item.category.matchn("Two-hander"):
			hands["lefthand"] = _item.id
			hands["righthand"] = _item.id
			$"EquipmentBackground/LeftHand/Sprite".texture = _item.getTexture()
			$"EquipmentBackground/RightHand/Sprite".texture = _item.getTexture()
		elif hands["lefthand"] != _item.id and hands["righthand"] != _item.id:
			hands[hoveredEquipment.to_lower()] = _item.id
			get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
	elif _matchingType.matchn("accessory"):
		if accessories[hoveredEquipment.to_lower()] != null:
			if _item.category.matchn("ring"):
				checkWhatRingIsWorn(_oldItem)
			if _item.category.matchn("amulet"):
				checkWhatAmuletIsWorn(_oldItem)
		accessories[hoveredEquipment.to_lower()] = _item.id
		get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
		if _item.category.matchn("ring"):
			checkWhatRingIsWorn(_item)
		if _item.category.matchn("amulet"):
			checkWhatAmuletIsWorn(_item)
	elif _matchingType.matchn("armor"):
		if equipment[hoveredEquipment.to_lower()] != null:
			if _item.category.matchn("belt"):
				checkWhatBeltIsWorn(_oldItem)
			if _item.category.matchn("cloak"):
				checkWhatCloakIsWorn(_oldItem)
			if _item.category.matchn("gauntlets"):
				checkWhatGauntletsAreWorn(_oldItem)
		equipment[hoveredEquipment.to_lower()] = _item.id
		get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
		if _item.category.matchn("belt"):
			checkWhatBeltIsWorn(_item)
		if _item.category.matchn("cloak"):
			checkWhatCloakIsWorn(_item)
		if _item.category.matchn("gauntlets"):
			checkWhatGauntletsAreWorn(_item)
	for _listItem in $ItemsBackground/ItemContainer/ItemList.get_children():
		if _item.itemName.matchn(_listItem.item.itemName):
			_listItem.updateValues(_item.itemName)
	if _item.binds != null and _item.binds.type.matchn("equipment"):
		_item.binds = {
			"type": _item.value.binds,
			"state": "Bound"
		}
		var panelStylebox = get_node("EquipmentBackground/{equipment}".format({ "equipment": hoveredEquipment })).get_stylebox("panel").duplicate()
		panelStylebox.set_border_width_all(1)
		panelStylebox.set_border_color(Color(1, 0, 0))
		get_node("EquipmentBackground/{equipment}".format({ "equipment": hoveredEquipment })).add_stylebox_override("panel", panelStylebox)
	$"/root/World/Critters/0".calculateEquipmentStats()
	$"/root/World/Critters/0".checkAllIdentification(true)
	$"/root/World".processGameTurn()

func takeOfEquipmentWhenDroppingItem(_id):
	checkIfEquipmentNeedsToBeUnequipped(_id)
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
		$"EquipmentBackground/LeftHand/Sprite".texture = load(equipmentUITemplatePaths["lefthand"])
		$"EquipmentBackground/RightHand/Sprite".texture = load(equipmentUITemplatePaths["righthand"])
	for _hand in hands.keys():
		if hands[_hand] == _id:
			hands[_hand] = null
			if _hand == "righthand":
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,4) + _hand[5].to_upper() + _hand.substr(6,-1) })).texture = load(equipmentUITemplatePaths[_hand.to_lower()])
			else:
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,3) + _hand[4].to_upper() + _hand.substr(5,-1) })).texture = load(equipmentUITemplatePaths[_hand.to_lower()])
			return
	for _accessory in accessories.keys():
		if accessories[_accessory] == _id:
			accessories[_accessory] = null
			get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _accessory[0].to_upper() + _accessory.substr(1,-1) })).texture = load(equipmentUITemplatePaths[_accessory.to_lower()])
			if _item.category.matchn("ring"):
				checkWhatRingIsWorn(_item)
			if _item.category.matchn("amulet"):
				checkWhatAmuletIsWorn(_item)
			return
	for _equipment in equipment.keys():
		if equipment[_equipment] == _id:
			equipment[_equipment] = null
			get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _equipment.capitalize() })).texture = load(equipmentUITemplatePaths[_equipment.to_lower()])
			if _item.category.matchn("belt"):
				checkWhatBeltIsWorn(_item)
			if _item.category.matchn("cloak"):
				checkWhatCloakIsWorn(_item)
			if _item.category.matchn("gauntlets"):
				checkWhatGauntletsAreWorn(_item)
			return

func getArmorClass():
	var _ac = 0
	if equipment["helmet"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["helmet"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if equipment["cloak"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["cloak"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if equipment["plate"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["plate"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if equipment["gauntlets"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["gauntlets"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if equipment["greaves"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["greaves"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if equipment["boots"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["boots"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if hands["lefthand"] != null and get_node("/root/World/Items/{id}".format({ "id": hands["lefthand"] })).category.matchn("shield"):
		var _item = get_node("/root/World/Items/{id}".format({ "id": hands["lefthand"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if hands["righthand"] != null and get_node("/root/World/Items/{id}".format({ "id": hands["righthand"] })).category.matchn("shield"):
		var _item = get_node("/root/World/Items/{id}".format({ "id": hands["righthand"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if accessories["ring1"] != null and get_node("/root/World/Items/{id}".format({ "id": accessories["ring1"] })).category.matchn("ring"):
		_ac += checkIfRingIsRingOfProtection(get_node("/root/World/Items/{id}".format({ "id": accessories["ring1"] })))
	if accessories["ring2"] != null and get_node("/root/World/Items/{id}".format({ "id": accessories["ring2"] })).category.matchn("ring"):
		_ac += checkIfRingIsRingOfProtection(get_node("/root/World/Items/{id}".format({ "id": accessories["ring2"] })))
	return _ac

func checkIfRingIsRingOfProtection(_ring):
	match _ring.identifiedItemName.to_lower():
		"ring of protection":
			return _ring.value
		_:
			return 0

func checkWhatAmuletIsWorn(_amulet):
	if (
		GlobalItemInfo.globalItemInfo.has(_amulet.identifiedItemName) and
		GlobalItemInfo.globalItemInfo[_amulet.identifiedItemName].identified == false
	):
		GlobalItemInfo.globalItemInfo[_amulet.identifiedItemName].identified = true
		Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _amulet.identifiedItemName, "unidentifiedItemName": _amulet.unidentifiedItemName }))
	var _playerNode = $"/root/World/Critters/0"
	match _amulet.identifiedItemName.to_lower():
		"amulet of seeing":
			if _playerNode.itemsTurnedOn.has(_amulet):
				_playerNode.statusEffects["seeing"] = 0
				_playerNode.itemsTurnedOn.erase(_amulet)
				Globals.gameConsole.addLog("It feels like you cant see at all.")
			else:
				_playerNode.statusEffects["seeing"] = -1
				_playerNode.itemsTurnedOn.append(_amulet)
				Globals.gameConsole.addLog("You can see everything!")
		"amulet of magic power":
			if _playerNode.itemsTurnedOn.has(_amulet):
				$"/root/World/Critters/0".bonusDmg.magicDmg -= 3
				_playerNode.itemsTurnedOn.erase(_amulet)
				Globals.gameConsole.addLog("Your magic energy feels weaker.")
			else:
				$"/root/World/Critters/0".bonusDmg.magicDmg += 3
				_playerNode.itemsTurnedOn.append(_amulet)
				Globals.gameConsole.addLog("Your magic energy feels stronger.")
		"amulet of life power":
			if _playerNode.itemsTurnedOn.has(_amulet):
				$"/root/World/Critters/0".maxhp -= 20
				if $"/root/World/Critters/0".hp > $"/root/World/Critters/0".maxhp:
					$"/root/World/Critters/0".hp = $"/root/World/Critters/0".maxhp
				_playerNode.itemsTurnedOn.erase(_amulet)
				Globals.gameConsole.addLog("Your life energy feels weaker.")
			else:
				$"/root/World/Critters/0".maxhp += 20
				_playerNode.itemsTurnedOn.append(_amulet)
				Globals.gameConsole.addLog("Your life energy feels stronger.")
		"amulet of backscattering":
			if _playerNode.itemsTurnedOn.has(_amulet):
				_playerNode.itemsTurnedOn.erase(_amulet)
				_playerNode.statusEffects.backscattering = 0
				Globals.gameConsole.addLog("Your feel an energy field dissipate around you.")
			else:
				_playerNode.itemsTurnedOn.append(_amulet)
				_playerNode.statusEffects.backscattering = -1
				Globals.gameConsole.addLog("Your feel an energy field around you.")
		"amulet of strangulation":
			if _playerNode.itemsTurnedOn.has(_amulet):
				_playerNode.itemsTurnedOn.erase(_amulet)
				Globals.gameConsole.addLog("You can breath agane.")
			else:
				_playerNode.itemsTurnedOn.append(_amulet)
				Globals.gameConsole.addLog("The amulet strangles you!")
		"amulet of toxix":
			if _playerNode.itemsTurnedOn.has(_amulet):
				_playerNode.itemsTurnedOn.erase(_amulet)
				_playerNode.statusEffects.toxix = 0
				Globals.gameConsole.addLog("You dont feel sick anymore.")
			else:
				_playerNode.itemsTurnedOn.append(_amulet)
				_playerNode.statusEffects.toxix = -1
				Globals.gameConsole.addLog("You feel terrible!")
		"amulet of sleep":
			if _playerNode.itemsTurnedOn.has(_amulet):
				_playerNode.itemsTurnedOn.erase(_amulet)
				_playerNode.statusEffects.sleep = 0
				Globals.gameConsole.addLog("You dont feel sleepy anymore.")
			else:
				_playerNode.itemsTurnedOn.append(_amulet)
				_playerNode.statusEffects.sleep = 10
				Globals.gameConsole.addLog("Your eyelids feel heavy.")
	_playerNode.checkAllIdentification(true)

func checkWhatRingIsWorn(_ring):
	if (
		GlobalItemInfo.globalItemInfo.has(_ring.identifiedItemName) and
		GlobalItemInfo.globalItemInfo[_ring.identifiedItemName].identified == false
	):
		GlobalItemInfo.globalItemInfo[_ring.identifiedItemName].identified = true
		Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _ring.identifiedItemName, "unidentifiedItemName": _ring.unidentifiedItemName }))
	var _playerNode = $"/root/World/Critters/0"
	match _ring.identifiedItemName.to_lower():
		"ring of slow digestion":
			if _playerNode.itemsTurnedOn.has(_ring):
				_playerNode.statusEffects["slow digestion"] = 0
				_playerNode.itemsTurnedOn.erase(_ring)
				Globals.gameConsole.addLog("Your belly feels faster.")
			else:
				_playerNode.statusEffects["slow digestion"] = -1
				_playerNode.itemsTurnedOn.append(_ring)
				Globals.gameConsole.addLog("Your belly feels constant.")
		"ring of fast digestion":
			if _playerNode.itemsTurnedOn.has(_ring):
				_playerNode.statusEffects["fast digestion"] = 0
				_playerNode.itemsTurnedOn.erase(_ring)
				Globals.gameConsole.addLog("Your belly feels normal.")
			else:
				_playerNode.statusEffects["fast digestion"] = -1
				_playerNode.itemsTurnedOn.append(_ring)
				Globals.gameConsole.addLog("Your belly feels like it has a hole.")
		"ring of regen":
			if _playerNode.itemsTurnedOn.has(_ring):
				_playerNode.statusEffects["regen"] = 0
				_playerNode.itemsTurnedOn.erase(_ring)
				Globals.gameConsole.addLog("Your skin feels more stable.")
			else:
				_playerNode.statusEffects["regen"] = -1
				_playerNode.itemsTurnedOn.append(_ring)
				Globals.gameConsole.addLog("Your skin tingles.")
		"ring of fumbling":
			if _playerNode.itemsTurnedOn.has(_ring):
				_playerNode.statusEffects["fumbling"] = 0
				_playerNode.itemsTurnedOn.erase(_ring)
				Globals.gameConsole.addLog("Your legs feel steady.")
			else:
				_playerNode.statusEffects["fumbling"] = -1
				_playerNode.itemsTurnedOn.append(_ring)
				Globals.gameConsole.addLog("Your legs feel like jelly.")
	_playerNode.checkAllIdentification(true)

func checkWhatBeltIsWorn(_belt):
	if (
		GlobalItemInfo.globalItemInfo.has(_belt.identifiedItemName) and
		GlobalItemInfo.globalItemInfo[_belt.identifiedItemName].identified == false
	):
		GlobalItemInfo.globalItemInfo[_belt.identifiedItemName].identified = true
		Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _belt.identifiedItemName, "unidentifiedItemName": _belt.unidentifiedItemName }))
	var _playerNode = $"/root/World/Critters/0"
	match _belt.identifiedItemName.to_lower():
		"belt of plato":
			if _playerNode.itemsTurnedOn.has(_belt):
				_playerNode.stats["wisdom"] -= 1
				_playerNode.itemsTurnedOn.erase(_belt)
				Globals.gameConsole.addLog("Your feel very dumb.")
			else:
				_playerNode.stats["wisdom"] += 1
				_playerNode.itemsTurnedOn.append(_belt)
				Globals.gameConsole.addLog("Your feel very wise.")
		"belt of faith":
			if _playerNode.itemsTurnedOn.has(_belt):
				_playerNode.stats["belief"] -= 1
				_playerNode.itemsTurnedOn.erase(_belt)
				Globals.gameConsole.addLog("Your feel like you dont believe in anything.")
			else:
				_playerNode.stats["belief"] += 1
				_playerNode.itemsTurnedOn.append(_belt)
				Globals.gameConsole.addLog("Your feel rapturous faith fill you.")
		"belt of symmetry":
			if _playerNode.itemsTurnedOn.has(_belt):
				_playerNode.stats["visage"] -= 1
				_playerNode.itemsTurnedOn.erase(_belt)
				Globals.gameConsole.addLog("Your feel ugly.")
			else:
				_playerNode.stats["visage"] += 1
				_playerNode.itemsTurnedOn.append(_belt)
				Globals.gameConsole.addLog("Your feel very photogenetic.")
	_playerNode.checkAllIdentification(true)

func checkWhatCloakIsWorn(_cloak):
	if (
		GlobalItemInfo.globalItemInfo.has(_cloak.identifiedItemName) and
		GlobalItemInfo.globalItemInfo[_cloak.identifiedItemName].identified == false
	):
		GlobalItemInfo.globalItemInfo[_cloak.identifiedItemName].identified = true
		Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _cloak.identifiedItemName, "unidentifiedItemName": _cloak.unidentifiedItemName }))
	var _playerNode = $"/root/World/Critters/0"
	match _cloak.identifiedItemName.to_lower():
		"cloak of displacement":
			if _playerNode.itemsTurnedOn.has(_cloak):
				_playerNode.statusEffects["displacement"] = 0
				_playerNode.itemsTurnedOn.erase(_cloak)
				Globals.gameConsole.addLog("Your feel like you're in one piece again.")
			else:
				_playerNode.statusEffects["displacement"] = -1
				_playerNode.itemsTurnedOn.append(_cloak)
				Globals.gameConsole.addLog("Your feel like you're all over the place.")
		"ring of magical ambiquity":
			if _playerNode.itemsTurnedOn.has(_cloak):
#				_playerNode.statusEffects[""] = 0
#				_playerNode.itemsTurnedOn.erase(_cloak)
				Globals.gameConsole.addLog("You feel magically normal. (UN_IMPL)")
			else:
#				_playerNode.statusEffects[""] = -1
#				_playerNode.itemsTurnedOn.append(_cloak)
				Globals.gameConsole.addLog("Your feel strangely ambivalent about magic. (UN_IMPL)")
	_playerNode.checkAllIdentification(true)

func checkWhatGauntletsAreWorn(_gauntlets):
	if (
		GlobalItemInfo.globalItemInfo.has(_gauntlets.identifiedItemName) and
		GlobalItemInfo.globalItemInfo[_gauntlets.identifiedItemName].identified == false
	):
		GlobalItemInfo.globalItemInfo[_gauntlets.identifiedItemName].identified = true
		Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _gauntlets.identifiedItemName, "unidentifiedItemName": _gauntlets.unidentifiedItemName }))
	var _playerNode = $"/root/World/Critters/0"
	match _gauntlets.identifiedItemName.to_lower():
		"gauntlets of devastation":
			if _playerNode.itemsTurnedOn.has(_gauntlets):
				_playerNode.stats["strength"] -= 1
				_playerNode.itemsTurnedOn.erase(_gauntlets)
				Globals.gameConsole.addLog("Your feel like a weak sausage.")
			else:
				_playerNode.stats["strength"] += 1
				_playerNode.itemsTurnedOn.append(_gauntlets)
				Globals.gameConsole.addLog("Your feel like you cant lift the world!")
		"gauntlets of nimbleness":
			if _playerNode.itemsTurnedOn.has(_gauntlets):
				_playerNode.stats["legerity"] -= 1
				_playerNode.itemsTurnedOn.erase(_gauntlets)
				Globals.gameConsole.addLog("Your feel a little clumsy.")
			else:
				_playerNode.stats["legerity"] += 1
				_playerNode.itemsTurnedOn.append(_gauntlets)
				Globals.gameConsole.addLog("Your feel like an elf.")
		"gauntlets of balance":
			if _playerNode.itemsTurnedOn.has(_gauntlets):
				_playerNode.stats["balance"] -= 1
				_playerNode.itemsTurnedOn.erase(_gauntlets)
				Globals.gameConsole.addLog("Your feel imbalanced.")
			else:
				_playerNode.stats["balance"] += 1
				_playerNode.itemsTurnedOn.append(_gauntlets)
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
	
	setEquipmentTextures()

func setEquipmentTextures():
	for _hand in hands.keys():
		if hands[_hand] != null:
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": hands[_hand] }))
			if _hand == "righthand":
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,4) + _hand[5].to_upper() + _hand.substr(6,-1) })).texture = _item.getTexture()
			else:
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,3) + _hand[4].to_upper() + _hand.substr(5,-1) })).texture = _item.getTexture()
	for _accessory in accessories.keys():
		if accessories[_accessory] != null:
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": accessories[_accessory] }))
			get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _accessory[0].to_upper() + _accessory.substr(1,-1) })).texture = _item.getTexture()
	for _equipment in equipment.keys():
		if equipment[_equipment] != null:
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": equipment[_equipment] }))
			get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _equipment.capitalize() })).texture = _item.getTexture()

func getEquipmentSaveData():
	return {
		hands = hands,
		equipment = equipment,
		accessories = accessories
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
		accept_event( )
