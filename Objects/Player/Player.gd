extends Node

var inventory = load("res://UI/Inventory/Inventory.tscn").instance()

#load("res://Assets/Newt.png")

var id = 0

var critterName = "Player"

var race = "Human"
var alignment = "Neutral"

var hp = 5
var mp = 2

var strength = 3
var legerity = 3
var balance = 3
var belief = 1
var sagacity = 1
var wisdom = 1

var strengthIncrease = 1
var legerityIncrease = 1
var balanceIncrease = 1
var beliefIncrease = 1
var sagacityIncrease = 1
var wisdomIncrease = 1

func create():
	name = str(0)
	inventory.create(true)
	add_child(inventory)

func calculateHitDmg():
	var dmg
	var weaponDmg
	if $Equipment.getWeapon() != null:
		weaponDmg = get_node("/root/World/Items/{item}".format({ "item": $Equipment.getWeapon() })).getTotalUseValue()
	if weaponDmg == null:
		return strength
	else:
		dmg = weaponDmg + strength
	return dmg

func hitCritter(_dmg):
	hp -= _dmg
