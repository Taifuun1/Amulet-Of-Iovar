extends Node

onready var critter = preload("res://Objects/Critter/Critter.tscn")
onready var critterSpawnBehaviour = preload("res://Objects/Critter/CritterSpawnBehaviour.gd").new()
onready var critterGenerationList = preload("res://Objects/Critter/CritterLevelGenerationList.gd").new()

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
			spawnCritters(_critter, null, _level)

func returnRandomCritter(_critterGeneration = null):
	if _critterGeneration != null:
		var _generatedSpecies = _critterGeneration.critters[_critterGeneration.critters.keys()[randi() % _critterGeneration.critters.keys().size()]]
		var _generatedCritter = _generatedSpecies[randi() % _generatedSpecies.size()]

		if GlobalCritterInfo.globalCritterInfo.has(_generatedCritter) and GlobalCritterInfo.globalCritterInfo[_generatedCritter].population != 0:
			return getCritterByName(_generatedCritter)#critters[_generatedSpecies][_generatedCritter]
		else:
			return null
	else:
		var _generatedSpecies = _critterGeneration.critters[_critterGeneration.critters.keys()[randi() % _critterGeneration.critters.keys().size()]]
		var _generatedCritter = _generatedSpecies[randi() % _generatedSpecies.size()]
		
		if GlobalCritterInfo.globalCritterInfo.has(_generatedCritter) and GlobalCritterInfo.globalCritterInfo[_generatedCritter].population != 0:
			return getCritterByName(_generatedCritter)#critters[_generatedSpecies][_generatedCritter]
		else:
			return null

func getCritterSpawns(_spawnData, _level):
	if _spawnData.amount[0] == 0:
		return []
	var _tiles = []
	var _tile = _level.spawnableCritterTiles[randi() % _level.spawnableCritterTiles.size()]
	var _distance = _spawnData.distance
	var _legibleTiles = []
	for _spawnableFloor in _level.spawnableCritterTiles:
		if (
			_spawnableFloor.x <= _tile.x + _distance and
			_spawnableFloor.x >= _tile.x - _distance and
			_spawnableFloor.y <= _tile.y + _distance and
			_spawnableFloor.y >= _tile.y - _distance and
			_level.isTileFreeOfCritters(_tile)
		):
			_legibleTiles.append(_spawnableFloor)
	var _minAmount = _spawnData.amount[0]
	var _randomChange = _spawnData.amount[1] - _spawnData.amount[0] + 1
	if _spawnData.amount[0] == _spawnData.amount[1]:
		_randomChange = 1
		_minAmount = _spawnData.amount[0]
	for _critterIndex in randi() % _randomChange + _minAmount:
		if _legibleTiles.empty():
			break
		var _randomTile = _legibleTiles[randi() % _legibleTiles.size()]
		_tiles.append(_randomTile)
		_legibleTiles.erase(_randomTile)
	return _tiles

func spawnCritters(_critterName, _position = null, _level = $"/root/World".level):
	var _spawnTiles = getCritterSpawns(critterSpawnBehaviour.critterSpawnBehaviour[_critterName], _level)
	for _spawnTile in _spawnTiles:
		spawnCritter(_critterName, _spawnTile)

func spawnCritter(_critter, _position = null, _level = $"/root/World".level):
	var _newCritter
	var _gridPosition
	
	# Name
	if typeof(_critter) == TYPE_STRING:
		_newCritter = getCritterByName(_critter)
	else:
		_newCritter = _critter
	
	# Position
	if _position == null:
		var _spawnableTiles = _level.spawnableCritterTiles.duplicate(true)
		for _spawnableTile in _spawnableTiles:
			var _randomTile = _spawnableTiles[randi() % _spawnableTiles.size()]
			if _level.isTileFreeOfCritters(_randomTile):
				_gridPosition = _randomTile
				break
			else:
				_spawnableTiles.erase(_randomTile)
		if _spawnableTiles.empty():
			push_warning("Couldn't find space for critter: %s, on level: %s" % [_newCritter.critterName, _level.name])
			return false
	else:
		_gridPosition = _position
	
	if (
		_level.grid[_gridPosition.x][_gridPosition.y].critter == null and
		GlobalCritterInfo.globalCritterInfo[_newCritter.critterName].population != 0 and
		GlobalCritterInfo.globalCritterInfo[_newCritter.critterName].crittersInPlay < GlobalCritterInfo.globalCritterInfo[_newCritter.critterName].population
	):
		var newCritter = critter.instance()
		newCritter.createCritter(_newCritter, _level.levelId)
		_level.grid[_gridPosition.x][_gridPosition.y].critter = newCritter.id
		$"/root/World/Critters".add_child(newCritter, true)
		_level.critters.append(newCritter.id)
		_level.removePointFromEnemyPathfinding(_gridPosition)
		GlobalCritterInfo.addCritterToPlay(newCritter.critterName)
		return _newCritter.critterName
	return false

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
			newCritter.createCritter(_critter, _spawnedLevel.levelId)
			_spawnedLevel.grid[_position.x][_position.y].critter = newCritter.id
			$"/root/World/Critters".add_child(newCritter, true)
			_spawnedLevel.critters.append(newCritter.id)
			_spawnedLevel.removePointFromEnemyPathfinding(_position)
			GlobalCritterInfo.addCritterToPlay(newCritter.critterName)
			return _critter.critterName
	return null

func checkNewCritterSpawn(_level, _playerTile):
	var _randomSpawnableTile = _level.spawnableCritterTiles[randi() % _level.spawnableCritterTiles.size()]
	var _critterSpawnDistance = _level.calculatePath(_randomSpawnableTile, _playerTile).size()
	if _randomSpawnableTile != null and _critterSpawnDistance > 16 and _level.critters.size() < 20:
		var _randomCritter = spawnableCritters[randi() % spawnableCritters.size()]
		spawnCritters(_randomCritter, _randomSpawnableTile)

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
