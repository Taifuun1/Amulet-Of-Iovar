extends Node

var weapons = {
	"right": null,
	"left": null
}

var equipment = {
	"head": null,
	"chest": null,
	"gloves": null,
	"rightFinger": null,
	"leftFinger": null,
	"belt": null,
	"legs": null,
	"boots": null
}

func getWeapon():
	return weapons.right

func getWornEquipment(_place):
	return equipment[_place]

func wieldWeapon(_weapon, _place):
	weapons[_place] = _weapon

func wearEquipment(_equipment, _place):
	equipment[_place] = _equipment

func unWieldWeapon(_place):
	weapons[_place] = null

func unWearEquipment(_place):
	equipment[_place] = null
