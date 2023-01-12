var dwarves = [
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
		"expDropAmount": 8,
		"hp": 17,
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
				"chance": 75,
				"amount": [25, 50]
			},
			{
				"names": [
					"Dwarvish coat",
					"Dwarvish chausses"
				],
				"chance": 5,
				"amount": [1, 1]
			},
			{
				"names": "Pickaxe",
				"chance": 25,
				"amount": [1, 1]
			},
			{
				"types": {
					"gem": ["common", "uncommon", "rare"]
				},
				"chance": 45,
				"amount": [1, 3]
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
		"expDropAmount": 12,
		"hp": 24,
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
				"chance": 75,
				"amount": [50, 75]
			}
		],
		"hostileClasses": ["Elves", "Goblins", "Orcs"]
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
		"expDropAmount": 18,
		"hp": 33,
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
				"chance": 75,
				"amount": [50, 75]
			},
			{
				"names": [
					"Dwarvish coat",
					"Dwarvish chausses"
				],
				"chance": 25,
				"amount": [1, 1]
			},
			{
				"names": [
					"Dwarvish dagger",
					"Dwarvish mace",
					"Dwarvish laysword"
				],
				"chance": 25,
				"amount": [1, 1]
			}
		],
		"hostileClasses": ["Elves", "Goblins", "Orcs"]
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
		"expDropAmount": 378,
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
				"amount": [250, 350]
			},
			{
				"names": [
					"Dwarvish coat",
					"Dwarvish chausses"
				],
				"chance": 25,
				"amount": [1, 1]
			},
			{
				"names": [
					"Dwarvish dagger",
					"Dwarvish mace",
					"Dwarvish laysword"
				],
				"chance": 25,
				"amount": [1, 1]
			},
			{
				"types": {
					"gem": ["rare"]
				},
				"chance": 50,
				"amount": [1, 3]
			}
		],
		"hostileClasses": ["Elves", "Goblins", "Orcs"]
	}
]
