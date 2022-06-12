var wraiths = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Spectral wraith",
			"race": "Wraith",
			"class": "Spiritual",
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/WraithSpectralWraith.png"),
			"alignment": "Neutral",
			"level": 4,
			"expDropAmount": 55,
			"hp": 8,
			"mp": 0,
			"ac": 0,
			"hits": [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0],
			"stats": {
				"strength": 1,
				"legerity": 1,
				"balance": 1,
				"belief": 9,
				"visage": 1,
				"wisdom": 1
			},
			"abilities": ["ghost touch", "etherealness"],
			"resistances": []
		},
		{
			"critterName": "Spooky ghost",
			"race": "Wraith",
			"class": "Spiritual",
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/WraithSpookyGhost.png"),
			"alignment": "Neutral",
			"level": 8,
			"expDropAmount": 85,
			"hp": 16,
			"mp": 0,
			"ac": 0,
			"hits": [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0],
			"stats": {
				"strength": 1,
				"legerity": 1,
				"balance": 1,
				"belief": 16,
				"visage": 1,
				"wisdom": 1
			},
			"abilities": ["ghost touch", "etherealness"],
			"resistances": []
		}
	]
}
