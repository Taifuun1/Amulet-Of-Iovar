extends Node

onready var critter = preload("res://Objects/Critter/Critter.tscn")
onready var critterSpawnBehaviour = preload("res://Objects/Miscellaneous/CritterSpawnBehaviour.gd").new()
onready var critterLevelGenerationList = preload("res://Objects/Miscellaneous/LevelGenerationCritters.gd").new()

var ants = preload("res://Objects/Critter/Ants/Ants.gd").new()
var aquaticLife = preload("res://Objects/Critter/Aquatic life/Aquatic life.gd").new()
var bats = preload("res://Objects/Critter/Bats/Bats.gd").new()
var blobs = preload("res://Objects/Critter/Blobs/Blobs.gd").new()
var bosses = preload("res://Objects/Critter/Bosses/Bosses.gd").new()
var canines = preload("res://Objects/Critter/Canines/Canines.gd").new()
var centaurs = preload("res://Objects/Critter/Centaurs/Centaurs.gd").new()
var dragons = preload("res://Objects/Critter/Dragons/Dragons.gd").new()
var dwarves = preload("res://Objects/Critter/Dwarves/Dwarves.gd").new()
var elves = preload("res://Objects/Critter/Elves/Elves.gd").new()
var felines = preload("res://Objects/Critter/Felines/Felines.gd").new()
var floatingSpheres = preload("res://Objects/Critter/Floating spheres/Floating spheres.gd").new()
var giants = preload("res://Objects/Critter/Giants/Giants.gd").new()
var humans = preload("res://Objects/Critter/Humans/Humans.gd").new()
var iovarsCultists = preload("res://Objects/Critter/Iovars cultists/Iovars cultists.gd").new()
var kobolds = preload("res://Objects/Critter/Kobolds/Kobolds.gd").new()
var liches = preload("res://Objects/Critter/Liches/Liches.gd").new()
var mimics = preload("res://Objects/Critter/Mimics/Mimics.gd").new()
var newts = preload("res://Objects/Critter/Newts/Newts.gd").new()
var orcs = preload("res://Objects/Critter/Orcs/Orcs.gd").new()
var others = preload("res://Objects/Critter/Others/Others.gd").new()
var outlaws = preload("res://Objects/Critter/Outlaws/Outlaws.gd").new()
var quadrapeds = preload("res://Objects/Critter/Quadrapeds/Quadrapeds.gd").new()
var rats = preload("res://Objects/Critter/Rats/Rats.gd").new()
var snakes = preload("res://Objects/Critter/Snakes/Snakes.gd").new()
var wraiths = preload("res://Objects/Critter/Wraiths/Wraiths.gd").new()

onready var crittersData = GlobalSave.saveAndloadLifeTimeStats("Critters")

var mutex

var critters = {}
var spawnableCritters = ["Sugar ant"]

func create():
	mutex = Mutex.new()
	name = "Critters"
	critters["ants"] = ants.ants
	critters["aquaticLife"] = aquaticLife.aquaticLife
	critters["bats"] = bats.bats
	critters["blobs"] = blobs.blobs
	critters["bosses"] = bosses.bosses
	critters["canines"] = canines.canines
	critters["centaurs"] = centaurs.centaurs
	critters["dragons"] = dragons.dragons
	critters["dwarves"] = dwarves.dwarves
	critters["elves"] = elves.elves
	critters["felines"] = felines.felines
	critters["floatingSpheres"] = floatingSpheres.floatingSpheres
	critters["giants"] = giants.giants
	critters["humans"] = humans.humans
	critters["iovarsCultists"] = iovarsCultists.iovarsCultists
	critters["kobolds"] = kobolds.kobolds
	critters["liches"] = liches.liches
	critters["mimics"] = mimics.mimics
	critters["newts"] = newts.newts
	critters["orcs"] = orcs.orcs
	critters["others"] = others.others
	critters["outlaws"] = outlaws.outlaws
	critters["quadrapeds"] = quadrapeds.quadrapeds
	critters["rats"] = rats.rats
	critters["snakes"] = snakes.snakes
	critters["wraiths"] = wraiths.wraiths

