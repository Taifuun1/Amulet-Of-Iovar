var snakes = [
	{
		"critterName": "Garnered snake",
		"race": "Snake",
		"class": "Animal",
		"weight": 100,
		"aI": "Aggressive",
		"aggroDistance": 7,
		"texture": load("res://Assets/Critters/SnakeGarneredSnake.png"),
		"piety": "Neutral",
		"level": 3,
		"expDropAmount": 3,
		"hp": 9,
		"mp": 1,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [1,4],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1],
		"stats": {
			"strength": 5,
			"legerity": 8,
			"balance": 3,
			"belief": 6,
			"visage": 6,
			"wisdom": 7
		},
		"abilities": [
			{
				"abilityName": "poisonBite",
				"abilityType": "meleeSpell",
				"chance": 8
			}
		],
		"abilityHits": [0,1,0,0,1,0],
		"resistances": ["toxix"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 40,
				"amount": [10, 15]
			},
			{
				"types": {
					"scroll": ["common"]
				},
				"chance": 10,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Marsh snake",
		"race": "Snake",
		"class": "Animal",
		"weight": 100,
		"aI": "Aggressive",
		"aggroDistance": 7,
		"texture": load("res://Assets/Critters/SnakeMarshSnake.png"),
		"piety": "Neutral",
		"level": 7,
		"expDropAmount": 7,
		"hp": 23,
		"mp": 15,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [2,7],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1],
		"stats": {
			"strength": 7,
			"legerity": 11,
			"balance": 5,
			"belief": 8,
			"visage": 8,
			"wisdom": 9
		},
		"abilities": [
			{
				"abilityName": "poisonBite",
				"abilityType": "meleeSpell",
				"chance": 6
			},
			{
				"abilityName": "displaceSelf",
				"abilityType": "selfCastSpell",
				"chance": 2
			}
		],
		"abilityHits": [0,1,0,1,0,0],
		"resistances": ["toxix"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 40,
				"amount": [15, 25]
			},
			{
				"types": {
					"scroll": ["common", "uncommon"]
				},
				"chance": 15,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Sawtooth-pattern snake",
		"race": "Snake",
		"class": "Animal",
		"weight": 100,
		"aI": "Aggressive",
		"aggroDistance": 12,
		"texture": load("res://Assets/Critters/SnakeSawtooth-PatternSnake.png"),
		"piety": "Neutral",
		"level": 12,
		"expDropAmount": 35,
		"hp": 38,
		"mp": 31,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [3,13],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1],
		"stats": {
			"strength": 11,
			"legerity": 16,
			"balance": 9,
			"belief": 11,
			"visage": 11,
			"wisdom": 12
		},
		"abilities": [
			{
				"abilityName": "poisonBite",
				"abilityType": "meleeSpell",
				"chance": 6
			},
			{
				"abilityName": "displaceSelf",
				"abilityType": "selfCastSpell",
				"chance": 2
			}
		],
		"abilityHits": [0,1,0,1,0,0],
		"resistances": ["toxix"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 40,
				"amount": [25, 35]
			},
			{
				"types": {
					"scroll": ["uncommon", "rare"]
				},
				"chance": 20,
				"amount": [1, 1]
			}
		]
	}
]
