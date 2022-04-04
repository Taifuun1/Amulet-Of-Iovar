extends Control

var equipmentItem = load("res://UI/Equipment/EquipmentItem.tscn")

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
	"head": null,
	"chest": null,
	"hands": null,
	"belt": null,
	"legs": null,
	"feet": null
}

var hoveredEquipment = null

func create():
	name = "Equipment"
	hide()

func _process(_delta):
	if Input.is_action_just_released("RIGHT_CLICK") and hoveredEquipment != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": hands[hoveredEquipment.to_lower()] }))
		var _slot = checkIfMatchingEquipmentAndSlot(_item.type, _item.category)
		var _changed = false
		if _slot == "Weapon" and _item.category == "Two-handed sword":
			if hands["lefthand"] == hands["righthand"] and hands["lefthand"] != null and hands["righthand"] != null:
				hands["lefthand"] = null
				hands["righthand"] = null
				$"EquipmentBackground/LeftHand/Sprite".texture = null
				$"EquipmentBackground/RightHand/Sprite".texture = null
				_changed = true
		else:
			if hands[hoveredEquipment.to_lower()] != null:
				_changed = true
			hands[hoveredEquipment.to_lower()] = null
			accessories[hoveredEquipment.to_lower()] = null
			equipment[hoveredEquipment.to_lower()] = null
			get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = null
		$"/root/World/Critters/0".calculateEquipment()
		if _changed:
			$"/root/World".processEnemyActions()
			$"/root/World".drawLevel()

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

func emptyWeapon(_slot):
	hands[_slot] = null

func emptyAccessory(_slot):
	accessories[_slot] = null

func emptyEquipment(_slot):
	equipment[_slot] = null

func setEquipment(_id):
	var _item = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _matchingType = checkIfMatchingEquipmentAndSlot(_item.type, _item.category)
	var _changed = false
	if _matchingType == "Weapon":
		if hands["lefthand"] == hands["righthand"] and hands["lefthand"] != null and hands["righthand"] != null:
			hands["lefthand"] = null
			hands["righthand"] = null
			$"EquipmentBackground/LeftHand/Sprite".texture = null
			$"EquipmentBackground/RightHand/Sprite".texture = null
		if _item.category == "Two-handed sword":
			hands["lefthand"] = _item.id
			hands["righthand"] = _item.id
			$"EquipmentBackground/LeftHand/Sprite".texture = _item.getTexture()
			$"EquipmentBackground/RightHand/Sprite".texture = _item.getTexture()
		elif hands["lefthand"] != _item.id and hands["righthand"] != _item.id:
			hands[hoveredEquipment.to_lower()] = _item.id
			get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
		_changed = true
	if _matchingType == "Accessory":
		accessories[hoveredEquipment.to_lower()] = _item.id
		get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
		_changed = true
	if _matchingType == "Armor":
		equipment[hoveredEquipment.to_lower()] = _item.id
		get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
		_changed = true
	$"/root/World/Critters/0".calculateEquipment()
	if _changed:
		$"/root/World".processEnemyActions()
		$"/root/World".drawLevel()

func checkIfWearingEquipment(_id):
	var _isWearingEquipment = false
	for _hand in hands.keys():
		if hands[_hand] == _id:
			hands[_hand] = null
			print(_hand[0].to_upper() + _hand.substr(1,3) + _hand[4].to_upper() + _hand.substr(5,-1))
			if _hand == "righthand":
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,4) + _hand[5].to_upper() + _hand.substr(6,-1) })).texture = null
			else:
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _hand[0].to_upper() + _hand.substr(1,3) + _hand[4].to_upper() + _hand.substr(5,-1) })).texture = null
			_isWearingEquipment = true
			break
	if _isWearingEquipment:
		for _accessory in accessories.keys():
			if accessories[_accessory] == _id:
				accessories[_accessory] = null
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _accessory.capitalize() })).texture = null
				_isWearingEquipment = true
				break
	if _isWearingEquipment:
		for _equipment in equipment.keys():
			if equipment[_equipment] == _id:
				equipment[_equipment] = null
				get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": _equipment.capitalize() })).texture = null
				break
	$"/root/World/Critters/0".calculateEquipment()

