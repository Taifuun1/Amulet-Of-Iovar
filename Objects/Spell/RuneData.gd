var runeData = {
	"eario": {
		"fleir": "#FA535C",
		"frost": "#25d1ff",
		"thunder": "#F1FB36",
		"gleeie'er": "#3AFFCB",
		"toxix": "#87DB4D",
	},
	"luirio": {
		"point": {
			"distance": 99
		},
		"line": {
			"distance": 15,
			"spellDirections": {
				Vector2(0,-1): {
					"angle": 0
				},
				Vector2(1,-1): {
					"angle": 45
				},
				Vector2(1,0): {
					"angle": 90
				},
				Vector2(1,1): {
					"angle": 135
				},
				Vector2(0,1): {
					"angle": 180
				},
				Vector2(-1,1): {
					"angle": 225
				},
				Vector2(-1,0): {
					"angle": 270
				},
				Vector2(-1,-1): {
					"angle": 315
				}
			}
		},
		"cone": {
			"distance": 5,
			"spellDirections": {
				Vector2(0,-1): [
					{
						"angle": 315,
						"direction": Vector2(-1,-1)
					},
					{
						"angle": 0,
						"direction": Vector2(0,-1)
					},
					{
						"angle": 45,
						"direction": Vector2(1,-1)
					}
				],
				Vector2(1,-1): [
					{
						"angle": 0,
						"direction": Vector2(0,-1)
					},
					{
						"angle": 45,
						"direction": Vector2(1,-1)
					},
					{
						"angle": 90,
						"direction": Vector2(1,0)
					}
				],
				Vector2(1,0): [
					{
						"angle": 45,
						"direction": Vector2(1,-1)
					},
					{
						"angle": 90,
						"direction": Vector2(1,0)
					},
					{
						"angle": 135,
						"direction": Vector2(1,1)
					}
				],
				Vector2(1,1): [
					{
						"angle": 90,
						"direction": Vector2(1,0)
					},
					{
						"angle": 135,
						"direction": Vector2(1,1)
					},
					{
						"angle": 180,
						"direction": Vector2(0,1)
					}
				],
				Vector2(0,1): [
					{
						"angle": 135,
						"direction": Vector2(1,1)
					},
					{
						"angle": 180,
						"direction": Vector2(0,1)
					},
					{
						"angle": 225,
						"direction": Vector2(-1,1)
					}
				],
				Vector2(-1,1): [
					{
						"angle": 180,
						"direction": Vector2(0,1)
					},
					{
						"angle": 225,
						"direction": Vector2(-1,1)
					},
					{
						"angle": 270,
						"direction": Vector2(-1,0)
					}
				],
				Vector2(-1,0): [
					{
						"angle": 225,
						"direction": Vector2(-1,1)
					},
					{
						"angle": 270,
						"direction": Vector2(-1,0)
					},
					{
						"angle": 315,
						"direction": Vector2(-1,-1)
					}
				],
				Vector2(-1,-1): [
					{
						"angle": 270,
						"direction": Vector2(-1,0)
					},
					{
						"angle": 315,
						"direction": Vector2(-1,-1)
					},
					{
						"angle": 0,
						"direction": Vector2(0,-1)
					}
				]
			}
		},
		"adjacent": {
			"distance": 0,
			"spellDirections": [
				{
					"angle": 90,
					"direction": Vector2(0,-1)
				},
				{
					"angle": 135,
					"direction": Vector2(1,-1)
				},
				{
					"angle": 180,
					"direction": Vector2(1,0)
				},
				{
					"angle": 225,
					"direction": Vector2(1,1)
				},
				{
					"angle": 270,
					"direction": Vector2(0,1)
				},
				{
					"angle": 315,
					"direction": Vector2(-1,1)
				},
				{
					"angle": 0,
					"direction": Vector2(-1,0)
				},
				{
					"angle": 45,
					"direction": Vector2(-1,-1)
				}
			]
		},
		"fourway": {
			"distance": 7,
			"spellDirections": {
				Vector2(0,-1): [
					{
						"angle": 0,
						"direction": Vector2(0,-1)
					},
					{
						"angle": 90,
						"direction": Vector2(1,0)
					},
					{
						"angle": 0,
						"direction": Vector2(0,1)
					},
					{
						"angle": 90,
						"direction": Vector2(-1,0)
					}
				],
				Vector2(1,0): [
					{
						"angle": 0,
						"direction": Vector2(0,-1)
					},
					{
						"angle": 90,
						"direction": Vector2(1,0)
					},
					{
						"angle": 0,
						"direction": Vector2(0,1)
					},
					{
						"angle": 90,
						"direction": Vector2(-1,0)
					}
				],
				Vector2(0,1): [
					{
						"angle": 0,
						"direction": Vector2(0,-1)
					},
					{
						"angle": 90,
						"direction": Vector2(1,0)
					},
					{
						"angle": 0,
						"direction": Vector2(0,1)
					},
					{
						"angle": 90,
						"direction": Vector2(-1,0)
					}
				],
				Vector2(-1,0): [
					{
						"angle": 0,
						"direction": Vector2(0,-1)
					},
					{
						"angle": 90,
						"direction": Vector2(1,0)
					},
					{
						"angle": 0,
						"direction": Vector2(0,1)
					},
					{
						"angle": 90,
						"direction": Vector2(-1,0)
					}
				],
				Vector2(1,-1): [
					{
						"angle": 45,
						"direction": Vector2(1,-1)
					},
					{
						"angle": 135,
						"direction": Vector2(1,1)
					},
					{
						"angle": 45,
						"direction": Vector2(-1,1)
					},
					{
						"angle": 135,
						"direction": Vector2(-1,-1)
					}
				],
				Vector2(1,1): [
					{
						"angle": 45,
						"direction": Vector2(1,-1)
					},
					{
						"angle": 135,
						"direction": Vector2(1,1)
					},
					{
						"angle": 45,
						"direction": Vector2(-1,1)
					},
					{
						"angle": 135,
						"direction": Vector2(-1,-1)
					}
				],
				Vector2(-1,1): [
					{
						"angle": 45,
						"direction": Vector2(1,-1)
					},
					{
						"angle": 135,
						"direction": Vector2(1,1)
					},
					{
						"angle": 45,
						"direction": Vector2(-1,1)
					},
					{
						"angle": 135,
						"direction": Vector2(-1,-1)
					}
				],
				Vector2(-1,-1): [
					{
						"angle": 45,
						"direction": Vector2(1,-1)
					},
					{
						"angle": 135,
						"direction": Vector2(1,1)
					},
					{
						"angle": 45,
						"direction": Vector2(-1,1)
					},
					{
						"angle": 135,
						"direction": Vector2(-1,-1)
					}
				]
			}
		}
	},
	"heario": {
		"true": {
			"dmgMultiplier": 1,
			"effectMultiplier": 2,
			"texture": load("res://Assets/Spells/True.png")
		},
		"bolt": {
			"dmgMultiplier": 0.75,
			"effectMultiplier": 1,
			"texture": load("res://Assets/Spells/Bolt.png")
		},
		"fragment": {
			"dmgMultiplier": 2,
			"effectMultiplier": 0.5,
			"texture": load("res://Assets/Spells/Fragment.png")
		},
		"flow": {
			"dmgMultiplier": 1,
			"effectMultiplier": 0.75,
			"texture": load("res://Assets/Spells/Flow.png")
		},
		"gas": {
			"dmgMultiplier": 0.5,
			"effectMultiplier": 0.5,
			"tick": 10,
			"texture": load("res://Assets/Spells/Gas.png")
		}
	}
}
