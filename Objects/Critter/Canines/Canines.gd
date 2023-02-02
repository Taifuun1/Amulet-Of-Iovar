var canines = [
	{
		"critterName": "Wolf",
		"race": "Canine",
		"class": "Animal",
		"weight": 50,
		"aI": "Aggressive",
		"aggroDistance": 12,
		"texture": load("res://Assets/Critters/CanineWolf.png"),
		"alignment": "Neutral",
		"level": 4,
		"expDropAmount": 2,
		"hp": 13,
		"mp": 0,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [3,5],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1],
		"stats": {
			"strength": 7,
			"legerity": 7,
			"balance": 7,
			"belief": 6,
			"visage": 9,
			"wisdom": 6
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"types": {
					"comestible": ["uncommon"]
				},
				"chance": 25,
				"amount": [1, 2],
			}
		],
		"hostileClasses": ["Felines"]
	},
	{
		"critterName": "Warg",
		"race": "Canines",
		"class": "Animal",
		"weight": 50,
		"aI": "Aggressive",
		"aggroDistance": 16,
		"texture": load("res://Assets/Critters/CanineWarg.png"),
		"alignment": "Neutral",
		"level": 7,
		"expDropAmount": 5,
		"hp": 19,
		"mp": 0,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [6,9],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1],
		"stats": {
			"strength": 12,
			"legerity": 10,
			"balance": 10,
			"belief": 9,
			"visage": 12,
			"wisdom": 9
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"types": {
					"comestible": ["uncommon"]
				},
				"chance": 25,
				"amount": [1, 2],
			}
		],
		"hostileClasses": ["Felines"]
	},
	{
		"critterName": "Gearh",
		"race": "Canines",
		"class": "Animal",
		"weight": 50,
		"aI": "Aggressive",
		"aggroDistance": 18,
		"texture": load("res://Assets/Critters/CanineGearh.png"),
		"alignment": "Neutral",
		"level": 11,
		"expDropAmount": 15,
		"hp": 37,
		"mp": 0,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [7,9],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [7,9],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1],
		"stats": {
			"strength": 15,
			"legerity": 13,
			"balance": 13,
			"belief": 12,
			"visage": 15,
			"wisdom": 12
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"types": {
					"comestible": ["uncommon", "rare"]
				},
				"chance": 25,
				"amount": [1, 2],
			}
		],
		"hostileClasses": ["Felines"]
	}
]
