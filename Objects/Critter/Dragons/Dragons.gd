var dragons = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Black dragon",
			"race": "Dragon",
			"class": "Ancient",
			"weight": 2000,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/DragonBlackDragon.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 7771,
			"hp": 160,
			"mp": 60,
			"ac": 10,
			"attacks": [
				{
					"dmg": [22,28],
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
				"visage": 30,
				"wisdom": 48
			},
			"abilities": [
				{
					"abilityName": "dragonBreath",
					"abilityType": "rangedSpell",
					"chance": 8
				}
			],
			"abilityHits": [1,1,0,1,0],
			"resistances": [],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 100,
					"amount": [2500, 5000]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 100,
					"amount": [3, 8]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 25,
					"amount": [2, 4]
				}
			]
		},
		{
			"critterName": "Blue dragon",
			"race": "Dragons",
			"class": "Ancient",
			"weight": 2000,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/DragonBlueDragon.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 7771,
			"hp": 160,
			"mp": 60,
			"ac": 10,
			"attacks": [
				{
					"dmg": [22,28],
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
				"visage": 30,
				"wisdom": 48
			},
			"abilities": [
				{
					"abilityName": "frostBreath",
					"abilityType": "rangedSpell",
					"chance": 8
				}
			],
			"abilityHits": [1,1,0,1,0],
			"resistances": ["frost"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 100,
					"amount": [2500, 5000]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 100,
					"amount": [3, 8]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 25,
					"amount": [2, 4]
				}
			]
		},
		{
			"critterName": "Cyan dragon",
			"race": "Dragons",
			"class": "Ancient",
			"weight": 2000,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/DragonCyanDragon.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 7771,
			"hp": 160,
			"mp": 60,
			"ac": 10,
			"attacks": [
				{
					"dmg": [22,28],
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
				"visage": 30,
				"wisdom": 48
			},
			"abilities": [
				{
					"abilityName": "dragonBeath",
					"abilityType": "rangedSpell",
					"chance": 8
				}
			],
			"abilityHits": [1,1,0,1,0],
			"resistances": ["confusion"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 100,
					"amount": [2500, 5000]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 100,
					"amount": [3, 8]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 25,
					"amount": [2, 4]
				}
			]
		},
		{
			"critterName": "Green dragon",
			"race": "Dragons",
			"class": "Ancient",
			"weight": 2000,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/DragonGreenDragon.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 7771,
			"hp": 160,
			"mp": 60,
			"ac": 10,
			"attacks": [
				{
					"dmg": [22,28],
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
				"visage": 30,
				"wisdom": 48
			},
			"abilities": [
				{
					"abilityName": "gleeieerBreath",
					"abilityType": "rangedSpell",
					"chance": 8
				}
			],
			"abilityHits": [1,1,0,1,0],
			"resistances": ["fumbling"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 100,
					"amount": [2500, 5000]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 100,
					"amount": [3, 8]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 25,
					"amount": [2, 4]
				}
			]
		},
		{
			"critterName": "Red dragon",
			"race": "Dragons",
			"class": "Ancient",
			"weight": 2000,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/DragonRedDragon.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 7771,
			"hp": 160,
			"mp": 60,
			"ac": 10,
			"attacks": [
				{
					"dmg": [22,28],
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
				"visage": 30,
				"wisdom": 48
			},
			"abilities": [
				{
					"abilityName": "fleirBreath",
					"abilityType": "rangedSpell",
					"chance": 8
				}
			],
			"abilityHits": [1,1,0,1,0],
			"resistances": ["fleir"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 100,
					"amount": [2500, 5000]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 100,
					"amount": [3, 8]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 25,
					"amount": [2, 4]
				}
			]
		},
		{
			"critterName": "Silver dragon",
			"race": "Dragons",
			"class": "Ancient",
			"weight": 2000,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/DragonSilverDragon.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 7771,
			"hp": 160,
			"mp": 60,
			"ac": 10,
			"attacks": [
				{
					"dmg": [22,28],
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
				"visage": 30,
				"wisdom": 48
			},
			"abilities": [
				{
					"abilityName": "dragonBreath",
					"abilityType": "rangedSpell",
					"chance": 8
				},
				{
					"abilityName": "reflection",
					"abilityType": "onHit",
				}
			],
			"abilityHits": [1,1,0,1,0],
			"resistances": [],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 100,
					"amount": [2500, 5000]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 100,
					"amount": [3, 8]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 25,
					"amount": [2, 4]
				}
			]
		},
		{
			"critterName": "Violet dragon",
			"race": "Dragons",
			"class": "Ancient",
			"weight": 2000,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/DragonVioletDragon.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 7771,
			"hp": 160,
			"mp": 60,
			"ac": 10,
			"attacks": [
				{
					"dmg": [22,28],
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
				"visage": 30,
				"wisdom": 48
			},
			"abilities": [
				{
					"abilityName": "dragonBreath",
					"abilityType": "rangedSpell",
					"chance": 8
				}
			],
			"abilityHits": [1,1,0,1,0],
			"resistances": ["stun"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 100,
					"amount": [2500, 5000]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 100,
					"amount": [3, 8]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 25,
					"amount": [2, 4]
				}
			]
		},
		{
			"critterName": "White dragon",
			"race": "Dragons",
			"class": "Ancient",
			"weight": 2000,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/DragonWhiteDragon.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 7771,
			"hp": 160,
			"mp": 60,
			"ac": 10,
			"attacks": [
				{
					"dmg": [22,28],
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
				"visage": 30,
				"wisdom": 48
			},
			"abilities": [
				{
					"abilityName": "dragonBreath",
					"abilityType": "rangedSpell",
					"chance": 8
				}
			],
			"abilityHits": [1,1,0,1,0],
			"resistances": ["stun"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 100,
					"amount": [2500, 5000]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 100,
					"amount": [3, 8]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 25,
					"amount": [2, 4]
				}
			]
		},
		{
			"critterName": "Yellow dragon",
			"race": "Dragons",
			"class": "Ancient",
			"weight": 2000,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/DragonYellowDragon.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 7771,
			"hp": 160,
			"mp": 60,
			"ac": 10,
			"attacks": [
				{
					"dmg": [22,28],
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
				"visage": 30,
				"wisdom": 48
			},
			"abilities": [
				{
					"abilityName": "thunderBreath",
					"abilityType": "rangedSpell",
					"chance": 8
				}
			],
			"abilityHits": [1,1,0,1,0],
			"resistances": ["thunder"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 100,
					"amount": [2500, 5000]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 100,
					"amount": [3, 8]
				},
				{
					"names": [
						"Apatite",
						"Citrine",
						"Moonstone",
						"Morganite",
						"Onyx",
						"Peridot",
						"Ruby",
						"Sapphire"
					],
					"chance": 25,
					"amount": [2, 4]
				}
			]
		}
	]
}
