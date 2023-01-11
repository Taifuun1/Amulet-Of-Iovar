var bosses = [
	{
		"critterName": "Tidoh Tel'hydrad",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 12,
		"texture": load("res://Assets/Critters/TidohTel'hydrad.png"),
		"alignment": "Neutral",
		"level": 11,
		"expDropAmount": 135,
		"hp": 51,
		"mp": 67,
		"ac": 6,
		"attacks": [
			{
				"dmg": [3,5],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
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
			"strength": 13,
			"legerity": 13,
			"balance": 12,
			"belief": 21,
			"visage": 18,
			"wisdom": 18
		},
		"abilities": [
			{
				"abilityName": "rockThrow",
				"abilityType": "rangedSpell",
				"chance": 5
			},
			{
				"abilityName": "frostBite",
				"abilityType": "rangedSpell",
				"chance": 2
			},
			{
				"abilityName": "createShield",
				"abilityType": "selfCastspell",
				"chance": 1
			}
		],
		"abilityHits": [1,0,1,0,0],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [50, 150]
			},
			{
				"types": {
					"wand": ["common", "uncommon", "rare"]
				},
				"chance": 50,
				"amount": [1, 2],
				"tries": 8
			},
			{
				"types": {
					"rune": ["rare"]
				},
				"chance": 15,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Elhybar",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 12,
		"texture": load("res://Assets/Critters/Elhybar.png"),
		"alignment": "Neutral",
		"level": 7,
		"expDropAmount": 77,
		"hp": 51,
		"mp": 67,
		"ac": 6,
		"attacks": [
			{
				"dmg": [2,3],
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
				"abilityName": "fleirnado",
				"abilityType": "rangedSpell",
				"chance": 2
			},
			{
				"abilityName": "frostBite",
				"abilityType": "rangedSpell",
				"chance": 2
			},
			{
				"abilityName": "thundersplit",
				"abilityType": "rangedSpell",
				"chance": 2
			},
			{
				"abilityName": "createShield",
				"abilityType": "selfCastSpell",
				"chance": 1
			},
			{
				"abilityName": "fleirMiasma",
				"abilityType": "spell",
				"chance": 1
			}
		],
		"abilityHits": [1,1,0,1],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [500, 1000]
			},
			{
				"types": {
					"scroll": ["common", "uncommon", "rare"]
				},
				"chance": 100,
				"amount": [1, 8],
				"tries": 11
			},
			{
				"types": {
					"rune": ["rare"]
				},
				"chance": 75,
				"amount": [1, 1],
				"tries": 4
			}
		]
	},
	{
		"critterName": "Shin'kor Leve'er",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 12,
		"texture": load("res://Assets/Critters/Shin'korLeve'er.png"),
		"alignment": "Neutral",
		"level": 16,
		"expDropAmount": 1395,
		"hp": 61,
		"mp": 67,
		"ac": 6,
		"attacks": [
			{
				"dmg": [12,16],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [12,16],
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
				"abilityName": "sharpenSword",
				"abilityType": "selfCastSpell",
				"chance": 8
			}
		],
		"abilityHits": [1,0,0,0,0,0,0,0],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [50, 150]
			},
			{
				"types": {
					"armor": ["uncommon", "rare"]
				},
				"chance": 100,
				"amount": [1, 1]
			},
			{
				"types": {
					"weapon": ["uncommon", "rare"]
				},
				"chance": 100,
				"amount": [1, 1],
				"tries": 5
			}
		]
	},
	{
		"critterName": "Mad Banana-hunter Ogre",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 8,
		"texture": load("res://Assets/Critters/MadBanana-hunterOgre.png"),
		"alignment": "Neutral",
		"level": 14,
		"expDropAmount": 443,
		"hp": 87,
		"mp": 67,
		"ac": 6,
		"attacks": [
			{
				"dmg": [20,25],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,0,0,1,1,1,1,0,0,1,1,1,0,1,1,0],
		"stats": {
			"strength": 13,
			"legerity": 13,
			"balance": 12,
			"belief": 21,
			"visage": 18,
			"wisdom": 18
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [250, 500]
			},
			{
				"types": {
					"comestible": ["common", "uncommon", "rare"]
				},
				"chance": 90,
				"amount": [2, 12],
				"tries": 10
			}
		]
	},
	{
		"critterName": "Elder Dragon",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 12,
		"texture": load("res://Assets/Critters/ElderDragon.png"),
		"alignment": "Neutral",
		"level": 32,
		"expDropAmount": 5890,
		"hp": 148,
		"mp": 89,
		"ac": 15,
		"attacks": [
			{
				"dmg": [26,32],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [12,16],
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
			"strength": 25,
			"legerity": 25,
			"balance": 25,
			"belief": 25,
			"visage": 50,
			"wisdom": 30
		},
		"abilities": [
			{
				"abilityName": "elderDragonBreath",
				"abilityType": "rangedSpell",
				"chance": 8
			}
		],
		"abilityHits": [1,1,0,1,0,0],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [10000, 21030]
			},
			{
				"types": {
					"gem": ["rare"]
				},
				"chance": 100,
				"amount": [5, 15],
				"tries": 5
			},
			{
				"names": "Dragonslayer",
				"chance": 100,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Iovar",
		"race": "Human",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": -1,
		"texture": load("res://Assets/Critters/Iovar.png"),
		"alignment": "Neutral",
		"level": 55,
		"expDropAmount": 2112,
		"hp": 170,
		"mp": 276,
		"ac": 10,
		"attacks": [
			{
				"dmg": [16,16],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [11,11],
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
			"strength": 18,
			"legerity": 18,
			"balance": 18,
			"belief": 50,
			"visage": 30,
			"wisdom": 80
		},
		"abilities": [
			{
				"abilityName": "summonCritters",
				"abilityType": "spell",
				"chance": 4
			},
			{
				"abilityName": "voidBlast",
				"abilityType": "rangedSpell",
				"chance": 2
			},
			{
				"abilityName": "frostTouch",
				"abilityType": "meleeSpell",
				"chance": 1
			},
			{
				"abilityName": "thunderPoint",
				"abilityType": "rangedSpell",
				"chance": 1
			}
		],
		"abilityHits": [1,1,1,1,0],
		"resistances": [],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [5000, 6140]
			},
			{
				"types": {
					"scroll": ["uncommon", "rare", "legendary"],
					"tool": ["rare"]
				},
				"chance": 100,
				"amount": [1, 3],
				"tries": 5
			},
			{
				"names": "Cloak of magical ambiguity",
				"chance": 100,
				"amount": [1, 1]
			}
		]
	}
]
