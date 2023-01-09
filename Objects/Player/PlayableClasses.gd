
var archeologist = {
	critterName = "Archeologist",
	skill = "Has a chance of getting multiple gems from mined minerals.",
	quote = "That belongs in a museum!",
	race = "Human",
	justice = "Grilling",
	hp = 14,
	mp = 8,
	stats = {
		strength = 9,
		legerity = 7,
		balance = 7,
		belief = 4,
		visage = 7,
		wisdom = 6
	},
	hpIncrease = 4,
	mpIncrease = 4,
	strengthIncrease = 1.5,
	legerityIncrease = 1,
	balanceIncrease = 1,
	beliefIncrease = 0.5,
	visageIncrease = 1,
	wisdomIncrease = 1.5,
	resistances = [ "thunder" ],
	items = {
		"Rigid flail": 1,
		"Leather mail": 1,
		"Leather belt": 1,
		"Leather pants": 1,
		"Low boots": 1,
		"Pickaxe": 1,
		"Wand of digging": 1,
		"Oil lamp": 1,
		"Candle": [1, 3],
		"Scroll of identify": [2, 5],
		"Scroll of create food": 2,
		"Water potion": 2,
		"Apple": 2,
		"Chocolate bar": 1,
		"Bean can": 3,
		"SPAM": 1
	},
	goldPieces = 275,
	skills = {
		"sword": {
			"experience": 0,
			"level": 0,
			"skillCap": 0
		},
		"two-hander": {
			"experience": 0,
			"level": 0,
			"skillCap": 2
		},
		"dagger": {
			"experience": 0,
			"level": 0,
			"skillCap": 1
		},
		"mace": {
			"experience": 0,
			"level": 0,
			"skillCap": 1
		},
		"flail": {
			"experience": 0,
			"level": 1,
			"skillCap": 3
		}
	},
	"texture": load("res://Assets/Classes/Archeologist.png")
}

var banker = {
	critterName = "Banker",
	skill = "Banker exploits the free markets for gold and valuables. Has high starting gold and gets discounts at shops.",
	quote = "The free market is the cornerstone of society.",
	race = "Human",
	justice = "Laissez-faire",
	hp = 11,
	mp = 12,
	stats = {
		strength = 5,
		legerity = 5,
		balance = 6,
		belief = 7,
		visage = 7,
		wisdom = 7
	},
	hpIncrease = 2,
	mpIncrease = 4,
	strengthIncrease = 0.6,
	legerityIncrease = 1,
	balanceIncrease = 1,
	beliefIncrease = 1.2,
	visageIncrease = 1.2,
	wisdomIncrease = 1,
	resistances = [  ],
	items = {
		"Orc dagger": 1,
		"Orc cloak": 1,
		"Orc mail": 1,
		"Leather belt": 1,
		"Leather pants": 1,
		"Low boots": 1,
		"Credit card": 1,
		"Official mail": [4, 10],
		"Ring of Frost resistance": 1,
		"Ring of Fleir resistance": 1,
		"Marker": 1,
		"Ink bottle": 1,
		"RFG Ration": 3
	},
	goldPieces = 2475,
	skills = {
		"sword": {
			"experience": 0,
			"level": 0,
			"skillCap": 3
		},
		"two-hander": {
			"experience": 0,
			"level": 0,
			"skillCap": 0
		},
		"dagger": {
			"experience": 0,
			"level": 1,
			"skillCap": 2
		},
		"mace": {
			"experience": 0,
			"level": 0,
			"skillCap": 0
		},
		"flail": {
			"experience": 0,
			"level": 0,
			"skillCap": 1
		}
	},
	"texture": load("res://Assets/Classes/Banker.png")
}

var freedomFighter = {
	critterName = "Freedom fighter",
	skill = "Get +2 to all Gleeie'er damage.",
	quote = "Overthrow the burgoisee!",
	race = "Human",
	justice = "Draconian",
	hp = 18,
	mp = 8,
	stats = {
		strength = 8,
		legerity = 5,
		balance = 5,
		belief = 6,
		visage = 15,
		wisdom = 3
	},
	hpIncrease = 4,
	mpIncrease = 4,
	strengthIncrease = 1.2,
	legerityIncrease = 1,
	balanceIncrease = 1,
	beliefIncrease = 1.5,
	visageIncrease = 2.5,
	wisdomIncrease = 0,
	resistances = [ "fleir" ],
	items = {
		"Chipped sword": 1,
		"Battered buckler": 1,
		"Bucket helmet": 1,
		"Leather mail": 1,
		"Low boots": 1,
		"Blindfold": 1,
		"Potion of blindness": [2, 3],
		"Potion of heal": 1,
		"Soda bottle": 2,
		"Orange": 1,
		"SPAM": 1
	},
	goldPieces = 8,
	skills = {
		"sword": {
			"experience": 0,
			"level": 1,
			"skillCap": 1
		},
		"two-hander": {
			"experience": 0,
			"level": 0,
			"skillCap": 3
		},
		"dagger": {
			"experience": 0,
			"level": 0,
			"skillCap": 1
		},
		"mace": {
			"experience": 0,
			"level": 0,
			"skillCap": 1
		},
		"flail": {
			"experience": 0,
			"level": 0,
			"skillCap": 1
		}
	},
	"texture": load("res://Assets/Classes/FreedomFighter.png")
}

