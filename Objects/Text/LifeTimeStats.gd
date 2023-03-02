
var lifetimeStats = {
	"Turn count": 0,
	"Highest physical damage dealt": 0,
	"Highest physical damage with magic dealt": 0,
	"Times attacked in melee": 0,
	"Damage dealt in melee": 0,
	"Highest spell damage dealt": 0,
	"Times attacked with spells": 0,
	"Damage dealt with spells": 0,
	"Damage taken": 0,
	"Highest damage taken": 0,
	"Items wished": 0,
	"Species genocided": 0,
	"Times ascended": 0,
	"Game count": 0
}

var items = {
	"Amulet of seeing": {
		"knowledge": false,
		"description": "Allows you to see in dark places."
	},
	"Amulet of magic power": {
		"knowledge": false,
		"description": "Gives +3 magic damage."
	},
	"Amulet of life power": {
		"knowledge": false,
		"description": "Gives +12 maxhp."
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
		"description": "Binds on equip and inflicts Toxix status effect."
	},
	"Thunderous roar": {
		"knowledge": false,
		"description": "Amulet sizzling with electricity. Third of the Thunder armor set."
	},
	"Cold breeze": {
		"knowledge": false,
		"description": "Amulet frozen right through. Third of the Frost armor set."
	},
	"Leather mail": {
		"knowledge": false,
		"description": "Basic leather armor."
	},
	"Leather vest": {
		"knowledge": false,
		"description": "Cool looking jacket for adventurers."
	},
	"Orc mail": {
		"knowledge": false,
		"description": "It's gleaming darkness itself."
	},
	"Scale ring mail": {
		"knowledge": false,
		"description": "Mail with scales layered on top of each other."
	},
	"Dwarvish coat": {
		"knowledge": false,
		"description": "Lightweight blueish coat. Finest craftsdwarfship."
	},
	"Platemail": {
		"knowledge": false,
		"description": "Heavy platemail armor."
	},
	"Blue dragon scale mail": {
		"knowledge": false,
		"description": "Blue dragon scale mail. Gives frost resistance."
	},
	"Green dragon scale mail": {
		"knowledge": false,
		"description": "Green dragon scale mail. Gives Gleeie'er resistance."
	},
	"Red dragon scale mail": {
		"knowledge": false,
		"description": "Red dragon scale mail. Gives Fleir resistance."
	},
	"Yellow dragon scale mail": {
		"knowledge": false,
		"description": "Yellow dragon scale mail. Gives Thunder resistance."
	},
	"Violet dragon scale mail": {
		"knowledge": false,
		"description": "Violet dragon scale mail. Gives Toxix resistance."
	},
	"Great Ulromirs platemail": {
		"knowledge": false,
		"description": "Massive, thick platemail."
	},
	"Frozen mail": {
		"knowledge": false,
		"description": "Mail frozen right through. Third of the Frost armor set."
	},
	"Thunder mail": {
		"knowledge": false,
		"description": "Mail sizzling with electricity. Third of the Thunder armor set."
	},
	"Leather cap": {
		"knowledge": false,
		"description": "A leather cap."
	},
	"Bucket helmet": {
		"knowledge": false,
		"description": "Basic metal helmet. A little funny looking."
	},
	"Adorned helmet": {
		"knowledge": false,
		"description": "Expensive fine-made helmet. Worn by royalty."
	},
	"Helm of ego": {
		"knowledge": false,
		"description": "Crown-looking hat for parties. Coveted by many."
	},
	"Uiroel helmet": {
		"knowledge": false,
		"description": "High-quality helmet."
	},
#	"Winged helmet": {
#		"knowledge": false,
#		"description": "Helmet with wings."
#	},
	"Mossy helmet": {
		"knowledge": false,
		"description": "Dank, mossy helmet. Third of the Gleeie'er armor set."
	},
	"Leather gloves": {
		"knowledge": false,
		"description": "Basic leather gloves."
	},
	"Fabric gloves": {
		"knowledge": false,
		"description": "Light, silky smooth gloves."
	},
	"Gauntlets of Devastation": {
		"knowledge": false,
		"description": "Gives a +1 strength bonus."
	},
	"Gauntlets of Nimbleness": {
		"knowledge": false,
		"description": "Gives a +1 legerity bonus."
	},
	"Gauntlets of Balance": {
		"knowledge": false,
		"description": "Gives a +1 balance bonus."
	},
	"Burning gauntlets": {
		"knowledge": false,
		"description": "Flaming gauntlets. Third of the Fleir armor set."
	},
	"Garden gloves": {
		"knowledge": false,
		"description": "Gloves made for gardening. Third of the Gleeie'er armor set."
	},
	"Gehennors gauntlets": {
		"knowledge": false,
		"description": "Legendary King Gehennors gauntlets. Thickly plated and massive."
	},
	"Leather belt": {
		"knowledge": false,
		"description": "A leather belt."
	},
	"Studded belt": {
		"knowledge": false,
		"description": "Metal studded belt."
	},
	"Belt of Faith": {
		"knowledge": false,
		"description": "Gives a +1 belief bonus."
	},
	"Belt of Symmetry": {
		"knowledge": false,
		"description": "Gives a +1 visage bonus."
	},
	"Belt of Plato": {
		"knowledge": false,
		"description": "Gives a +1 wisdom bonus."
	},
	"Slithery belt": {
		"knowledge": false,
		"description": "Belt made from rare snake skin. Third of the Gleeie'er armor set."
	},
	"Leather cloak": {
		"knowledge": false,
		"description": "A leather cloak."
	},
	"Orc cloak": {
		"knowledge": false,
		"description": "Heavily plated cloak."
	},
	"Elven cloak": {
		"knowledge": false,
		"description": "Light green cloak."
	},
	"Dwarven cloak": {
		"knowledge": false,
		"description": "Good quality cloak."
	},
	"Toga": {
		"knowledge": false,
		"description": "Robe used by royalty."
	},
	"Cloak of displacement": {
		"knowledge": false,
		"description": "Gives displacement."
	},
	"Cloak of magical ambiguity": {
		"knowledge": false,
		"description": "-3 Spell damage taken."
	},
#	"Cloak of invisibility": {
#		"knowledge": false,
#		"description": "Gives invisibility."
#	},
#	"Adorned cloak": {
#		"knowledge": false,
#		"description": "Cloak worn by royalty."
#	},
	"Alchemists robes": {
		"knowledge": false,
		"description": "Robes of an alchemist who sought to bring back the dead."
	},
	"Fumy cloth": {
		"knowledge": false,
		"description": "Piece of cloth that exudes fumes. Half of the Toxix armor set."
	},
	"Battered buckler": {
		"knowledge": false,
		"description": "Small, worn buckler."
	},
	"Large orcish shield": {
		"knowledge": false,
		"description": "Large orcish shield."
	},
	"Justice'eer shield": {
		"knowledge": false,
		"description": "Shield of the religious forces. Gives backscattering."
	},
	"Lords tower board shield": {
		"knowledge": false,
		"description": "A huge shield."
	},
	"Burning shield": {
		"knowledge": false,
		"description": "A flaming shield. Third of the Fleir armor set."
	},
	"Leather pants": {
		"knowledge": false,
		"description": "Leather pants."
	},
	"Scale ring mail chausses": {
		"knowledge": false,
		"description": "Chausses with scales layered on top of each other."
	},
	"Dwarvish chausses": {
		"knowledge": false,
		"description": "Lightweight blueish chausses. Finest craftsdwarfship."
	},
	"Thunder greaves": {
		"knowledge": false,
		"description": "Greaves sizzling with electricity. Third of the Thunder armor set."
	},
	"Burning mail chausses": {
		"knowledge": false,
		"description": "Flaming chausses. Third of the Fleir armor set."
	},
	"Low boots": {
		"knowledge": false,
		"description": "Low boots."
	},
	"Studded boots": {
		"knowledge": false,
		"description": "Plated boots."
	},
	"Boots of magic": {
		"knowledge": false,
		"description": "Boots imbued with magic. Gives +1 non-Fleir spell damage."
	},
	"Boots of fumbling": {
		"knowledge": false,
		"description": "Gives fumbling."
	},
	"Chilly boots": {
		"knowledge": false,
		"description": "Boots frozen right through. Third of the Frost armor set."
	},
	"Cool Mikeys": {
		"knowledge": false,
		"description": "Sick shoes. Wicked style! Gives +2 non-Fleir spell damage."
	},
	"Venom riders": {
		"knowledge": false,
		"description": "Toxix-soaked slick shoes. Half of the Toxix armor set."
	},
	"Empty potion bottle": {
		"knowledge": false,
		"description": "An empty potion bottle. You can fill it with water at a fountain."
	},
	"Water potion": {
		"knowledge": false,
		"description": "Water. Dip scroll into formal water potion to get a blank scroll. Revere or blasphemy items by dipping into respective variants of the water potion."
	},
	"Soda bottle": {
		"knowledge": false,
		"description": "Juicer-enjoyers favourite."
	},
	"Potion of confusion": {
		"knowledge": false,
		"description": "Gives confusion."
	},
	"Potion of Toxix": {
		"knowledge": false,
		"description": "Deals Toxix damage and gives Toxix status effect."
	},
	"Potion of heal": {
		"knowledge": false,
		"description": "Restores hp. Hp amount scales with level."
	},
	"Potion of sleep": {
		"knowledge": false,
		"description": "Makes you fall asleep."
	},
	"Potion of blindness": {
		"knowledge": false,
		"description": "Gives temporary blindness."
	},
#	"Potion of invisibility": {
#		"knowledge": false,
#		"description": "Makes you invisible."
#	},
#	"Potion of levitation": {
#		"knowledge": false,
#		"description": "Makes you levitate."
#	},
	"Potion of paralysis": {
		"knowledge": false,
		"description": "Stuns when quaffed or thrown."
	},
	"Potion of hunger": {
		"knowledge": false,
		"description": "Makes you more hungry. Reverent potion nourishes you."
	},
	"Potion of Healaga": {
		"knowledge": false,
		"description": "Restores alot of hp. Hp amount scales with level."
	},
	"Potion of gain level": {
		"knowledge": false,
		"description": "Level up! Reverent potion gives extra exp. Blasphemous potion removes all current level exp."
	},
#	"Potion of up stat": {
#		"knowledge": false,
#		"description": "Permanent increase for one stat."
#	},
#	"Potion of down stat": {
#		"knowledge": false,
#		"description": "Permanent decrease for one stat."
#	},
	"Ring of Fleir resistance": {
		"knowledge": false,
		"description": "Gives Fleir resistance when worn."
	},
	"Ring of Frost resistance": {
		"knowledge": false,
		"description": "Gives Frost resistance when worn."
	},
	"Ring of Thunder resistance": {
		"knowledge": false,
		"description": "Gives Thunder resistance when worn."
	},
	"Ring of Gleeie'er resistance": {
		"knowledge": false,
		"description": "Gives Gleeie'er resistance when worn."
	},
	"Ring of Toxix resistance": {
		"knowledge": false,
		"description": "Gives Toxix resistance when worn."
	},
	"Ring of protection": {
		"knowledge": false,
		"description": "Gives +3 ac when worn."
	},
	"Ring of hunger": {
		"knowledge": false,
		"description": "Makes you hungry faster. Binds on equip."
	},
#	"Ring of levitation": {
#		"knowledge": false,
#		"description": "Makes you levitate. Binds on equip."
#	},
	"Ring of slow digestion": {
		"knowledge": false,
		"description": "Makes you hungry slower."
	},
	"Ring of regen": {
		"knowledge": false,
		"description": "Gives +3 hp on each hp regen tick."
	},
	"Ring of fumbling": {
		"knowledge": false,
		"description": "Gives fumbling status effect when worn. Binds on equip."
	},
#	"Ring of Strength": {
#		"knowledge": false,
#		"description": "Ring that boosts your strength."
#	},
#	"Ring of Legerity": {
#		"knowledge": false,
#		"description": "Ring that boosts your belief."
#	},
#	"Ring of Balance": {
#		"knowledge": false,
#		"description": "Ring that boosts your belief."
#	},
#	"Ring of Wisdom": {
#		"knowledge": false,
#		"description": "Ring that boosts your belief."
#	},
#	"Ring of Belief": {
#		"knowledge": false,
#		"description": "Ring that boosts your belief."
#	},
#	"Ring of Visage": {
#		"knowledge": false,
#		"description": "Ring that boosts your belief."
#	},
	"Official mail": {
		"knowledge": false,
		"description": "Official mail. Very important, but doesn't actually do anything."
	},
	"Blank scroll": {
		"knowledge": false,
		"description": "A blank scroll. You can write scrolls on it with a marker and ink."
	},
	"Scroll of identify": {
		"knowledge": false,
		"description": "Identifies an item in your inventory. Reverent scroll identifies all items. Blasphemous scroll only identifies a quality of an item."
	},
	"Scroll of create food": {
		"knowledge": false,
		"description": "Summons a comestible. Reverent scroll summons lots of food. Blasphemous scroll summons some cherries."
	},
	"Scroll of confusion": {
		"knowledge": false,
		"description": "Gives confusion."
	},
	"Scroll of remove curse": {
		"knowledge": false,
		"description": "Remove a bind on an item. Reverent scoll unbinds all items. Blasphemous scroll rebinds all bindable items."
	},
	"Scroll of enchant weapon": {
		"knowledge": false,
		"description": "Enchants your worn weapon. Reverent scroll enchants both worn weapons. Blasphemous scroll unenchants a worn weapon."
	},
	"Scroll of enchant armor": {
		"knowledge": false,
		"description": "Enchants a worn armor piece. Reverent scroll enchants three worn armor pieces. Blasphemous scroll unenchants a worn armor piece."
	},
	"Scroll of destroy armor": {
		"knowledge": false,
		"description": "Destroys a piece of worn armor. Reverent scroll disenchants an item."
	},
	"Scroll of summon critter": {
		"knowledge": false,
		"description": "Summons a critter to you. Reverent scroll summons neutral critters. Blasphemous scroll summons critters all around you."
	},
	"Scroll of create potion": {
		"knowledge": false,
		"description": "Summons a potion. Reverent scroll summons lots of potions. Blasphemous scroll summons a Toxix potion."
	},
	"Scroll of teleport": {
		"knowledge": false,
		"description": "Scroll that teleports you. Blasphemous scroll teleports between levels."
	},
	"Scroll of reverent scripture": {
		"knowledge": false,
		"description": "Reveres items when read on an altar with items. Blasphemous scripture blasphemises an item."
	},
	"Scroll of blasphemous scripture": {
		"knowledge": false,
		"description": "Blasphemises items read on an altar with items. Blasphemous scripture reveres an item."
	},
	"Scroll of genocide": {
		"knowledge": false,
		"description": "Genocides a type of monster. Reverent scroll genocides a whole race of critters. Blasphemous scroll summons all the critters to you."
	},
	"Leather bag": {
		"knowledge": false,
		"description": "A bag that can store things."
	},
	"Lockpick": {
		"knowledge": false,
		"description": "Can open and lock doors, albeit slowly. (4 turns for action)"
	},
	"Blindfold": {
		"knowledge": false,
		"description": "Put it on to lose sight temporarily."
	},
	"Candle": {
		"knowledge": false,
		"description": "Gives a small amount of light for a short time in dark places."
	},
	"Credit card": {
		"knowledge": false,
		"description": "Can open locked doors. (3 turns for action)"
	},
	"Shovel": {
		"knowledge": false,
		"description": "Allows you to dig hidden items on the beach."
	},
	"Message in a bottle": {
		"knowledge": false,
		"description": "A bottle that holds a message. What could it be?"
	},
	"Fancy whistle": {
		"knowledge": false,
		"description": "Fancy looking whistle."
	},
	"Oil lamp": {
		"knowledge": false,
		"description": "An oil lamp. Gives a good amount of light for a long time in darkness."
	},
	"Pickaxe": {
		"knowledge": false,
		"description": "Allows mining stone walls."
	},
	"Marker": {
		"knowledge": false,
		"description": "Write scrolls on empty scrolls with marker and ink."
	},
	"Ink bottle": {
		"knowledge": false,
		"description": "Write scrolls on empty scrolls with marker and ink."
	},
	"Key": {
		"knowledge": false,
		"description": "A key. Open and lock doors. (2 turns for action)"
	},
	"Bag of weight": {
		"knowledge": false,
		"description": "Increases weight of items inside the bag. Items put inside bind to the bag. Binds on pick up."
	},
	"Bag of holding": {
		"knowledge": false,
		"description": "Lowers weight of items inside the bag."
	},
	"Magic lamp": {
		"knowledge": false,
		"description": "Magical lamp. Never runs out of oil."
	},
	"Magic marker": {
		"knowledge": false,
		"description": "Magical marker. Never runs out of ink."
	},
	"Magic key": {
		"knowledge": false,
		"description": "Magical key. (1 turn for action)"
	},
	"Tome of Knowledge": {
		"knowledge": true,
		"description": "Tome full of knowledge. When read, unlocks information about an item or a critter."
	},
	"Wand of light": {
		"knowledge": false,
		"description": "Lights your surroundings for awhile."
	},
	"Wand of turn lock": {
		"knowledge": false,
		"description": "Point it at a door to turn the lock. Blasphemous wand doesn't always work."
	},
	"Wand of digging": {
		"knowledge": false,
		"description": "Point it at a stone wall to bore a tunnel. More reverent piety level increases digging distance."
	},
	"Wand of Frost": {
		"knowledge": false,
		"description": "Point it at a critter to strike them with Frost. More reverent piety level increases wand damage and distance."
	},
	"Wand of Fleir": {
		"knowledge": false,
		"description": "Point it at a critter to strike them with Fleir. More reverent piety level increases wand damage and distance."
	},
	"Wand of Thunder": {
		"knowledge": false,
		"description": "Point it at a critter to strike them with Thunder. More reverent piety level increases wand damage and distance."
	},
	"Wand of sleep": {
		"knowledge": false,
		"description": "Point it at a critter to put them to sleep."
	},
	"Wand of magic sphere": {
		"knowledge": false,
		"description": "Launches a magical sphere. More reverent piety level increases wand damage and distance."
	},
	"Wand of backwards magic sphere": {
		"knowledge": false,
		"description": "Launches a magical sphere, at you! Reverent wand misses you."
	},
	"Wand of teleport": {
		"knowledge": false,
		"description": "Point it at a critter to teleport it."
	},
	"Wand of item polymorph": {
		"knowledge": false,
		"description": "Polymorphs items on the ground. More reverent piety level increases amount of items polymorphed and wand distance."
	},
	"Wand of summon critter": {
		"knowledge": false,
		"description": "Summons critters to you. Reverent wand summons neutral critters. Blasphemous wand summons critters all around you."
	},
	"Wand of wishing": {
		"knowledge": false,
		"description": "Make a wish for an item."
	},
	"Chipped sword": {
		"knowledge": false,
		"description": "An old, chipped sword. I think it was my grandpas."
	},
	"Elvish sword": {
		"knowledge": false,
		"description": "An elvish sword. Lightweight."
	},
	"Dwarvish laysword": {
		"knowledge": false,
		"description": "A dwarven laysword. Finest craftdwarfship."
	},
	"Orcish sword": {
		"knowledge": false,
		"description": "Brutish sword made by orcs."
	},
	"Adorned sword": {
		"knowledge": false,
		"description": "Fancy sword carried by royalty."
	},
	"Fleirflare": {
		"knowledge": false,
		"description": "Sword of Fleir."
	},
	"Frostfury": {
		"knowledge": false,
		"description": "Sword of Frost."
	},
	"Thunderstruck": {
		"knowledge": false,
		"description": "Sword of Thunder."
	},
	"Justice'eer sword": {
		"knowledge": false,
		"description": "Sword of the religious forces. Deals extra damage against evil."
	},
	"Stormbringer": {
		"knowledge": false,
		"description": "Sword that carries a storm around it."
	},
	"Vorpal sword": {
		"knowledge": false,
		"description": "Sword that cuts through space itself."
	},
	"Dull two-hander": {
		"knowledge": false,
		"description": "A dull two-hander. This is sharp enough to cut cheese, maybe."
	},
	"Mithril two-hander": {
		"knowledge": false,
		"description": "A dwarven two-hander. Finest craftdwarfship."
	},
	"Dragonslayer": {
		"knowledge": false,
		"description": "A huge slab of iron. Too large to be called a sword."
	},
	"Brittleleaf": {
		"knowledge": false,
		"description": "A brittle branch with some leaves."
	},
	"Icesplitter": {
		"knowledge": false,
		"description": "A two-hander of Frost and Thunder."
	},
	"Cut dagger": {
		"knowledge": false,
		"description": "Broken dagger. You can still poke people with it."
	},
	"Orc dagger": {
		"knowledge": false,
		"description": "Brutish dagger made by orcs."
	},
	"Glowing dagger": {
		"knowledge": false,
		"description": "It glows with lightning."
	},
	"Dwarvish dagger": {
		"knowledge": false,
		"description": "A well-made dwarven dagger. Finest craftdwarfship."
	},
	"Krakag Orraig": {
		"knowledge": false,
		"description": "This dagger was pulled from the eldritch dimension."
	},
	"Dagger of Elbier": {
		"knowledge": false,
		"description": "The Hero Elbiers dagger. Summons Thunder on hit."
	},
	"Worn mace": {
		"knowledge": false,
		"description": "An old mace. It still works."
	},
	"Elvish mace": {
		"knowledge": false,
		"description": "Elven mace. Pretty light."
	},
	"Dwarvish mace": {
		"knowledge": false,
		"description": "Dwarven mace. Pretty powerful."
	},
	"Morning star": {
		"knowledge": false,
		"description": "Mace with spikes."
	},
	"Dumpel Pompel": {
		"knowledge": false,
		"description": "Fancy looking mace."
	},
	"Final Dawn": {
		"knowledge": false,
		"description": "Mace imbued with Fleir."
	},
	"Titan Slayer": {
		"knowledge": false,
		"description": "Mace made for slaying large opponents."
	},
	"Rigid flail": {
		"knowledge": false,
		"description": "Rusty flail ready to fall apart."
	},
	"Sharp flail": {
		"knowledge": false,
		"description": "Flail with sharpened spikes."
	},
	"Elvish flail": {
		"knowledge": false,
		"description": "Elven flail. Lightweight."
	},
	"Crustel flail": {
		"knowledge": false,
		"description": "You can hear winds blow around the spikes."
	},
	"Loperiels Destiny": {
		"knowledge": false,
		"description": "Flail slick with Toxix."
	},
	"Star Love": {
		"knowledge": false,
		"description": "Flail made of the stars themselves."
	}
}

