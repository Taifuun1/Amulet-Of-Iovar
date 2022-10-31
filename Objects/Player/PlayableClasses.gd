
var archeologist = {
	critterName = "Archeologist",
	race = "Human",
	justice = "Grilling",
	hp = 14,
	mp = 8,
	strength = 9,
	legerity = 7,
	balance = 7,
	belief = 4,
	visage = 7,
	wisdom = 6,
	hpIncrease = 4,
	mpIncrease = 4,
	strengthIncrease = 1.5,
	legerityIncrease = 1,
	balanceIncrease = 1,
	beliefIncrease = 0.5,
	visageIncrease = 1,
	wisdomIncrease = 1.5,
	items = {
		"Rigid flail": 1,
		"Leather armor": 1,
		"Leather belt": 1,
		"Cotton pants": 1,
		"Low boots": 1,
		"Pickaxe": 1,
		"Wand of digging": 1,
		"Lamp": 1,
		"Candle": [1, 3]
	},
	goldPieces = 275,
	skills = {
		"sword": {
			"skill": 0,
			"skillCap": 0
		},
		"twohandedSword": {
			"skill": 0,
			"skillCap": 2
		},
		"dagger": {
			"skill": 0,
			"skillCap": 1
		},
		"mace": {
			"skill": 0,
			"skillCap": 1
		},
		"flail": {
			"skill": 1,
			"skillCap": 3
		}
	},
	"texture": load("res://Assets/Classes/Archeologist.png")
}

var banker = {
	critterName = "Banker",
	race = "Human",
	justice = "Laissez-faire",
	hp = 11,
	mp = 12,
	strength = 5,
	legerity = 5,
	balance = 6,
	belief = 7,
	visage = 7,
	wisdom = 7,
	hpIncrease = 2,
	mpIncrease = 4,
	strengthIncrease = 0.6,
	legerityIncrease = 1,
	balanceIncrease = 1,
	beliefIncrease = 1.2,
	visageIncrease = 1.2,
	wisdomIncrease = 1,
	items = {
		"Orc dagger": 1,
#		"Orc cloak": 1,
#		"Orc mail": 1,
#		"Leather belt": 1,
#		"Leather pants": 1,
#		"Low boots": 1,
		"Credit card": 1,
#		"Mail": [4, 10],
#		"Ring of Frost resistance": 1,
#		"Ring of Fleir resistance": 1,
#		"Marker": 1,
#		"Ink bottle": 1
	},
	goldPieces = 2475,
	skills = {
		"sword": {
			"skill": 0,
			"skillCap": 2
		},
		"twohandedSword": {
			"skill": 0,
			"skillCap": 0
		},
		"dagger": {
			"skill": 1,
			"skillCap": 3
		},
		"mace": {
			"skill": 0,
			"skillCap": 0
		},
		"flail": {
			"skill": 0,
			"skillCap": 1
		}
	},
	"texture": load("res://Assets/Classes/Banker.png")
}

var freedomFighter = {
	critterName = "Freedom fighter",
	race = "Human",
	justice = "Draconian",
	hp = 18,
	mp = 8,
	strength = 8,
	legerity = 5,
	balance = 5,
	belief = 12,
	visage = 13,
	wisdom = 3,
	hpIncrease = 4,
	mpIncrease = 4,
	strengthIncrease = 1.2,
	legerityIncrease = 1,
	balanceIncrease = 1,
	beliefIncrease = 1.5,
	visageIncrease = 2.5,
	wisdomIncrease = 0,
	items = {
		"Chipped sword": 1,
		"Chipped buckler": 1,
		"Tattered cloak": 1,
		"Leather armor": 1,
		"Leather belt": 1,
		"Cotton pants": 1,
		"Low boots": 1,
		"Blindfold": 1,
		"Potion of blindness": [2, 3]
	},
	goldPieces = 8,
	skills = {
		"sword": {
			"skill": 1,
			"skillCap": 1
		},
		"twohandedSword": {
			"skill": 0,
			"skillCap": 3
		},
		"dagger": {
			"skill": 0,
			"skillCap": 1
		},
		"mace": {
			"skill": 0,
			"skillCap": 1
		},
		"flail": {
			"skill": 0,
			"skillCap": 1
		}
	},
	"texture": load("res://Assets/Classes/FreedomFighter.png")
}

var herbalogue = {
	critterName = "Herbalogue",
	race = "Human",
	justice = "Grilling",
	hp = 10,
	mp = 14,
	strength = 4,
	legerity = 8,
	balance = 6,
	belief = 8,
	visage = 5,
	wisdom = 10,
	hpIncrease = 3,
	mpIncrease = 6,
	strengthIncrease = 0.8,
	legerityIncrease = 1,
	balanceIncrease = 1,
	beliefIncrease = 1,
	visageIncrease = 1,
	wisdomIncrease = 2,
	items = {
		"Chipped sword": 1,
		"Leather mail": 1,
		"Leather pants": 1,
		"Low boots": 1,
#		"Potion of heala": 2,
#		"Ring of Toxix resistance": 1,
#		"Wand of Fleir": 1,
#		"Wand of Frost": 1,
#		"Wand of item polymorph": 1
	},
	goldPieces = 20,
	skills = {
		"sword": {
			"skill": 0,
			"skillCap": 2
		},
		"twohandedSword": {
			"skill": 0,
			"skillCap": 2
		},
		"dagger": {
			"skill": 0,
			"skillCap": 2
		},
		"mace": {
			"skill": 0,
			"skillCap": 2
		},
		"flail": {
			"skill": 0,
			"skillCap": 2
		}
	},
	"texture": load("res://Assets/Classes/Herbalogue.png")
}

