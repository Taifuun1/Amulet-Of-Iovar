var floatingSpheres = [
	{
		"critterName": "Floating eye",
		"race": "Floating sphere",
		"class": "Natural hazard",
		"weight": 150,
		"aI": "Slow aggressive",
		"aggroDistance": 3,
		"texture": load("res://Assets/Critters/FloatingSphereFloatingEye.png"),
		"piety": "Slow Aggressive",
		"level": 3,
		"expDropAmount": 7,
		"hp": 7,
		"mp": 4,
		"ac": 0,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [1,1],
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
			"strength": 1,
			"legerity": 1,
			"balance": 1,
			"belief": 1,
			"visage": 1,
			"wisdom": 13
		},
		"abilities": [
			{
				"abilityName": "reflectStun",
				"abilityType": "onHit"
			}
		],
		"abilityHits": [1],
		"resistances": [],
		"drops": [
			{
				"names": "Potion of heal",
				"chance": 50,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Unstable floating sphere",
		"race": "Floating sphere",
		"class": "Natural hazard",
		"weight": 150,
		"aI": "Slow Aggressive",
		"aggroDistance": 3,
		"texture": load("res://Assets/Critters/FloatingSphereUnstableFloatingSphere.png"),
		"level": 4,
		"expDropAmount": 12,
		"hp": 13,
		"mp": 4,
		"ac": 0,
		"magicac": 0,
		"attacks": [],
		"hits": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
		"stats": {
			"strength": 1,
			"legerity": 1,
			"balance": 1,
			"belief": 1,
			"visage": 1,
			"wisdom": 17
		},
		"abilities": [
			{
				"abilityName": "selfdestruct",
				"abilityType": "onAttack"
			}
		],
		"abilityHits": [1],
		"resistances": [],
		"drops": [
			{
				"names": "Potion of Toxix",
				"chance": 100,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Freezing floating sphere",
		"race": "Floating sphere",
		"class": "Natural hazard",
		"weight": 150,
		"aI": "Aggressive",
		"aggroDistance": 5,
		"texture": load("res://Assets/Critters/FloatingSphereFreezingFloatingSphere.png"),
		"level": 6,
		"expDropAmount": 18,
		"hp": 14,
		"mp": 5,
		"ac": 0,
		"magicac": 0,
		"attacks": [],
		"hits": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
		"stats": {
			"strength": 1,
			"legerity": 1,
			"balance": 1,
			"belief": 1,
			"visage": 1,
			"wisdom": 17
		},
		"abilities": [
			{
				"abilityName": "frostSelfdestruct",
				"abilityType": "onAttack"
			}
		],
		"abilityHits": [1],
		"resistances": [],
		"drops": [
			{
				"names": "Potion of blindness",
				"chance": 100,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Thunderous floating sphere",
		"race": "Floating sphere",
		"class": "Natural hazard",
		"weight": 150,
		"aI": "Aggressive",
		"aggroDistance": 7,
		"texture": load("res://Assets/Critters/FloatingSphereThunderousFloatingSphere.png"),
		"level": 8,
		"expDropAmount": 44,
		"hp": 17,
		"mp": 7,
		"ac": 0,
		"magicac": 0,
		"attacks": [],
		"hits": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
		"stats": {
			"strength": 1,
			"legerity": 1,
			"balance": 1,
			"belief": 1,
			"visage": 1,
			"wisdom": 17
		},
		"abilities": [
			{
				"abilityName": "thunderSelfdestruct",
				"abilityType": "onAttack"
			}
		],
		"abilityHits": [1],
		"resistances": [],
		"drops": [
			{
				"names": "Potion of paralysis",
				"chance": 100,
				"amount": [1, 1]
			}
		]
	}
]
