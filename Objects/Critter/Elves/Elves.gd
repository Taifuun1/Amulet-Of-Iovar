var elves = [
	{
		"critterName": "Elf hunter",
		"race": "Elf",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 12,
		"texture": load("res://Assets/Critters/ElfHunter.png"),
		"alignment": "Neutral",
		"level": 5,
		"expDropAmount": 4,
		"hp": 16,
		"mp": 15,
		"ac": 1,
		"attacks": [
			{
				"dmg": [2,3],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
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
		"hits": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0],
		"stats": {
			"strength": 7,
			"legerity": 11,
			"balance": 11,
			"belief": 9,
			"visage": 12,
			"wisdom": 10
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": ["Gleeie'er"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [10, 30]
			},
			{
				"names": [
					"Elvish flail",
					"Elvish cloak"
				],
				"chance": 10,
				"amount": [1, 1]
			}
		],
		"hostileClasses": ["Dwarves", "Goblins", "Orcs"]
	},
	{
		"critterName": "Elf assassin",
		"race": "Elf",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 21,
		"texture": load("res://Assets/Critters/ElfAssassin.png"),
		"alignment": "Neutral",
		"level": 10,
		"expDropAmount": 17,
		"hp": 23,
		"mp": 22,
		"ac": 2,
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
				"dmg": [4,6],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [2,4],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0],
		"stats": {
			"strength": 10,
			"legerity": 16,
			"balance": 13,
			"belief": 13,
			"visage": 16,
			"wisdom": 14
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": ["Gleeie'er"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 25,
				"amount": [50, 60]
			},
			{
				"names": [
					"Elvish cloak"
				],
				"chance": 10,
				"amount": [1, 1]
			}
		],
		"hostileClasses": ["Dwarves", "Goblins", "Orcs"]
	},
	{
		"critterName": "Elf noble",
		"race": "Elf",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 6,
		"texture": load("res://Assets/Critters/ElfNoble.png"),
		"alignment": "Neutral",
		"level": 15,
		"expDropAmount": 128,
		"hp": 56,
		"mp": 37,
		"ac": 4,
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
				"dmg": [12,13],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
		"stats": {
			"strength": 12,
			"legerity": 19,
			"balance": 15,
			"belief": 15,
			"visage": 20,
			"wisdom": 18
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": ["Gleeie'er"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [250, 500]
			},
			{
				"names": [
					"Elvish sword",
					"Elvish mace",
					"Elvish flail",
					"Elvish cloak"
				],
				"chance": 10,
				"amount": [1, 1]
			}
		],
		"hostileClasses": ["Dwarves", "Goblins", "Orcs"]
	},
	{
		"critterName": "Elf king",
		"race": "Elf",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 15,
		"texture": load("res://Assets/Critters/ElfKing.png"),
		"alignment": "Neutral",
		"level": 20,
		"expDropAmount": 1000,
		"hp": 79,
		"mp": 55,
		"ac": 7,
		"attacks": [
			{
				"dmg": [12,14],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [12,14],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [6,14],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [4,5],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
		"stats": {
			"strength": 16,
			"legerity": 25,
			"balance": 19,
			"belief": 19,
			"visage": 36,
			"wisdom": 22
		},
		"abilities": [],
		"abilityHits": [],
		"resistances": ["Gleeie'er"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 50,
				"amount": [2500, 5000]
			},
			{
				"names": "Stormbringer",
				"chance": 100,
				"amount": [1, 1]
			},
			{
				"names": "Adorned helmet",
				"chance": 50,
				"amount": [1, 1]
			}
		],
		"hostileClasses": ["Dwarves", "Goblins", "Orcs"]
	}
]
