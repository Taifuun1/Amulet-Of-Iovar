var aquaticLife = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Fiddler crab",
			"race": "Aquatic life",
			"class": "Animal",
			"weight": 50,
			"aI": "Aggressive",
			"aggroDistance": 4,
			"texture": load("res://Assets/Critters/AquaticLifeFiddlerCrab.png"),
			"alignment": "Neutral",
			"level": 7,
			"expDropAmount": 56,
			"hp": 16,
			"mp": 13,
			"ac": 2,
			"attacks": [
				{
					"dmg": [6,8],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [2,3],
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
				"strength": 6,
				"legerity": 9,
				"balance": 12,
				"belief": 9,
				"visage": 12,
				"wisdom": 15
			},
			"abilities": [],
			"abilityHits": [],
			"resistances": [],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 25,
					"amount": [5, 10]
				}
			]
		},
		{
			"critterName": "Ringed seal",
			"race": "Aquatic life",
			"class": "Animal",
			"weight": 50,
			"aI": "Neutral",
			"aggroDistance": 2,
			"texture": load("res://Assets/Critters/AquaticLifeRingedSeal.png"),
			"alignment": "Neutral",
			"level": 9,
			"expDropAmount": 98,
			"hp": 32,
			"mp": 16,
			"ac": 2,
			"attacks": [
				{
					"dmg": [7,10],
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
				"strength": 8,
				"legerity": 13,
				"balance": 10,
				"belief": 15,
				"visage": 12,
				"wisdom": 14
			},
			"abilities": [],
			"abilityHits": [],
			"resistances": [],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 25,
					"amount": [5, 10]
				}
			]
		},
		{
			"critterName": "Eyebrow seal",
			"race": "Aquatic life",
			"class": "Animal",
			"weight": 50,
			"aI": "Aggressive",
			"aggroDistance": 5,
			"texture": load("res://Assets/Critters/AquaticLifeEyebrowSeal.png"),
			"alignment": "Neutral",
			"level": 13,
			"expDropAmount": 242,
			"hp": 40,
			"mp": 18,
			"ac": 3,
			"attacks": [
				{
					"dmg": [10,12],
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
				"strength": 8,
				"legerity": 11,
				"balance": 16,
				"belief": 14,
				"visage": 18,
				"wisdom": 22
			},
			"abilities": [],
			"abilityHits": [],
			"resistances": [],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 25,
					"amount": [5, 10]
				}
			]
		},
		{
			"critterName": "Tonatuna",
			"race": "Aquatic life",
			"class": "Animal",
			"weight": 50,
			"aI": "Aggressive",
			"aggroDistance": 10,
			"texture": load("res://Assets/Critters/AquaticLifeTonatuna.png"),
			"alignment": "Neutral",
			"level": 17,
			"expDropAmount": 3456,
			"hp": 88,
			"mp": 32,
			"ac": 1,
			"attacks": [
				{
					"dmg": [14,16],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [14,16],
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
				"strength": 15,
				"legerity": 15,
				"balance": 16,
				"belief": 12,
				"visage": 19,
				"wisdom": 25
			},
			"abilities": [],
			"abilityHits": [],
			"resistances": [],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 25,
					"amount": [50, 100]
				}
			]
		},
	]
}
