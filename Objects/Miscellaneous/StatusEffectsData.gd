
var statusEffectsData = {
	"stun": {
		"label": "stn",
		"description": "You are stunned. (Skip turns until not stunned.)",
		"color": "#ff0000",
		"texture": load("res://Assets/Status Effects/StatusEffectStun.png")
	},
	"sleep": {
		"label": "slp",
		"description": "You are asleep. (Skip turns until hit or not asleep.)",
		"color": "#ff0000",
		"texture": load("res://Assets/Status Effects/StatusEffectSleep.png")
	},
	"blindness": {
		"label": "blnd",
		"description": "You can't see. (-1 bal and 0 visibility)",
		"color": "#ffff5a",
		"texture": load("res://Assets/Status Effects/StatusEffectBlindness.png"),
		"effects": {
			"balance": -1
		}
	},
	"fumbling": {
		"label": "fmb",
		"description": "Sometimes, you fumble on your feet. (-3 leg and random chance to miss turn when moving)",
		"color": "#67eb34",
		"texture": load("res://Assets/Status Effects/StatusEffectFumbling.png"),
		"effects": {
			"legerity": -3
		}
	},
	"confusion": {
		"label": "conf",
		"description": "Sometimes, you get a little confused on directions. (-1 bal, -1 leg and random chance to attack or move to wrong tile)",
		"color": "#34d9eb",
		"texture": load("res://Assets/Status Effects/StatusEffectConfusion.png"),
		"effects": {
			"legerity": -1,
			"balance": -1
		}
	},
	"hungry": {
		"label": "hng",
		"description": "Youre hungry. (-1 str)",
		"color": "#d9b518",
		"texture": load("res://Assets/Status Effects/StatusEffectHunger.png"),
		"effects": {
			"strength": -1
		}
	},
	"malnourished": {
		"label": "mlno",
		"description": "You are very hungry. (-1 str and -1 bal)",
		"color": "#bf9f0d",
		"texture": load("res://Assets/Status Effects/StatusEffectMalnourished.png"),
		"effects": {
			"strength": -1,
			"balance": -1
		}
	},
	"famished": {
		"label": "famh",
		"description": "You are starving. (-2 str, -1 bal and -1 leg)",
		"color": "#ab8e09",
		"texture": load("res://Assets/Status Effects/StatusEffectFamished.png"),
		"effects": {
			"strength": -2,
			"legerity": -1,
			"balance": -1
		}
	},
	"overencumbured": {
		"label": "oecb",
		"description": "You are overencumbured. (+1 turn on move or attack)",
		"color": "#2357db",
		"texture": load("res://Assets/Status Effects/StatusEffectOverEncumbured.png")
	},
	"burdened": {
		"label": "brdn",
		"description": "You are burdened. (+2 turns on move or attack)",
		"color": "#0b3296",
		"texture": load("res://Assets/Status Effects/StatusEffectBurdened.png")
	},
	"flattened": {
		"label": "flat",
		"description": "You are flattened. (+3 turns on move or attack)",
		"color": "#0b3296",
		"texture": load("res://Assets/Status Effects/StatusEffectFlattened.png")
	},
	"fast digestion": {
		"label": "fsd",
		"description": "You feel like youre wasting energy. (Lose an extra hunger point every turn)",
		"color": "#c4047b",
		"texture": load("res://Assets/Status Effects/StatusEffectSlowDigestion.png")
	},
	"slow digestion": {
		"label": "sld",
		"description": "You feel like youre saving energy. (Lose a hunger point less every turn)",
		"color": "#a0e571",
		"texture": load("res://Assets/Status Effects/StatusEffectSlowDigestion.png")
	},
	"regen": {
		"label": "reg",
		"description": "You feel like your wounds close on their own. (+3hp on every regen tick)",
		"color": "#2ede02",
		"texture": load("res://Assets/Status Effects/StatusEffectRegen.png")
	},
	"displacement": {
		"label": "dlc",
		"description": "You feel ambigious. (Enemy attacks have a 25% chance of missing.)",
		"color": "#e800f0",
		"texture": load("res://Assets/Status Effects/StatusEffectDisplacement.png")
	},
	"seeing": {
		"label": "see",
		"description": "You can see magically. (You can see enemies through walls.)",
		"color": "#ffbb1c",
		"texture": load("res://Assets/Status Effects/StatusEffectSeeing.png")
	},
	"backscattering": {
		"label": "bsc",
		"description": "You reflect some magic attacks. (You take no damage from rock throw and dragon breath.)",
		"color": "#7bcaea",
		"texture": load("res://Assets/Status Effects/StatusEffectBackscattering.png")
	},
	"toxix": {
		"label": "tox",
		"description": "You are poisoned. (You take 1 damage every turn for a duration.)",
		"color": "#6abe30",
		"texture": load("res://Assets/Status Effects/StatusEffectToxix.png"),
		"effects": {
			"wisdom": -3,
		}
	},
	"onFleir": {
		"label": "tox",
		"description": "You are poisoned. (-3 wis, You take 2 damage every turn for a duration.)",
		"color": "#6abe30",
		"texture": load("res://Assets/Status Effects/StatusEffectToxix.png"),
		"effects": {
			"visage": -3,
		}
	},
}
