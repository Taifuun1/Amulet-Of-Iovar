var liches = [
	{
		"critterName": "Half-lich",
		"race": "Lich",
		"class": "Ancient",
		"weight": 100,
		"aI": "Aggressive",
		"aggroDistance": 9,
		"texture": load("res://Assets/Critters/LichHalf-Lich.png"),
		"alignment": "Neutral",
		"level": 12,
		"expDropAmount": 28,
		"hp": 32,
		"mp": 68,
		"ac": 0,
		"attacks": [
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
			"strength": 5,
			"legerity": 8,
			"balance": 10,
			"belief": 31,
			"visage": 8,
			"wisdom": 27
		},
		"abilities": [
			{
				"abilityName": "fleirpoint",
				"abilityType": "rangedSpell",
				"chance": 2
			},
			{
				"abilityName": "frostpoint",
				"abilityType": "rangedSpell",
				"chance": 2
			},
			{
				"abilityName": "thunderPoint",
				"abilityType": "rangedSpell",
				"chance": 2
			},
			{
				"abilityName": "createShield",
				"abilityType": "selfCastSpell",
				"chance": 2
			}
		],
		"abilityHits": [1,0,0,0,1,1,0,0],
		"resistances": ["gleeie'er", "toxix", "blindness", "confusion", "fumbling", "sleep"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 10,
				"amount": [50, 500]
			},
			{
				"types": {
					"amulet": ["uncommon", "rare", "legendary"],
					"ring": ["uncommon", "rare"],
					"scroll": ["uncommon", "rare"],
					"wand": ["uncommon", "rare"]
				},
				"chance": 75,
				"amount": [1, 1]
			},
			{
				"types": {
					"rune": ["rare"]
				},
				"chance": 25,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Lich",
		"race": "Lich",
		"class": "Ancient",
		"weight": 100,
		"aI": "Aggressive",
		"aggroDistance": 13,
		"texture": load("res://Assets/Critters/LichLich.png"),
		"alignment": "Neutral",
		"level": 15,
		"expDropAmount": 105,
		"hp": 52,
		"mp": 84,
		"ac": 0,
		"attacks": [
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
			"strength": 4,
			"legerity": 7,
			"balance": 8,
			"belief": 34,
			"visage": 7,
			"wisdom": 29
		},
		"abilityHits": [1,0,1,0,1,1,0,0],
		"abilities": [
			{
				"abilityName": "frostpoint",
				"abilityType": "rangedSpell",
				"chance": 6
			},
			{
				"abilityName": "summonCritter",
				"abilityType": "spell",
				"chance": 2
			}
		],
		"resistances": ["fleir", "frost", "gleeie'er", "toxix", "blindness", "confusion", "fumbling", "sleep"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 10,
				"amount": [50, 500]
			},
			{
				"types": {
					"amulet": ["uncommon", "rare", "legendary"],
					"ring": ["uncommon", "rare"],
					"scroll": ["uncommon", "rare"],
					"wand": ["uncommon", "rare"]
				},
				"chance": 75,
				"amount": [1, 1]
			},
			{
				"types": {
					"rune": ["rare"]
				},
				"chance": 25,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Grand lich",
		"race": "Lich",
		"class": "Ancient",
		"weight": 100,
		"aI": "Aggressive",
		"aggroDistance": 13,
		"texture": load("res://Assets/Critters/LichGrandLich.png"),
		"alignment": "Neutral",
		"level": 20,
		"expDropAmount": 368,
		"hp": 70,
		"mp": 99,
		"ac": 0,
		"attacks": [
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
			"strength": 3,
			"legerity": 6,
			"balance": 7,
			"belief": 42,
			"visage": 6,
			"wisdom": 45
		},
		"abilities": [
			{
				"abilityName": "fleirpoint",
				"abilityType": "rangedSpell",
				"chance": 4
			},
			{
				"abilityName": "summonCritters",
				"abilityType": "spell",
				"chance": 4
			}
		],
		"abilityHits": [1,1,1,0,1,1,0,1],
		"resistances": ["fleir", "frost", "gleeie'er", "toxix", "stun", "blindness", "confusion", "fumbling", "sleep"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 10,
				"amount": [50, 500]
			},
			{
				"types": {
					"amulet": ["uncommon", "rare", "legendary"],
					"ring": ["uncommon", "rare"],
					"scroll": ["uncommon", "rare"],
					"wand": ["uncommon", "rare"]
				},
				"chance": 75,
				"amount": [1, 1]
			},
			{
				"types": {
					"rune": ["rare"]
				},
				"chance": 25,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Arch-lich",
		"race": "Lich",
		"class": "Ancient",
		"weight": 100,
		"aI": "Aggressive",
		"aggroDistance": 13,
		"texture": load("res://Assets/Critters/LichArch-Lich.png"),
		"alignment": "Neutral",
		"level": 25,
		"expDropAmount": 505,
		"hp": 89,
		"mp": 204,
		"ac": 0,
		"attacks": [  ],
		"hits": [1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0],
		"stats": {
			"strength": 1,
			"legerity": 4,
			"balance": 5,
			"belief": 70,
			"visage": 5,
			"wisdom": 70
		},
		"abilities": [
			{
				"abilityName": "thundersplit",
				"abilityType": "rangedSpell",
				"chance": 2
			},
			{
				"abilityName": "summonCritters",
				"abilityType": "spell",
				"chance": 6
			}
		],
		"abilityHits": [1,1,1,1,1,1,1,0],
		"resistances": ["fleir", "frost", "thunder", "gleeie'er", "toxix", "stun", "blindness", "confusion", "fumbling", "sleep"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 10,
				"amount": [50, 500]
			},
			{
				"types": {
					"amulet": ["uncommon", "rare", "legendary"],
					"ring": ["uncommon", "rare"],
					"scroll": ["uncommon", "rare"],
					"wand": ["uncommon", "rare"]
				},
				"chance": 75,
				"amount": [1, 1]
			},
			{
				"types": {
					"rune": ["rare"]
				},
				"chance": 25,
				"amount": [1, 1]
			}
		]
	}
]
