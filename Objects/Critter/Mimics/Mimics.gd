var mimics = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Mimic",
			"race": "Mimic",
			"class": "Natural hazard",
			"weight": 100,
			"aI": "Skulking",
			"aggroDistance": 4,
			"texture": load("res://Assets/Critters/MimicMimic.png"),
			"alignment": "Neutral",
			"level": 8,
			"attacks": [
				{
					"dmg": [8,10],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [4,8],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				}
			],
			"expDropAmount": 145,
			"hp": 23,
			"mp": 13,
			"ac": 3,
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
					"abilityName": "mimicBox",
					"abilityType": "selfCastSpell"
				}
			],
			"abilityHits": [0,0,0,0,0,0,0,1],
			"resistances": ["thunder", "sleep"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [50, 150]
				}
			]
		},
		{
			"critterName": "Humongous mimic",
			"race": "Mimic",
			"class": "Natural hazard",
			"weight": 350,
			"aI": "Skulking",
			"aggroDistance": 6,
			"texture": load("res://Assets/Critters/MimicHumongousMimic.png"),
			"alignment": "Neutral",
			"level": 14,
			"expDropAmount": 1283,
			"hp": 38,
			"mp": 23,
			"ac": 7,
			"attacks": [
				{
					"dmg": [13,16],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
						"element": null
					}
				},
				{
					"dmg": [5,7],
					"bonusDmg": {},
					"armorPen": 0,
					"magicDmg": {
						"dmg": 0,
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
					"abilityName": "mimicChest",
					"abilityType": "selfCastSpell"
				}
			],
			"abilityHits": [0,0,0,0,0,0,0,1],
			"resistances": ["thunder", "sleep"],
			"drops": [
				{
					"names": "goldPieces",
					"chance": 50,
					"amount": [50, 150]
				}
			]
		}
	]
}
