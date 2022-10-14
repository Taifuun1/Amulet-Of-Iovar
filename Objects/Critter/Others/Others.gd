var others = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Grid bug",
			"race": "Grid bug",
			"class": "Other",
			"weight": 50,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/OtherGridBug.png"),
			"alignment": "Neutral",
			"level": 1,
			"expDropAmount": 1,
			"hp": 4,
			"mp": 0,
			"ac": 0,
			"hits": [1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0],
			"stats": {
				"strength": 4,
				"legerity": 4,
				"balance": 4,
				"belief": 4,
				"visage": 4,
				"wisdom": 3
			},
			"abilities": ["grid movement"],
			"resistances": ["thunder"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [10, 20]
				}
			]
		},
		{
			"critterName": "Chicken",
			"race": "Chicken",
			"class": "Animal",
			"weight": 50,
			"aI": "Neutral",
			"texture": load("res://Assets/Critters/OtherChicken.png"),
			"alignment": "Neutral",
			"level": 2,
			"expDropAmount": 2,
			"hp": 6,
			"mp": 0,
			"ac": 0,
			"hits": [1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0],
			"stats": {
				"strength": 3,
				"legerity": 5,
				"balance": 3,
				"belief": 4,
				"visage": 4,
				"wisdom": 12
			},
			"abilities": [],
			"resistances": [],
			"drops": [  ]
		}
	]
}
