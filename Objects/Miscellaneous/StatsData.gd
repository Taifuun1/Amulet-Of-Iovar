
var lifetimeStats = {
	"Turn count": 0,
	"Times attacked": 0,
	"Damage dealt": 0,
	"Highest damage dealt": 0,
	"Damage taken": 0,
	"Highest damage taken": 0,
	"Items wished": 0,
	"Species genocided": 0,
	"Times ascended": 0,
}

var gameStats = {
	"Turn count": 0,
	"Times attacked": 0,
	"Damage dealt": 0,
	"Highest damage dealt": 0,
	"Damage taken": 0,
	"Highest damage taken": 0,
	"Items wished": 0,
	"Species genocided": 0,
	"Times ascended": 0,
	"Points": 0,
}

var items = {
	"Amulet of seeing": {
		"knowledge": false,
		"description": ""
	},
	"Amulet of magic power": {
		"knowledge": false,
		"description": ""
	},
	"Amulet of life power": {
		"knowledge": false,
		"description": ""
	},
	"Amulet of backscattering": {
		"knowledge": false,
		"description": ""
	},
	"Amulet of strangulation": {
		"knowledge": false,
		"description": ""
	},
	"Amulet of sleep": {
		"knowledge": false,
		"description": ""
	},
	"Amulet of Toxix": {
		"knowledge": false,
		"description": ""
	},
	"Thunderous roar": {
		"knowledge": false,
		"description": ""
	},
	"Cold breeze": {
		"knowledge": false,
		"description": ""
	},
	"Leather mail": {
		"knowledge": false,
		"description": ""
	},
	"Orc mail": {
		"knowledge": false,
		"description": ""
	},
	"Scale ring mail": {
		"knowledge": false,
		"description": ""
	},
	"Dwarvish coat": {
		"knowledge": false,
		"description": ""
	},
	"Platemail": {
		"knowledge": false,
		"description": ""
	},
	"Blue dragon scale mail": {
		"knowledge": false,
		"description": ""
	},
	"Green dragon scale mail": {
		"knowledge": false,
		"description": ""
	},
	"Red dragon scale mail": {
		"knowledge": false,
		"description": ""
	},
	"Yellow dragon scale mail": {
		"knowledge": false,
		"description": ""
	},
	"Violet dragon scale mail": {
		"knowledge": false,
		"description": ""
	},
	"Great Ulromirs platemail": {
		"knowledge": false,
		"description": ""
	},
	"Frozen mail": {
		"knowledge": false,
		"description": ""
	},
	"Flaming mail": {
		"knowledge": false,
		"description": ""
	},
	"Thunder mail": {
		"knowledge": false,
		"description": ""
	},
	"Gleeie'er mail": {
		"knowledge": false,
		"description": ""
	},
	"Bubbly mail": {
		"knowledge": false,
		"description": ""
	},
	"Leather cap": {
		"knowledge": false,
		"description": ""
	},
	"Bucket helmet": {
		"knowledge": false,
		"description": ""
	},
	"Adorned helmet": {
		"knowledge": false,
		"description": ""
	},
	"Helm of ego": {
		"knowledge": false,
		"description": ""
	},
	"Uiroel helmet": {
		"knowledge": false,
		"description": ""
	},
	"Mossy helmet": {
		"knowledge": false,
		"description": ""
	},
	"Winged helmet": {
		"knowledge": false,
		"description": ""
	},
	"Leather gloves": {
		"knowledge": false,
		"description": ""
	},
	"Fabric gloves": {
		"knowledge": false,
		"description": ""
	},
	"Gauntlets of Devastation": {
		"knowledge": false,
		"description": ""
	},
	"Gauntlets of Nimbleness": {
		"knowledge": false,
		"description": ""
	},
	"Gauntlets of Balance": {
		"knowledge": false,
		"description": ""
	},
	"Gehennors gauntlets": {
		"knowledge": false,
		"description": ""
	},
	"Leather belt": {
		"knowledge": false,
		"description": ""
	},
	"Studded belt": {
		"knowledge": false,
		"description": ""
	},
	"Belt of Plato": {
		"knowledge": false,
		"description": ""
	},
	"Belt of Faith": {
		"knowledge": false,
		"description": ""
	},
	"Belt of Symmetry": {
		"knowledge": false,
		"description": ""
	},
	"Leather cloak": {
		"knowledge": false,
		"description": ""
	},
	"Orc cloak": {
		"knowledge": false,
		"description": ""
	},
	"Roman robe": {
		"knowledge": false,
		"description": ""
	},
	"Adorned cloak": {
		"knowledge": false,
		"description": ""
	},
	"Cloak of displacement": {
		"knowledge": false,
		"description": ""
	},
#	"Cloak of invisibility": {
#		"knowledge": false,
#		"description": ""
#	},
	"Alchemists robes": {
		"knowledge": false,
		"description": ""
	},
	"Cloak of magical ambiguity": {
		"knowledge": false,
		"description": ""
	},
	"Battered buckler": {
		"knowledge": false,
		"description": ""
	},
	"Large orc shield": {
		"knowledge": false,
		"description": ""
	},
	"Justice'eer shield": {
		"knowledge": false,
		"description": ""
	},
	"Lords tower board shield": {
		"knowledge": false,
		"description": ""
	},
	"Burning shield": {
		"knowledge": false,
		"description": ""
	},
	"Leather pants": {
		"knowledge": false,
		"description": ""
	},
	"Scale ring mail chausses": {
		"knowledge": false,
		"description": ""
	},
	"Thunder greaves": {
		"knowledge": false,
		"description": ""
	},
	"Burning mail chausses": {
		"knowledge": false,
		"description": ""
	},
	"Low boots": {
		"knowledge": false,
		"description": ""
	},
	"Studded boots": {
		"knowledge": false,
		"description": ""
	},
	"Boots of magic": {
		"knowledge": false,
		"description": ""
	},
	"Boots of fumbling": {
		"knowledge": false,
		"description": ""
	},
	"Chilly boots": {
		"knowledge": false,
		"description": ""
	},
	"Cool Mikeys": {
		"knowledge": false,
		"description": ""
	},
	"Water potion": {
		"knowledge": false,
		"description": ""
	},
	"Soda bottle": {
		"knowledge": false,
		"description": ""
	},
	"Potion of confusion": {
		"knowledge": false,
		"description": ""
	},
	"Potion of Toxix": {
		"knowledge": false,
		"description": ""
	},
	"Potion of heal": {
		"knowledge": false,
		"description": ""
	},
	"Potion of sleep": {
		"knowledge": false,
		"description": ""
	},
	"Potion of blindness": {
		"knowledge": false,
		"description": ""
	},
#	"Potion of invisibility": {
#		"knowledge": false,
#		"description": ""
#	},
#	"Potion of levitation": {
#		"knowledge": false,
#		"description": ""
#	},
	"Potion of paralysis": {
		"knowledge": false,
		"description": ""
	},
	"Potion of hunger": {
		"knowledge": false,
		"description": ""
	},
	"Potion of Healaga": {
		"knowledge": false,
		"description": ""
	},
	"Potion of gain level": {
		"knowledge": false,
		"description": ""
	},
	"Potion of up stat": {
		"knowledge": false,
		"description": ""
	},
	"Potion of down stat": {
		"knowledge": false,
		"description": ""
	},
	"Ring of Fleir resistance": {
		"knowledge": false,
		"description": ""
	},
	"Ring of Frost resistance": {
		"knowledge": false,
		"description": ""
	},
	"Ring of Thunder resistance": {
		"knowledge": false,
		"description": ""
	},
	"Ring of Gleeie'er resistance": {
		"knowledge": false,
		"description": ""
	},
	"Ring of Toxix resistance": {
		"knowledge": false,
		"description": ""
	},
	"Ring of protection": {
		"knowledge": false,
		"description": ""
	},
	"Ring of hunger": {
		"knowledge": false,
		"description": ""
	},
#	"Ring of levitation": {
#		"knowledge": false,
#		"description": ""
#	},
	"Ring of slow digestion": {
		"knowledge": false,
		"description": ""
	},
	"Ring of regen": {
		"knowledge": false,
		"description": ""
	},
	"Ring of fumbling": {
		"knowledge": false,
		"description": ""
	},
	"Ring of Strength": {
		"knowledge": false,
		"description": ""
	},
	"Ring of Legerity": {
		"knowledge": false,
		"description": ""
	},
	"Ring of Balance": {
		"knowledge": false,
		"description": ""
	},
	"Ring of Wisdom": {
		"knowledge": false,
		"description": ""
	},
	"Ring of Belief": {
		"knowledge": false,
		"description": ""
	},
	"Ring of Visage": {
		"knowledge": false,
		"description": ""
	},
	"Official mail": {
		"knowledge": false,
		"description": ""
	},
	"Blank scroll": {
		"knowledge": false,
		"description": ""
	},
	"Scroll of identify": {
		"knowledge": false,
		"description": ""
	},
	"Scroll of create food": {
		"knowledge": false,
		"description": ""
	},
	"Scroll of confusion": {
		"knowledge": false,
		"description": ""
	},
	"Scroll of remove curse": {
		"knowledge": false,
		"description": ""
	},
	"Scroll of enchant weapon": {
		"knowledge": false,
		"description": ""
	},
	"Scroll of enchant armor": {
		"knowledge": false,
		"description": ""
	},
	"Scroll of destroy armor": {
		"knowledge": false,
		"description": ""
	},
	"Scroll of summon critter": {
		"knowledge": false,
		"description": ""
	},
	"Scroll of create potion": {
		"knowledge": false,
		"description": ""
	},
	"Scroll of teleport": {
		"knowledge": false,
		"description": ""
	},
	"Scroll of genocide": {
		"knowledge": false,
		"description": ""
	},
	"Leather bag": {
		"knowledge": false,
		"description": ""
	},
	"Lockpick": {
		"knowledge": false,
		"description": ""
	},
	"Blindfold": {
		"knowledge": false,
		"description": ""
	},
	"Candle": {
		"knowledge": false,
		"description": ""
	},
	"Credit card": {
		"knowledge": false,
		"description": ""
	},
	"Shovel": {
		"knowledge": false,
		"description": ""
	},
	"Message in a bottle": {
		"knowledge": false,
		"description": ""
	},
	"Fancy whistle": {
		"knowledge": false,
		"description": ""
	},
	"Oil lamp": {
		"knowledge": false,
		"description": ""
	},
	"Pickaxe": {
		"knowledge": false,
		"description": ""
	},
	"Marker": {
		"knowledge": false,
		"description": ""
	},
	"Ink bottle": {
		"knowledge": false,
		"description": ""
	},
	"Key": {
		"knowledge": false,
		"description": ""
	},
	"Bag of disenchantment": {
		"knowledge": false,
		"description": ""
	},
	"Bag of holding": {
		"knowledge": false,
		"description": ""
	},
	"Magic lamp": {
		"knowledge": false,
		"description": ""
	},
	"Magic marker": {
		"knowledge": false,
		"description": ""
	},
	"Magic key": {
		"knowledge": false,
		"description": ""
	},
	"Wand of light": {
		"knowledge": false,
		"description": ""
	},
	"Wand of turn lock": {
		"knowledge": false,
		"description": ""
	},
	"Wand of digging": {
		"knowledge": false,
		"description": ""
	},
	"Wand of Frost": {
		"knowledge": false,
		"description": ""
	},
	"Wand of Fleir": {
		"knowledge": false,
		"description": ""
	},
	"Wand of Thunder": {
		"knowledge": false,
		"description": ""
	},
	"Wand of sleep": {
		"knowledge": false,
		"description": ""
	},
	"Wand of magic sphere": {
		"knowledge": false,
		"description": ""
	},
	"Wand of backwards magic sphere": {
		"knowledge": false,
		"description": ""
	},
	"Wand of teleport": {
		"knowledge": false,
		"description": ""
	},
	"Wand of item polymorph": {
		"knowledge": false,
		"description": ""
	},
	"Wand of summon critter": {
		"knowledge": false,
		"description": ""
	},
	"Wand of wishing": {
		"knowledge": false,
		"description": ""
	},
	"Chipped sword": {
		"knowledge": false,
		"description": ""
	},
	"Dwarvish laysword": {
		"knowledge": false,
		"description": ""
	},
	"Orcish sword": {
		"knowledge": false,
		"description": ""
	},
	"Adorned sword": {
		"knowledge": false,
		"description": ""
	},
	"Fleirflare": {
		"knowledge": false,
		"description": ""
	},
	"Frostfury": {
		"knowledge": false,
		"description": ""
	},
	"Justice'eer sword": {
		"knowledge": false,
		"description": ""
	},
	"Stormbringer": {
		"knowledge": false,
		"description": ""
	},
	"Vorpal sword": {
		"knowledge": false,
		"description": ""
	},
	"Dull two-hander": {
		"knowledge": false,
		"description": ""
	},
	"Mithril two-hander": {
		"knowledge": false,
		"description": ""
	},
	"Dragonslayer": {
		"knowledge": false,
		"description": ""
	},
	"Brittleleaf": {
		"knowledge": false,
		"description": ""
	},
	"Icesplitter": {
		"knowledge": false,
		"description": ""
	},
	"Cut dagger": {
		"knowledge": false,
		"description": ""
	},
	"Orc dagger": {
		"knowledge": false,
		"description": ""
	},
	"Glowing dagger": {
		"knowledge": false,
		"description": ""
	},
	"Krakag Orraig": {
		"knowledge": false,
		"description": ""
	},
	"Dagger of Elbier": {
		"knowledge": false,
		"description": ""
	},
	"Worn mace": {
		"knowledge": false,
		"description": ""
	},
	"Morning star": {
		"knowledge": false,
		"description": ""
	},
	"Dumpel Pompel": {
		"knowledge": false,
		"description": ""
	},
	"Final Dawn": {
		"knowledge": false,
		"description": ""
	},
	"Titan Slayer": {
		"knowledge": false,
		"description": ""
	},
	"Rigid flail": {
		"knowledge": false,
		"description": ""
	},
	"Sharp flail": {
		"knowledge": false,
		"description": ""
	},
	"Crustel flail": {
		"knowledge": false,
		"description": ""
	},
	"Loperiels Destiny": {
		"knowledge": false,
		"description": ""
	}
}

