var centaurs = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Hill centaur",
			"race": "Centaur",
			"class": "Animal",
			"weight": 500,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/CentaurHillCentaur.png"),
			"alignment": "Neutral",
			"level": 7,
			"expDropAmount": 80,
			"hp": 29,
			"mp": 13,
			"ac": 1,
			"attacks": [
				{
					"dmg": [5,8],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
					"names": [
						"Leather cap",
						"Leather cloak",
						"Studded belt"
					],
					"chance": 25,
					"amount": [1, 1]
				},
				{
					"names": [
						"Chipped sword",
						"Elvish sword"
					],
					"chance": 25,
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
			"texture": load("res://Assets/Critters/CentaurGryonemCentaur.png"),
			"alignment": "Neutral",
			"level": 16,
			"expDropAmount": 3027,
			"hp": 67,
			"mp": 36,
			"ac": 5,
			"attacks": [
				{
					"dmg": [15,17],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [15,17],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
					"names": [
						"Scale ring mail chausses",
						"Adorned helmet",
						"Studded boots"
					],
					"chance": 25,
					"amount": [1, 1]
				},
				{
					"names": [
						"Adorned sword",
						"Elvish sword"
					],
					"chance": 25,
					"amount": [1, 1]
				}
			]
		}
	]
}
