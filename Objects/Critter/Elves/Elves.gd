var elves = {
	"hostile": ["dwarves, orcs"],
	"critterTypes": [
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
			"expDropAmount": 24,
			"hp": 15,
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
			"critterName": "Elf assassin",
			"race": "Elf",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 21,
			"texture": load("res://Assets/Critters/ElfAssassin.png"),
			"alignment": "Neutral",
			"level": 10,
			"expDropAmount": 116,
			"hp": 30,
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
					"dmg": [3,5],
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
			"critterName": "Elf noble",
			"race": "Elf",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 6,
			"texture": load("res://Assets/Critters/ElfNoble.png"),
			"alignment": "Neutral",
			"level": 15,
			"expDropAmount": 1650,
			"hp": 48,
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
					"amount": [500, 1500]
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
			"critterName": "Elf king",
			"race": "Elf",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 15,
			"texture": load("res://Assets/Critters/ElfKing.png"),
			"alignment": "Neutral",
			"level": 20,
			"expDropAmount": 14600,
			"hp": 72,
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