var critters = {
	"Iovar": {
		"knowledge": false,
		"description": "Iovar, the ancient mage",
		"killCount": 0
	},
	"Elder Dragon": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Mad Banana-hunter Ogre": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Shin'kor Leve'er": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Elhybar": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Tidoh Tel'hydrad": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Double-pattern ant": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Leaf ant": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Soldier ant": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Sugar ant": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Eyebrow seal": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Fiddler crab": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Ringed seal": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Tonatuna": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Dark bat": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Spooky bat": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Squinting bat": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Vampire bat": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Slerp": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Sluerp": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Gearh": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Wolf": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Warg": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Gryonem centaur": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Hill centaur": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Black dragon": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Blue dragon": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Cyan dragon": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Green dragon": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Red dragon": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Silver dragon": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Violet dragon": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"White dragon": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Yellow dragon": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Dwarven contirer": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Dwarf engineer": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Dwarf miner": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Dwarf smith": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Elf assassin": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Elf hunter": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Elf king": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Elf noble": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Cat": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Lynx": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Tiger": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Floating eye": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Freezing floating sphere": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Thunderous floating sphere": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Unstable floating sphere": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Balding giant": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Hill giant": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"One-eyed ogre": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Parched giant": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Guard": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Guard captain": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Outlaw watcher": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Outlaw fusiee'er": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Outlaw merchandiee'er": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Iovars cultist acolyte": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Iovars cultist": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Shopkeeper": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Large kobold": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Tiny kobold": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Half-lich": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Lich": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Grand lich": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Arch-lich": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Humongous mimic": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Mimic": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Arctic newt": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Highlands newt": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Mine newt": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Paper newt": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"River newt": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Dungeon orc": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Flatlands orc": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Goblin": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Mountain orc": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Yrak-i": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Chicken": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Grid bug": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Brontotheridae": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Rhino": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Big rat": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Cave rat": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Sewer rat": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Garnered snake": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Marsh snake": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Sawtooth-pattern snake": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Spectral wraith": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	},
	"Spooky ghost": {
		"knowledge": false,
		"description": "",
		"killCount": 0
	}
}