func setNeutralClasses():
	for _neutralClass in $"/root/World/Critters/0".neutralClasses:
		if critters.has(_neutralClass):
			for _critter in critters[_neutralClass]:
				_critter.aI = "Neutral"



##########################
### Critter generation ###
##########################

func spawnCritter(_critter, _position = null, _isDeactivated = null, _spawnNew = true, _level = $"/root/World".level):
	mutex.lock()
	
	var _newCritter
	var _gridPosition
	var _aI
	var _extraData = {}
	
	# Name
	if typeof(_critter) == TYPE_STRING:
		_newCritter = getCritterByName(_critter).duplicate(true)
	else:
		_newCritter = _critter.duplicate(true)
	
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
			mutex.unlock()
			return false
	else:
		_gridPosition = _position
	
	# Extradata
	if typeof(_isDeactivated) == TYPE_INT:
		_aI = "Deactivated"
	else:
		_aI = _newCritter.aI
	
	if !_spawnNew:
		var newCritter = critter.instance()
		_newCritter.class = _newCritter.critterClass
		newCritter.createCritter(_newCritter, _newCritter.levelId, crittersData[_newCritter.critterName], _extraData, _spawnNew)
		newCritter.createAi(_critter.aI.aI, _critter.aI.aggroDistance, _critter.aI.activationDistance)
		$"/root/World/Critters".add_child(newCritter, true)
		mutex.unlock()
		return _newCritter.critterName
	elif (
		_level.grid[_gridPosition.x][_gridPosition.y].critter == null and
		GlobalCritterInfo.globalCritterInfo[_newCritter.critterName].population != 0 and
		GlobalCritterInfo.globalCritterInfo[_newCritter.critterName].crittersInPlay < GlobalCritterInfo.globalCritterInfo[_newCritter.critterName].population
	):
		var newCritter = critter.instance()
		newCritter.createCritter(_newCritter, _level.levelId, crittersData[_newCritter.critterName], _extraData)
		newCritter.createAi(_aI, _newCritter.aggroDistance, _isDeactivated)
		$"/root/World/Critters".add_child(newCritter, true)
		_level.grid[_gridPosition.x][_gridPosition.y].critter = newCritter.id
		_level.critters.append(newCritter.id)
		_level.removePointFromEnemyPathfinding(_gridPosition)
		GlobalCritterInfo.addCritterToPlay(newCritter.critterName)
		newCritter.checkIfAddFlavorGamelog("activated", newCritter.critterName)
		mutex.unlock()
		return _newCritter.critterName
	mutex.unlock()
	return false

func spawnCritters(_critterName, _position = null, _level = $"/root/World".level):
	var _spawnTiles = getCritterSpawns(critterSpawnBehaviour.critterSpawnBehaviour[_critterName], _level, _position)
	for _spawnTile in _spawnTiles:
		spawnCritter(_critterName, _spawnTile, null, true, _level)

func generateCrittersForLevel(_level):
	if critterLevelGenerationList.critterLevelGenerationList.has(_level.dungeonType):
		var _levelCritterGeneration = critterLevelGenerationList.critterLevelGenerationList[_level.dungeonType]
		var _critters = []
		
		var _minAmount = _levelCritterGeneration.amount[0]
		var _randomChange = _levelCritterGeneration.amount[1] - _levelCritterGeneration.amount[0] + 1
		if _levelCritterGeneration.amount[0] == _levelCritterGeneration.amount[1]:
			_randomChange = 1
			_minAmount = _levelCritterGeneration.amount[0]
		for _i in range(randi() % _randomChange + _minAmount):
			_critters.append(returnRandomCritter(_levelCritterGeneration))
		
		for _critter in _critters:
			if _critter != null:
				spawnCritters(_critter, null, _level)

