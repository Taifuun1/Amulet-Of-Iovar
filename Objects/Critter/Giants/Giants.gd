var giants = [
	{
		"critterName": "Hill giant",
		"race": "Giant",
		"class": "Humanoid",
		"weight": 500,
		"aI": "Aggressive",
		"aggroDistance": 5,
		"texture": load("res://Assets/Critters/GiantHillGiant.png"),
		"alignment": "Neutral",
		"level": 5,
		"expDropAmount": 8,
		"hp": 19,
		"mp": 0,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [7,9],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1],
		"stats": {
			"strength": 16,
			"legerity": 5,
			"balance": 6,
			"belief": 6,
			"visage": 6,
			"wisdom": 2
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 10,
				"amount": [50, 100]
			},
			{
				"types": {
					"tool": ["common", "uncommon"],
					"weapon": ["common", "uncommon"]
				},
				"chance": 50,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Balding giant",
		"race": "Giant",
		"class": "Humanoid",
		"weight": 500,
		"aI": "Aggressive",
		"aggroDistance": 5,
		"texture": load("res://Assets/Critters/GiantBaldingGiant.png"),
		"alignment": "Neutral",
		"level": 10,
		"expDropAmount": 15,
		"hp": 42,
		"mp": 0,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [12,17],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [0,0,1,1,0,0,1,1,0,0,1,1,0,0,1,1],
		"stats": {
			"strength": 22,
			"legerity": 8,
			"balance": 11,
			"belief": 8,
			"visage": 8,
			"wisdom": 3
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [100, 150]
			},
			{
				"types": {
					"tool": ["common", "uncommon"],
					"weapon": ["common", "uncommon"]
				},
				"chance": 50,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Parched giant",
		"race": "Giant",
		"class": "Humanoid",
		"weight": 500,
		"aI": "Aggressive",
		"aggroDistance": 5,
		"texture": load("res://Assets/Critters/GiantParchedGiant.png"),
		"alignment": "Neutral",
		"level": 13,
		"expDropAmount": 22,
		"hp": 63,
		"mp": 0,
		"ac": 2,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [16,26],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [5,6],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1],
		"stats": {
			"strength": 25,
			"legerity": 12,
			"balance": 15,
			"belief": 11,
			"visage": 10,
			"wisdom": 5
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [100, 200]
			},
			{
				"types": {
					"tool": ["common", "uncommon"],
					"weapon": ["common", "uncommon"]
				},
				"chance": 50,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "One-eyed ogre",
		"race": "Giant",
		"class": "Humanoid",
		"weight": 500,
		"aI": "Aggressive",
		"aggroDistance": 6,
		"texture": load("res://Assets/Critters/GiantOne-eyedOgre.png"),
		"alignment": "Neutral",
		"level": 18,
		"expDropAmount": 324,
		"hp": 88,
		"mp": 0,
		"ac": 4,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [23,41],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1],
		"stats": {
			"strength": 33,
			"legerity": 15,
			"balance": 16,
			"belief": 12,
			"visage": 11,
			"wisdom": 6
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [250, 500]
			},
			{
				"types": {
					"tool": ["common", "uncommon"],
					"weapon": ["uncommon", "rare", "legendary"]
				},
				"chance": 50,
				"amount": [1, 1]
			}
		]
	}
]
