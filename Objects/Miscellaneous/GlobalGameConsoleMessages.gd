extends Node

func getRandomMessageByType(_critterName, _messageType):
	return GlobalGameConsoleMessages.globalGameConsoleMessages[_critterName][_messageType][randi() % GlobalGameConsoleMessages.globalGameConsoleMessages[_critterName][_messageType].size()]

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
	"Shin'kor Leve'er": {
		"activated": "I've lost all I've known... You'll be next.",
		"taunt": {
			"frequency": 6,
			"lines": [
				"I live for the blade.",
				"This trauma... How depressing.",
				"When you were chasing Iovar, I studied the blade.",
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
		"despawn": [
			"Eeeee!"
		]
	},
	"Soldier ant": {
		"despawn": [
			"RRRRRrrrr..."
		]
	},
	"Sugar ant": {
		"despawn": [
			"Eeeeee..."
		]
	},
	"Dark bat": {
		"despawn": [
			"Sqwueeek!"
		]
	},
	"Spooky bat": {
		"despawn": [
			"Skreeeeee!"
		]
	},
	"Squinting bat": {
		"despawn": [
			"Sqwueeek..."
		]
	},
	"Gryonem centaur": {
		"taunt": {
			"freguency": 16,
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
