extends Control

var equipmentItem = load("res://UI/Equipment/Equipment Item.tscn")

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

var dualWielding = false
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
				pass
			elif _matchingType.matchn("weapon"):
				if _item.category.matchn("two-hander"):
					if hands["lefthand"] == hands["righthand"] and hands["lefthand"] != null and hands["righthand"] != null:
						hands["lefthand"] = null
						hands["righthand"] = null
						$"EquipmentBackground/LeftHand/Sprite".texture = null
						$"EquipmentBackground/RightHand/Sprite".texture = null
						_changed = true
				else:
					if hands[hoveredEquipment.to_lower()] == null:
						dualWielding = false
					if hands[hoveredEquipment.to_lower()] != null:
						_changed = true
					hands[hoveredEquipment.to_lower()] = null
					get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = null
			elif _matchingType.matchn("armor"):
				if equipment[hoveredEquipment.to_lower()] != null:
					_changed = true
				equipment[hoveredEquipment.to_lower()] = null
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = null
			elif _matchingType.matchn("accessory"):
				if accessories[hoveredEquipment.to_lower()] != null:
					_changed = true
				accessories[hoveredEquipment.to_lower()] = null
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = null
				if _item.category.matchn("ring"):
					checkWhatRingIsWorn(_item)
			$"/root/World/Critters/0".calculateEquipmentStats()
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
		pass
	elif _matchingType.matchn("weapon"):
		dualWielding = false
		if hands["lefthand"] == hands["righthand"] and hands["lefthand"] != null and hands["righthand"] != null:
			hands["lefthand"] = null
			hands["righthand"] = null
			$"EquipmentBackground/LeftHand/Sprite".texture = null
			$"EquipmentBackground/RightHand/Sprite".texture = null
		if _item.category == "Two-hander":
			hands["lefthand"] = _item.id
			hands["righthand"] = _item.id
			$"EquipmentBackground/LeftHand/Sprite".texture = _item.getTexture()
			$"EquipmentBackground/RightHand/Sprite".texture = _item.getTexture()
		elif hands["lefthand"] != _item.id and hands["righthand"] != _item.id:
			hands[hoveredEquipment.to_lower()] = _item.id
			get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
		if hands["lefthand"] != null and hands["righthand"] != null and !(hands["lefthand"] == hands["righthand"]):
			dualWielding = true
		$"/root/World/Critters/0".calculateEquipmentStats()
		$"/root/World".processGameTurn()
	elif _matchingType.matchn("accessory"):
		accessories[hoveredEquipment.to_lower()] = _item.id
		get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
		if _item.category.matchn("ring"):
			checkWhatRingIsWorn(_item)
		$"/root/World/Critters/0".calculateEquipmentStats()
		$"/root/World".processGameTurn()
	elif _matchingType.matchn("armor"):
		equipment[hoveredEquipment.to_lower()] = _item.id
		get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
		$"/root/World/Critters/0".calculateEquipmentStats()
		$"/root/World".processGameTurn()

func takeOfEquipmentWhenDroppingItem(_id):
	checkIfEquipmentNeedsToBeUnequipped(_id)
	$"/root/World/Critters/0".calculateEquipmentStats()

func checkIfEquipmentNeedsToBeUnequipped(_id):
	for _hand in hands.keys():
		if hands[_hand] == _id:
			hands[_hand] = null
			if _hand == "righthand":
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,4) + _hand[5].to_upper() + _hand.substr(6,-1) })).texture = null
			else:
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,3) + _hand[4].to_upper() + _hand.substr(5,-1) })).texture = null
			return
		for _accessory in accessories.keys():
			if accessories[_accessory] == _id:
				accessories[_accessory] = null
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _accessory[0].to_upper() + _accessory.substr(1,-1) })).texture = null
				return
		for _equipment in equipment.keys():
			if equipment[_equipment] == _id:
				equipment[_equipment] = null
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _equipment.capitalize() })).texture = null
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
	_playerNode.checkAllItemsIdentification()

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
	_playerNode.checkAllItemsIdentification()

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

func _on_mouse_entered_equipment_slot(_equipmentSlot):
	hoveredEquipment = _equipmentSlot

func _on_mouse_exited_equipment_slot():
	hoveredEquipment = null
