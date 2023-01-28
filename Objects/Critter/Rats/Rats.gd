var rats = [
	{
		"critterName": "Big rat",
		"race": "Rat",
		"class": "Animal",
		"weight": 100,
		"aI": "Aggressive",
		"aggroDistance": 11,
		"texture": load("res://Assets/Critters/RatBigRat.png"),
		"alignment": "Neutral",
		"level": 3,
		"expDropAmount": 3,
		"hp": 7,
		"mp": 0,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [2,4],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0],
		"stats": {
			"strength": 7,
			"legerity": 7,
			"balance": 7,
			"belief": 0,
			"visage": 1,
			"wisdom": 2
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 90,
				"amount": [25, 35]
			},
			{
				"types": {
					"ring": ["uncommon"]
				},
				"chance": 10,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Sewer rat",
		"race": "Rat",
		"class": "Animal",
		"weight": 100,
		"aI": "Aggressive",
		"aggroDistance": 13,
		"texture": load("res://Assets/Critters/RatSewerRat.png"),
		"alignment": "Neutral",
		"level": 5,
		"expDropAmount": 5,
		"hp": 16,
		"mp": 0,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [4,5],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0],
		"stats": {
			"strength": 8,
			"legerity": 8,
			"balance": 8,
			"belief": 0,
			"visage": 2,
			"wisdom": 4
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 90,
				"amount": [30, 45]
			},
			{
				"types": {
					"ring": ["uncommon"]
				},
				"chance": 15,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Cave rat",
		"race": "Rat",
		"class": "Animal",
		"weight": 100,
		"aI": "Aggressive",
		"aggroDistance": 15,
		"texture": load("res://Assets/Critters/RatCaveRat.png"),
		"alignment": "Neutral",
		"level": 7,
		"expDropAmount": 8,
		"hp": 22,
		"mp": 0,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [5,6],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [2,2],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0],
		"stats": {
			"strength": 12,
			"legerity": 12,
			"balance": 12,
			"belief": 0,
			"visage": 3,
			"wisdom": 6
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 90,
				"amount": [45, 60]
			},
			{
				"types": {
					"ring": ["uncommon", "rare"]
				},
				"chance": 20,
				"amount": [1, 1]
			}
		]
	}
]