var herbalogue = {
	critterName = "Herbalogue",
	skill = "Gets a third more calories from eating.",
	quote = "I need to wash my hands. Wheres the cleansing powder?",
	race = "Human",
	justice = "Grilling",
	hp = 10,
	mp = 14,
	stats = {
		strength = 4,
		legerity = 8,
		balance = 6,
		belief = 8,
		visage = 5,
		wisdom = 10
	},
	hpIncrease = 3,
	mpIncrease = 6,
	strengthIncrease = 0.8,
	legerityIncrease = 1,
	balanceIncrease = 1,
	beliefIncrease = 1,
	visageIncrease = 1,
	wisdomIncrease = 2,
	resistances = [ "toxix" ],
	items = {
		"Chipped sword": 1,
		"Leather mail": 1,
		"Leather pants": 1,
		"Low boots": 1,
		"Bag of holding": 1,
		"Potion of heal": 2,
		"Ring of Toxix resistance": 1,
		"Wand of magic sphere": 1,
		"Wand of Fleir": 1,
		"Wand of Frost": 1,
		"Wand of item polymorph": 1,
		"Apple": 2,
		"Carrot": 3,
		"Orange": 3,
		"Tomato": 2
	},
	goldPieces = 20,
	skills = {
		"sword": {
			"experience": 0,
			"level": 0,
			"skillCap": 2
		},
		"two-hander": {
			"experience": 0,
			"level": 0,
			"skillCap": 2
		},
		"dagger": {
			"experience": 0,
			"level": 0,
			"skillCap": 2
		},
		"mace": {
			"experience": 0,
			"level": 0,
			"skillCap": 2
		},
		"flail": {
			"experience": 0,
			"level": 0,
			"skillCap": 2
		}
	},
	"texture": load("res://Assets/Classes/Herbalogue.png")
}

var mercenary = {
	critterName = "Mercenary",
	skill = "Gets +1 to all physical damage.",
	quote = "Theres three important things in life: Combat, Coin, and Women.",
	race = "Human",
	justice = "Grilling",
	hp = 20,
	mp = 10,
	stats = {
		strength = 12,
		legerity = 9,
		balance = 9,
		belief = 4,
		visage = 8,
		wisdom = 6
	},
	hpIncrease = 7,
	mpIncrease = 1,
	strengthIncrease = 2,
	legerityIncrease = 1.2,
	balanceIncrease = 1.2,
	beliefIncrease = -0.2,
	visageIncrease = 1,
	wisdomIncrease = 1,
	resistances = [ "frost" ],
	items = {
		"Mithril two-hander": 1,
		"Adorned helmet": 1,
		"Dwarven cloak": 1,
		"Scale ring mail": 1,
		"Studded belt": 1,
		"Studded gauntlets": 1,
		"Scale ring mail chausses": 1,
		"Studded boots": 1,
		"Potion of heal": [2, 4],
		"Potion of confusion": 1,
		"Potion of gain level": 1,
		"Amulet of life power": 1,
		"Wand of sleep": 1,
		"Leather bag": 1,
		"Candle": [1, 3],
		"Apple": 1,
		"Chocolate bar": 3,
		"Bean can": 2,
		"SPAM": 2
	},
	goldPieces = 350,
	skills = {
		"sword": {
			"experience": 0,
			"level": 0,
			"skillCap": 3
		},
		"two-hander": {
			"experience": 0,
			"level": 1,
			"skillCap": 3
		},
		"dagger": {
			"experience": 0,
			"level": 0,
			"skillCap": 2
		},
		"mace": {
			"experience": 0,
			"level": 0,
			"skillCap": 2
		},
		"flail": {
			"experience": 0,
			"level": 0,
			"skillCap": 2
		}
	},
	"texture": load("res://Assets/Classes/Mercenary.png")
}

