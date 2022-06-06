extends Node

onready var critter = preload("res://Objects/Critter/Critter.tscn")

var ants = preload("res://Objects/Critter/Ants/Ants.gd").new()
var aquaticLife = preload("res://Objects/Critter/Aquatic life/Aquatic life.gd").new()
var bats = preload("res://Objects/Critter/Bats/Bats.gd").new()
var dwarves = preload("res://Objects/Critter/Dwarves/Dwarves.gd").new()
var giants = preload("res://Objects/Critter/Giants/Giants.gd").new()
var kobolds = preload("res://Objects/Critter/Kobolds/Kobolds.gd").new()
var newts = preload("res://Objects/Critter/Newts/Newts.gd").new()
var orcs = preload("res://Objects/Critter/Orcs/Orcs.gd").new()

var critterGenerationList = {
	"dungeon1": {
		"amount": [3, 3],
		"critters": {
			"ants": ["Sugar ant"],
			"kobolds": ["Tiny kobold"],
			"newts": ["River newt"],
			"orcs": ["Goblin"]
		}
	},
	"minesOfTidoh": {
		"amount": [3, 3],
		"critters": {
			"ants": ["Sugar ant", "Soldier ant"],
			"bats": ["Dark bat"],
			"dwarves": ["Dwarf miner"],
			"giants": ["Hill giant"],
			"kobolds": ["Tiny kobold"],
			"newts": ["River newt", "Mine newt"],
			"orcs": ["Goblin", "Flatlands orc"]
		}
	}
}

var critters = {}
var spawnableCritters = ["Sugar ant", "Tiny kobold", "River newt", "Goblin"]

func create():
	name = "Critters"
	critters["ants"] = ants.ants
	critters["aquaticLife"] = aquaticLife.aquaticLife
	critters["bats"] = bats.bats
	critters["dwarves"] = dwarves.dwarves
	critters["giants"] = giants.giants
	critters["kobolds"] = kobolds.kobolds
	critters["newts"] = newts.newts
	critters["orcs"] = orcs.orcs

func generateCrittersForLevel(_level):
	var _levelCritterGeneration = critterGenerationList[_level.dungeonType]
	var _critters = []
	
	for _i in range(randi() % _levelCritterGeneration.amount[1] + _levelCritterGeneration.amount[0]):
		_critters.append(returnRandomCritter(_levelCritterGeneration))
	
	for _critter in _critters:
		if _critter != null:
			spawnCritter(_critter, _level)

func returnRandomCritter(_critterGeneration):
	var _generatedSpecies = _critterGeneration.critters[_critterGeneration.critters.keys()[randi() % _critterGeneration.critters.keys().size() - 1]]
	var _generatedCritter = _generatedSpecies[randi() % _generatedSpecies.size() - 1]
	
	if GlobalCritterInfo.globalCritterInfo.has(_generatedCritter) and GlobalCritterInfo.globalCritterInfo[_generatedCritter].population != 0:
		return getCritterByName(_generatedCritter)#critters[_generatedSpecies][_generatedCritter]
	else:
		return null
	
#	var type
#	var rarity
#
#	var randomType = []
#	for _key in _critterGeneration["type"].keys():
#		for _i in range(_critterGeneration["type"][_key]):
#			randomType.append(_key)
#	type = randomType[randi() % 1000]
#
#	var randomRarity = []
#	for _key in _critterGeneration["rarity"].keys():
#		for _i in range(_critterGeneration["rarity"][_key]):
#			randomRarity.append(_key)
#	rarity = randomRarity[randi() % 1000]
#
#	if critters[type].has(rarity):
#		return critters[type][rarity][randi() % critters[type][rarity].size() - 1]
#	else:
#		return null

func spawnCritter(_critter, _level, _byName = false):
	var gridPosition = _level.spawnableFloors[randi() % _level.spawnableFloors.size() - 1]
	if _level.grid[gridPosition.x][gridPosition.y].critter == null:
		var newCritter = critter.instance()
		if _byName:
			newCritter.createCritter(getCritterByName(_critter))
		else:
			newCritter.createCritter(_critter)
		_level.grid[gridPosition.x][gridPosition.y].critter = newCritter.id
		$"/root/World/Critters".add_child(newCritter, true)
		_level.critters.append(newCritter.id)
		GlobalCritterInfo.globalCritterInfo[newCritter.critterName].population -= 1

func checkNewCritterSpawn(_level):
	var _randomCritter = spawnableCritters[randi() % spawnableCritters.size() - 1]
	spawnCritter(_randomCritter, _level, true)

func checkSpawnableCrittersLevel():
	for _species in critters.values():
		for _critter in _species.critterTypes:
			if _critter.level <= $"/root/World/Critters/0".level and !spawnableCritters.has(critter):
				spawnableCritters.append(_critter.critterName)

func getCritterByName(_critterName):
	for _species in critters.values():
		for _critter in _species.critterTypes:
			if _critter.critterName == _critterName:
				return _critter
