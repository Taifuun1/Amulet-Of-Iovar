extends Node

func getRandomMessageByType(_critterName, _messageType):
	if !globalGameConsoleMessages.has(_critterName) or !globalGameConsoleMessages[_critterName].has(_messageType):
		return null
	if typeof(globalGameConsoleMessages[_critterName][_messageType]) == TYPE_STRING:
		return globalGameConsoleMessages[_critterName][_messageType]
	if globalGameConsoleMessages[_critterName][_messageType].has("frequency"):
		if randi() % globalGameConsoleMessages[_critterName][_messageType].frequency == 0:
			return globalGameConsoleMessages[_critterName][_messageType].lines[randi() % globalGameConsoleMessages[_critterName][_messageType].lines.size()]
		return null
	else:
		return globalGameConsoleMessages[_critterName][_messageType][randi() % globalGameConsoleMessages[_critterName][_messageType].size()]

func getInteractionFlavorMessage(_critterName, _critterAI):
	if _critterAI.matchn("aggressive") or _critterAI.matchn("slow aggressive") or _critterAI.matchn("mimicking"):
		match _critterName.to_lower():
			"fiddler crab":
				Globals.gameConsole.addLog("The fiddler crab tries to pincer you.")
			"ringed seal", "eyebrow seal":
				Globals.gameConsole.addLog("The seal doesn't accept your pats.")
			"wolf":
				Globals.gameConsole.addLog("You try to pet the wolf. It tries to bite you. Bad doggy!.")
			"wolf":
				Globals.gameConsole.addLog("You try to pet the Warg. It growls at you. Scary!")
			"gearh":
				Globals.gameConsole.addLog("You try to pet the gearh. It tries to eat you. Aaah!")
			"elhybar":
				Globals.gameConsole.addLog("Keep your trogdolyte hands to yourself!", _critterName)
			"tidoh tel'hydrad":
				Globals.gameConsole.addLog("Beatiful goblin hands you have! Hahaha!", _critterName)
			"shin'kor leve'er":
				Globals.gameConsole.addLog("...", _critterName)
			"elder Dragon":
				Globals.gameConsole.addLog("Your headpats mean nothing, peon.", _critterName)
			"iovar":
				Globals.gameConsole.addLog("Keep thy hands off me, cur!", _critterName)
			"gryonem centaur":
				Globals.gameConsole.addLog("Thy shalt not converse in war, weakling.", _critterName)
			"dwarf miner", "dwarf engineer", "dwarf smith", "dwarf contirer":
				Globals.gameConsole.addLog("Got any gems?", _critterName)
			"elf hunter", "elf noble":
				Globals.gameConsole.addLog("Good day.", _critterName)
			"elf assassin":
				Globals.gameConsole.addLog("...")
			"elf king":
				Globals.gameConsole.addLog("Your feet disgrace these halls.", _critterName)
			"cat":
				Globals.gameConsole.addLog("You try to pet the cat. It tries to scratch you. Ow!")
			"lynx":
				Globals.gameConsole.addLog("You try to pet the lynx. It tries to scratch you. Ow!")
			"tiger":
				Globals.gameConsole.addLog("You try to pet the tiger. It tries to eat you. Aaah!")
			"shopkeeper":
				Globals.gameConsole.addLog("Aaah!", _critterName)
			"guard", "guard captain":
				Globals.gameConsole.addLog("Stop! You violated the law. Pay the court a fine or serve your sentence. Your stolen goods are now forfeit.", _critterName)
			"outlaw watcher", "outlaw fusiee'er", "outlaw merchandiee'er":
				Globals.gameConsole.addLog("I'll shank ya, mate!", _critterName)
			"iovars cultist acolyte", "iovars cultist":
				Globals.gameConsole.addLog("Die, interloper!", _critterName)
			"half-lich":
				Globals.gameConsole.addLog("[i]Rattles bones aggressively[/i]", _critterName)
			"lich", "grand lich", "arch-lich":
				Globals.gameConsole.addLog("You can't escape to death.", _critterName)
			_:
				Globals.gameConsole.addLog("You can't interact with the {critterName}.".format({ "critterName": _critterName }))
	else:
		match _critterName.to_lower():
			"fiddler crab":
				Globals.gameConsole.addLog("The fiddler crab is unimpressed by your pats.")
			"ringed seal", "eyebrow seal":
				Globals.gameConsole.addLog("The seal accepts your pats.")
			"wolf":
				Globals.gameConsole.addLog("You pet the wolf. It woofs exitedly. Good doggy!.")
			"wolf":
				Globals.gameConsole.addLog("You pet the Warg. It stares at you. Scary!")
			"gearh":
				Globals.gameConsole.addLog("You pet the gearh. It looks like it wants to eat you. Aaah!")
			"gryonem centaur":
				Globals.gameConsole.addLog("A true warrior is always vigilant.")
			"dwarf miner", "dwarf engineer", "dwarf smith", "dwarf contirer":
				Globals.gameConsole.addLog("Got any gems?")
			"elf hunter", "elf noble":
				Globals.gameConsole.addLog("Good day.")
			"elf assassin":
				Globals.gameConsole.addLog("...")
			"elf king":
				Globals.gameConsole.addLog("You are welcome in these halls.")
			"cat":
				Globals.gameConsole.addLog("You pet the cat.")
				Globals.gameConsole.addLog("[i]Purrr...[/i]", _critterName)
			"lynx":
				Globals.gameConsole.addLog("You pet the lynx.")
				Globals.gameConsole.addLog("[i]Purrr...[/i]", _critterName)
			"tiger":
				Globals.gameConsole.addLog("You pet the tiger.")
				Globals.gameConsole.addLog("[i]Purrr...[/i]", _critterName)
			"shopkeeper":
				Globals.gameConsole.addLog("Only the best wares here.")
			"guard", "guard captain":
				Globals.gameConsole.addLog("Good day, sir.", _critterName)
			"outlaw watcher", "outlaw fusiee'er", "outlaw merchandiee'er":
				if randi() % 2 == 0:
					Globals.gameConsole.addLog("G'day, mate.", _critterName)
				else:
					Globals.gameConsole.addLog("Mmph.", _critterName)
			"iovars cultist acolyte", "iovars cultist":
				Globals.gameConsole.addLog("Hello, friend of Iovar.", _critterName)
			"half-lich":
				Globals.gameConsole.addLog("[i]Rattles bones conversely[/i]", _critterName)
			"lich", "grand lich", "arch-lich":
				Globals.gameConsole.addLog("Hello, young one.", _critterName)
			_:
				Globals.gameConsole.addLog("You can't interact with the {critterName}.".format({ "critterName": _critterName }))

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
				"Perish, cur!",
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
			"Qpgoq lmmgotath!",
			"Szop'gk lm'tagh!",
			"Umqg'vat gqopz!"
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
				"Monke give banana!"
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
			"frequency": 18,
			"lines": [
				"[i]chp-chp-chp[/i]"
			],
		}
	},
	"Soldier ant": {
		"taunt": {
			"frequency": 5,
			"lines": [
				"[i]CHP-CHP-CHP[/i]"
			],
		},
		"speech": {
			"frequency": 15,
			"lines": [
				"[i]Chp-chp-chp[/i]"
			],
		},
		"despawn": [
			"[i]CLAK-CLAK[/i]"
		]
	},
	"Sugar ant": {
		"speech": {
			"frequency": 10,
			"lines": [
				"[i]Chp-chp-chp[/i]"
			],
		}
	},
	"Fiddler crab": {
		"speech": {
			"frequency": 3,
			"lines": [
				"[i]Click[/i]",
				"[i]Clack[/i]"
			],
		},
		"despawn": [
			"Crack!"
		]
	},
	"Dark bat": {
		"speech": {
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
		"speech": {
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
		"speech": {
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
		"speech": {
			"frequency": 5,
			"lines": [
				"[i]Slerp[/i]",
				"[i]Slorp[/i]"
			],
		},
		"taunt": {
			"frequency": 5,
			"lines": [
				"[i]Slerp[/i]",
				"[i]Slorp[/i]"
			],
		},
		"despawn": [
			"[i]Splat![/i]"
		]
	},
	"Sluerp": {
		"speech": {
			"frequency": 5,
			"lines": [
				"[i]Sluerp[/i]",
				"[i]Slarp[/i]",
				"[i]Splorp[/i]"
			],
		},
		"taunt": {
			"frequency": 5,
			"lines": [
				"[i]Sluerp[/i]",
				"[i]Slarp[/i]",
				"[i]Splorp[/i]"
			],
		},
		"despawn": [
			"[i]Splat![/i]"
		]
	},
	"Fleir breb": {
		"speech": {
			"frequency": 10,
			"lines": [
				"[i]Brop[/i]",
				"[i]Brup[/i]",
				"[i]Brep[/i]"
			],
		},
		"taunt": {
			"frequency": 7,
			"lines": [
				"[i]Brop[/i]",
				"[i]Brup[/i]",
				"[i]Brep[/i]"
			],
		},
		"despawn": [
			"[i]Crak![/i]"
		]
	},
	"Toxix breb": {
		"speech": {
			"frequency": 10,
			"lines": [
				"[i]Brop[/i]",
				"[i]Brup[/i]",
				"[i]Brep[/i]"
			],
		},
		"taunt": {
			"frequency": 7,
			"lines": [
				"[i]Brop[/i]",
				"[i]Brup[/i]",
				"[i]Brep[/i]"
			],
		},
		"despawn": [
			"[i]Crak![/i]"
		]
	},
	"Thunder breb": {
		"speech": {
			"frequency": 10,
			"lines": [
				"[i]Brop[/i]",
				"[i]Brup[/i]",
				"[i]Brep[/i]"
			],
		},
		"taunt": {
			"frequency": 7,
			"lines": [
				"[i]Brop[/i]",
				"[i]Brup[/i]",
				"[i]Brep[/i]"
			],
		},
		"despawn": [
			"[i]Crak![/i]"
		]
	},
	"Gearh": {
		"taunt": {
			"frequency": 4,
			"lines": [
				"[i]Roar[/i]",
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
				"[i]Roar[/i]",
				"Raaarrr!",
				"Grrrrrrr..."
			],
		},
		"despawn": [
			"[i]Whimper[/i]",
			"Grrrr..."
		]
	},
	"Warg": {
		"taunt": {
			"frequency": 8,
			"lines": [
				"[i]Roar[/i]",
				"Raaarrr!",
				"Grrrrrrr..."
			],
		},
		"despawn": [
			"[i]Whimper[/i]",
			"Grrrr..."
		]
	},
	"Gryonem centaur": {
		"taunt": {
			"frequency": 12,
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
			"frequency": 22,
			"lines": [
				"Protect the treasury!",
				"You slimy elf!"
			],
		},
		"despawn": [
			"I return to earth...",
			"[i]Yells[/i]"
		]
	},
	"Dwarf engineer": {
		"spawn": "What happened? Elven trickery!",
		"taunt": {
			"frequency": 22,
			"lines": [
				"Protect the treasury!",
				"You slimy elf!"
			],
		},
		"despawn": [
			"I return to earth...",
			"[i]Yells[/i]"
		]
	},
	"Dwarf miner": {
		"spawn": "What happened? Elven trickery!",
		"taunt": {
			"frequency": 22,
			"lines": [
				"Protect the treasury!",
				"You slimy elf!"
			],
		},
		"despawn": [
			"I return to earth...",
			"[i]Yells[/i]"
		]
	},
	"Dwarf smith": {
		"spawn": "What happened? Elven trickery!",
		"taunt": {
			"frequency": 22,
			"lines": [
				"Protect the treasury!",
				"You slimy elf!"
			],
		},
		"despawn": [
			"I return to earth...",
			"[i]Yells[/i]"
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
			"frequency": 22,
			"lines": [
				"Protect the trees!",
				"You fat dwarf!",
			],
		},
		"spell": {
			"frequency": 8,
			"lines": [
				"Sharpshooter Bolt!"
			],
		},
		"despawn": [
			"I return to earth...",
			"[i]Screams[/i]"
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
			"frequency": 22,
			"lines": [
				"Protect the trees!",
				"You fat dwarf!",
			],
		},
		"spell": {
			"frequency": 8,
			"lines": [
				"Sharpshooter Bolt!"
			],
		},
		"despawn": [
			"I return to earth...",
			"[i]Screams[/i]"
		]
	},
	"Cat": {
		"taunt": {
			"frequency": 12,
			"lines": [
				"[i]Roars cutely[/i]",
				"Raawwrr!",
				"Hissss!"
			],
		},
		"speech": {
			"frequency": 12,
			"lines": [
				"Meow!",
				"Mau?",
				"Nau!",
				"Mrrvvv.",
				"[i]Purr[/i]"
			]
		},
		"despawn": [
			"Meow..."
		]
	},
	"Lynx": {
		"taunt": {
			"frequency": 12,
			"lines": [
				"[i]Roar[/i]",
				"Raawwrr!",
				"Grrrrr...",
				"Hissss!",
			],
		},
		"speech": {
			"frequency": 10,
			"lines": [
				"Mrrvvv.",
				"[i]Purr[/i]"
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
				"[i]Roar[/i]",
				"RAAAaawwrrr!",
				"GRRRrrrrrrr...",
				"Haz-hhsssssss!"
			],
		},
		"speech": {
			"frequency": 10,
			"lines": [
				"[i]Purr[/i]"
			],
		},
		"despawn": [
			"[i]Whimper[/i]",
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
				"[i]Grunts[/i]",
				"Your hair... You... Too?"
			],
		},
		"speech": {
			"frequency": 20,
			"lines": [
				"Ugg?",
				"Ogg.",
				"Me strong!",
				"Egghh.",
				"[i]Grunts[/i]",
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
				"[i]Grunts[/i]"
			],
		},
		"speech": {
			"frequency": 20,
			"lines": [
				"Ugg?",
				"Ogg.",
				"Me strong!",
				"Egghh.",
				"[i]Grunts[/i]"
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
				"[i]Grunts[/i]"
			],
		},
		"speech": {
			"frequency": 20,
			"lines": [
				"Ugg?",
				"Ogg.",
				"Me strong!",
				"Egghh.",
				"[i]Grunts[/i]"
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
				"Me thirsty!",
				"Egghh.",
				"You drink?",
				"[i]Grunts[/i]"
			],
		},
		"speech": {
			"frequency": 20,
			"lines": [
				"Ugg?",
				"Ogg.",
				"Me strong!",
				"Egghh.",
				"You drink?",
				"[i]Grunts[/i]"
			],
		},
		"despawn": [
			"UUUGGgghhhhh...",
			"UUUuuunnfffff..."
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
				"What?",
				"What!",
				"See?",
				"[i]Grunt[/i]"
			],
		},
		"speech": {
			"frequency": 15,
			"lines": [
				"Shall we gather for whiskey and cigars tonight?",
				"Indeed, I believe so.",
				"Nothing to report.",
				"What?",
				"What!",
				"See?",
				"Who's there?",
				"Must'ave been the wind...",
				"I need a drink...",
				"[i]Burp[/i]"
			],
		},
		"despawn": [
			"Ooohh...",
			"Uuuff..."
		]
	},
	"Guard captain": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 12,
			"lines": [
				"For the Guard!",
				"Charge!",
				"I won't give in!",
				"[i]Grunt[/i]"
			],
		},
		"speech": {
			"frequency": 25,
			"lines": [
				"Report, grunt!",
				"Straighten that gardbrace, soldier.",
				"Easy now.",
				"Hmmm..."
			],
		},
		"despawn": [
			"Ooohh...",
			"Uuuff..."
		]
	},
	"Outlaw watcher": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 21,
			"lines": [
				"I forgot me hat...",
				"Come e're!",
				"Ye oaf!",
				"I'll shank ya, mate!",
				"You wanker!"
			],
		},
		"despawn": [
			"Uuughh...",
			"Oooffffghh..."
		]
	},
	"Outlaw fusiee'er": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 21,
			"lines": [
				"Come e're!",
				"Ye oaf!",
				"I'll shank ya, mate!",
				"You wanker!"
			],
		},
		"spell": [
			"Super Rock Throw!"
		],
		"despawn": [
			"Uuughh...",
			"Oooffghh..."
		]
	},
	"Outlaw merchandiee'er": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 14,
			"lines": [
				"Come e're!",
				"Ye oaf!",
				"I'll shank ya, mate!",
				"You wanker!"
			],
		},
		"despawn": [
			"Uuughh...",
			"Oofffghh..."
		]
	},
	"Iovars cultist acolyte": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 7,
			"lines": [
				"Thy shalt not utter Iovars name!",
				"Die, interloper!",
				"For Iovar!"
			],
		},
		"despawn": [
			"Ooooofff...",
			"Uuuugghhfff...",
			"For Iovar..."
		]
	},
	"Iovars cultist": {
		"spawn": "Huh? Where am I?",
		"taunt": {
			"frequency": 7,
			"lines": [
				"Thy shalt not utter Iovars name!",
				"Die, interloper!",
				"For Iovar!"
			],
		},
		"despawn": [
			"Ooofff...",
			"Uuughfff...",
			"For Iovar..."
		]
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
			"Uuughh...",
			"Ooofffghh..."
		]
	},
	"Half-lich": {
		"spawn": "[i]Rattles bones enthusiastically[/i]",
		"taunt": {
			"frequency": 7,
			"lines": [
				"[i]Rattles bones[/i]",
				"[i]Rattles bones aggressively[/i]",
				"Clack. Clack! Clack."
			],
		},
		"speech": {
			"frequency": 15,
			"lines": [
				"[i]Rattles bones chattily[/i]"
			],
		},
		"despawn": [
			"[i]Clomps![/i]",
		]
	},
	"Lich": {
		"spawn": "I rise!",
		"speech": {
			"frequency": 15,
			"lines": [
				"You came from outside the dungeon? Haven't heard of that in 144 years!",
				"I'm 237 years young, mind you."
			],
		},
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
		"speech": {
			"frequency": 15,
			"lines": [
				"You came from outside the dungeon? Haven't heard of that in 301 years!",
				"I'm 587 years young, mind you."
			],
		},
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
		"speech": {
			"frequency": 15,
			"lines": [
				"You came from outside the dungeon? Haven't heard of that in 770 years!",
				"I'm 898 years young, mind you."
			],
		},
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
		"speech": {
			"frequency": 17,
			"lines": [
				"Ssss.",
				"Sss?"
			],
		},
		"taunt": {
			"frequency": 6,
			"lines": [
				"SSSssss!",
				"Sss-szh!"
			],
		},
		"despawn": [
			"Ssszzz..."
		]
	},
	"Highlands newt": {
		"speech": {
			"frequency": 17,
			"lines": [
				"Ssss.",
				"Sss?"
			],
		},
		"taunt": {
			"frequency": 6,
			"lines": [
				"SSSssss!",
				"Sss-szh!"
			],
		},
		"despawn": [
			"Ssszzz..."
		]
	},
	"Mine newt": {
		"speech": {
			"frequency": 17,
			"lines": [
				"Ssss.",
				"Sss?"
			],
		},
		"taunt": {
			"frequency": 6,
			"lines": [
				"SSSssss!",
				"Sss-szh!"
			],
		},
		"despawn": [
			"Ssszzz..."
		]
	},
	"Paper newt": {
		"speech": {
			"frequency": 17,
			"lines": [
				"Ssss.",
				"Sss?"
			],
		},
		"taunt": {
			"frequency": 6,
			"lines": [
				"SSSssss!",
				"Sss-szh!"
			],
		},
		"despawn": [
			"Ssszzz..."
		]
	},
	"River newt": {
		"speech": {
			"frequency": 17,
			"lines": [
				"Ssss.",
				"Sss?"
			],
		},
		"taunt": {
			"frequency": 6,
			"lines": [
				"SSSssss!",
				"Sss-szh!"
			],
		},
		"despawn": [
			"Ssszzz..."
		]
	},
	"Dungeon orc": {
		"speech": {
			"frequency": 17,
			"lines": [
				"Blergh.",
				"Blurg."
			],
		},
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
		"speech": {
			"frequency": 17,
			"lines": [
				"Blergh.",
				"Blurg."
			],
		},
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
				"REEee!",
				"REEEE!"
			],
		},
		"despawn": [
			"Reeeee..."
		]
	},
	"Mountain orc": {
		"speech": {
			"frequency": 17,
			"lines": [
				"Blergh.",
				"Blurg."
			],
		},
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
		"speech": {
			"frequency": 7,
			"lines": [
				"Po-blaaat!",
				"Pa-tooot!",
				"Ptt. Ptt. Ptt.",
				"Cluck. Cluck. Pt."
			],
		},
		"taunt": {
			"frequency": 5,
			"lines": [
				"Po-blaaat!",
				"Pa-tooooot!",
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
			"BLURGGGH..."
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
		"speech": {
			"frequency": 7,
			"lines": [
				"Sqwik.",
				"Sqwk. Sqwk."
			],
		},
		"taunt": {
			"frequency": 6,
			"lines": [
				"Sqwueeek!"
			],
		},
		"despawn": [
			"Sqwueeek..."
		]
	},
	"Cave rat": {
		"speech": {
			"frequency": 7,
			"lines": [
				"Sqwik.",
				"Sqwk. Sqwk."
			],
		},
		"taunt": {
			"frequency": 6,
			"lines": [
				"Sqwueeek!"
			],
		},
		"despawn": [
			"Sqwueeek..."
		]
	},
	"Sewer rat": {
		"speech": {
			"frequency": 7,
			"lines": [
				"Sqwik.",
				"Sqwk. Sqwk."
			],
		},
		"taunt": {
			"frequency": 6,
			"lines": [
				"Sqwueeek!"
			],
		},
		"despawn": [
			"Sqwueeek..."
		]
	},
	"Garnered snake": {
		"speech": {
			"frequency": 14,
			"lines": [
				"Ssss."
			],
		},
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
		"speech": {
			"frequency": 14,
			"lines": [
				"Ssss."
			],
		},
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
		"speech": {
			"frequency": 14,
			"lines": [
				"Ssss."
			],
		},
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
		"speech": {
			"frequency": 14,
			"lines": [
				"OOOOOooooooaaaa...",
				"OOOOOoooooouuuu...",
				"OOOOOoooooooooo..."
			],
		},
		"taunt": {
			"frequency": 4,
			"lines": [
				"oooaaaooo...",
				"ooooooooo..."
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
		"speech": {
			"frequency": 14,
			"lines": [
				"OOOOOooooooaaaa...",
				"OOOOOoooooouuuu...",
				"OOOOOoooooooooo..."
			],
		},
		"taunt": {
			"frequency": 2,
			"lines": [
				"OOOOOOOoooooOOOOO!",
				"oooooooOOOOOOO!",
				"OOOoooooOOooooOOO!"
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
