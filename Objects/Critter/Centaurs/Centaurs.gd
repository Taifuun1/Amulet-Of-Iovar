var centaurs = [
	{
		"critterName": "Hill centaur",
		"race": "Centaur",
		"class": "Animal",
		"weight": 500,
		"aI": "Aggressive",
		"aggroDistance": 7,
		"texture": load("res://Assets/Critters/CentaurHillCentaur.png"),
		"alignment": "Neutral",
		"level": 7,
		"expDropAmount": 12,
		"hp": 25,
		"mp": 13,
		"ac": 1,
		"attacks": [
			{
				"dmg": [5,8],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,1,1,0,1,1,0,1,1,0,1,1,1,0,1],
		"stats": {
			"strength": 13,
			"legerity": 13,
			"balance": 13,
			"belief": 13,
			"visage": 14,
			"wisdom": 15
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 100,
				"amount": [25, 150]
			},
			{
				"types": {
					"armor": ["common", "uncommon"]
				},
				"chance": 50,
				"amount": [1, 1],
				"tries": 2
			},
			{
				"types": {
					"weapon": ["common", "uncommon"]
				},
				"chance": 50,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Gryonem centaur",
		"race": "Centaurs",
		"class": "Animal",
		"weight": 500,
		"aI": "Aggressive",
		"aggroDistance": 14,
		"texture": load("res://Assets/Critters/CentaurGryonemCentaur.png"),
		"alignment": "Neutral",
		"level": 16,
		"expDropAmount": 254,
		"hp": 74,
		"mp": 36,
		"ac": 5,
		"attacks": [
			{
				"dmg": [15,17],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [15,17],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1],
		"stats": {
			"strength": 17,
			"legerity": 17,
			"balance": 17,
			"belief": 21,
			"visage": 22,
			"wisdom": 24
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 100,
				"amount": [250, 350]
			},
			{
				"types": {
					"armor": ["uncommon", "rare"]
				},
				"chance": 50,
				"amount": [1, 1]
			},
			{
				"types": {
					"weapon": ["uncommon", "rare"]
				},
				"chance": 50,
				"amount": [1, 1]
			}
		]
	}
]
