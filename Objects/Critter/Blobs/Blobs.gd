var blobs = [
	{
		"critterName": "Slerp",
		"race": "Blobs",
		"class": "Natural hazard",
		"weight": 50,
		"aI": "Aggressive",
		"aggroDistance": 3,
		"texture": load("res://Assets/Critters/BlobSlerp.png"),
		"alignment": "Neutral",
		"level": 4,
		"expDropAmount": 2,
		"hp": 11,
		"mp": 0,
		"ac": 0,
		"magicac": 3,
		"attacks": [
			{
				"dmg": [0,2],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1],
		"stats": {
			"strength": 1,
			"legerity": 1,
			"balance": 1,
			"belief": 1,
			"visage": 1,
			"wisdom": 1
		},
		"abilities": [
			{
				"abilityName": "toxixSplash",
				"abilityType": "onHit"
			}
		],
		"abilityHits": [1],
		"resistances": ["fleir", "frost", "toxix"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 25,
				"amount": [5, 10]
			},
			{
				"types": {
					"amulet": ["uncommon", "rare", "legendary"],
					"armor": ["common", "uncommon", "rare", "legendary"],
					"gem": ["common", "uncommon", "rare"],
					"ring": ["uncommon", "rare"],
					"tool": ["common", "uncommon", "rare"],
					"weapon": ["common", "uncommon", "rare", "legendary"]
				},
				"chance": 100,
				"amount": [1, 1]
			}
		]
	},
	{
		"critterName": "Sluerp",
		"race": "Blobs",
		"class": "Natural hazard",
		"weight": 50,
		"aI": "Aggressive",
		"aggroDistance": 3,
		"texture": load("res://Assets/Critters/BlobSluerp.png"),
		"alignment": "Neutral",
		"level": 4,
		"expDropAmount": 2,
		"hp": 11,
		"mp": 0,
		"ac": 0,
		"magicac": 3,
		"attacks": [
			{
				"dmg": [0,2],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			}
		],
		"hits": [0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1],
		"stats": {
			"strength": 1,
			"legerity": 1,
			"balance": 1,
			"belief": 1,
			"visage": 1,
			"wisdom": 1
		},
		"abilities": [
			{
				"abilityName": "corrosion",
				"abilityType": "onHit"
			}
		],
		"abilityHits": [1],
		"resistances": ["fleir", "frost", "toxix"],
		"drops": [
			{
				"names": "goldPieces",
				"chance": 25,
				"amount": [5, 10]
			},
			{
				"types": {
					"amulet": ["uncommon", "rare", "legendary"],
					"armor": ["common", "uncommon", "rare", "legendary"],
					"gem": ["common", "uncommon", "rare"],
					"ring": ["uncommon", "rare"],
					"tool": ["common", "uncommon", "rare"],
					"weapon": ["common", "uncommon", "rare", "legendary"]
				},
				"chance": 100,
				"amount": [1, 1]
			}
		]
	}
]
