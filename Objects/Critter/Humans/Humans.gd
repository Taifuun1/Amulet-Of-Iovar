var humans = {
	"hostile": ["orcs"],
	"critterTypes": [
		{
			"critterName": "Shopkeeper",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Neutral",
			"aggroDistance": 2,
			"texture": load("res://Assets/Critters/HumanShopkeeper.png"),
			"alignment": "Neutral",
			"level": 8,
			"expDropAmount": 105,
			"hp": 29,
			"mp": 11,
			"ac": 0,
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
				"strength": 9,
				"legerity": 8,
				"balance": 10,
				"belief": 8,
				"visage": 8,
				"wisdom": 8
			},
			"abilities": [],
			"abilityHits": [],
			"resistances": [],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [500, 1500]
				}
			]
		},
		{
			"critterName": "Guard",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Neutral",
			"aggroDistance": 9,
			"texture": load("res://Assets/Critters/HumanGuard.png"),
			"alignment": "Neutral",
			"level": 9,
			"expDropAmount": 152,
			"hp": 33,
			"mp": 8,
			"ac": 5,
			"attacks": [
				{
					"dmg": [8,11],
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
				"strength": 12,
				"legerity": 9,
				"balance": 14,
				"belief": 8,
				"visage": 8,
				"wisdom": 8
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
			"critterName": "Guard captain",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Neutral",
			"aggroDistance": 11,
			"texture": load("res://Assets/Critters/HumanGuardCaptain.png"),
			"alignment": "Neutral",
			"level": 13,
			"expDropAmount": 302,
			"hp": 45,
			"mp": 10,
			"ac": 7,
			"attacks": [
				{
					"dmg": [9,12],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [5,6],
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
			"critterName": "Outlaw watcher",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 9,
			"texture": load("res://Assets/Critters/HumanOutlawWatcher.png"),
			"alignment": "Neutral",
			"level": 6,
			"expDropAmount": 86,
			"hp": 23,
			"mp": 3,
			"ac": 2,
			"attacks": [
				{
					"dmg": [4,7],
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
			"critterName": "Outlaw fusiee'er",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 11,
			"texture": load("res://Assets/Critters/HumanOutlawFusiee'er.png"),
			"alignment": "Neutral",
			"level": 9,
			"expDropAmount": 109,
			"hp": 45,
			"mp": 10,
			"ac": 3,
			"attacks": [
				{
					"dmg": [3,4],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [3,4],
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
			"critterName": "Outlaw merchandiee'er",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 11,
			"texture": load("res://Assets/Critters/HumanOutlawMerchandiee'er.png"),
			"alignment": "Neutral",
			"level": 11,
			"expDropAmount": 198,
			"hp": 45,
			"mp": 21,
			"ac": 6,
			"attacks": [
				{
					"dmg": [9,12],
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
			"critterName": "Iovars cultist acolyte",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 24,
			"texture": load("res://Assets/Critters/HumanIovarsCultistAcolyte.png"),
			"alignment": "Neutral",
			"level": 13,
			"expDropAmount": 650,
			"hp": 44,
			"mp": 48,
			"ac": 5,
			"attacks": [
				{
					"dmg": [3,6],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [3,6],
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
			"critterName": "Iovars cultist",
			"race": "Human",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": -1,
			"texture": load("res://Assets/Critters/HumanIovarsCultist.png"),
			"alignment": "Neutral",
			"level": 16,
			"expDropAmount": 1120,
			"hp": 55,
			"mp": 67,
			"ac": 6,
			"attacks": [
				{
					"dmg": [5,6],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [5,6],
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
					"abilityName": "thundersplit",
					"abilityType": "rangedSpell",
					"chance": 8
				}
			],
			"abilityHits": [1,0,1,0],
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
