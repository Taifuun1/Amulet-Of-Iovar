var runeData = {
	"eario": {
		"fleir": {
			"color": "#FA535C",
			"mp": 8
		},
		"frost": {
			"color": "#25d1ff",
			"mp": 4
		},
		"thunder": {
			"color": "#F1FB36",
			"mp": 3
		},
		"gleeie'er": {
			"color": "#3AFFCB",
			"mp": 1
		},
		"toxix": {
			"color": "#87DB4D",
			"mp": 0
		},
	},
	"luirio": {
		"point": {
			"distance": 99,
			"mp": 1
		},
		"line": {
			"distance": 15,
			"mp": 3,
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
			"distance": 4,
			"mp": 7,
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
			"mp": 4,
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
			"mp": 8,
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
			"texture": load("res://Assets/Spells/True.png"),
			"mp": 10
		},
		"bolt": {
			"dmgMultiplier": 0.75,
			"effectMultiplier": 1,
			"texture": load("res://Assets/Spells/Bolt.png"),
			"mp": 5
		},
		"fragment": {
			"dmgMultiplier": 2,
			"effectMultiplier": 0.5,
			"texture": load("res://Assets/Spells/Fragment.png"),
			"mp": 12
		},
		"flow": {
			"dmgMultiplier": 1,
			"effectMultiplier": 1,
			"texture": load("res://Assets/Spells/Flow.png"),
			"mp": 5
		},
		"gas": {
			"dmgMultiplier": 0.5,
			"effectMultiplier": 0.5,
			"tick": 10,
			"texture": load("res://Assets/Spells/Gas.png"),
			"mp": 2
		}
	}
}
