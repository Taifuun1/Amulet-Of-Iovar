var wraiths = [
	{
		"critterName": "Spectral wraith",
		"race": "Wraith",
		"class": "Spiritual",
		"weight": 1,
		"aI": "Slow Aggressive",
		"aggroDistance": 31,
		"texture": load("res://Assets/Critters/WraithSpectralWraith.png"),
		"alignment": "Neutral",
		"level": 5,
		"expDropAmount": 5,
		"hp": 13,
		"mp": 0,
		"ac": 0,
		"magicac": 10,
		"attacks": [
			{
				"dmg": [0,0],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [3,3],
					"element": "Frost"
				}
			}
		],
		"hits": [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
		"stats": {
			"strength": 1,
			"legerity": 1,
			"balance": 1,
			"belief": 9,
			"visage": 1,
			"wisdom": 1
		},
		"abilities": [
			{
				"abilityName": "ghostTouch",
				"abilityType": "onAttack",
			},
			{
				"abilityName": "etherealness",
				"abilityType": "onHit"
			}
		],
		"abilityHits": [0,0,0,0,0,1],
		"resistances": [],
		"drops": [
			{
				"types": {
					"amulet": ["uncommon", "rare"]
				},
				"chance": 20,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Spooky ghost",
		"race": "Wraith",
		"class": "Spiritual",
		"weight": 1,
		"aI": "Aggressive",
		"aggroDistance": 31,
		"texture": load("res://Assets/Critters/WraithSpookyGhost.png"),
		"alignment": "Neutral",
		"level": 8,
		"expDropAmount": 15,
		"hp": 21,
		"mp": 0,
		"ac": 0,
		"magicac": 10,
		"attacks": [
			{
				"dmg": [0,0],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [5,5],
					"element": "Frost"
				}
			}
		],
		"hits": [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0],
		"stats": {
			"strength": 1,
			"legerity": 1,
			"balance": 1,
			"belief": 16,
			"visage": 1,
			"wisdom": 1
		},
		"abilities": [
			{
				"abilityName": "ghostTouch",
				"abilityType": "onAttack",
			},
			{
				"abilityName": "etherealness",
				"abilityType": "onHit"
			}
		],
		"abilityHits": [1,1,0],
		"resistances": [],
		"drops": [
			{
				"types": {
					"amulet": ["uncommon", "rare"]
				},
				"chance": 20,
				"amount": [1, 1]
			}
		]
	}
]
