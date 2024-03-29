var mimics = [
	{
		"critterName": "Mimic",
		"race": "Mimic",
		"class": "Natural hazard",
		"weight": 100,
		"aI": "Mimicking",
		"aggroDistance": 4,
		"texture": load("res://Assets/Critters/MimicMimic.png"),
		"piety": "Neutral",
		"level": 5,
		"expDropAmount": 8,
		"hp": 14,
		"mp": 13,
		"ac": 2,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [3,3],
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
		"hits": [1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1],
		"stats": {
			"strength": 13,
			"legerity": 4,
			"balance": 4,
			"belief": 4,
			"visage": 6,
			"wisdom": 7
		},
		"abilities": [
			{
				"abilityName": "mimic",
				"abilityType": "skill"
			}
		],
		"abilityHits": [0,0,0,0,0,0,0,1],
		"resistances": ["thunder", "sleep"],
		"drops": []
	},
	{
		"critterName": "Humongous mimic",
		"race": "Mimic",
		"class": "Natural hazard",
		"weight": 350,
		"aI": "Mimicking",
		"aggroDistance": 5,
		"texture": load("res://Assets/Critters/MimicHumongousMimic.png"),
		"piety": "Neutral",
		"level": 10,
		"expDropAmount": 44,
		"hp": 42,
		"mp": 23,
		"ac": 10,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [11,14],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
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
		"hits": [1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1],
		"stats": {
			"strength": 19,
			"legerity": 9,
			"balance": 9,
			"belief": 9,
			"visage": 12,
			"wisdom": 13
		},
		"abilities": [
			{
				"abilityName": "mimic",
				"abilityType": "skill"
			}
		],
		"abilityHits": [0,0,0,0,0,0,0,1],
		"resistances": ["thunder", "sleep"],
		"drops": []
	}
]
