extends Node

func getRandomMessageByType(_critterName, _messageType):
	if typeof(globalGameConsoleMessages[_critterName][_messageType]) == TYPE_STRING:
		return globalGameConsoleMessages[_critterName][_messageType]
	if globalGameConsoleMessages[_critterName][_messageType].has("frequency"):
		if randi() % globalGameConsoleMessages[_critterName][_messageType].frequency == 0:
			return globalGameConsoleMessages[_critterName][_messageType].lines[randi() % globalGameConsoleMessages[_critterName][_messageType].lines.size()]
		return null
	else:
		return globalGameConsoleMessages[_critterName][_messageType][randi() % globalGameConsoleMessages[_critterName][_messageType].size()]

var globalGameConsoleMessages = {
	"Iovar": {
		"spawn": [
			"Thou shalt not escape, cur!",
			"I return!",
			"Thee cannot run!",
			"Thee cannot run, fool!"
		],
		"activated": "I shalt destroy thee, cur!",
		"taunt": {
			"frequency": 3,
			"lines": [
				"Cur!",
				"Perish, ye cur!",
				"Hell awaits thee!",
				"Hell awaits ye!",
				"Hell awaits ye, thug!",
				"Thee shalt not steal mine trinket!",
				"Thee royalty is inadequate, jester!",
				"Thine mettle lacks conviction!",
				"Thee appearance is asymmetrical!",
				"Thine weapon lacks quality!",
				"Thine armor wast stolen!",
				"Thee hairline is receding!"
			],
		},
		"spell": [
			"Have at thee, cur!",
			"Perish, fiend!",
			"Qpgoq lmmgotath!"
		],
		"despawn": [
			"'Tis but a scratch...",
			"I shall return...",
			"I shall return... Cur...",
			"Mine innards, leave not..."
		]
	},
	"Elder Dragon": {
		"activated": "Another adventurer? How quaint.",
		"taunt": {
			"frequency": 4,
			"lines": [
				"Whats this, a snack?",
				"A worm, looking for death.",
				"A twig is challenging me? Hah!",
				"Your face looks like week old porridge.",
				"This is Iovars archnemesis? How the mighty have fallen.",
				"First time seeing an egghead.",
				"Perhaps your hair took a vacation?",
				"Monks hairline and you have plenty in common."
			],
		},
		"spell": [
			"Die.",
			"Flames like the ocean.",
			"Giga Hellfire Burst!"
		],
		"despawn": [
			"One with the fire...",
			"My time... has come...",
			"Perhaps... Iovar will meet his match afterall..."
		]
	},
	"Mad Banana-hunter Ogre": {
		"activated": "Give banana!",
		"taunt": {
			"frequency": 5,
			"lines": [
				"Give banana!",
				"You have banana?",
				"Monke give banana!",
			],
		},
		"despawn": [
			"UUUuUghhh..."
		]
	},
	"Shin'kor Leve'er": {
		"activated": "I've lost all I've known... You'll be next.",
		"taunt": {
			"frequency": 6,
			"lines": [
				"I live for the blade.",
				"This trauma... How depressing.",
				"When you were chasing Iovar, I studied the blade.",
				"Why are we here? Just to suffer?",
				"You couldn't understand what I've been through.",
				"At least I still have my hairline, unlike some."
			],
		},
		"spell": [
			"Sharpen Blade!"
		],
		"despawn": [
			"""Under moonlit sky
Cherry blossom blooms at last
I wither away"""
		]
	},
	"Elhybar": {
		"activated": "You cannot pass! I'm the wielder of the Tome of knowledge! Your dark ignorance will not awail you!",
		"taunt": {
			"frequency": 4,
			"lines": [
				"Stealing books? How could you!",
				"Not the books!",
				"You illiterate fool!",
				"Once I was like you... Then I read some books.",
				"Iovar is doing right in getting rid of you.",
				"The scrolls too? Have you no mercy?",
				"You lowly troglodyte! Begone!",
				"Your hair? Where did it go? How tragic..."
			],
		},
		"spell": [
			"This'll take care of you!",
			"Big Book Attack!",
			"Omega Knowledge Cannon!"
		],
		"despawn": [
			"But who will maintain the library? No...",
			"Who will copy the books? Our history...",
			"But... My responsibility is here. What will time do to this place?"
		]
	},
	"Tidoh Tel'hydrad": {
		"activated": "Whats this? Another joke? Tee-hee-hee!",
		"taunt": {
			"frequency": 2,
			"lines": [
				"Jesters shoes fit you well, I see. Tee-hee-hee!",
				"Fancy seeing a troglodyte all the way down here. Hih hih!",
				"Iovar certainly has his hands full with you. Quite the heavy load! Hahaha!",
				"Are you lost, mine newt? Hee-hee-hee!",
				"I think I saw your cousin yesterday. Hes a nice ogre. Haha, hehe, huhu!",
				"My loved, where are you? I'm lost...",
				"Will you return, Lucy?",
				"Is that a potato on your face? Oh, its just your nose. Hee-he-hee!",
				"Quite the achievement, falling the stairs all the way down here. Ha! Ha! Ha!",
				"Look, you're supposed to hold the weapon by the handle, not the blade! Heh heh!",
				"Nice coat! Did you steal it from a goblin? Ho! Ho! Ho!",
				"Looks like your hair already retreated from this battle. Hah!"
			],
		},
		"spell": [
			"Speliamus gigantomus!",
			"Crucio!",
			"Freeziamo!",
			"Burnicus maximus!",
			"Shockelimanos!"
		],
		"despawn": [
			"HAHAHAHAHA!!!",
			"EHEHEHEHEHE!!!",
			"Lucy... One day..."
		]
	},
	"Leaf ant": {
		"taunt": {
			"frequency": 10,
			"lines": [
				"Skitters"
			],
		},
		"despawn": [
			"Eeeee!"
		]
	},
	"Soldier ant": {
		"taunt": {
			"frequency": 10,
			"lines": [
				"Skitters"
			],
		},
		"despawn": [
			"RRRrrrr..."
		]
	},
	"Sugar ant": {
		"taunt": {
			"frequency": 10,
			"lines": [
				"Skitters"
			],
		},
		"despawn": [
			"Eeeeee..."
		]
	},
	"Fiddler crab": {
		"taunt": {
			"frequency": 3,
			"lines": [
				"Click",
				"Clack"
			],
		},
		"despawn": [
			"Crack!"
		]
	},
	"Dark bat": {
		"taunt": {
			"frequency": 7,
			"lines": [
				"Sqwueeek!"
			],
		},
		"despawn": [
			"Sqwueeek!"
		]
	},
	"Spooky bat": {
		"taunt": {
			"frequency": 7,
			"lines": [
				"Skreeee!",
				"Skreeeeh!"
			],
		},
		"despawn": [
			"Skreeee!"
		]
	},
	"Squinting bat": {
		"taunt": {
			"frequency": 7,
			"lines": [
				"Sqwueeek!"
			],
		},
		"despawn": [
			"Sqwueeek..."
		]
	},
	"Slerp": {
		"taunt": {
			"frequency": 5,
			"lines": [
				"Slerp",
				"Slorp"
			],
		},
		"despawn": [
			"Splat!"
		]
	},
	"Sluerp": {
		"taunt": {
			"frequency": 5,
			"lines": [
				"Sluerp",
				"Slarp",
				"Splorp"
			],
		},
		"despawn": [
			"Splat!"
		]
	},
	"Gearh": {
		"taunt": {
			"frequency": 4,
			"lines": [
				"Roars",
				"RAAAAARRRRRR!",
				"GGRRRRRRRRR!!!"
			],
		},
		"despawn": [
			"GRRRRrrrr..."
		]
	},
	"Wolf": {
		"taunt": {
			"frequency": 12,
			"lines": [
				"Roars",
				"Raaarrr!",
				"Grrrrrrr..."
			],
		},
		"despawn": [
			"Whimpers",
			"Grrrr..."
		]
	},
	"Warg": {
		"taunt": {
			"frequency": 8,
			"lines": [
				"Roars",
				"Raaarrr!",
				"Grrrrrrr..."
			],
		},
		"despawn": [
			"Whimpers",
			"Grrrr..."
		]
	},
	"Gryonem centaur": {
		"taunt": {
			"freguency": 12,
			"lines": [
				"Thy constitution is weak, wimp!",
				"Thy mind is simple, fool!",
				"Thy legs are slow, stragler!",
				"Hmph."
			]
		},
		"despawn": [
			"Ugghhhfffff..."
		]
	},
	"Hill centaur": {
		"despawn": [
			"Unff!"
		]
	},
	"Black dragon": {
		"spawn": [
			"GGGGRRRRRRAAAAAAAAAAAAAAAAA!!!!!",
		],
		"spell": [
			"GGGGGRRRRRRRRRROOOOOOOOOOOOO!!!!!"
		],
		"despawn": [
			"GGGRRRRRrrrrrr....."
		]
	},
	"Blue dragon": {
		"spawn": [
			"GGGGRRRRRRAAAAAAAAAAAAAAAAA!!!!!",
		],
		"spell": [
			"GGGGGRRRRRRRRRROOOOOOOOOOOOO!!!!!"
		],
		"despawn": [
			"GGGRRRRRrrrrrr....."
		]
	},
	"Cyan dragon": {
		"spawn": [
			"GGGGRRRRRRAAAAAAAAAAAAAAAAA!!!!!",
		],
		"spell": [
			"GGGGGRRRRRRRRRROOOOOOOOOOOOO!!!!!"
		],
		"despawn": [
			"GGGRRRRRrrrrrr....."
		]
	},
	"Green dragon": {
		"spawn": [
			"GGGGRRRRRRAAAAAAAAAAAAAAAAA!!!!!",
		],
		"spell": [
			"GGGGGRRRRRRRRRROOOOOOOOOOOOO!!!!!"
		],
		"despawn": [
			"GGGRRRRRrrrrrr....."
		]
	},
	"Red dragon": {
		"spawn": [
			"GGGGRRRRRRAAAAAAAAAAAAAAAAA!!!!!",
		],
		"spell": [
			"GGGGGRRRRRRRRRROOOOOOOOOOOOO!!!!!"
		],
		"despawn": [
			"GGGRRRRRrrrrrr....."
		]
	},
	"Silver dragon": {
		"spawn": [
			"GGGGRRRRRRAAAAAAAAAAAAAAAAA!!!!!",
		],
		"spell": [
			"GGGGGRRRRRRRRRROOOOOOOOOOOOO!!!!!"
		],
		"despawn": [
			"GGGRRRRRrrrrrr....."
		]
	},
	"Violet dragon": {
		"spawn": [
			"GGGGRRRRRRAAAAAAAAAAAAAAAAA!!!!!",
		],
		"spell": [
			"GGGGGRRRRRRRRRROOOOOOOOOOOOO!!!!!"
		],
		"despawn": [
			"GGGRRRRRrrrrrr....."
		]
	},
	"White dragon": {
		"spawn": [
			"GGGGRRRRRRAAAAAAAAAAAAAAAAA!!!!!",
		],
		"spell": [
			"GGGGGRRRRRRRRRROOOOOOOOOOOOO!!!!!"
		],
		"despawn": [
			"GGGRRRRRrrrrrr....."
		]
	},
	"Yellow dragon": {
		"spawn": [
			"GGGGRRRRRRAAAAAAAAAAAAAAAAA!!!!!",
		],
		"spell": [
			"GGGGGRRRRRRRRRROOOOOOOOOOOOO!!!!!"
		],
		"despawn": [
			"GGGRRRRRrrrrrr....."
		]
	},
	"Dwarven contirer": {
		"spawn": "What happened? Elven trickery!",
		"taunt": {
			"frequency": 8,
			"lines": [
				"Protect the treasury!",
				"You slimy elf!",
				"Our ways are superior!"
			],
		},
		"despawn": [
			"I return to earth...",
			"Yells"
		]
	},
	"Dwarf engineer": {
		"spawn": "What happened? Elven trickery!",
		"taunt": {
			"frequency": 8,
			"lines": [
				"Protect the treasury!",
				"You slimy elf!",
				"Our ways are superior!"
			],
		},
		"despawn": [
			"I return to earth...",
			"Yells"
		]
	},
	"Dwarf miner": {
		"spawn": "What happened? Elven trickery!",
		"taunt": {
			"frequency": 8,
			"lines": [
				"Protect the treasury!",
				"You slimy elf!",
				"Our ways are superior!"
			],
		},
		"despawn": [
			"I return to earth...",
			"Yells"
		]
	},
	"Dwarf smith": {
		"spawn": "What happened? Elven trickery!",
		"taunt": {
			"frequency": 8,
			"lines": [
				"Protect the treasury!",
				"You slimy elf!",
				"Our ways are superior!"
			],
		},
		"despawn": [
			"I return to earth...",
			"Yells"
		]
	},
	"Elf assassin": {
		"despawn": [
			"I become one with nature..."
		]
	},
	"Elf hunter": {
		"spawn": "What happened? Dwarven trickery!",
		"taunt": {
			"frequency": 8,
			"lines": [
				"Protect nature!",
				"You fat dwarf!",
				"Our ways are superior!"
			],
		},
		"spell": {
			"freguency": 8,
			"lines": [
				"Sharpshooter Bolt!"
			],
		},
		"despawn": [
			"I return to earth...",
			"Screams"
		]
	},
	"Elf king": {
		"activated": "Fool. Never should have come here.",
		"taunt": {
			"frequency": 7,
			"lines": [
				"Your stature is that of a dwarf!",
				"Mine kingdom is not for yours to take.",
				"Leave my halls!",
				"Iovar couldn't defeat me, why would you be any different?",
				"I see you've lost some of your hair."
			],
		},
		"spell": [
			"Hyper Wind Gust!"
		],
		"despawn": [
			"Finally... I'll be whole again...",
			"One... With the earth..."
		]
	},
	"Elf noble": {
		"spawn": "What happened? Dwarven trickery!",
		"taunt": {
			"frequency": 8,
			"lines": [
				"Protect nature!",
				"You fat dwarf!",
				"Our ways are superior!"
			],
		},
		"spell": {
			"freguency": 8,
			"lines": [
				"Sharpshooter Bolt!"
			],
		},
		"despawn": [
			"I return to earth...",
			"Screams"
		]
	},
	"Cat": {
		"taunt": {
			"frequency": 12,
			"lines": [
				"Roars cutely",
				"Raawwrr!",
				"Hissss!",
				"Meow!",
				"Mau?",
				"Nau!",
				"Mrrvvv.",
				"Purrs"
			],
		},
		"despawn": [
			"Meow..."
		]
	},
	"Lynx": {
		"taunt": {
			"frequency": 12,
			"lines": [
				"Roars",
				"Raawwrr!",
				"Grrrrr...",
				"Hissss!",
				"Mrrvvv.",
				"Purrs"
			],
		},
		"despawn": [
			"Meow..."
		]
	},
	"Tiger": {
		"taunt": {
			"frequency": 12,
			"lines": [
				"Roars",
				"RAAAaawwrrr!",
				"GRRRrrrrrrr...",
				"Haz-hhsssssss!",
				"Purrs"
			],
		},
		"despawn": [
			"Whimpers",
			"Grrrrrrr..."
		]
	},
	"Unstable floating sphere": {
		"despawn": [
			"KA-BLAM!!!"
		]
	},
	"Freezing floating sphere": {
		"despawn": [
			"CRACCSHHK!!!"
		]
	},
	"Thunderous floating sphere": {
		"despawn": [
			"KA-BOOOOOOOM!!!"
		]
	},
	"Balding giant": {
		"spawn": "Huh? Where... am... I?",
		"taunt": {
			"frequency": 20,
			"lines": [
				"You big smelly willy!",
				"Ugg?",
				"Ogg.",
				"Me strong!",
				"Egghh.",
				"Grunts",
				"Your hair... You... Too?"
			],
		},
		"despawn": [
			"UUUUUuuUUUGggghhhhh...",
			"UUUuuUuunnfffff..."
		]
	},
	"Hill giant": {
		"spawn": "Huh? Where... am... I?",
		"taunt": {
			"frequency": 20,
			"lines": [
				"You big smelly willy!",
				"Ugg?",
				"Ogg.",
				"Me strong!",
				"Egghh.",
				"Grunts"
			],
		},
		"despawn": [
			"UUUUUuuUUUGggghhhhh...",
			"UUUuuUuunnfffff..."
		]
	},
	"One-eyed ogre": {
		"spawn": "Huh? Where... am... I?",
		"taunt": {
			"frequency": 20,
			"lines": [
				"You big smelly willy!",
				"Ugg?",
				"Ogg.",
				"Me strong!",
				"Egghh.",
				"Grunts"
			],
		},
		"despawn": [
			"UUUUUuuUUUGggghhhhh...",
			"UUUuuUuunnfffff..."
		]
	},
	"Parched giant": {
		"spawn": "Huh? Where... am... I?",
		"taunt": {
			"frequency": 20,
			"lines": [
				"You big smelly willy!",
				"Ugg?",
				"Ogg.",
				"Me strong!",
				"Egghh.",
				"Grunts"
			],
		},
		"despawn": [
			"UUUUUuuUUUGggghhhhh...",
			"UUUuuUuunnfffff..."
		]
	},
	"Guard": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 12,
			"lines": [
				"For the Guard!",
				"Fight! Fight! Fight!",
				"I won't give in!",
				"Shall we gather for whisky and cigars tonight?",
				"Indeed, I believe so.",
				"What?",
				"What!",
				"See?",
				"Grunts"
			],
		},
		"despawn": [
			"OOOoooohhhh...",
			"UUUuuuuffff..."
		]
	},
	"Guard captain": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 12,
			"lines": [
				"For the Guard!",
				"Charge!",
				"I won't give in!"
			],
		},
		"despawn": [
			"OOOoooohhhh...",
			"UUUuuuuffff..."
		]
	},
	"Outlaw watcher": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 21,
			"lines": [
				"I forgot my hat...",
				"Come e're!",
				"Ye oaf!",
				"I'll shank ya, mate!"
			],
		},
		"despawn": [
			"Uuuuughhhh...",
			"Ooooffffghhhh..."
		]
	},
	"Outlaw fusiee'er": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 21,
			"lines": [
				"Come 're!",
				"Ye oaf!",
				"I'll shank ya, mate!"
			],
		},
		"spell": [
			"Super Rock Throw!"
		],
		"despawn": [
			"Uuuuughhhh...",
			"Ooooffffghhhh..."
		]
	},
	"Outlaw merchandiee'er": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 14,
			"lines": [
				"Come 're!",
				"Ye oaf!",
				"I'll shank ya, mate!"
			],
		},
		"despawn": [
			"Uuuuughhhh...",
			"Ooooffffghhhh..."
		]
	},
	"Iovars cultist acolyte": {
		"population": 64,
		"crittersInPlay": 0
	},
	"Iovars cultist": {
		"population": 38,
		"crittersInPlay": 0
	},
	"Shopkeeper": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 7,
			"lines": [
				"No! Stop!",
				"Im just a shopkeeper!",
				"Why?"
			],
		},
		"despawn": [
			"Uuuuughhhh...",
			"Ooooffffghhhh..."
		]
	},
	"Half-lich": {
		"spawn": "Rattles bones enthusiastically",
		"taunt": {
			"frequency": 7,
			"lines": [
				"Rattles bones",
				"Rattles bones aggressively",
				"Clack. Clack! Clack."
			],
		},
		"despawn": [
			"Clomps!",
		]
	},
	"Lich": {
		"spawn": "I rise!",
		"taunt": {
			"frequency": 7,
			"lines": [
				"Living shouldn't question the dead!",
				"You'll be part of my undead!",
				"I'm 237 years young, mind you.",
				"Iovar will never have you. You're mine!",
				"Skeletons have more hair than you."
			],
		},
		"spell": {
			"frequency": 4,
			"lines": [
				"Freeze!",
				"Burn!",
				"Thunder!",
				"Summon Critter!"
			]
		},
		"despawn": [
			"One day, I'll return.",
			"Death is not the end."
		]
	},
	"Grand lich": {
		"spawn": "I rise!",
		"taunt": {
			"frequency": 7,
			"lines": [
				"Living shouldn't question the dead!",
				"You'll be part of my undead!",
				"I'm 587 years young, mind you.",
				"Iovar will never have you. You're mine!",
				"Skeletons have more hair than you."
			],
		},
		"spell": {
			"frequency": 4,
			"lines": [
				"Freeze!",
				"Burn!",
				"Thunder!",
				"Greater Summon Critter!"
			]
		},
		"despawn": [
			"One day, I'll return.",
			"Death is not the end."
		]
	},
	"Arch-lich": {
		"spawn": "I rise once more!",
		"taunt": {
			"frequency": 7,
			"lines": [
				"Living shouldn't question the dead!",
				"You'll be part of my undead!",
				"I'm 898 years young, mind you.",
				"Iovar will never have you. You're mine!",
				"Skeletons have more hair than you."
			],
		},
		"spell": {
			"frequency": 4,
			"lines": [
				"Freeze!",
				"Burn!",
				"Thunder!",
				"Greater Summon Critter!"
			]
		},
		"despawn": [
			"One day, I'll return.",
			"Death is not the end."
		]
	},
	"Arctic newt": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"SSSsssss!",
				"Sss.",
				"Sss-szh!"
			],
		},
		"despawn": [
			"Sssszszszs..."
		]
	},
	"Highlands newt": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"SSSsssss!",
				"Sss.",
				"Sss-szh!"
			],
		},
		"despawn": [
			"Sssszszszs..."
		]
	},
	"Mine newt": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"SSSsssss!",
				"Sss.",
				"Sss-szh!"
			],
		},
		"despawn": [
			"Sssszszszs..."
		]
	},
	"Paper newt": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"SSSsssss!",
				"Sss.",
				"Sss-szh!"
			],
		},
		"despawn": [
			"Sssszszszs..."
		]
	},
	"River newt": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"SSSsssss!",
				"Sss.",
				"Sss-szh!"
			],
		},
		"despawn": [
			"Sssszszszs..."
		]
	},
	"Dungeon orc": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"Blorgh!",
				"Blorg.",
				"Blurgh-ogh!"
			],
		},
		"despawn": [
			"Blurgh..."
		]
	},
	"Flatlands orc": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"Blorgh!",
				"Blorg.",
				"Blurgh-ogh!"
			],
		},
		"despawn": [
			"Blurgh..."
		]
	},
	"Goblin": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"REeeeEE!",
				"REEEeeee!",
				"REEEEE!"
			],
		},
		"despawn": [
			"Reeeeeee..."
		]
	},
	"Mountain orc": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"Blorgh!",
				"Blorg.",
				"Blurgh-ogh!"
			],
		},
		"despawn": [
			"Blurgh..."
		]
	},
	"Yrak-i": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"BLOOORGGHH!",
				"BLURGH!",
				"BLÖÖÖÖRG!"
			],
		},
		"despawn": [
			"UUURRGGGHHH..."
		]
	},
	"Chicken": {
		"taunt": {
			"frequency": 5,
			"lines": [
				"Po-blaaat!",
				"Pa-tooooot!",
				"Ptt. Ptt. Ptt.",
				"Cluck. Cluck. Pt.",
				"Buk, buk, buk, ba-GAWK!"
			],
		},
		"despawn": [
			"Pa-TOOOT!"
		]
	},
	"Brontotheridae": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"BULAAARGGG!",
				"BLOOOOORRGGG!",
				"BLEEOORRRG."
			],
		},
		"despawn": [
			"BLURGH..."
		]
	},
	"Rhino": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"BULAAARGGG!",
				"BLOOOOORRGGG!",
				"BLEEOORRRG."
			],
		},
		"despawn": [
			"BLURGH..."
		]
	},
	"Big rat": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"Sqwueeek!",
				"Sqwik.",
				"Sqwk. Sqwk."
			],
		},
		"despawn": [
			"Sqwueeek..."
		]
	},
	"Cave rat": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"Sqwueeek!",
				"Sqwik.",
				"Sqwk. Sqwk."
			],
		},
		"despawn": [
			"Sqwueeek..."
		]
	},
	"Sewer rat": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"Sqwueeek!",
				"Sqwik.",
				"Sqwk. Sqwk."
			],
		},
		"despawn": [
			"Sqwueeek..."
		]
	},
	"Garnered snake": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"Ssss!",
				"Ssss..."
			],
		},
		"spell": [
			"HhssssSSSS!"
		],
		"despawn": [
			"SSSssss..."
		]
	},
	"Marsh snake": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"Ssss!",
				"Ssss..."
			],
		},
		"spell": [
			"HhssssSSSS!"
		],
		"despawn": [
			"SSSssss..."
		]
	},
	"Sawtooth-pattern snake": {
		"taunt": {
			"frequency": 6,
			"lines": [
				"Ssss!",
				"Ssss..."
			],
		},
		"spell": [
			"HhssssSSSS!"
		],
		"despawn": [
			"SSSssss..."
		]
	},
	"Spectral wraith": {
		"taunt": {
			"frequency": 4,
			"lines": [
				"oooaaaooo..."
			],
		},
		"spell": [
			"OOOOoooooowwwww..."
		],
		"despawn": [
			"AAAAAaaaaaOOOOOoooooooo..."
		]
	},
	"Spooky ghost": {
		"taunt": {
			"frequency": 2,
			"lines": [
				"OOOOOOOoooooOOOOO!"
			],
		},
		"spell": [
			"ooooOOOOOOOOO!!!"
		],
		"despawn": [
			"OOOOOOoooooooOOOOOOooooooo..."
		]
	}
}