var critters = {
	"Iovar": {
		"knowledge": false,
		"description": "Iovar, the ancient mage who rules over the dungeon. Seeks godhood with obsessive conviction.",
		"killCount": 0
	},
	"Elder Dragon": {
		"knowledge": false,
		"description": "An elderly dragon living in retirement. Exceedingly powerful. Likes to hoard valuables.",
		"killCount": 0
	},
	"Mad Banana-hunter Ogre": {
		"knowledge": false,
		"description": "Give banana?",
		"killCount": 0
	},
	"Shin'kor Leve'er": {
		"knowledge": false,
		"description": "His backstory is as edgy as his blade.",
		"killCount": 0
	},
	"Elhybar": {
		"knowledge": false,
		"description": "Book enthusiast. Scroll-lover. Library vacator.",
		"killCount": 0
	},
	"Tidoh Tel'hydrad": {
		"knowledge": false,
		"description": "A court wizard gone mad with grief. Likes to tell jokes.",
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
		"description": "Regular worker ant. Pretty weak.",
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
		"description": "A blob of acid. Dulls damage when hit.",
		"killCount": 0
	},
	"Sluerp": {
		"knowledge": false,
		"description": "A blob of acid. Deals back damage when hit.",
		"killCount": 0
	},
	"Fleir breb": {
		"knowledge": false,
		"description": "Little Fleir-filled rock. Emits fiery fumes.",
		"killCount": 0
	},
	"Toxix breb": {
		"knowledge": false,
		"description": "Little Toxix-filled rock. Emits toxic fumes.",
		"killCount": 0
	},
	"Thunder breb": {
		"knowledge": false,
		"description": "Little Thunder-filled rock. Emits thunderous fumes.",
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
		"description": "A silver dragon. Has backscattering ability. Breathes dragonfire.",
		"killCount": 0
	},
	"Violet dragon": {
		"knowledge": false,
		"description": "A violet dragon. Toxix resistant. Breathes Toxix fire",
		"killCount": 0
	},
	"White dragon": {
		"knowledge": false,
		"description": "A white dragon. Breathes dragonfire.",
		"killCount": 0
	},
	"Yellow dragon": {
		"knowledge": false,
		"description": "A yellow dragon. Thunder resistant. Breathes Thunder fire.",
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
		"description": "Lone assassin.",
		"killCount": 0
	},
	"Elf hunter": {
		"knowledge": false,
		"description": "A bow wielding hunter.",
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
		"description": "Cat.",
		"killCount": 0
	},
	"Lynx": {
		"knowledge": false,
		"description": "A big cat that lives in coniferous forests.",
		"killCount": 0
	},
	"Tiger": {
		"knowledge": false,
		"description": "Ferocious beast of the jungle. Beware its sharp claws!",
		"killCount": 0
	},
	"Floating eye": {
		"knowledge": false,
		"description": "A creepy floating eye. Its piercing gaze will stun you! You can blind yourself to hit the eye.",
		"killCount": 0
	},
	"Freezing floating sphere": {
		"knowledge": false,
		"description": "A floating spherical shape of frost. It explodes!",
		"killCount": 0
	},
	"Thunderous floating sphere": {
		"knowledge": false,
		"description": "A floating spherical shape of thunder. It explodes!",
		"killCount": 0
	},
	"Unstable floating sphere": {
		"knowledge": false,
		"description": "A floating spherical shape. It explodes!",
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
		"description": "A town guard.",
		"killCount": 0
	},
	"Guard captain": {
		"knowledge": false,
		"description": "Captain of the town guard.",
		"killCount": 0
	},
	"Outlaw watcher": {
		"knowledge": false,
		"description": "An outlaw.",
		"killCount": 0
	},
	"Outlaw fusiee'er": {
		"knowledge": false,
		"description": "Outlaw with a slingshot.",
		"killCount": 0
	},
	"Outlaw merchandiee'er": {
		"knowledge": false,
		"description": "A more thuggish outlaw.",
		"killCount": 0
	},
	"Iovars cultist acolyte": {
		"knowledge": false,
		"description": "An Iovar cult acolyte.",
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
		"description": "Arch-mage of a distant past turned dark. Magical repertoire includes summoning hordes of critters.",
		"killCount": 0
	},
	"Humongous mimic": {
		"knowledge": false,
		"description": "Oh, it's a sword. Ah, its alive!",
		"killCount": 0
	},
	"Mimic": {
		"knowledge": false,
		"description": "Oh, it's an apple. Ah, its alive!",
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
		"description": "Newt that lives in mines and feeds of of minerals.",
		"killCount": 0
	},
	"Paper newt": {
		"knowledge": false,
		"description": "Lizard that feeds on paper and bamboo. Scourge of librarians and archivists alike.",
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
		"description": "A huge rhino. Can't see very well.",
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
		"description": "Marsh snakes live near swamps and lakes. Has a poisonous bite.",
		"killCount": 0
	},
	"Sawtooth-pattern snake": {
		"knowledge": false,
		"description": "Deadliest of snakes. Has a poisonous bite.",
		"killCount": 0
	},
	"Spectral wraith": {
		"knowledge": false,
		"description": "A spectral wraith risen from the grave. Etherealness-ability allows the spectral wraith to dodge every other physical attack.",
		"killCount": 0
	},
	"Spooky ghost": {
		"knowledge": false,
		"description": "A spooky ghost from folk tales. Etherealness-ability allows the spooky ghost to dodge every other physical attack.",
		"killCount": 0
	}
}
