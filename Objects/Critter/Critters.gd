extends Node

onready var critter = preload("res://Objects/Critter/Critter.tscn")

var animals = preload("res://Objects/Critter/Animals/Animals.gd").new()
var humanoids = preload("res://Objects/Critter/Humanoids/Humanoids.gd").new()

var critterGeneration = {
	"dungeon1": {
		"floor": {
			"type": {
				"animals": 800,
				"humanoids": 200,
			},
			"rarity": {
				"common": 1000,
			}
		},
		"custom": null
	}
}

var critters = {}

func create():
	name = "Critters"
	critters["animals"] = animals.animals
	critters["humanoids"] = humanoids.humanoids

func generateCrittersForLevel(_level):
	var _critterGeneration = critterGeneration[_level.dungeonType]
	var _critters = []
	
	for _i in range(randi() % 2 + 2):
		_critters.append(returnRandomCritter(_critterGeneration["floor"]))
	
	for _critter in _critters:
		if _critter != null:
			var gridPosition = _level.spawnableFloors[randi() % _level.spawnableFloors.size() - 1]
			if _level.grid[gridPosition.x][gridPosition.y].critter == null:
				var newCritter = critter.instance()
				newCritter.createCritter(_critter)
				_level.grid[gridPosition.x][gridPosition.y].critter = newCritter.id
				$"/root/World/Critters".add_child(newCritter, true)
				_level.critters.append(newCritter.id)

func returnRandomCritter(_critterGeneration):
	var type
	var rarity
	
	var randomType = []
	for _key in _critterGeneration["type"].keys():
		for _i in range(_critterGeneration["type"][_key]):
			randomType.append(_key)
	type = randomType[randi() % 1000]
	
	var randomRarity = []
	for _key in _critterGeneration["rarity"].keys():
		for _i in range(_critterGeneration["rarity"][_key]):
			randomRarity.append(_key)
	rarity = randomRarity[randi() % 1000]
	
	if critters[type].has(rarity):
		return critters[type][rarity][randi() % critters[type][rarity].size() - 1]
	else:
		return null

func getCritterByName(_critterName):
	for types in critters.values():
		for rarity in types.values():
			for _critter in rarity:
				if _critter.critterName == _critterName:
					return _critter
