var floatingSpheres = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Floating eye",
			"race": "Floating sphere",
			"class": "Natural hazard",
			"weight": 150,
			"aI": "Neutral",
			"aggroDistance": 6,
			"texture": load("res://Assets/Critters/FloatingSphereFloatingEye.png"),
			"alignment": "Neutral",
			"level": 3,
			"expDropAmount": 10,
			"hp": 8,
			"mp": 4,
			"ac": 0,
			"attacks": [  ],
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
			"abilityHits": [],
			"resistances": [],
			"drops": [  ]
		},
		{
			"critterName": "Unstable floating sphere",
			"race": "Floating sphere",
			"class": "Natural hazard",
			"weight": 150,
			"aI": "Aggressive",
			"aggroDistance": 6,
			"texture": load("res://Assets/Critters/FloatingSphereUnstableFloatingSphere.png"),
			"alignment": "Neutral",
			"level": 6,
			"expDropAmount": 33,
			"hp": 13,
			"mp": 2,
			"ac": 0,
			"attacks": [  ],
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
			"drops": [  ]
		},
		{
			"critterName": "Freezing floating sphere",
			"race": "Floating sphere",
			"class": "Natural hazard",
			"weight": 150,
			"aI": "Aggressive",
			"aggroDistance": 6,
			"texture": load("res://Assets/Critters/FloatingSphereFreezingFloatingSphere.png"),
			"alignment": "Neutral",
			"level": 6,
			"expDropAmount": 38,
			"hp": 13,
			"mp": 2,
			"ac": 0,
			"attacks": [  ],
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
			"drops": [  ]
		},
		{
			"critterName": "Thunderous floating sphere",
			"race": "Floating sphere",
			"class": "Natural hazard",
			"weight": 150,
			"aI": "Aggressive",
			"aggroDistance": 6,
			"texture": load("res://Assets/Critters/FloatingSphereThunderousFloatingSphere.png"),
			"alignment": "Neutral",
			"level": 6,
			"expDropAmount": 38,
			"hp": 13,
			"mp": 2,
			"ac": 0,
			"attacks": [  ],
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
			"drops": [  ]
		}
	]
}
