extends Node

func create():
	name = "Critters"

func getCritterByName(_critterName):
	for critter in critters.values():
		if critter.critterName == _critterName:
			return critter

func getCritterById(_id):
	for id in critters.keys():
		if id == _id:
			return critters[id]

var critters = {
	0: {
		"critterName": "Newt",
		"race": "Lizard",
		"amount": 10,
		"ai": "Aggressive",
		"texture": load("res://Assets/Newt.png"),
		"alignment": "Neutral",
		"hp": 5,
		"mp": 0,
		"stats": {
			"strength": 4,
			"legerity": 3,
			"balance": 3,
			"belief": 0,
			"sagacity": 0,
			"wisdom": 0
		},
		"statIncreases": {
			"strength": 1,
			"legerity": 1,
			"balance": 0,
			"belief": 0,
			"sagacity": 0,
			"wisdom": 0
		},
		"resistances": []
	},
	1: {
		"critterName": "Jackal",
		"race": "Canina",
		"amount": 10,
		"ai": "Aggressive",
		"texture": load("res://Assets/Newt.png"),
		"alignment": "Neutral",
		"hp": 4,
		"mp": 0,
		"stats": {
			"strength": 3,
			"legerity": 4,
			"balance": 3,
			"belief": 0,
			"sagacity": 0,
			"wisdom": 0
		},
		"statIncreases": {
			"strength": 1,
			"legerity": 1,
			"balance": 0,
			"belief": 0,
			"sagacity": 0,
			"wisdom": 0
		},
		"resistances": []
	},
	2: {
		"critterName": "Dwarven miner",
		"race": "Dwarf",
		"amount": 2,
		"ai": "Miner",
		"texture": load("res://Assets/Newt.png"),
		"alignment": "Neutral",
		"hp": 14,
		"mp": 2,
		"stats": {
			"strength": 8,
			"legerity": 3,
			"balance": 5,
			"belief": 4,
			"sagacity": 9,
			"wisdom": 2
		},
		"statIncreases": {
			"strength": 3,
			"legerity": 1,
			"balance": 2,
			"belief": 1,
			"sagacity": 3,
			"wisdom": 1
		},
		"resistances": []
	},
}
