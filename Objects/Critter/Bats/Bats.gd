var bats = [
	{
		"critterName": "Dark bat",
		"race": "Bats",
		"class": "Animal",
		"weight": 50,
		"aI": "Aggressive",
		"aggroDistance": 8,
		"texture": load("res://Assets/Critters/BatDarkBat.png"),
		"alignment": "Neutral",
		"level": 3,
		"expDropAmount": 6,
		"hp": 8,
		"mp": 2,
		"ac": 0,
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
		"alignment": "Neutral",
		"level": 6,
		"expDropAmount": 13,
		"hp": 13,
		"mp": 4,
		"ac": 0,
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
		"alignment": "Neutral",
		"level": 9,
		"expDropAmount": 27,
		"hp": 21,
		"mp": 2,
		"ac": 2,
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
		"alignment": "Neutral",
		"level": 8,
		"expDropAmount": 38,
		"hp": 16,
		"mp": 2,
		"ac": 0,
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
