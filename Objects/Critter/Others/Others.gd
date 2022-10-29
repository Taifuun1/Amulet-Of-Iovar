var others = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Grid bug",
			"race": "Grid bug",
			"class": "Other",
			"weight": 50,
			"aI": "Aggressive",
			"aggroDistance": 16,
			"texture": load("res://Assets/Critters/OtherGridBug.png"),
			"alignment": "Neutral",
			"level": 1,
			"expDropAmount": 1,
			"hp": 4,
			"mp": 0,
			"ac": 0,
			"attacks": [
				{
					"dmg": [1,1],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				}
			],
			"hits": [1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0],
			"stats": {
				"strength": 4,
				"legerity": 4,
				"balance": 4,
				"belief": 4,
				"visage": 4,
				"wisdom": 3
			},
			"abilities": [
				{
					"abilityName": "gridMovement",
					"abilityType": "skill"
				}
			],
			"abilityHits": [1],
			"resistances": ["thunder"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [10, 20]
				}
			]
		},
		{
			"critterName": "Chicken",
			"race": "Chicken",
			"class": "Animal",
			"weight": 50,
			"aI": "Neutral",
			"aggroDistance": 4,
			"texture": load("res://Assets/Critters/OtherChicken.png"),
			"alignment": "Neutral",
			"level": 2,
			"expDropAmount": 2,
			"hp": 6,
			"mp": 0,
			"ac": 0,
			"attacks": [
				{
					"dmg": [1,2],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				}
			],
			"hits": [1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0],
			"stats": {
				"strength": 3,
				"legerity": 5,
				"balance": 3,
				"belief": 4,
				"visage": 4,
				"wisdom": 12
			},
			"abilities": [],
			"abilityHits": [],
			"resistances": [],
			"drops": [  ]
		}
	]
}
