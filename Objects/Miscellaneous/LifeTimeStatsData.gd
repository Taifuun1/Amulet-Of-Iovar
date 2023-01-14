
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
		"description": "Allows you see in dark places."
	},
	"Amulet of magic power": {
		"knowledge": false,
		"description": "Gives +3 magic damage."
	},
	"Amulet of life power": {
		"knowledge": false,
		"description": "Gives +20 maxhp."
	},
	"Amulet of backscattering": {
		"knowledge": false,
		"description": "Blocks Rock throw and Dragon breath -abilities."
	},
	"Amulet of strangulation": {
		"knowledge": false,
		"description": "Binds on equip and deals -5 dmg every turn."
	},
	"Amulet of sleep": {
		"knowledge": false,
		"description": "Binds on equip and inflicts sleep randomly."
	},
	"Amulet of Toxix": {
		"knowledge": false,
		"description": "Binds on equip and inflicts toxix status effect."
	},
	"Thunderous roar": {
		"knowledge": false,
		"description": ". Third of the Thunder armor set."
	},
	"Cold breeze": {
		"knowledge": false,
		"description": ". Third of the Frost armor set."
	},
	"Leather mail": {
		"knowledge": false,
		"description": "Basic leather armor. +3 ac"
	},
	"Leather vest": {
		"knowledge": false,
		"description": "Cool looking jacket for adventurers. +2 ac"
	},
	"Orc mail": {
		"knowledge": false,
		"description": "It's gleaming darkness."
	},
	"Scale ring mail": {
		"knowledge": false,
		"description": "Scales layered on top of each other."
	},
	"Dwarvish coat": {
		"knowledge": false,
		"description": "Lightweight bluish coat made by dwarves. Finest craftsdwarfship."
	},
	"Platemail": {
		"knowledge": false,
		"description": "Heavy platemail armor."
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
	"Thunder mail": {
		"knowledge": false,
		"description": ""
	},
	"Leather cap": {
		"knowledge": false,
		"description": "Basic leather cap. +1 ac"
	},
	"Bucket helmet": {
		"knowledge": false,
		"description": "Basic metal helmet. A little funny looking. +2 ac"
	},
	"Adorned helmet": {
		"knowledge": false,
		"description": "Expensive fine-made helmet. Worn by royalty. +3 ac"
	},
	"Helm of ego": {
		"knowledge": false,
		"description": ""
	},
	"Uiroel helmet": {
		"knowledge": false,
		"description": ""
	},
#	"Winged helmet": {
#		"knowledge": false,
#		"description": ""
#	},
	"Mossy helmet": {
		"knowledge": false,
		"description": ""
	},
	"Leather gloves": {
		"knowledge": false,
		"description": "Basic leather gloves. +1 ac"
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
	"Burning gauntlets": {
		"knowledge": false,
		"description": ""
	},
	"Garden gloves": {
		"knowledge": false,
		"description": "Gloves made for gardening. Third of the Gleeie'er armor set. +1 ac"
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
	"Slithery belt": {
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
	"Elven cloak": {
		"knowledge": false,
		"description": ""
	},
	"Dwarven cloak": {
		"knowledge": false,
		"description": ""
	},
	"Roman robe": {
		"knowledge": false,
		"description": ""
	},
	"Cloak of displacement": {
		"knowledge": false,
		"description": ""
	},
	"Cloak of magical ambiguity": {
		"knowledge": false,
		"description": ""
	},
#	"Cloak of invisibility": {
#		"knowledge": false,
#		"description": ""
#	},
#	"Adorned cloak": {
#		"knowledge": false,
#		"description": ""
#	},
	"Alchemists robes": {
		"knowledge": false,
		"description": ""
	},
	"Fumy cloth": {
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
	"Dwarvish chausses": {
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
		"description": "Sick shoes. Wicked style! +2 magic dmg"
	},
	"Venom riders": {
		"knowledge": false,
		"description": " Half of the Toxix armor set."
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
	"Bag of weight": {
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
	"Elvish sword": {
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
	"Thunderstruck": {
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
	"Dwarvish dagger": {
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
	"Elvish mace": {
		"knowledge": false,
		"description": ""
	},
	"Dwarvish mace": {
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
	"Elvish flail": {
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
	},
	"Star Love": {
		"knowledge": false,
		"description": ""
	}
}

var critters = {
	"Iovar": {
		"knowledge": false,
		"description": "Iovar, the ancient mage who rules over the dungeon.",
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
		"description": "Non-exoskeletal ant. Terrifyingly strong.",
		"killCount": 0
	},
	"Leaf ant": {
		"knowledge": false,
		"description": "Leaf-carrier ant. Dangerous in large packs.",
		"killCount": 0
	},
	"Soldier ant": {
		"knowledge": false,
		"description": "An ant made for war. Has sharp pincers.",
		"killCount": 0
	},
	"Sugar ant": {
		"knowledge": false,
		"description": "Regular worker ant. Pretty weak",
		"killCount": 0
	},
	"Eyebrow seal": {
		"knowledge": false,
		"description": "Eyebrow-looking ass.",
		"killCount": 0
	},
	"Fiddler crab": {
		"knowledge": false,
		"description": "Crab with a huge claw. And a small one.",
		"killCount": 0
	},
	"Ringed seal": {
		"knowledge": false,
		"description": "A seal with rings.",
		"killCount": 0
	},
	"Tonatuna": {
		"knowledge": false,
		"description": "A slumbering fish. An adult weighs around 1200kg.",
		"killCount": 0
	},
	"Dark bat": {
		"knowledge": false,
		"description": "A regular bat.",
		"killCount": 0
	},
	"Spooky bat": {
		"knowledge": false,
		"description": "An extra spooky bat.",
		"killCount": 0
	},
	"Squinting bat": {
		"knowledge": false,
		"description": "Daytime bat. It can't see very well.",
		"killCount": 0
	},
	"Vampire bat": {
		"knowledge": false,
		"description": "A blood sucking vermin. Beware its lifestealing bite!",
		"killCount": 0
	},
	"Slerp": {
		"knowledge": false,
		"description": "A blob of acid.",
		"killCount": 0
	},
	"Sluerp": {
		"knowledge": false,
		"description": "A blob of acid.",
		"killCount": 0
	},
	"Gearh": {
		"knowledge": false,
		"description": "Powerful, hairy, hunchbacked creature.",
		"killCount": 0
	},
	"Wolf": {
		"knowledge": false,
		"description": "Dogs relative. Hunts in packs.",
		"killCount": 0
	},
	"Warg": {
		"knowledge": false,
		"description": "Wolfs more powerful relative.",
		"killCount": 0
	},
	"Gryonem centaur": {
		"knowledge": false,
		"description": "Flatlands centaur. Very territorial.",
		"killCount": 0
	},
	"Hill centaur": {
		"knowledge": false,
		"description": "Centaur hill people. Not smart enough for talk.",
		"killCount": 0
	},
	"Black dragon": {
		"knowledge": false,
		"description": "A black dragon. Breathes dragonfire.",
		"killCount": 0
	},
	"Blue dragon": {
		"knowledge": false,
		"description": "A blue dragon. Frost resistant. Breathes Frost fire.",
		"killCount": 0
	},
	"Cyan dragon": {
		"knowledge": false,
		"description": "A cyan dragon. Breathes dragonfire.",
		"killCount": 0
	},
	"Green dragon": {
		"knowledge": false,
		"description": "A green dragon. Gleeie'er resistant. Breathes Gleeie'er fire.",
		"killCount": 0
	},
	"Red dragon": {
		"knowledge": false,
		"description": "A red dragon. Fleir resistant. Breathes Fleir fire.",
		"killCount": 0
	},
	"Silver dragon": {
		"knowledge": false,
		"description": "A silver dragon. Breathes dragonfire.",
		"killCount": 0
	},
	"Violet dragon": {
		"knowledge": false,
		"description": "A red dragon. Toxix resistant. Breathes Toxix fir.e",
		"killCount": 0
	},
	"White dragon": {
		"knowledge": false,
		"description": "A red dragon. Breathes dragonfire.",
		"killCount": 0
	},
	"Yellow dragon": {
		"knowledge": false,
		"description": "A red dragon. Thunder resistant. Breathes Thunder fire.",
		"killCount": 0
	},
	"Dwarven contirer": {
		"knowledge": false,
		"description": "A noble dwarf. A little uppity.",
		"killCount": 0
	},
	"Dwarf engineer": {
		"knowledge": false,
		"description": "A dwarven engineer. Constructs equipment for dwarven conquest.",
		"killCount": 0
	},
	"Dwarf miner": {
		"knowledge": false,
		"description": "A dwarven miner. Mines too greedily and too deeply.",
		"killCount": 0
	},
	"Dwarf smith": {
		"knowledge": false,
		"description": "A dwarven smith. Forges equipment for the dwarven army.",
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
		"description": "King of the Elves. Rules from the halls of Lemqueviun.",
		"killCount": 0
	},
	"Elf noble": {
		"knowledge": false,
		"description": "A noble elf. A little uppity.",
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
		"description": "Creepy floating eye. Its piercing gaze will stun you! You can blind yourself to hit the eye.",
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
		"description": "A small-brained giant. Its hairline is receding.",
		"killCount": 0
	},
	"Hill giant": {
		"knowledge": false,
		"description": "A small-brained giant from the hills.",
		"killCount": 0
	},
	"One-eyed ogre": {
		"knowledge": false,
		"description": "A one-eyed ogre. Pretty strong.",
		"killCount": 0
	},
	"Parched giant": {
		"knowledge": false,
		"description": "A small-brained giant. It needs a drink.",
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
		"description": "An Iovar cult recruit.",
		"killCount": 0
	},
	"Iovars cultist": {
		"knowledge": false,
		"description": "A senior cultist. Can cast powerful magics.",
		"killCount": 0
	},
	"Shopkeeper": {
		"knowledge": false,
		"description": "He runs a shop. Shops come in many varieties.",
		"killCount": 0
	},
	"Large kobold": {
		"knowledge": false,
		"description": "Large critter of more than average height.",
		"killCount": 0
	},
	"Tiny kobold": {
		"knowledge": false,
		"description": "Tiny critter of less than average height.",
		"killCount": 0
	},
	"Half-lich": {
		"knowledge": false,
		"description": "One who sook eternal life, but couldn't retain his vitality.",
		"killCount": 0
	},
	"Lich": {
		"knowledge": false,
		"description": "A wizard who sook the mysteries of eternal life.",
		"killCount": 0
	},
	"Grand lich": {
		"knowledge": false,
		"description": "Ancient royal court wizard who sought to overthrow the monarchy. Magical repertoire includes summoning hordes of critters.",
		"killCount": 0
	},
	"Arch-lich": {
		"knowledge": false,
		"description": "Arch-mage of a distant pasts turned dark. Magical repertoire includes summoning hordes of critters.",
		"killCount": 0
	},
	"Humongous mimic": {
		"knowledge": false,
		"description": "It's a chest. Ah, its alive!",
		"killCount": 0
	},
	"Mimic": {
		"knowledge": false,
		"description": "It's an apple. Ah, its alive!",
		"killCount": 0
	},
	"Arctic newt": {
		"knowledge": false,
		"description": "Lizard from the far south.",
		"killCount": 0
	},
	"Highlands newt": {
		"knowledge": false,
		"description": "Medium-sized newt from the badlands.",
		"killCount": 0
	},
	"Mine newt": {
		"knowledge": false,
		"description": "Newt that lives of of minerals.",
		"killCount": 0
	},
	"Paper newt": {
		"knowledge": false,
		"description": "Lizard that feeds on paper and bamboo. Scourge of librarians and  alike",
		"killCount": 0
	},
	"River newt": {
		"knowledge": false,
		"description": "Small river newt.",
		"killCount": 0
	},
	"Dungeon orc": {
		"knowledge": false,
		"description": "Orc originating from Iovars dungeon.",
		"killCount": 0
	},
	"Flatlands orc": {
		"knowledge": false,
		"description": "A regular orc.",
		"killCount": 0
	},
	"Goblin": {
		"knowledge": false,
		"description": "A little gremlin-looking creature. Makes high-pitched screeching noises.",
		"killCount": 0
	},
	"Mountain orc": {
		"knowledge": false,
		"description": "Big mountain orc. Grown in the hostile highlands.",
		"killCount": 0
	},
	"Yrak-i": {
		"knowledge": false,
		"description": "Biggest of the orckind. Yrak-is never bathe, so they are permanently covered in the blood of their enemies.",
		"killCount": 0
	},
	"Chicken": {
		"knowledge": false,
		"description": "Little mammal that quawks and pa-toots.",
		"killCount": 0
	},
#	"Grid bug": {
#		"knowledge": false,
#		"description": "Little bug that moves in a particular pattern.",
#		"killCount": 0
#	},
	"Brontotheridae": {
		"knowledge": false,
		"description": "Huge beast from the distant past. Brought back by Iovars spell.",
		"killCount": 0
	},
	"Rhino": {
		"knowledge": false,
		"description": "A huge rhino. Cant see very well.",
		"killCount": 0
	},
	"Big rat": {
		"knowledge": false,
		"description": "Big ol' rat.",
		"killCount": 0
	},
	"Cave rat": {
		"knowledge": false,
		"description": "Cave-dwelling rat.",
		"killCount": 0
	},
	"Sewer rat": {
		"knowledge": false,
		"description": "Rat grown in the sewers.",
		"killCount": 0
	},
	"Garnered snake": {
		"knowledge": false,
		"description": "Regular snake.",
		"killCount": 0
	},
	"Marsh snake": {
		"knowledge": false,
		"description": "Marsh snakes like to live in swamps and lakes. Has a poisonous bite.",
		"killCount": 0
	},
	"Sawtooth-pattern snake": {
		"knowledge": false,
		"description": "The deadliest of snakes. Has a poisonous bite.",
		"killCount": 0
	},
	"Spectral wraith": {
		"knowledge": false,
		"description": "A spectral wraith from the grave. Etherealness-ability allows the spectral wraith to dodge every other physical attack.",
		"killCount": 0
	},
	"Spooky ghost": {
		"knowledge": false,
		"description": "A spooky ghost from folk tales. Etherealness-ability allows the spooky ghost to dodge every other physical attack.",
		"killCount": 0
	}
}
