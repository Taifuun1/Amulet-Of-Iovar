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
			hoveredEquipment.matchn("head") or
			hoveredEquipment.matchn("chest") or
			hoveredEquipment.matchn("hands") or
			hoveredEquipment.matchn("belt") or
			hoveredEquipment.matchn("legs") or
			hoveredEquipment.matchn("feet")
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
		_changed = true
	elif _matchingType.matchn("accessory"):
		accessories[hoveredEquipment.to_lower()] = _item.id
		get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
		_changed = true
	elif _matchingType.matchn("armor"):
		equipment[hoveredEquipment.to_lower()] = _item.id
		get_node("EquipmentBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _item.getTexture()
		_changed = true
	$"/root/World/Critters/0".calculateEquipmentStats()
	if _changed:
		$"/root/World".processGameTurn()

func checkIfWearingEquipment(_id):
	var _isWearingEquipment = false
	for _hand in hands.keys():
		if hands[_hand] == _id:
			hands[_hand] = null
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
	$"/root/World/Critters/0".calculateEquipmentStats()

func getSlot(_item):
	if (
		_item._category.matchn("Sword") or
		_item._category.matchn("Two-hander") or
		_item._category.matchn("Dagger") or
		_item._category.matchn("Mace") or
		_item._category.matchn("Flail") or
		_item._category.matchn("Shield")
	):
		return "Weapon"
	if (
		_item._category.matchn("Ring") or
		_item._category.matchn("Amulet")
	):
		return "Accessory"
	if (
		_item._category.matchn("Boots") or
		_item._category.matchn("Greaves") or
		_item._category.matchn("Belt") or
		_item._category.matchn("Gauntlets") or
		_item._category.matchn("Plate") or
		_item._category.matchn("Helmet")
	):
		return "Armor"

func getArmorClass():
	var _ac = 0
	if equipment["head"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["head"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if equipment["chest"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["chest"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if equipment["hands"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["hands"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if equipment["legs"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["legs"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if equipment["feet"] != null:
		var _item = get_node("/root/World/Items/{id}".format({ "id": equipment["feet"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if hands["lefthand"] != null and get_node("/root/World/Items/{id}".format({ "id": hands["lefthand"] })).category.matchn("shield"):
		var _item = get_node("/root/World/Items/{id}".format({ "id": hands["lefthand"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if hands["righthand"] != null and get_node("/root/World/Items/{id}".format({ "id": hands["righthand"] })).category.matchn("shield"):
		var _item = get_node("/root/World/Items/{id}".format({ "id": hands["righthand"] }))
		_ac += (_item.value.ac + _item.enchantment)
	if accessories["ring1"] != null and get_node("/root/World/Items/{id}".format({ "id": accessories["ring1"] })).category.matchn("ring"):
		_ac += checkWhatRingIsWorn(get_node("/root/World/Items/{id}".format({ "id": accessories["ring1"] })))
	if accessories["ring2"] != null and get_node("/root/World/Items/{id}".format({ "id": accessories["ring2"] })).category.matchn("ring"):
		_ac += checkWhatRingIsWorn(get_node("/root/World/Items/{id}".format({ "id": accessories["ring2"] })))
	return _ac

func checkWhatRingIsWorn(_ring):
	match _ring.identifiedItemName.to_lower():
		"ring of protection":
			return _ring.value
	return 0

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
	elif _type.matchn("Armor"):
		if (
			_category.matchn("Helmet") and
			hoveredEquipment.matchn("Head")
		):
			return "Armor"
		if (
			_category.matchn("Plate") and
			hoveredEquipment.matchn("Chest")
		):
			return "Armor"
		if (
			_category.matchn("Gauntlets") and
			hoveredEquipment.matchn("Hands")
		):
			return "Armor"
		if (
			_category.matchn("Shield") and
			(
				hoveredEquipment.matchn("LeftHand") or
				hoveredEquipment.matchn("RightHand")
			)
		):
			return "Weapon"
		if (
			_category.matchn("Belt") and
			hoveredEquipment.matchn("Belt")
		):
			return "Armor"
		if (
			_category.matchn("Greaves") and
			hoveredEquipment.matchn("Legs")
		):
			return "Armor"
		if (
			_category.matchn("Boots") and
			hoveredEquipment.matchn("Feet")
		):
			return "Armor"
	return null

func _on_mouse_entered_equipment_slot(_equipmentSlot):
	hoveredEquipment = _equipmentSlot

func _on_mouse_exited_equipment_slot(_equipmentSlot):
	hoveredEquipment = null