var mercenary = {
	critterName = "Mercenary",
	race = "Human",
	justice = "Grilling",
	hp = 20,
	mp = 10,
	strength = 12,
	legerity = 9,
	balance = 9,
	belief = 4,
	visage = 8,
	wisdom = 6,
	hpIncrease = 7,
	mpIncrease = 1,
	strengthIncrease = 2,
	legerityIncrease = 1.2,
	balanceIncrease = 1.2,
	beliefIncrease = -0.2,
	visageIncrease = 1,
	wisdomIncrease = 1,
	items = {
		"Mithril two-hander": 1,
#		"Adorned helmet": 1,
#		"Adorned cloak": 1,
#		"Ring mail": 1,
#		"Studded belt": 1,
#		"Leather gloves": 1,
#		"Scale-ring greaves": 1,
#		"Low boots": 1,
#		"Potion of heala": [2, 4],
#		"Potion of blindness": 1,
#		"Potion of gain level": 1,
#		"Amulet of life power": 1,
#		"Wand of sleep": 1,
#		"Candle": [1, 3]
	},
	goldPieces = 350,
	skills = {
		"sword": {
			"skill": 0,
			"skillCap": 3
		},
		"twohandedSword": {
			"skill": 1,
			"skillCap": 3
		},
		"dagger": {
			"skill": 0,
			"skillCap": 2
		},
		"mace": {
			"skill": 0,
			"skillCap": 2
		},
		"flail": {
			"skill": 0,
			"skillCap": 2
		}
	},
	"texture": load("res://Assets/Classes/Mercenary.png")
}

var exterminator = {
	critterName = "Exterminator",
	race = "Human",
	justice = "Draconian",
	hp = 8,
	mp = 8,
	strength = 5,
	legerity = 5,
	balance = 5,
	belief = 5,
	visage = 5,
	wisdom = 5,
	hpIncrease = 6,
	mpIncrease = 6,
	strengthIncrease = 1.4,
	legerityIncrease = 1.4,
	balanceIncrease = 1.4,
	beliefIncrease = 1.4,
	visageIncrease = 1.4,
	wisdomIncrease = 1.4,
	items = {
		"Chipped sword": 1,
	},
	goldPieces = 45,
	skills = {
		"sword": {
			"skill": 0,
			"skillCap": 3
		},
		"twohandedSword": {
			"skill": 0,
			"skillCap": 3
		},
		"dagger": {
			"skill": 0,
			"skillCap": 3
		},
		"mace": {
			"skill": 0,
			"skillCap": 3
		},
		"flail": {
			"skill": 0,
			"skillCap": 3
		}
	},
	"texture": load("res://Assets/Classes/Perry.png")
}

var rogue = {
	critterName = "Rogue",
	race = "Human",
	justice = "Laissez-faire",
	hp = 12,
	mp = 12,
	strength = 7,
	legerity = 12,
	balance = 10,
	belief = 5,
	visage = 10,
	wisdom = 5,
	hpIncrease = 3,
	mpIncrease = 3,
	strengthIncrease = 1,
	legerityIncrease = 2,
	balanceIncrease = 1.5,
	beliefIncrease = 0.8,
	visageIncrease = 1.5,
	wisdomIncrease = 1,
	items = {
		"Cut dagger": 1,
		"Leather cap": 1,
#		"Tattered cloak cloak": 1,
		"Leather mail": 1,
		"Leather belt": 1,
		"Leather gloves": 1,
		"Leather pants": 1,
		"Low boots": 1,
		"Candle": 1,
		"Magic key": 1,
		"Potion of blindness": 1,
		"Potion of paralysis": 1,
		"Marker": 1,
		"Ink bottle": 1
	},
	goldPieces = 701,
	skills = {
		"sword": {
			"skill": 0,
			"skillCap": 2
		},
		"twohandedSword": {
			"skill": 0,
			"skillCap": 0
		},
		"dagger": {
			"skill": 2,
			"skillCap": 3
		},
		"mace": {
			"skill": 0,
			"skillCap": 1
		},
		"flail": {
			"skill": 0,
			"skillCap": 1
		}
	},
	"texture": load("res://Assets/Classes/Rogue.png")
}

var savant = {
	critterName = "Savant",
	race = "Human",
	justice = "Grilling",
	hp = 8,
	mp = 18,
	strength = 4,
	legerity = 8,
	balance = 9,
	belief = 12,
	visage = 5,
	wisdom = 13,
	hpIncrease = 2,
	mpIncrease = 8,
	strengthIncrease = 0.5,
	legerityIncrease = 1,
	balanceIncrease = 1,
	beliefIncrease = 1.5,
	visageIncrease = 0.5,
	wisdomIncrease = 3,
	items = {
		"Worn mace": 1,
#		"Roman robe": 1,
#		"Fabric gloves": 1,
#		"Springy boots": 1,
#		"Wand of Thunder": 1,
#		"Amulet of magic power": 1,
#		"Scroll of remove curse": 1,
#		"Scroll of identify": [2, 3],
#		"Lamp": 1,
#		"Magic marker": 1
	},
	goldPieces = 110,
	skills = {
		"sword": {
			"skill": 0,
			"skillCap": 0
		},
		"twohandedSword": {
			"skill": 0,
			"skillCap": 0
		},
		"dagger": {
			"skill": 0,
			"skillCap": 0
		},
		"mace": {
			"skill": 1,
			"skillCap": 3
		},
		"flail": {
			"skill": 0,
			"skillCap": 3
		}
	},
	"texture": load("res://Assets/Classes/Savant.png")
}
