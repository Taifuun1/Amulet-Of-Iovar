var liches = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Half-lich",
			"race": "Lich",
			"class": "Ancient",
			"weight": 100,
			"aI": "Aggresive",
			"texture": load("res://Assets/Critters/LichHalf-Lich.png"),
			"alignment": "Neutral",
			"level": 15,
			"expDropAmount": 1100,
			"hp": 42,
			"mp": 68,
			"ac": 0,
			"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
			"stats": {
				"strength": 5,
				"legerity": 8,
				"balance": 10,
				"belief": 31,
				"visage": 8,
				"wisdom": 27
			},
			"abilities": ["summon critter"],
			"resistances": ["gleeie'er", "toxix", "blindness", "confusion", "fumbling", "sleep"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [50, 150]
				},
				{
					"names": [
						"Leather mail",
						"Leather cap",
						"Leather gloves",
						"Leather belt",
						"Leather cloak",
						"Leather pants",
						"Low boots",
						"Elvish sword"
					],
					"chance": 100,
					"amount": [1, 1]
				}
			]
		},
		{
			"critterName": "Lich",
			"race": "Lich",
			"class": "Ancient",
			"weight": 100,
			"aI": "Aggresive",
			"texture": load("res://Assets/Critters/LichLich.png"),
			"alignment": "Neutral",
			"level": 18,
			"expDropAmount": 8888,
			"hp": 57,
			"mp": 84,
			"ac": 0,
			"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
			"stats": {
				"strength": 4,
				"legerity": 7,
				"balance": 8,
				"belief": 34,
				"visage": 7,
				"wisdom": 29
			},
			"abilities": ["summon critter"],
			"resistances": ["fleir", "frost", "gleeie'er", "toxix", "blindness", "confusion", "fumbling", "sleep"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [50, 150]
				},
				{
					"names": [
						"Leather mail",
						"Leather cap",
						"Leather gloves",
						"Leather belt",
						"Leather cloak",
						"Leather pants",
						"Low boots",
						"Elvish sword"
					],
					"chance": 100,
					"amount": [1, 1]
				}
			]
		},
		{
			"critterName": "Grand lich",
			"race": "Lich",
			"class": "Ancient",
			"weight": 100,
			"aI": "Aggresive",
			"texture": load("res://Assets/Critters/LichGrandLich.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 18660,
			"hp": 74,
			"mp": 99,
			"ac": 0,
			"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
			"stats": {
				"strength": 3,
				"legerity": 6,
				"balance": 7,
				"belief": 42,
				"visage": 6,
				"wisdom": 45
			},
			"abilities": ["summon critter"],
			"resistances": ["fleir", "frost", "gleeie'er", "toxix", "stun", "blindness", "confusion", "fumbling", "sleep"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [50, 150]
				},
				{
					"names": [
						"Leather mail",
						"Leather cap",
						"Leather gloves",
						"Leather belt",
						"Leather cloak",
						"Leather pants",
						"Low boots",
						"Elvish sword"
					],
					"chance": 100,
					"amount": [1, 1]
				}
			]
		},
		{
			"critterName": "Arch-lich",
			"race": "Lich",
			"class": "Ancient",
			"weight": 100,
			"aI": "Aggresive",
			"texture": load("res://Assets/Critters/LichArch-Lich.png"),
			"alignment": "Neutral",
			"level": 25,
			"expDropAmount": 89951,
			"hp": 106,
			"mp": 204,
			"ac": 0,
			"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
			"stats": {
				"strength": 1,
				"legerity": 4,
				"balance": 5,
				"belief": 70,
				"visage": 5,
				"wisdom": 70
			},
			"abilities": ["summon critter"],
			"resistances": ["fleir", "frost", "thunder", "gleeie'er", "toxix", "stun", "blindness", "confusion", "fumbling", "sleep"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [50, 150]
				},
				{
					"names": [
						"Leather mail",
						"Leather cap",
						"Leather gloves",
						"Leather belt",
						"Leather cloak",
						"Leather pants",
						"Low boots",
						"Elvish sword"
					],
					"chance": 100,
					"amount": [1, 1]
				}
			]
		}
	]
}
