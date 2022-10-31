extends Node

var globalItemInfo = {
	"Amulet of seeing": {
		"identified": false
	},
	"Amulet of magic power": {
		"identified": false
	},
	"Amulet of life power": {
		"identified": false
	},
	"Amulet of backscattering": {
		"identified": false
	},
	"Amulet of strangulation": {
		"identified": false
	},
	"Amulet of sleep": {
		"identified": false
	},
	"Amulet of Toxix": {
		"identified": false
	},
	"Thunderous roar": {
		"identified": false
	},
	"Cold breeze": {
		"identified": false
	},
	"Leather mail": {
		"identified": false
	},
	"Orc mail": {
		"identified": false
	},
	"Scale ring mail": {
		"identified": false
	},
	"Dwarvish coat": {
		"identified": false
	},
	"Platemail": {
		"identified": false
	},
	"Blue dragon scale mail": {
		"identified": false
	},
	"Green dragon scale mail": {
		"identified": false
	},
	"Red dragon scale mail": {
		"identified": false
	},
	"Yellow dragon scale mail": {
		"identified": false
	},
	"Violet dragon scale mail": {
		"identified": false
	},
	"Great Ulromirs platemail": {
		"identified": false
	},
	"Frozen mail": {
		"identified": false
	},
	"Flaming mail": {
		"identified": false
	},
	"Thunder mail": {
		"identified": false
	},
	"Gleeie'er mail": {
		"identified": false
	},
	"Bubbly mail": {
		"identified": false
	},
	"Leather cap": {
		"identified": false
	},
	"Bucket helmet": {
		"identified": false
	},
	"Adorned helmet": {
		"identified": false
	},
	"Helm of ego": {
		"identified": false
	},
	"Uiroel helmet": {
		"identified": false
	},
	"Mossy helmet": {
		"identified": false
	},
	"Winged helmet": {
		"identified": false
	},
	"Leather gloves": {
		"identified": false
	},
	"Fabric gloves": {
		"identified": false
	},
	"Gauntlets of Devastation": {
		"identified": false
	},
	"Gauntlets of Nimbleness": {
		"identified": false
	},
	"Gauntlets of Balance": {
		"identified": false
	},
	"Gehennors gauntlets": {
		"identified": false
	},
	"Leather belt": {
		"identified": false
	},
	"Studded belt": {
		"identified": false
	},
	"Belt of Plato": {
		"identified": false
	},
	"Belt of Faith": {
		"identified": false
	},
	"Belt of Symmetry": {
		"identified": false
	},
	"Leather cloak": {
		"identified": false,
	},
	"Orc cloak": {
		"identified": false,
	},
	"Roman robe": {
		"identified": false,
	},
	"Adorned cloak": {
		"identified": false,
	},
	"Cloak of displacement": {
		"identified": false,
	},
#	"Cloak of invisibility": {
#		"identified": false,
#	},
	"Alchemists robes": {
		"identified": false,
	},
	"Cloak of magical ambiguity": {
		"identified": false,
	},
	"Battered buckler": {
		"identified": false,
	},
	"Large orc shield": {
		"identified": false,
	},
	"Justice'eer shield": {
		"identified": false,
	},
	"Lords tower board shield": {
		"identified": false,
	},
	"Burning shield": {
		"identified": false,
	},
	"Leather pants": {
		"identified": false,
	},
	"Scale ring mail chausses": {
		"identified": false,
	},
	"Thunder greaves": {
		"identified": false,
	},
	"Burning mail chausses": {
		"identified": false,
	},
	"Low boots": {
		"identified": false
	},
	"Studded boots": {
		"identified": false
	},
	"Boots of magic": {
		"identified": false
	},
	"Boots of fumbling": {
		"identified": false
	},
	"Chilly boots": {
		"identified": false
	},
	"Cool Mikeys": {
		"identified": false
	},
	"Water potion": {
		"identified": false
	},
	"Soda bottle": {
		"identified": false
	},
	"Potion of confusion": {
		"identified": false
	},
	"Potion of Toxix": {
		"identified": false
	},
	"Potion of heal": {
		"identified": false
	},
	"Potion of sleep": {
		"identified": false
	},
	"Potion of blindness": {
		"identified": false
	},
#	"Potion of invisibility": {
#		"identified": false
#	},
#	"Potion of levitation": {
#		"identified": false
#	},
	"Potion of paralysis": {
		"identified": false
	},
	"Potion of hunger": {
		"identified": false
	},
	"Potion of Healaga": {
		"identified": false
	},
	"Potion of gain level": {
		"identified": false
	},
	"Potion of up stat": {
		"identified": false
	},
	"Potion of down stat": {
		"identified": false
	},
	"Ring of Fleir resistance": {
		"identified": false
	},
	"Ring of Frost resistance": {
		"identified": false
	},
	"Ring of Thunder resistance": {
		"identified": false
	},
	"Ring of Gleeie'er resistance": {
		"identified": false
	},
	"Ring of Toxix resistance": {
		"identified": false
	},
	"Ring of protection": {
		"identified": false
	},
	"Ring of hunger": {
		"identified": false
	},
#	"Ring of levitation": {
#		"identified": false
#	},
	"Ring of slow digestion": {
		"identified": false
	},
	"Ring of regen": {
		"identified": false
	},
	"Ring of fumbling": {
		"identified": false
	},
	"Ring of Strength": {
		"identified": false
	},
	"Ring of Legerity": {
		"identified": false
	},
	"Ring of Balance": {
		"identified": false
	},
	"Ring of Wisdom": {
		"identified": false
	},
	"Ring of Belief": {
		"identified": false
	},
	"Ring of Visage": {
		"identified": false
	},
	"Official mail": {
		"identified": false
	},
	"Blank scroll": {
		"identified": false
	},
	"Scroll of identify": {
		"identified": false
	},
	"Scroll of create food": {
		"identified": false
	},
	"Scroll of confusion": {
		"identified": false
	},
	"Scroll of remove curse": {
		"identified": false
	},
	"Scroll of enchant weapon": {
		"identified": false
	},
	"Scroll of enchant armor": {
		"identified": false
	},
	"Scroll of destroy armor": {
		"identified": false
	},
	"Scroll of summon critter": {
		"identified": false
	},
	"Scroll of create potion": {
		"identified": false
	},
	"Scroll of teleport": {
		"identified": false
	},
	"Scroll of genocide": {
		"identified": false
	},
	"Leather bag": {
		"identified": false
	},
	"Lockpick": {
		"identified": false
	},
	"Blindfold": {
		"identified": false
	},
	"Candle": {
		"identified": false
	},
	"Credit card": {
		"identified": false
	},
	"Shovel": {
		"identified": false
	},
	"Message in a bottle": {
		"identified": false
	},
	"Fancy whistle": {
		"identified": false
	},
	"Oil lamp": {
		"identified": false
	},
	"Pickaxe": {
		"identified": false
	},
	"Marker": {
		"identified": false
	},
	"Ink bottle": {
		"identified": false
	},
	"Key": {
		"identified": false
	},
	"Bag of disenchantment": {
		"identified": false
	},
	"Bag of holding": {
		"identified": false
	},
	"Magic lamp": {
		"identified": false
	},
	"Magic marker": {
		"identified": false
	},
	"Magic key": {
		"identified": false
	},
	"Wand of light": {
		"identified": false
	},
	"Wand of turn lock": {
		"identified": false
	},
	"Wand of digging": {
		"identified": false
	},
	"Wand of Frost": {
		"identified": false
	},
	"Wand of Fleir": {
		"identified": false
	},
	"Wand of Thunder": {
		"identified": false
	},
	"Wand of sleep": {
		"identified": false
	},
	"Wand of magic sphere": {
		"identified": false
	},
	"Wand of backwards magic sphere": {
		"identified": false
	},
	"Wand of teleport": {
		"identified": false
	},
	"Wand of item polymorph": {
		"identified": false
	},
	"Wand of summon critter": {
		"identified": false
	},
	"Wand of wishing": {
		"identified": false
	},
	"Chipped sword": {
		"identified": false
	},
	"Dwarvish laysword": {
		"identified": false
	},
	"Orcish sword": {
		"identified": false
	},
	"Adorned sword": {
		"identified": false
	},
	"Fleirflare": {
		"identified": false
	},
	"Frostfury": {
		"identified": false
	},
	"Justice'eer sword": {
		"identified": false
	},
	"Stormbringer": {
		"identified": false
	},
	"Vorpal sword": {
		"identified": false
	},
	"Dull two-hander": {
		"identified": false
	},
	"Mithril two-hander": {
		"identified": false
	},
	"Giantslayer": {
		"identified": false
	},
	"Brittleleaf": {
		"identified": false
	},
	"Icesplitter": {
		"identified": false
	},
	"Cut dagger": {
		"identified": false
	},
	"Orc dagger": {
		"identified": false
	},
	"Glowing dagger": {
		"identified": false
	},
	"Krakag Orraig": {
		"identified": false
	},
	"Dagger of Elbier": {
		"identified": false
	},
	"Worn mace": {
		"identified": false
	},
	"Morning star": {
		"identified": false
	},
	"Dumpel Pompel": {
		"identified": false
	},
	"Final Dawn": {
		"identified": false
	},
	"Titan Slayer": {
		"identified": false
	},
	"Rigid flail": {
		"identified": false
	},
	"Sharp flail": {
		"identified": false
	},
	"Crustel flail": {
		"identified": false
	},
	"Loperiels Destiny": {
		"identified": false
	}
}
