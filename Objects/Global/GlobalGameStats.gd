extends Node

func loadGlobalGameStatsData(_data):
	gameStats = _data.gameStats
	critters = _data.critters

func getGlobalGameStats():
	var date = Time.get_date_dict_from_system(true)
	gameStats["Game ended at"] = "%s/%s/%s" % [date.day, date.month, date.year]
	var _gameStats = {
		"gameStats": gameStats,
		"critters": critters,
	}
	
	return _gameStats

var gameStats = {
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
	"Points": 0,
	"Game started at": null,
	"Game ended at": null
}

var critters = {
	"Iovar": {
		"killCount": 0
	},
	"Elder Dragon": {
		"killCount": 0
	},
	"Mad Banana-hunter Ogre": {
		"killCount": 0
	},
	"Shin'kor Leve'er": {
		"killCount": 0
	},
	"Elhybar": {
		"killCount": 0
	},
	"Tidoh Tel'hydrad": {
		"killCount": 0
	},
	"Double-pattern ant": {
		"killCount": 0
	},
	"Leaf ant": {
		"killCount": 0
	},
	"Soldier ant": {
		"killCount": 0
	},
	"Sugar ant": {
		"killCount": 0
	},
	"Eyebrow seal": {
		"killCount": 0
	},
	"Fiddler crab": {
		"killCount": 0
	},
	"Ringed seal": {
		"killCount": 0
	},
	"Tonatuna": {
		"killCount": 0
	},
	"Dark bat": {
		"killCount": 0
	},
	"Spooky bat": {
		"killCount": 0
	},
	"Squinting bat": {
		"killCount": 0
	},
	"Vampire bat": {
		"killCount": 0
	},
	"Slerp": {
		"killCount": 0
	},
	"Sluerp": {
		"killCount": 0
	},
	"Fleir breb": {
		"killCount": 0
	},
	"Toxix breb": {
		"killCount": 0
	},
	"Thunder breb": {
		"killCount": 0
	},
	"Gearh": {
		"killCount": 0
	},
	"Wolf": {
		"killCount": 0
	},
	"Warg": {
		"killCount": 0
	},
	"Gryonem centaur": {
		"killCount": 0
	},
	"Hill centaur": {
		"killCount": 0
	},
	"Black dragon": {
		"killCount": 0
	},
	"Blue dragon": {
		"killCount": 0
	},
	"Cyan dragon": {
		"killCount": 0
	},
	"Green dragon": {
		"killCount": 0
	},
	"Red dragon": {
		"killCount": 0
	},
	"Silver dragon": {
		"killCount": 0
	},
	"Violet dragon": {
		"killCount": 0
	},
	"White dragon": {
		"killCount": 0
	},
	"Yellow dragon": {
		"killCount": 0
	},
	"Dwarven contirer": {
		"killCount": 0
	},
	"Dwarf engineer": {
		"killCount": 0
	},
	"Dwarf miner": {
		"killCount": 0
	},
	"Dwarf smith": {
		"killCount": 0
	},
	"Elf assassin": {
		"killCount": 0
	},
	"Elf hunter": {
		"killCount": 0
	},
	"Elf king": {
		"killCount": 0
	},
	"Elf noble": {
		"killCount": 0
	},
	"Cat": {
		"killCount": 0
	},
	"Lynx": {
		"killCount": 0
	},
	"Tiger": {
		"killCount": 0
	},
	"Floating eye": {
		"killCount": 0
	},
	"Freezing floating sphere": {
		"killCount": 0
	},
	"Thunderous floating sphere": {
		"killCount": 0
	},
	"Unstable floating sphere": {
		"killCount": 0
	},
	"Balding giant": {
		"killCount": 0
	},
	"Hill giant": {
		"killCount": 0
	},
	"One-eyed ogre": {
		"killCount": 0
	},
	"Parched giant": {
		"killCount": 0
	},
	"Guard": {
		"killCount": 0
	},
	"Guard captain": {
		"killCount": 0
	},
	"Outlaw watcher": {
		"killCount": 0
	},
	"Outlaw fusiee'er": {
		"killCount": 0
	},
	"Outlaw merchandiee'er": {
		"killCount": 0
	},
	"Iovars cultist acolyte": {
		"killCount": 0
	},
	"Iovars cultist": {
		"killCount": 0
	},
	"Shopkeeper": {
		"killCount": 0
	},
	"Large kobold": {
		"killCount": 0
	},
	"Tiny kobold": {
		"killCount": 0
	},
	"Half-lich": {
		"killCount": 0
	},
	"Lich": {
		"killCount": 0
	},
	"Grand lich": {
		"killCount": 0
	},
	"Arch-lich": {
		"killCount": 0
	},
	"Humongous mimic": {
		"killCount": 0
	},
	"Mimic": {
		"killCount": 0
	},
	"Arctic newt": {
		"killCount": 0
	},
	"Highlands newt": {
		"killCount": 0
	},
	"Mine newt": {
		"killCount": 0
	},
	"Paper newt": {
		"killCount": 0
	},
	"River newt": {
		"killCount": 0
	},
	"Dungeon orc": {
		"killCount": 0
	},
	"Flatlands orc": {
		"killCount": 0
	},
	"Goblin": {
		"killCount": 0
	},
	"Mountain orc": {
		"killCount": 0
	},
	"Yrak-i": {
		"killCount": 0
	},
	"Chicken": {
		"killCount": 0
	},
#	"Grid bug": {
#		"killCount": 0
#	},
	"Brontotheridae": {
		"killCount": 0
	},
	"Rhino": {
		"killCount": 0
	},
	"Big rat": {
		"killCount": 0
	},
	"Cave rat": {
		"killCount": 0
	},
	"Sewer rat": {
		"killCount": 0
	},
	"Garnered snake": {
		"killCount": 0
	},
	"Marsh snake": {
		"killCount": 0
	},
	"Sawtooth-pattern snake": {
		"killCount": 0
	},
	"Spectral wraith": {
		"killCount": 0
	},
	"Spooky ghost": {
		"killCount": 0
	}
}
