var snakes = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Garnered snake",
			"race": "Snake",
			"class": "Animal",
			"weight": 100,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/SnakeGarneredSnake.png"),
			"alignment": "Neutral",
			"level": 3,
			"expDropAmount": 12,
			"hp": 9,
			"mp": 1,
			"ac": 0,
			"hits": [1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1],
			"stats": {
				"strength": 5,
				"legerity": 8,
				"balance": 3,
				"belief": 6,
				"visage": 6,
				"wisdom": 7
			},
			"abilities": ["poison bite"],
			"resistances": ["toxix"]
		},
		{
			"critterName": "Marsh snake",
			"race": "Snake",
			"class": "Animal",
			"weight": 100,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/SnakeMarshSnake.png"),
			"alignment": "Neutral",
			"level": 7,
			"expDropAmount": 46,
			"hp": 25,
			"mp": 15,
			"ac": 0,
			"hits": [1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1],
			"stats": {
				"strength": 7,
				"legerity": 11,
				"balance": 5,
				"belief": 8,
				"visage": 8,
				"wisdom": 9
			},
			"abilities": ["poison bite", "displace self"],
			"resistances": ["toxix"]
		},
		{
			"critterName": "Sawtooth-pattern snake",
			"race": "Snake",
			"class": "Animal",
			"weight": 100,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/SnakeSawtooth-PatternSnake.png"),
			"alignment": "Neutral",
			"level": 12,
			"expDropAmount": 150,
			"hp": 47,
			"mp": 31,
			"ac": 0,
			"hits": [1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1],
			"stats": {
				"strength": 11,
				"legerity": 16,
				"balance": 9,
				"belief": 11,
				"visage": 11,
				"wisdom": 12
			},
			"abilities": ["poison bite", "displace self"],
			"resistances": ["toxix"]
		}
	]
}
