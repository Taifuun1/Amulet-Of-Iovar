extends Node

var weapons = {
	"right": null,
	"left": null
}

var equipment = {
	"head": null,
	"amulet": null,
	"chest": null,
	"gloves": null,
	"rightRing": null,
	"leftRing": null,
	"belt": null,
	"legs": null,
	"boots": null
}

func getWeapon():
	return weapons.right

func getWornEquipment(_place):
	return equipment[_place]

func wieldWeapon(_weapon, _place):
	if get_node("/root/World/Items/{id}".format({ "id": _weapon })).type == "Two-handed Weapon":
		weapons.right = _weapon
		weapons.left = _weapon
	else:
		weapons[_place] = _weapon

func wearEquipment(_equipment, _place):
	equipment[_place] = _equipment

func unWieldWeapon(_place):
	if weapons.right == weapons.left:
		weapons.right = null
		weapons.left = null
	else:
		weapons[_place] = null

func unWearEquipment(_place):
	equipment[_place] = null
