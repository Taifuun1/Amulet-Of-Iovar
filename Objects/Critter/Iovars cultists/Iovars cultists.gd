var iovarsCultists = [
	{
		"critterName": "Iovars cultist acolyte",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 24,
		"texture": load("res://Assets/Critters/HumanIovarsCultistAcolyte.png"),
		"piety": "Neutral",
		"level": 13,
		"expDropAmount": 22,
		"hp": 34,
		"mp": 48,
		"ac": 5,
		"magicac": 5,
		"attacks": [
			{
				"dmg": [3,6],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [3,6],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
		"stats": {
			"strength": 12,
			"legerity": 10,
			"balance": 11,
			"belief": 16,
			"visage": 14,
			"wisdom": 16
		},
		"abilities": [
			{
				"abilityName": "frostBite",
				"abilityType": "rangedSpell",
				"chance": 8
			}
		],
		"abilityHits": [1,0,1,0],
		"resistances": [],
		"drops": [
			{
				"types": {
					"amulet": ["uncommon"],
					"ring": ["uncommon"],
					"wand": ["common", "uncommon", "rare"]
				},
				"chance": 25,
				"amount": [1, 1]
			}
		],
		"hostileRaces": ["Wraith"]
	},
	{
		"critterName": "Iovars cultist",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": -1,
		"texture": load("res://Assets/Critters/HumanIovarsCultist.png"),
		"piety": "Neutral",
		"level": 16,
		"expDropAmount": 120,
		"hp": 58,
		"mp": 67,
		"ac": 6,
		"magicac": 10,
		"attacks": [
			{
				"dmg": [5,6],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [5,6],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
		"stats": {
			"strength": 13,
			"legerity": 13,
			"balance": 12,
			"belief": 21,
			"visage": 18,
			"wisdom": 18
		},
		"abilities": [
			{
				"abilityName": "thundersplit",
				"abilityType": "rangedSpell",
				"chance": 8
			}
		],
		"abilityHits": [1,0,1,0],
		"resistances": [],
		"drops": [
			{
				"types": {
					"amulet": ["uncommon"],
					"ring": ["uncommon"],
					"wand": ["common", "uncommon", "rare"]
				},
				"chance": 25,
				"amount": [1, 1]
			}
		],
		"hostileRaces": ["Wraith"]
	}
]
