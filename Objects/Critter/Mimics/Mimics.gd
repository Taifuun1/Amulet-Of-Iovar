var mimics = [
	{
		"critterName": "Mimic",
		"race": "Mimic",
		"class": "Natural hazard",
		"weight": 100,
		"aI": "Mimicking",
		"aggroDistance": 4,
		"texture": load("res://Assets/Critters/MimicMimic.png"),
		"alignment": "Neutral",
		"level": 8,
		"expDropAmount": 13,
		"hp": 16,
		"mp": 13,
		"ac": 3,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [4,5],
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
		"alignment": "Neutral",
		"level": 14,
		"expDropAmount": 44,
		"hp": 46,
		"mp": 23,
		"ac": 7,
		"magicac": 0,
		"attacks": [
			{
				"dmg": [12,15],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			{
				"dmg": [5,7],
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