var exterminator = {
	critterName = "Exterminator",
	skill = "Exterminator has gone mad with power. Gets +2 to all fleir damage.",
	quote = "He tells me to burn things.",
	race = "Human",
	justice = "Draconian",
	hp = 8,
	mp = 8,
	stats = {
		strength = 5,
		legerity = 5,
		balance = 5,
		belief = 5,
		visage = 5,
		wisdom = 5
	},
	hpIncrease = 6,
	mpIncrease = 6,
	strengthIncrease = 1.4,
	legerityIncrease = 1.4,
	balanceIncrease = 1.4,
	beliefIncrease = 1.4,
	visageIncrease = 1.4,
	wisdomIncrease = 1.4,
	resistances = [ "fleir" ],
	items = {
		"Chipped sword": 1,
		"Toga": 1,
		"Boots of fumbling": 1,
		"Scroll of confusion": 1,
		"Scroll of remove curse": 1,
		"Scroll of enchant weapon": [1, 5],
		"Scroll of enchant armor": [2, 6],
		"Scroll of summon critter": [2, 4],
		"Scroll of teleport": [2, 6],
		"Potion of Toxix": [2, 5],
		"Potion of paralysis": [1, 2],
		"Potion of healaga": [2, 5],
		"Wand of light": 2,
		"Wand of turn lock": 2,
		"Wand of Fleir": [5, 8],
		"Cookie": 5,
		"CC ration": 2
	},
	goldPieces = 45,
	skills = {
		"sword": {
			"experience": 0,
			"level": 0,
			"skillCap": 2
		},
		"two-hander": {
			"experience": 0,
			"level": 0,
			"skillCap": 3
		},
		"dagger": {
			"experience": 0,
			"level": 0,
			"skillCap": 0
		},
		"mace": {
			"experience": 0,
			"level": 0,
			"skillCap": 1
		},
		"flail": {
			"experience": 0,
			"level": 0,
			"skillCap": 1
		}
	},
	"texture": load("res://Assets/Classes/Exterminator.png")
}

var rogue = {
	critterName = "Rogue",
	skill = "Rogue uses a cloak and dagger from the shadows. Gets +1 to all toxix damage and +1 bonus damage from using daggers.",
	quote = "I'm darker than the blackest night.",
	race = "Human",
	justice = "Laissez-faire",
	hp = 12,
	mp = 12,
	stats = {
		strength = 7,
		legerity = 12,
		balance = 10,
		belief = 5,
		visage = 10,
		wisdom = 5
	},
	hpIncrease = 3,
	mpIncrease = 3,
	strengthIncrease = 1,
	legerityIncrease = 2,
	balanceIncrease = 1.5,
	beliefIncrease = 0.8,
	visageIncrease = 1.5,
	wisdomIncrease = 1,
	resistances = [ "toxix" ],
	items = {
		"Cut dagger": 1,
		"Orc cloak": 1,
		"Leather gloves": 1,
		"Low boots": 1,
		"Leather bag": 1,
		"Candle": 1,
		"Lockpick": 1,
		"Potion of blindness": 1,
		"Potion of paralysis": 1,
		"Potion of sleep": [2, 3]
	},
	goldPieces = 701,
	skills = {
		"sword": {
			"experience": 0,
			"level": 0,
			"skillCap": 2
		},
		"two-hander": {
			"experience": 0,
			"level": 0,
			"skillCap": 0
		},
		"dagger": {
			"experience": 0,
			"level": 2,
			"skillCap": 3
		},
		"mace": {
			"experience": 0,
			"level": 0,
			"skillCap": 1
		},
		"flail": {
			"experience": 0,
			"level": 0,
			"skillCap": 1
		}
	},
	"texture": load("res://Assets/Classes/Rogue.png")
}

var savant = {
	critterName = "Savant",
	skill = "Savant is a 1400 year old wizard. Gets +3 frost and thunder spell damage.",
	quote = "We used to cast spells uphill both ways.",
	race = "Human",
	justice = "Grilling",
	hp = 8,
	mp = 18,
	stats = {
		strength = 5,
		legerity = 8,
		balance = 9,
		belief = 12,
		visage = 5,
		wisdom = 13
	},
	hpIncrease = 2,
	mpIncrease = 8,
	strengthIncrease = 0.5,
	legerityIncrease = 1,
	balanceIncrease = 1,
	beliefIncrease = 1.5,
	visageIncrease = 0.5,
	wisdomIncrease = 3,
	resistances = [  ],
	items = {
		"Worn mace": 1,
		"Alchemists robes": 1,
		"Fabric gloves": 1,
		"Boots of magic": 1,
		"Wand of Thunder": 1,
		"Amulet of magic power": 1,
		"Scroll of remove curse": 1,
		"Scroll of identify": [2, 3],
		"Magic marker": 1,
		"Wand of light": 1,
		"Orange": 1,
		"RFG Ration": 1
	},
	goldPieces = 110,
	skills = {
		"sword": {
			"experience": 0,
			"level": 0,
			"skillCap": 0
		},
		"two-hander": {
			"experience": 0,
			"level": 0,
			"skillCap": 0
		},
		"dagger": {
			"experience": 0,
			"level": 0,
			"skillCap": 0
		},
		"mace": {
			"experience": 0,
			"level": 1,
			"skillCap": 3
		},
		"flail": {
			"experience": 0,
			"level": 0,
			"skillCap": 3
		}
	},
	"texture": load("res://Assets/Classes/Savant.png")
}
