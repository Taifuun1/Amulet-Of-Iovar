var bats = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Dark bat",
			"race": "Bats",
			"class": "Animal",
			"weight": 50,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/BatDarkBat.png"),
			"alignment": "Neutral",
			"level": 3,
			"expDropAmount": 8,
			"hp": 8,
			"mp": 2,
			"ac": 0,
			"attacks": [
				{
					"dmg": [2,4],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
			"drops": [  ]
		},
		{
			"critterName": "Squinting bat",
			"race": "Bats",
			"class": "Animal",
			"weight": 50,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/BatSquintingBat.png"),
			"alignment": "Neutral",
			"level": 6,
			"expDropAmount": 29,
			"hp": 13,
			"mp": 4,
			"ac": 0,
			"attacks": [
				{
					"dmg": [2,4],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [2,4],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
			"drops": [  ]
		},
		{
			"critterName": "Spooky bat",
			"race": "Bats",
			"class": "Animal",
			"weight": 50,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/BatSpookyBat.png"),
			"alignment": "Neutral",
			"level": 9,
			"expDropAmount": 98,
			"hp": 21,
			"mp": 2,
			"ac": 2,
			"attacks": [
				{
					"dmg": [4,5],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [4,5],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
			"drops": [  ]
		},
		{
			"critterName": "Vampire bat",
			"race": "Bats",
			"class": "Animal",
			"weight": 50,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/BatVampireBat.png"),
			"alignment": "Neutral",
			"level": 8,
			"expDropAmount": 128,
			"hp": 16,
			"mp": 2,
			"ac": 0,
			"attacks": [
				{
					"dmg": [3,4],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [3,4],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
			"drops": [  ]
		}
	]
}
