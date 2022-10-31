var blobs = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Slerp",
			"race": "Blobs",
			"class": "Natural hazard",
			"weight": 50,
			"aI": "Aggressive",
			"aggroDistance": 2,
			"texture": load("res://Assets/Critters/BlobSlerp.png"),
			"alignment": "Neutral",
			"level": 4,
			"expDropAmount": 16,
			"hp": 9,
			"mp": 0,
			"ac": 0,
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
				}
			]
		},
		{
			"critterName": "Sluerp",
			"race": "Blobs",
			"class": "Natural hazard",
			"weight": 50,
			"aI": "Aggressive",
			"aggroDistance": 2,
			"texture": load("res://Assets/Critters/BlobSluerp.png"),
			"alignment": "Neutral",
			"level": 4,
			"expDropAmount": 16,
			"hp": 9,
			"mp": 0,
			"ac": 0,
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
				}
			]
		}
	]
}
