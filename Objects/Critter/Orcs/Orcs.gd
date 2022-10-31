var orcs = {
	"hostile": ["humans, elves, dwarves"],
	"critterTypes": [
		{
			"critterName": "Goblin",
			"race": "Orc",
			"class": "Humanoid",
			"weight": 150,
			"aI": "Aggressive",
			"aggroDistance": 9,
			"texture": load("res://Assets/Critters/OrcGoblin.png"),
			"alignment": "Neutral",
			"level": 4,
			"expDropAmount": 18,
			"hp": 12,
			"mp": 0,
			"ac": 0,
			"attacks": [
				{
					"dmg": [2,5],
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
			"critterName": "Flatlands orc",
			"race": "Orc",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 8,
			"texture": load("res://Assets/Critters/OrcFlatlandsOrc.png"),
			"alignment": "Neutral",
			"level": 6,
			"expDropAmount": 38,
			"hp": 12,
			"mp": 0,
			"ac": 0,
			"attacks": [
				{
					"dmg": [3,8],
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
			"critterName": "Mountain orc",
			"race": "Orc",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 12,
			"texture": load("res://Assets/Critters/OrcMountainOrc.png"),
			"alignment": "Neutral",
			"level": 8,
			"expDropAmount": 76,
			"hp": 26,
			"mp": 0,
			"ac": 3,
			"attacks": [
				{
					"dmg": [6,12],
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
			"critterName": "Dungeon orc",
			"race": "Orc",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 12,
			"texture": load("res://Assets/Critters/OrcDungeonOrc.png"),
			"alignment": "Neutral",
			"level": 13,
			"expDropAmount": 356,
			"hp": 44,
			"mp": 0,
			"ac": 6,
			"attacks": [
				{
					"dmg": [8,16],
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
			"critterName": "Yrak-i",
			"race": "Orc",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 15,
			"texture": load("res://Assets/Critters/OrcYrak-i.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 12450,
			"hp": 72,
			"mp": 0,
			"ac": 10,
			"attacks": [
				{
					"dmg": [21,33],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": [0,0],
						"element": null
					}
				},
				{
					"dmg": [2,14],
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
