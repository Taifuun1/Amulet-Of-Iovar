var quadrapeds = [
	{
		"critterName": "Rhino",
		"race": "Quadraped",
		"class": "Animal",
		"weight": 500,
		"aI": "Aggressive",
		"aggroDistance": 5,
		"texture": load("res://Assets/Critters/QuadrapedRhino.png"),
		"piety": "Neutral",
		"level": 11,
		"expDropAmount": 32,
		"hp": 50,
		"mp": 8,
		"ac": 5,
		"magicac": 10,
		"attacks": [
			{
				"dmg": [12,14],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,1,0,1,0,0,0,1,1,0,1,0,1,0,0],
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
		"piety": "Neutral",
		"level": 14,
		"expDropAmount": 68,
		"hp": 70,
		"mp": 21,
		"ac": 7,
		"magicac": 18,
		"attacks": [
			{
				"dmg": [22,24],
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
