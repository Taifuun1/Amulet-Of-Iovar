var kobolds = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Tiny kobold",
			"race": "Kobold",
			"class": "Humanoid",
			"weight": 50,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/KoboldTinyKobold.png"),
			"alignment": "Neutral",
			"level": 2,
			"expDropAmount": 3,
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
			"hits": [1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1],
			"stats": {
				"strength": 2,
				"legerity": 8,
				"balance": 5,
				"belief": 0,
				"visage": 0,
				"wisdom": 0
			},
			"abilities": [],
			"abilityHits": [],
			"resistances": [],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [5, 15]
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
			"critterName": "Large kobold",
			"race": "Kobold",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/KoboldLargeKobold.png"),
			"alignment": "Neutral",
			"level": 6,
			"expDropAmount": 41,
			"hp": 16,
			"mp": 0,
			"ac": 1,
			"attacks": [
				{
					"dmg": [4,6],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				}
			],
			"hits": [1,0,0,1,1,0,0,1,1,0,0,1,1,0,0,1],
			"stats": {
				"strength": 5,
				"legerity": 11,
				"balance": 8,
				"belief": 0,
				"visage": 0,
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
