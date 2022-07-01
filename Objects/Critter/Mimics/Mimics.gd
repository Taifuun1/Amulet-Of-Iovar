var mimics = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Mimic",
			"race": "Mimic",
			"class": "Natural hazard",
			"weight": 100,
			"aI": "Skulking",
			"texture": load("res://Assets/Critters/MimicMimic.png"),
			"alignment": "Neutral",
			"level": 8,
			"expDropAmount": 145,
			"hp": 23,
			"mp": 13,
			"ac": 3,
			"hits": [1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1],
			"stats": {
				"strength": 13,
				"legerity": 4,
				"balance": 4,
				"belief": 4,
				"visage": 6,
				"wisdom": 7
			},
			"abilities": ["mimic chest"],
			"resistances": ["thunder", "sleep"]
		},
		{
			"critterName": "Humongous mimic",
			"race": "Mimic",
			"class": "Natural hazard",
			"weight": 350,
			"aI": "Skulking",
			"texture": load("res://Assets/Critters/MimicHumongousMimic.png"),
			"alignment": "Neutral",
			"level": 14,
			"expDropAmount": 1283,
			"hp": 38,
			"mp": 23,
			"ac": 7,
			"hits": [1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1],
			"stats": {
				"strength": 19,
				"legerity": 9,
				"balance": 9,
				"belief": 9,
				"visage": 12,
				"wisdom": 13
			},
			"abilities": ["mimic chest"],
			"resistances": ["thunder", "sleep"]
		}
	]
}