func returnRandomCritter(_critterGeneration = null):
	if _critterGeneration != null:
		var _generatedSpecies = _critterGeneration.critters[_critterGeneration.critters.keys()[randi() % _critterGeneration.critters.keys().size()]]
		var _generatedCritter = _generatedSpecies[randi() % _generatedSpecies.size()]

		if GlobalCritterInfo.globalCritterInfo.has(_generatedCritter) and GlobalCritterInfo.globalCritterInfo[_generatedCritter].population != 0:
			return _generatedCritter
		else:
			return null
	else:
		var _generatedSpecies = _critterGeneration.critters[_critterGeneration.critters.keys()[randi() % _critterGeneration.critters.keys().size()]]
		var _generatedCritter = _generatedSpecies[randi() % _generatedSpecies.size()]
		
		if GlobalCritterInfo.globalCritterInfo.has(_generatedCritter) and GlobalCritterInfo.globalCritterInfo[_generatedCritter].population != 0:
			return _generatedCritter
		else:
			return null

func spawnRandomCritter(_position, _spawnLiches = true):
	var _level = $"/root/World".level
	if _level.grid[_position.x][_position.y].critter == null:
		var _species = critters.keys()[randi() % critters.keys().size()]
		if !_species.matchn("bosses"):
			if !_spawnLiches and _species.matchn("liches"):
				return null
			var _critter = critters[_species][randi() % critters[_species].size()].duplicate(true)
			if (
				GlobalCritterInfo.globalCritterInfo[_critter.critterName].population != 0 and
				GlobalCritterInfo.globalCritterInfo[_critter.critterName].crittersInPlay < GlobalCritterInfo.globalCritterInfo[_critter.critterName].population
			):
				mutex.lock()
				var newCritter = critter.instance()
				newCritter.createCritter(_critter, _level.levelId, crittersData[_critter.critterName])
				newCritter.createAi(_critter.aI, _critter.aggroDistance)
				_level.grid[_position.x][_position.y].critter = newCritter.id
				$"/root/World/Critters".add_child(newCritter, true)
				_level.critters.append(newCritter.id)
				_level.removePointFromEnemyPathfinding(_position)
				GlobalCritterInfo.addCritterToPlay(newCritter.critterName)
				mutex.unlock()
				return _critter.critterName
	return null



########################
### Helper functions ###
########################

func getCritterByName(_critterName):
	for _species in critters.values():
		for _critter in _species:
			if _critter.critterName.matchn(_critterName):
				return _critter

func getCritterSpawns(_spawnData, _level, _spawnPosition = null):
	if _spawnData.amount[0] == 0:
		return []
	var _tiles = []
	var _tile
	if _spawnPosition != null:
		_tile = _spawnPosition
	else:
		_tile = _level.spawnableCritterTiles[randi() % _level.spawnableCritterTiles.size()]
	var _distance = _spawnData.distance
	var _legibleTiles = []
	for _spawnableFloor in _level.spawnableCritterTiles:
		if (
			_spawnableFloor.x <= _tile.x + _distance and
			_spawnableFloor.x >= _tile.x - _distance and
			_spawnableFloor.y <= _tile.y + _distance and
			_spawnableFloor.y >= _tile.y - _distance and
			_level.isTileFreeOfCritters(_tile) and
			Globals.isTileFree(_tile, _level.grid)
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

func checkSpawnableCrittersLevel():
	for _species in critters.keys():
		for _critter in critters[_species]:
			if _critter.level <= $"/root/World/Critters/0".level and !spawnableCritters.has(critter) and !_species.matchn("bosses"):
				spawnableCritters.append(_critter.critterName)

func checkNewCritterSpawn(_level, _playerTile):
	if _level.spawnableCritterTiles.size() != 0:
		var _randomSpawnableTile = _level.spawnableCritterTiles[randi() % _level.spawnableCritterTiles.size()]
		var _critterSpawnDistance = _level.calculatePath(_randomSpawnableTile, _playerTile).size()
		if _randomSpawnableTile != null and _critterSpawnDistance > 16 and _level.critters.size() < 20:
			var _randomCritter = spawnableCritters[randi() % spawnableCritters.size()]
			spawnCritters(_randomCritter, _randomSpawnableTile)

func checkAllCrittersIdentification():
	for _critter in $"/root/World/Critters".get_children():
		if _critter.name.matchn("Critters") or _critter.id == 0:
			continue
		_critter.checkCritterIdentification(crittersData[_critter.critterName])
