extends Node

var id
var gridPosition
var itemName
var unidentifiedItemName
var type
var alignment
var enchantment
var stackable

var notIdentified = {
	"use": false,
	"alignment": false,
	"enchantment": false
}

func getId():
	return id

func setValues(_item):
	id = _item.id
	name = str(_item.id)
	
	get_node("Name").text = _item.itemName
	get_node("Alignment").text = _item.alignment
	if enchantment == true:
		get_node("Enchantment").text = str(_item.enchantment)
