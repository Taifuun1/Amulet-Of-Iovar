var blobs = {
	"hostile": [],
	"critterTypes": [
		{
			"critterName": "Slerp",
			"race": "Blobs",
			"class": "Natural hazard",
			"weight": 50,
			"aI": "Aggressive",
			"texture": load("res://Assets/Critters/BlobSlerp.png"),
			"alignment": "Neutral",
			"level": 4,
			"expDropAmount": 16,
			"hp": 9,
			"mp": 0,
			"ac": 0,
			"hits": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			"stats": {
				"strength": 1,
				"legerity": 1,
				"balance": 1,
				"belief": 1,
				"visage": 1,
				"wisdom": 1
			},
			"abilities": ["toxix"],
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
			"texture": load("res://Assets/Critters/BlobSluerp.png"),
			"alignment": "Neutral",
			"level": 4,
			"expDropAmount": 16,
			"hp": 9,
			"mp": 0,
			"ac": 0,
			"hits": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			"stats": {
				"strength": 1,
				"legerity": 1,
				"balance": 1,
				"belief": 1,
				"visage": 1,
				"wisdom": 1
			},
			"abilities": ["corrosion"],
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
