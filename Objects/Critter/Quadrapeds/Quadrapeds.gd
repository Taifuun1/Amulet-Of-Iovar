var quadrapeds = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Rhino",
			"race": "Quadraped",
			"class": "Animal",
			"weight": 500,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/QuadrapedRhino.png"),
			"alignment": "Neutral",
			"level": 11,
			"expDropAmount": 200,
			"hp": 67,
			"mp": 8,
			"ac": 4,
			"hits": [1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0],
			"stats": {
				"strength": 18,
				"legerity": 12,
				"balance": 14,
				"belief": 6,
				"visage": 9,
				"wisdom": 9
			},
			"abilities": ["charge"],
			"resistances": ["fleir", "thunder"]
		},
		{
			"critterName": "Brontotheridae",
			"race": "Quadraped",
			"class": "Animal",
			"weight": 500,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/QuadrapedBrontotheridae.png"),
			"alignment": "Neutral",
			"level": 14,
			"expDropAmount": 860,
			"hp": 82,
			"mp": 21,
			"ac": 7,
			"hits": [1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0],
			"stats": {
				"strength": 23,
				"legerity": 15,
				"balance": 17,
				"belief": 9,
				"visage": 11,
				"wisdom": 13
			},
			"abilities": ["charge"],
			"resistances": ["fleir", "thunder"]
		}
	]
}
