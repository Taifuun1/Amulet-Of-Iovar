var bosses = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Tidoh Tel'hydrad",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/TidohTel'hydrad.png"),
			"alignment": "Neutral",
			"level": 8,
			"expDropAmount": 1120,
			"hp": 55,
			"mp": 67,
			"ac": 6,
			"attacks": [
				{
					"dmg": [3,5],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [3,5],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
			"critterName": "Elhybar",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/Elhybar.png"),
			"alignment": "Neutral",
			"level": 10,
			"expDropAmount": 1120,
			"hp": 55,
			"mp": 67,
			"ac": 6,
			"attacks": [
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
		},
		{
			"critterName": "Shin'kor Leve'er",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/Shin'korLeve'er.png"),
			"alignment": "Neutral",
			"level": 12,
			"expDropAmount": 1120,
			"hp": 55,
			"mp": 67,
			"ac": 6,
			"attacks": [
				{
					"dmg": [12,16],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [12,16],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
			"critterName": "Mad Banana-hunter Ogre",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/MadBanana-hunterOgre.png"),
			"alignment": "Neutral",
			"level": 14,
			"expDropAmount": 1120,
			"hp": 55,
			"mp": 67,
			"ac": 6,
			"attacks": [
				{
					"dmg": [20,25],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
		},
		{
			"critterName": "Elder Dragon",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/ElderDragon.png"),
			"alignment": "Neutral",
			"level": 28,
			"expDropAmount": 1120,
			"hp": 138,
			"mp": 89,
			"ac": 15,
			"attacks": [
				{
					"dmg": [26,32],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [12,16],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
		},
		{
			"critterName": "Iovar",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/Iovar.png"),
			"alignment": "Neutral",
			"level": 32,
			"expDropAmount": 20002,
			"hp": 220,
			"mp": 476,
			"ac": 10,
			"attacks": [
				{
					"dmg": [16,16],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [11,11],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
