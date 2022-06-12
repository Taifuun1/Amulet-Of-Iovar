var dwarves = {
	"hostile": ["elves, orcs"],
	"critterTypes": [
		{
			"critterName": "Dwarf miner",
			"race": "Dwarf",
			"class": "Humanoid",
			"aI": "Neutral",
			"texture": load("res://Assets/Critters/DwarfMiner.png"),
			"alignment": "Neutral",
			"level": 6,
			"expDropAmount": 40,
			"hp": 22,
			"mp": 5,
			"ac": 2,
			"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
			"stats": {
				"strength": 9,
				"legerity": 3,
				"balance": 5,
				"belief": 4,
				"visage": 4,
				"wisdom": 2
			},
			"abilities": [],
			"resistances": []
		},
		{
			"critterName": "Dwarf engineer",
			"race": "Dwarf",
			"class": "Humanoid",
			"aI": "Neutral",
			"texture": load("res://Assets/Critters/DwarfEngineer.png"),
			"alignment": "Neutral",
			"level": 8,
			"expDropAmount": 128,
			"hp": 22,
			"mp": 5,
			"ac": 2,
			"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
			"stats": {
				"strength": 8,
				"legerity": 3,
				"balance": 5,
				"belief": 4,
				"visage": 4,
				"wisdom": 2
			},
			"abilities": [],
			"resistances": []
		},
		{
			"critterName": "Dwarf smith",
			"race": "Dwarf",
			"class": "Humanoid",
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/DwarfSmith.png"),
			"alignment": "Neutral",
			"level": 10,
			"expDropAmount": 156,
			"hp": 29,
			"mp": 5,
			"ac": 4,
			"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
			"stats": {
				"strength": 14,
				"legerity": 4,
				"balance": 9,
				"belief": 3,
				"visage": 3,
				"wisdom": 2
			},
			"abilities": [],
			"resistances": []
		},
		{
			"critterName": "Dwarven contirer",
			"race": "Dwarf",
			"class": "Humanoid",
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/DwarfContirer.png"),
			"alignment": "Neutral",
			"level": 18,
			"expDropAmount": 9880,
			"hp": 62,
			"mp": 5,
			"ac": 10,
			"hits": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0],
			"stats": {
				"strength": 21,
				"legerity": 9,
				"balance": 15,
				"belief": 9,
				"visage": 3,
				"wisdom": 1
			},
			"abilities": [],
			"resistances": ["frost", "thunder", "toxix"]
		}
	]
}
