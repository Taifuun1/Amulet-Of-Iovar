extends Node

func addCritterToPlay(_critterName):
	globalCritterInfo[_critterName].crittersInPlay += 1

func removeCritterFromPlay(_critterName):
	globalCritterInfo[_critterName].population -= 1
	globalCritterInfo[_critterName].crittersInPlay -= 1

func addCritterBackToPopulation(_critterName):
	globalCritterInfo[_critterName].population += 1
	globalCritterInfo[_critterName].crittersInPlay -= 1

var globalCritterInfo = {
	"Iovar": {
		"population": 999999999,
		"crittersInPlay": 0
	},
	"Elder Dragon": {
		"population": 1,
		"crittersInPlay": 0
	},
	"Mad Banana-hunter Ogre": {
		"population": 1,
		"crittersInPlay": 0
	},
	"Shin'kor Leve'er": {
		"population": 1,
		"crittersInPlay": 0
	},
	"Elhybar": {
		"population": 1,
		"crittersInPlay": 0
	},
	"Tidoh Tel'hydrad": {
		"population": 1,
		"crittersInPlay": 0
	},
	"Double-pattern ant": {
		"population": 64,
		"crittersInPlay": 0
	},
	"Leaf ant": {
		"population": 128,
		"crittersInPlay": 0
	},
	"Soldier ant": {
		"population": 156,
		"crittersInPlay": 0
	},
	"Sugar ant": {
		"population": 206,
		"crittersInPlay": 0
	},
	"Eyebrow seal": {
		"population": 50,
		"crittersInPlay": 0
	},
	"Fiddler crab": {
		"population": 72,
		"crittersInPlay": 0
	},
	"Ringed seal": {
		"population": 50,
		"crittersInPlay": 0
	},
	"Tonatuna": {
		"population": 44,
		"crittersInPlay": 0
	},
	"Dark bat": {
		"population": 64,
		"crittersInPlay": 0
	},
	"Spooky bat": {
		"population": 64,
		"crittersInPlay": 0
	},
	"Squinting bat": {
		"population": 64,
		"crittersInPlay": 0
	},
	"Vampire bat": {
		"population": 28,
		"crittersInPlay": 0
	},
	"Slerp": {
		"population": 16,
		"crittersInPlay": 0
	},
	"Sluerp": {
		"population": 16,
		"crittersInPlay": 0
	},
	"Gearh": {
		"population": 61,
		"crittersInPlay": 0
	},
	"Wolf": {
		"population": 73,
		"crittersInPlay": 0
	},
	"Warg": {
		"population": 67,
		"crittersInPlay": 0
	},
	"Gryonem centaur": {
		"population": 38,
		"crittersInPlay": 0
	},
	"Hill centaur": {
		"population": 58,
		"crittersInPlay": 0
	},
	"Black dragon": {
		"population": 28,
		"crittersInPlay": 0
	},
	"Blue dragon": {
		"population": 28,
		"crittersInPlay": 0
	},
	"Cyan dragon": {
		"population": 28,
		"crittersInPlay": 0
	},
	"Green dragon": {
		"population": 28,
		"crittersInPlay": 0
	},
	"Red dragon": {
		"population": 28,
		"crittersInPlay": 0
	},
	"Silver dragon": {
		"population": 28,
		"crittersInPlay": 0
	},
	"Violet dragon": {
		"population": 28,
		"crittersInPlay": 0
	},
	"White dragon": {
		"population": 28,
		"crittersInPlay": 0
	},
	"Yellow dragon": {
		"population": 28,
		"crittersInPlay": 0
	},
	"Dwarven contirer": {
		"population": 32,
		"crittersInPlay": 0
	},
	"Dwarf engineer": {
		"population": 32,
		"crittersInPlay": 0
	},
	"Dwarf miner": {
		"population": 72,
		"crittersInPlay": 0
	},
	"Dwarf smith": {
		"population": 32,
		"crittersInPlay": 0
	},
	"Elf assassin": {
		"population": 28,
		"crittersInPlay": 0
	},
	"Elf hunter": {
		"population": 104,
		"crittersInPlay": 0
	},
	"Elf king": {
		"population": 1,
		"crittersInPlay": 0
	},
	"Elf noble": {
		"population": 48,
		"crittersInPlay": 0
	},
	"Cat": {
		"population": 122,
		"crittersInPlay": 0
	},
	"Lynx": {
		"population": 68,
		"crittersInPlay": 0
	},
	"Tiger": {
		"population": 41,
		"crittersInPlay": 0
	},
	"Floating eye": {
		"population": 32,
		"crittersInPlay": 0
	},
	"Freezing floating sphere": {
		"population": 32,
		"crittersInPlay": 0
	},
	"Thunderous floating sphere": {
		"population": 32,
		"crittersInPlay": 0
	},
	"Unstable floating sphere": {
		"population": 32,
		"crittersInPlay": 0
	},
	"Balding giant": {
		"population": 36,
		"crittersInPlay": 0
	},
	"Hill giant": {
		"population": 56,
		"crittersInPlay": 0
	},
	"One-eyed ogre": {
		"population": 36,
		"crittersInPlay": 0
	},
	"Parched giant": {
		"population": 36,
		"crittersInPlay": 0
	},
	"Guard": {
		"population": 128,
		"crittersInPlay": 0
	},
	"Guard captain": {
		"population": 24,
		"crittersInPlay": 0
	},
	"Outlaw watcher": {
		"population": 70,
		"crittersInPlay": 0
	},
	"Outlaw fusiee'er": {
		"population": 40,
		"crittersInPlay": 0
	},
	"Outlaw merchandiee'er": {
		"population": 40,
		"crittersInPlay": 0
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
		"population": 28,
		"crittersInPlay": 0
	},
	"Large kobold": {
		"population": 46,
		"crittersInPlay": 0
	},
	"Tiny kobold": {
		"population": 46,
		"crittersInPlay": 0
	},
	"Half-lich": {
		"population": 42,
		"crittersInPlay": 0
	},
	"Lich": {
		"population": 35,
		"crittersInPlay": 0
	},
	"Grand lich": {
		"population": 21,
		"crittersInPlay": 0
	},
	"Arch-lich": {
		"population": 14,
		"crittersInPlay": 0
	},
	"Humongous mimic": {
		"population": 38,
		"crittersInPlay": 0
	},
	"Mimic": {
		"population": 38,
		"crittersInPlay": 0
	},
	"Arctic newt": {
		"population": 56,
		"crittersInPlay": 0
	},
	"Highlands newt": {
		"population": 56,
		"crittersInPlay": 0
	},
	"Mine newt": {
		"population": 56,
		"crittersInPlay": 0
	},
	"Paper newt": {
		"population": 56,
		"crittersInPlay": 0
	},
	"River newt": {
		"population": 56,
		"crittersInPlay": 0
	},
	"Dungeon orc": {
		"population": 43,
		"crittersInPlay": 0
	},
	"Flatlands orc": {
		"population": 74,
		"crittersInPlay": 0
	},
	"Goblin": {
		"population": 46,
		"crittersInPlay": 0
	},
	"Mountain orc": {
		"population": 51,
		"crittersInPlay": 0
	},
	"Yrak-i": {
		"population": 19,
		"crittersInPlay": 0
	},
	"Chicken": {
		"population": 68,
		"crittersInPlay": 0
	},
	"Grid bug": {
		"population": 32,
		"crittersInPlay": 0
	},
	"Brontotheridae": {
		"population": 46,
		"crittersInPlay": 0
	},
	"Rhino": {
		"population": 46,
		"crittersInPlay": 0
	},
	"Big rat": {
		"population": 62,
		"crittersInPlay": 0
	},
	"Cave rat": {
		"population": 62,
		"crittersInPlay": 0
	},
	"Sewer rat": {
		"population": 62,
		"crittersInPlay": 0
	},
	"Garnered snake": {
		"population": 86,
		"crittersInPlay": 0
	},
	"Marsh snake": {
		"population": 72,
		"crittersInPlay": 0
	},
	"Sawtooth-pattern snake": {
		"population": 62,
		"crittersInPlay": 0
	},
	"Spectral wraith": {
		"population": 25,
		"crittersInPlay": 0
	},
	"Spooky ghost": {
		"population": 25,
		"crittersInPlay": 0
	}
}
