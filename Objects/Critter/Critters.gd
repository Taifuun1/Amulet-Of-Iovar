extends Node

onready var critter = preload("res://Objects/Critter/Critter.tscn")

var ants = preload("res://Objects/Critter/Ants/Ants.gd").new()
var aquaticLife = preload("res://Objects/Critter/Aquatic life/Aquatic life.gd").new()
var bats = preload("res://Objects/Critter/Bats/Bats.gd").new()
var blobs = preload("res://Objects/Critter/Blobs/Blobs.gd").new()
var canines = preload("res://Objects/Critter/Canines/Canines.gd").new()
var centaurs = preload("res://Objects/Critter/Centaurs/Centaurs.gd").new()
var dragons = preload("res://Objects/Critter/Dragons/Dragons.gd").new()
var dwarves = preload("res://Objects/Critter/Dwarves/Dwarves.gd").new()
var elves = preload("res://Objects/Critter/Elves/Elves.gd").new()
var felines = preload("res://Objects/Critter/Felines/Felines.gd").new()
var floatingSpheres = preload("res://Objects/Critter/Floating spheres/Floating spheres.gd").new()
var giants = preload("res://Objects/Critter/Giants/Giants.gd").new()
var humans = preload("res://Objects/Critter/Humans/Humans.gd").new()
var kobolds = preload("res://Objects/Critter/Kobolds/Kobolds.gd").new()
var liches = preload("res://Objects/Critter/Liches/Liches.gd").new()
var mimics = preload("res://Objects/Critter/Mimics/Mimics.gd").new()
var newts = preload("res://Objects/Critter/Newts/Newts.gd").new()
var orcs = preload("res://Objects/Critter/Orcs/Orcs.gd").new()
var others = preload("res://Objects/Critter/Others/Others.gd").new()
var quadrapeds = preload("res://Objects/Critter/Quadrapeds/Quadrapeds.gd").new()
var rats = preload("res://Objects/Critter/Rats/Rats.gd").new()
var snakes = preload("res://Objects/Critter/Snakes/Snakes.gd").new()
var wraiths = preload("res://Objects/Critter/Wraiths/Wraiths.gd").new()

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
	critters["blobs"] = blobs.blobs
	critters["canines"] = canines.canines
	critters["centaurs"] = centaurs.centaurs
	critters["dragons"] = dragons.dragons
	critters["dwarves"] = dwarves.dwarves
	critters["elves"] = elves.elves
	critters["felines"] = felines.felines
	critters["floatingSpheres"] = floatingSpheres.floatingSpheres
	critters["giants"] = giants.giants
	critters["humans"] = humans.humans
	critters["kobolds"] = kobolds.kobolds
	critters["liches"] = liches.liches
	critters["mimics"] = mimics.mimics
	critters["newts"] = newts.newts
	critters["orcs"] = orcs.orcs
	critters["others"] = others.others
	critters["quadrapeds"] = quadrapeds.quadrapeds
	critters["rats"] = rats.rats
	critters["snakes"] = snakes.snakes
	critters["wraiths"] = wraiths.wraiths

func generateCrittersForLevel(_level):
	var _levelCritterGeneration = critterGenerationList[_level.dungeonType]
	var _critters = []
	
	for _i in range(randi() % _levelCritterGeneration.amount[1] + _levelCritterGeneration.amount[0]):
		_critters.append(returnRandomCritter(_levelCritterGeneration))
	
	for _critter in _critters:
		if _critter != null:
			spawnCritter(_critter, null, false, _level)

func returnRandomCritter(_critterGeneration = null):
	if _critterGeneration != null:
		var _generatedSpecies = _critterGeneration.critters[_critterGeneration.critters.keys()[randi() % _critterGeneration.critters.keys().size() - 1]]
		var _generatedCritter = _generatedSpecies[randi() % _generatedSpecies.size() - 1]

		if GlobalCritterInfo.globalCritterInfo.has(_generatedCritter) and GlobalCritterInfo.globalCritterInfo[_generatedCritter].population != 0:
			return getCritterByName(_generatedCritter)#critters[_generatedSpecies][_generatedCritter]
		else:
			return null
	else:
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

func spawnCritter(_critter, _position = null, _byName = false, _level = null):
	var _spawnedLevel
	var _newCritter
	var _gridPosition
	
	# Level
	if _level == null:
		_spawnedLevel = $"/root/World".level
	else:
		_spawnedLevel = _level
	
	# Position
	if _position == null:
		_gridPosition = _spawnedLevel.spawnableFloors[randi() % _spawnedLevel.spawnableFloors.size() - 1]
	else:
		_gridPosition = _position
	
	# Name
	if _byName:
		_newCritter = getCritterByName(_critter)
	else:
		_newCritter = _critter
	
	if (
		_spawnedLevel.grid[_gridPosition.x][_gridPosition.y].critter == null and
		GlobalCritterInfo.globalCritterInfo[_newCritter.critterName].population != 0 and
		GlobalCritterInfo.globalCritterInfo[_newCritter.critterName].crittersInPlay < GlobalCritterInfo.globalCritterInfo[_newCritter.critterName].population
	):
		var newCritter = critter.instance()
		newCritter.createCritter(_newCritter)
		_spawnedLevel.grid[_gridPosition.x][_gridPosition.y].critter = newCritter.id
		$"/root/World/Critters".add_child(newCritter, true)
		_spawnedLevel.critters.append(newCritter.id)
		_spawnedLevel.removePointFromEnemyPathfinding(_gridPosition, _spawnedLevel.grid)
		GlobalCritterInfo.addCritterToPlay(newCritter.critterName)
		return _newCritter.critterName
	return null

func spawnRandomCritter(_position, _level = null):
	
	var _spawnedLevel
	
	# Level
	if _level == null:
		_spawnedLevel = $"/root/World".level
	else:
		_spawnedLevel = _level
	
	if _spawnedLevel.grid[_position.x][_position.y].critter == null:
		var _species = critters.keys()[randi() % critters.keys().size()]
		var _critter = critters[_species].critterTypes[randi() % critters[_species].critterTypes.size()]
		if (
			GlobalCritterInfo.globalCritterInfo[_critter.critterName].population != 0 and
			GlobalCritterInfo.globalCritterInfo[_critter.critterName].crittersInPlay < GlobalCritterInfo.globalCritterInfo[_critter.critterName].population
		):
			var newCritter = critter.instance()
			newCritter.createCritter(_critter)
			_spawnedLevel.grid[_position.x][_position.y].critter = newCritter.id
			$"/root/World/Critters".add_child(newCritter, true)
			_spawnedLevel.critters.append(newCritter.id)
			_spawnedLevel.removePointFromEnemyPathfinding(_position, _spawnedLevel.grid)
			GlobalCritterInfo.addCritterToPlay(newCritter.critterName)
			return _critter.critterName
	return null

func checkNewCritterSpawn(_level):
	var _randomCritter = spawnableCritters[randi() % spawnableCritters.size() - 1]
	spawnCritter(_randomCritter, null, true)

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