func getSlot(_item):
	if (
		_item._category == "Sword" or
		_item._category == "Two-handed sword" or
		_item._category == "Dagger" or
		_item._category == "Hammer" or
		_item._category == "Flail" or
		_item._category == "Shield"
	):
		return "Weapon"
	if (
		_item._category == "Ring" or
		_item._category == "Amulet"
	):
		return "Accessory"
	if (
		_item._category == "Boots" or
		_item._category == "Chausses" or
		_item._category == "Belt" or
		_item._category == "Gauntlets" or
		_item._category == "Platemail" or
		_item._category == "Helmet"
	):
		return "Armor"

func getArmorClass():
	var _ac = 0
	if equipment["head"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["head"] }))
		_ac += (_item.value + _item.enchantment)
	if equipment["chest"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["chest"] }))
		_ac += (_item.value + _item.enchantment)
	if equipment["hands"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["hands"] }))
		_ac += (_item.value + _item.enchantment)
	if equipment["legs"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["legs"] }))
		_ac += (_item.value + _item.enchantment)
	if equipment["feet"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["feet"] }))
		_ac += (_item.value + _item.enchantment)
	if hands["lefthand"] != null and get_node("/root/World/Items/{id}".format({ "id": hands["lefthand"] })).category == "Shield":
		var _item = get_node("/root/World/Items/{id}".format({ "id": hands["lefthand"] }))
		_ac += (_item.value + _item.enchantment)
	if hands["righthand"] != null and get_node("/root/World/Items/{id}".format({ "id": hands["righthand"] })).category == "Shield":
		var _item = get_node("/root/World/Items/{id}".format({ "id": hands["righthand"] }))
		_ac += (_item.value + _item.enchantment)
	return _ac

func checkIfMatchingEquipmentAndSlot(_type, _category):
	if _type == "Weapon":
		if (
			(
				_category == "Sword" or
				_category == "Two-handed sword" or
				_category == "Dagger" or
				_category == "Hammer" or
				_category == "Flail"
			) and
			(
				hoveredEquipment == "LeftHand" or
				hoveredEquipment == "RightHand"
			)
		):
			return "Weapon"
	elif _type == "Accessory":
		if (
			(
				_category == "Ring"
			) and
			(
				hoveredEquipment == "Ring1" or
				hoveredEquipment == "Ring2"
			)
		):
			return "Accessory"
		if (
			(
				_category == "Amulet"
			) and
			hoveredEquipment == "Amulet"
		):
			return "Accessory"
	elif _type == "Armor":
		if (
			(
				_category == "Helmet"
			) and
			hoveredEquipment == "Head"
		):
			return "Armor"
		if (
			(
				_category == "Platemail"
			) and
			hoveredEquipment == "Chest"
		):
			return "Armor"
		if (
			(
				_category == "Gauntlets"
			) and
			hoveredEquipment == "Hands"
		):
			return "Armor"
		if (
			(
				_category == "Shield"
			) and
			(
				hoveredEquipment == "LeftHand" or
				hoveredEquipment == "RightHand"
			)
		):
			return "Weapon"
		if (
			(
				_category == "Belt"
			) and
			hoveredEquipment == "Belt"
		):
			return "Armor"
		if (
			(
				_category == "Chausses"
			) and
			hoveredEquipment == "Legs"
		):
			return "Armor"
		if (
			(
				_category == "Boots"
			) and
			hoveredEquipment == "Feet"
		):
			return "Armor"
	return null

func _on_mouse_entered_equipment_slot(_equipmentSlot):
	hoveredEquipment = _equipmentSlot

func _on_mouse_exited_equipment_slot(_equipmentSlot):
	hoveredEquipment = null
