var humans = [
	{
		"critterName": "Shopkeeper",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Neutral",
		"aggroDistance": 3,
		"texture": load("res://Assets/Critters/HumanShopkeeper.png"),
		"piety": "Neutral",
		"level": 8,
		"expDropAmount": 2,
		"hp": 16,
		"mp": 11,
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
		"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
		"stats": {
			"strength": 9,
			"legerity": 8,
			"balance": 10,
			"belief": 8,
			"visage": 8,
			"wisdom": 8
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
				"names": "Key",
				"chance": 50,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Guard",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 9,
		"texture": load("res://Assets/Critters/HumanGuard.png"),
		"piety": "Neutral",
		"level": 8,
		"expDropAmount": 9,
		"hp": 31,
		"mp": 8,
		"ac": 5,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [8,11],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
		"stats": {
			"strength": 12,
			"legerity": 9,
			"balance": 14,
			"belief": 8,
			"visage": 8,
			"wisdom": 8
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [2, 8]
			},
			{
				"types": {
					"armor": ["common", "uncommon"],
					"weapon": ["common", "uncommon"]
				},
				"chance": 50,
				"amount": [1, 1]
			}
		],
		"hostileClasses": ["Goblins", "Orcs", "Rats", "Snakes", "Wraiths"]
	},
	{
		"critterName": "Guard captain",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 11,
		"texture": load("res://Assets/Critters/HumanGuardCaptain.png"),
		"piety": "Neutral",
		"level": 11,
		"expDropAmount": 15,
		"hp": 39,
		"mp": 10,
		"ac": 7,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [9,12],
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
		"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
		"stats": {
			"strength": 14,
			"legerity": 11,
			"balance": 15,
			"belief": 10,
			"visage": 10,
			"wisdom": 10
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [5, 12]
			},
			{
				"types": {
					"armor": ["uncommon"],
					"weapon": ["uncommon"]
				},
				"chance": 50,
				"amount": [1, 1]
			}
		],
		"hostileClasses": ["Goblins", "Orcs", "Rats", "Snakes", "Wraiths"]
	}
]
