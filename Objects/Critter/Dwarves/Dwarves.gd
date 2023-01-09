var dwarves = {
	"hostile": ["elves, orcs"],
	"critterTypes": [
		{
			"critterName": "Dwarf miner",
			"race": "Dwarf",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Miner",
			"aggroDistance": 5,
			"texture": load("res://Assets/Critters/DwarfMiner.png"),
			"alignment": "Neutral",
			"level": 6,
			"expDropAmount": 40,
			"hp": 22,
			"mp": 5,
			"ac": 2,
			"attacks": [
				{
					"dmg": [4,8],
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
				"strength": 9,
				"legerity": 3,
				"balance": 5,
				"belief": 4,
				"visage": 4,
				"wisdom": 2
			},
			"abilities": [
				{
					"abilityName": "mining",
					"abilityType": "skill"
				}
			],
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
						"Studded boots",
						"Scale ring mail chausses",
						"Studded belt",
						"Dwarvish coat",
						"Leather cloak",
						"Dwarvish laysword"
					],
					"chance": 25,
					"amount": [1, 1]
				},
				{
					"names": [
						"Black glass",
						"Blue glass",
						"Green glass",
						"Pink glass",
						"Red glass",
						"Turqoise glass",
						"White glass",
						"Yellow glass"
					],
					"chance": 75,
					"amount": [1, 2]
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
					"chance": 5,
					"amount": [1, 1]
				}
			],
			"hostileClasses": ["Elves", "Goblins", "Orcs"]
		},
		{
			"critterName": "Dwarf engineer",
			"race": "Dwarf",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 7,
			"texture": load("res://Assets/Critters/DwarfEngineer.png"),
			"alignment": "Neutral",
			"level": 8,
			"expDropAmount": 128,
			"hp": 22,
			"mp": 5,
			"ac": 2,
			"attacks": [
				{
					"dmg": [6,8],
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
				"strength": 8,
				"legerity": 3,
				"balance": 5,
				"belief": 4,
				"visage": 4,
				"wisdom": 2
			},
			"abilities": [],
			"abilityHits": [],
			"resistances": [],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [100, 200]
				}
			]
		},
		{
			"critterName": "Dwarf smith",
			"race": "Dwarf",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 7,
			"texture": load("res://Assets/Critters/DwarfSmith.png"),
			"alignment": "Neutral",
			"level": 10,
			"expDropAmount": 156,
			"hp": 29,
			"mp": 5,
			"ac": 4,
			"attacks": [
				{
					"dmg": [8,12],
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
				"legerity": 4,
				"balance": 9,
				"belief": 3,
				"visage": 3,
				"wisdom": 2
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
						"Studded boots",
						"Scale ring mail chausses",
						"Studded belt",
						"Dwarvish coat",
						"Leather cloak",
						"Dwarvish laysword"
					],
					"chance": 100,
					"amount": [1, 1]
				}
			]
		},
		{
			"critterName": "Dwarven contirer",
			"race": "Dwarf",
			"class": "Humanoid",
			"weight": 200,
			"aI": "Aggressive",
			"aggroDistance": 9,
			"texture": load("res://Assets/Critters/DwarfContirer.png"),
			"alignment": "Neutral",
			"level": 18,
			"expDropAmount": 9880,
			"hp": 62,
			"mp": 5,
			"ac": 10,
			"attacks": [
				{
					"dmg": [18,20],
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
				"strength": 21,
				"legerity": 9,
				"balance": 15,
				"belief": 9,
				"visage": 3,
				"wisdom": 1
			},
			"abilities": [],
			"abilityHits": [],
			"resistances": ["frost", "thunder", "toxix"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [50, 150]
				},
				{
					"names": [
						"Studded boots",
						"Scale ring mail chausses",
						"Studded belt",
						"Dwarvish coat",
						"Leather cloak",
						"Dwarvish laysword"
					],
					"chance": 100,
					"amount": [1, 1],
					"tries": 2
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
					"chance": 35,
					"amount": [2, 11]
				}
			]
		}
	]
}
