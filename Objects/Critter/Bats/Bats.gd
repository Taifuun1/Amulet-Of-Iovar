var bats = [
	{
		"critterName": "Dark bat",
		"race": "Bats",
		"class": "Animal",
		"weight": 50,
		"aI": "Aggressive",
		"aggroDistance": 8,
		"texture": load("res://Assets/Critters/BatDarkBat.png"),
		"piety": "Neutral",
		"level": 3,
		"expDropAmount": 2,
		"hp": 10,
		"mp": 2,
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
		"hits": [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
		"stats": {
			"strength": 4,
			"legerity": 8,
			"balance": 4,
			"belief": 2,
			"visage": 2,
			"wisdom": 2
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "Worn mace",
				"chance": 5,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Squinting bat",
		"race": "Bats",
		"class": "Animal",
		"weight": 50,
		"aI": "Aggressive",
		"aggroDistance": 3,
		"texture": load("res://Assets/Critters/BatSquintingBat.png"),
		"piety": "Neutral",
		"level": 6,
		"expDropAmount": 5,
		"hp": 14,
		"mp": 4,
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
			},
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
		"hits": [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
		"stats": {
			"strength": 7,
			"legerity": 15,
			"balance": 7,
			"belief": 4,
			"visage": 4,
			"wisdom": 4
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 15,
				"amount": [5, 15]
			}
		]
	},
	{
		"critterName": "Spooky bat",
		"race": "Bats",
		"class": "Animal",
		"weight": 50,
		"aI": "Aggressive",
		"aggroDistance": 3,
		"texture": load("res://Assets/Critters/BatSpookyBat.png"),
		"piety": "Neutral",
		"level": 9,
		"expDropAmount": 8,
		"hp": 22,
		"mp": 2,
		"ac": 2,
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
			},
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
		"hits": [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
		"stats": {
			"strength": 10,
			"legerity": 23,
			"balance": 10,
			"belief": 6,
			"visage": 6,
			"wisdom": 6
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "Morning star",
				"chance": 5,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Vampire bat",
		"race": "Bats",
		"class": "Animal",
		"weight": 50,
		"aI": "Aggressive",
		"aggroDistance": 20,
		"texture": load("res://Assets/Critters/BatVampireBat.png"),
		"piety": "Neutral",
		"level": 8,
		"expDropAmount": 10,
		"hp": 18,
		"mp": 2,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [3,4],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [3,4],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
		"stats": {
			"strength": 8,
			"legerity": 8,
			"balance": 16,
			"belief": 3,
			"visage": 3,
			"wisdom": 3
		},
		"abilities": [
			{
				"abilityName": "lifesteal",
				"abilityType": "onAttack"
			}
		],
		"abilityHits": [1],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 35,
				"amount": [5, 75]
			},
			{
				"names": "Marker",
				"chance": 5,
				"amount": [1, 1]
			}
		]
	}
]
