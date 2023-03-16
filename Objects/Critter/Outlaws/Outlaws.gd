var outlaws = [
	{
		"critterName": "Outlaw watcher",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 9,
		"texture": load("res://Assets/Critters/HumanOutlawWatcher.png"),
		"piety": "Neutral",
		"level": 6,
		"expDropAmount": 5,
		"hp": 13,
		"mp": 3,
		"ac": 1,
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
		"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
		"stats": {
			"strength": 10,
			"legerity": 10,
			"balance": 12,
			"belief": 7,
			"visage": 7,
			"wisdom": 7
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [6, 12]
			},
			{
				"types": {
					"armor": ["common"],
					"weapon": ["common"]
				},
				"chance": 50,
				"amount": [1, 1]
			}
		],
		"hostileRaces": ["Rat", "Snake", "Wraith"]
	},
	{
		"critterName": "Outlaw fusiee'er",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 11,
		"texture": load("res://Assets/Critters/HumanOutlawFusiee'er.png"),
		"piety": "Neutral",
		"level": 9,
		"expDropAmount": 13,
		"hp": 28,
		"mp": 10,
		"ac": 3,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [3,4],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [3,4],
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
			"balance": 13,
			"belief": 9,
			"visage": 9,
			"wisdom": 9
		},
		"abilities": [
			{
				"abilityName": "crackerThrow",
				"abilityType": "rangedSpell",
				"chance": 8
			}
		],
		"abilityHits": [1,0,0,1,0],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [10, 18]
			},
			{
				"types": {
					"armor": ["common", "uncommon"],
					"weapon": ["common", "uncommon"]
				},
				"chance": 50,
				"amount": [1, 1]
			}
		],
		"hostileRaces": ["Rat", "Snake", "Wraith"]
	},
	{
		"critterName": "Outlaw merchandiee'er",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 11,
		"texture": load("res://Assets/Critters/HumanOutlawMerchandiee'er.png"),
		"piety": "Neutral",
		"level": 11,
		"expDropAmount": 18,
		"hp": 35,
		"mp": 21,
		"ac": 5,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [10,14],
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
			"strength": 14,
			"legerity": 11,
			"balance": 15,
			"belief": 10,
			"visage": 10,
			"wisdom": 10
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [15, 20]
			},
			{
				"types": {
					"armor": ["common", "uncommon"],
					"weapon": ["common", "uncommon"]
				},
				"chance": 50,
				"amount": [1, 1]
			}
		],
		"hostileRaces": ["Rat", "Snake", "Wraith"]
	}
]
