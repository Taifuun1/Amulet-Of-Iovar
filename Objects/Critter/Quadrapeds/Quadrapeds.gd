var quadrapeds = [
	{
		"critterName": "Rhino",
		"race": "Quadraped",
		"class": "Animal",
		"weight": 500,
		"aI": "Aggressive",
		"aggroDistance": 5,
		"texture": load("res://Assets/Critters/QuadrapedRhino.png"),
		"alignment": "Neutral",
		"level": 11,
		"expDropAmount": 71,
		"hp": 48,
		"mp": 8,
		"ac": 4,
		"attacks": [
			{
				"dmg": [12,13],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0],
		"stats": {
			"strength": 18,
			"legerity": 12,
			"balance": 14,
			"belief": 6,
			"visage": 9,
			"wisdom": 9
		},
		"abilities": [
			{
				"abilityName": "charge",
				"abilityType": "skill",
				"chance": 8
			}
		],
		"abilityHits": [1,0,0,0],
		"resistances": ["fleir", "thunder"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [75, 150]
			},
			{
				"types": {
					"armor": ["uncommon"],
					"weapon": ["uncommon"]
				},
				"chance": 10,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Brontotheridae",
		"race": "Quadraped",
		"class": "Animal",
		"weight": 500,
		"aI": "Aggressive",
		"aggroDistance": 8,
		"texture": load("res://Assets/Critters/QuadrapedBrontotheridae.png"),
		"alignment": "Neutral",
		"level": 14,
		"expDropAmount": 137,
		"hp": 70,
		"mp": 21,
		"ac": 7,
		"attacks": [
			{
				"dmg": [16,17],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,0,1,0,0,1,0,0,0,1,0,1,0,0,0],
		"stats": {
			"strength": 23,
			"legerity": 15,
			"balance": 17,
			"belief": 9,
			"visage": 11,
			"wisdom": 13
		},
		"abilities": [
			{
				"abilityName": "charge",
				"abilityType": "skill",
				"chance": 8
			}
		],
		"abilityHits": [1,0,0,0],
		"resistances": ["fleir", "thunder"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [100, 200]
			},
			{
				"types": {
					"armor": ["uncommon"],
					"weapon": ["uncommon"]
				},
				"chance": 10,
				"amount": [1, 1]
			}
		]
	}
]
