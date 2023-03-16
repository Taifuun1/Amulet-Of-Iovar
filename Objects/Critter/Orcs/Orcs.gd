var orcs = [
	{
		"critterName": "Goblin",
		"race": "Orc",
		"class": "Humanoid",
		"weight": 150,
		"aI": "Aggressive",
		"aggroDistance": 9,
		"texture": load("res://Assets/Critters/OrcGoblin.png"),
		"piety": "Neutral",
		"level": 3,
		"expDropAmount": 3,
		"hp": 9,
		"mp": 0,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [2,3],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,1,1,0,0,1,0,1,0,1,1,0,0,1,0],
		"stats": {
			"strength": 5,
			"legerity": 10,
			"balance": 5,
			"belief": 0,
			"visage": -2,
			"wisdom": 0
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [2, 5]
			},
			{
				"types": {
					"armor": ["common"],
					"weapon": ["common"]
				},
				"chance": 25,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Flatlands orc",
		"race": "Orc",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 8,
		"texture": load("res://Assets/Critters/OrcFlatlandsOrc.png"),
		"piety": "Neutral",
		"level": 6,
		"expDropAmount": 7,
		"hp": 15,
		"mp": 0,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [2,6],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,1,1,0,0,1,0,1,0,1,1,0,0,1,0],
		"stats": {
			"strength": 9,
			"legerity": 9,
			"balance": 8,
			"belief": 0,
			"visage": -2,
			"wisdom": 0
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [5, 8]
			},
			{
				"types": {
					"armor": ["common", "uncommon"],
					"weapon": ["common", "uncommon"]
				},
				"chance": 25,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Mountain orc",
		"race": "Orc",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 12,
		"texture": load("res://Assets/Critters/OrcMountainOrc.png"),
		"piety": "Neutral",
		"level": 8,
		"expDropAmount": 12,
		"hp": 29,
		"mp": 0,
		"ac": 2,
		"magicac": 3,
		"attacks": [
			{
				"dmg": [5,10],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,1,1,0,0,1,0,1,0,1,1,0,0,1,0],
		"stats": {
			"strength": 13,
			"legerity": 13,
			"balance": 12,
			"belief": 0,
			"visage": -2,
			"wisdom": 0
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [10, 12]
			},
			{
				"types": {
					"armor": ["common", "uncommon"],
					"weapon": ["common", "uncommon"]
				},
				"chance": 25,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Dungeon orc",
		"race": "Orc",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 12,
		"texture": load("res://Assets/Critters/OrcDungeonOrc.png"),
		"piety": "Neutral",
		"level": 13,
		"expDropAmount": 34,
		"hp": 46,
		"mp": 0,
		"ac": 6,
		"magicac": 3,
		"attacks": [
			{
				"dmg": [8,13],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,1,1,0,0,1,0,1,0,1,1,0,0,1,0],
		"stats": {
			"strength": 16,
			"legerity": 16,
			"balance": 14,
			"belief": 0,
			"visage": -2,
			"wisdom": 0
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [20, 25]
			},
			{
				"types": {
					"armor": ["common", "uncommon", "rare"],
					"weapon": ["common", "uncommon", "rare"]
				},
				"chance": 25,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Yrak-i",
		"race": "Orc",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 15,
		"texture": load("res://Assets/Critters/OrcYrak-i.png"),
		"piety": "Neutral",
		"level": 20,
		"expDropAmount": 374,
		"hp": 78,
		"mp": 0,
		"ac": 0,
		"magicac": 5,
		"attacks": [
			{
				"dmg": [23,33],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [2,18],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,1,1,0,1,1,0,1,1,0,1,0,1,1,0],
		"stats": {
			"strength": 22,
			"legerity": 16,
			"balance": 18,
			"belief": 0,
			"visage": 3,
			"wisdom": 0
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [25, 50]
			},
			{
				"types": {
					"armor": ["uncommon", "rare"],
					"weapon": ["uncommon", "rare"]
				},
				"chance": 25,
				"amount": [1, 1]
			}
		]
	}
]
