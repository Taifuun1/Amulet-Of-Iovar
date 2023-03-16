var dwarves = [
	{
		"critterName": "Dwarf miner",
		"race": "Dwarf",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Miner",
		"aggroDistance": 5,
		"texture": load("res://Assets/Critters/DwarfMiner.png"),
		"piety": "Neutral",
		"level": 6,
		"expDropAmount": 5,
		"hp": 16,
		"mp": 5,
		"ac": 2,
		"magicac": 0,
		"attacks": [
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
				"amount": [15, 25]
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
		"hostileRaces": ["Elf", "Goblin", "Orc"]
	},
	{
		"critterName": "Dwarf engineer",
		"race": "Dwarf",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 7,
		"texture": load("res://Assets/Critters/DwarfEngineer.png"),
		"piety": "Neutral",
		"level": 8,
		"expDropAmount": 8,
		"hp": 32,
		"mp": 5,
		"ac": 9,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [5,6],
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
				"amount": [15, 25]
			}
		],
		"hostileRaces": ["Elf", "Goblin", "Orc"]
	},
	{
		"critterName": "Dwarf smith",
		"race": "Dwarf",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 7,
		"texture": load("res://Assets/Critters/DwarfSmith.png"),
		"piety": "Neutral",
		"level": 10,
		"expDropAmount": 14,
		"hp": 33,
		"mp": 5,
		"ac": 14,
		"magicac": 0,
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
				"amount": [25, 45]
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
		"hostileRaces": ["Elf", "Goblin", "Orc"]
	},
	{
		"critterName": "Dwarven contirer",
		"race": "Dwarf",
		"class": "Humanoid",
		"weight": 200,
		"aI": "Aggressive",
		"aggroDistance": 9,
		"texture": load("res://Assets/Critters/DwarfContirer.png"),
		"piety": "Neutral",
		"level": 18,
		"expDropAmount": 186,
		"hp": 52,
		"mp": 5,
		"ac": 20,
		"magicac": 5,
		"attacks": [
			{
				"dmg": [18,25],
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
				"amount": [200, 250]
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
		"hostileRaces": ["Elf", "Goblin", "Orc"]
	}
]
