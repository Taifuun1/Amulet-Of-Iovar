extends WorldManagement

onready var critters = preload("res://Objects/Critter/Critters.tscn").instance()
onready var items = preload("res://Objects/Item/Items.tscn").instance()

func sortLevels(_levelA, _levelB):
	if _levelA.levelId < _levelB.levelId:
		return true
	return false

#####################################
### Dungeon generation node paths ###
#####################################

const levelPaths = {
	"dungeon": "res://Level Generation/Generic Generation/Dungeon Levels/Dungeon.tscn",
	"beach": "res://Level Generation/Generic Generation/Beach/Beach.tscn",
	"vacationResort": "res://Level Generation/Generic Generation/Beach/VacationResort.tscn",
	"minesOfTidoh": "res://Level Generation/WFC Generation/Mines of Tidoh/MinesOfTidoh.tscn",
	"depthsOfTidoh": "res://Level Generation/WFC Generation/Depths of Tidoh/DepthsOfTidoh.tscn",
	"abandonedOutpost": "res://Level Generation/WFC Generation/Abandoned Outpost/AbandonedOutpost.tscn",
	"anthill": "res://Level Generation/WFC Generation/Anthill/Anthill.tscn",
	"patch": "res://Level Generation/WFC Generation/Patch/Patch.tscn",
	"library": "res://Level Generation/WFC Generation/Library/Library.tscn",
	"banditWarcamp": "res://Level Generation/WFC Generation/Bandit Warcamp/BanditWarcamp.tscn",
	"dungeonHallways": "res://Level Generation/WFC Generation/Dungeon Halls/DungeonHalls.tscn",
	"labyrinth": "res://Level Generation/WFC Generation/Labyrinth/Labyrinth.tscn",
	"dragonsPeak": "res://Level Generation/WFC Generation/Dragons Peak/DragonsPeak.tscn",
	"fortressEntrance": "res://Level Generation/WFC Generation/Fortress Entrance/FortressEntrance.tscn",
	"fortress": "res://Level Generation/WFC Generation/Fortress/Fortress.tscn",
	"theGreatShadows": "res://Level Generation/WFC Generation/The Great Shadows/TheGreatShadows.tscn",
	"banditCompound1": "res://Level Generation/Premade Levels/Bandit Compound/BanditCompound1.tscn",
	"banditCompound2": "res://Level Generation/Premade Levels/Bandit Compound/BanditCompound2.tscn",
	"banditWarcamp1": "res://Level Generation/Premade Levels/Bandit Warcamp/BanditWarcamp1.tscn",
	"banditWarcamp2": "res://Level Generation/Premade Levels/Bandit Warcamp/BanditWarcamp2.tscn",
	"elderDragonsLair1": "res://Level Generation/Premade Levels/Elder Dragons Lair/ElderDragonsLair1.tscn",
	"elderDragonsLair2": "res://Level Generation/Premade Levels/Elder Dragons Lair/ElderDragonsLair2.tscn",
	"storageArea1": "res://Level Generation/Premade Levels/Storage Area/StorageArea1.tscn",
	"storageArea2": "res://Level Generation/Premade Levels/Storage Area/StorageArea2.tscn",
	"tidohMinesEnd1": "res://Level Generation/Premade Levels/Tidoh Mines End/TidohMinesEnd1.tscn",
	"tidohMinesEnd2": "res://Level Generation/Premade Levels/Tidoh Mines End/TidohMinesEnd2.tscn",
	"tidohMiningOutpost1": "res://Level Generation/Premade Levels/Tidoh Mining Outpost/TidohMiningOutpost1.tscn",
	"tidohMiningOutpost2": "res://Level Generation/Premade Levels/Tidoh Mining Outpost/TidohMiningOutpost2.tscn",
	"iovarsLair1": "res://Level Generation/Premade Levels/Iovars Lair/IovarsLair1.tscn",
	"iovarsLair2": "res://Level Generation/Premade Levels/Iovars Lair/IovarsLair2.tscn",
	"church": "res://Level Generation/Premade Levels/Church/Church.tscn"
}

##################################
### Dungeon generation threads ###
##################################

var threadDungeon1
var threadDungeon2
var threadDungeon3
var threadDungeon4
var threadDungeon5
var threadDungeon6
var threadDungeon7
var threadDungeon8

var dungeonGenLevel = 1

func _ready():
	randomize()
	
	$UI/UITheme/"Dancing Dragons".startDancingDragons()
	
	$UI/UITheme/GameConsole.create()
	$UI/UITheme/ItemManagement.create()
	$UI/UITheme/Equipment.create()
	$UI/UITheme/ListMenu.create()
	$UI/UITheme/Container.create()
	$UI/UITheme/DialogMenu.create()
	for _node in $UI/UITheme.get_children():
		if !_node.name.matchn("dancing dragons"):
			_node.hide()
	
	yield(get_tree().create_timer(0.01), "timeout")
	
	var saveData = $Save.loadData("SaveData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }))
	if saveData.hasSave:
		$UI/UITheme/"Dancing Dragons".setLoadingText("Loading game...")
		
		gameSetUpThread = Thread.new()
		gameSetUpThread.start(self, "loadGame")
	else:
		critters.create()
		$Critters.add_child(critters)
		
		items.create()
		$Items.add_child(items)
		$Items/Items.randomizeRandomItems()
		
		yield(get_tree().create_timer(0.01), "timeout")
		
		setUpDungeon()
		
		for _section in levels:
			if typeof(levels[_section]) != TYPE_ARRAY:
				totalLevelCount += 1
			else:
				totalLevelCount += levels[_section].size()
#		totalLevelCount += 1
		
		$FOV.createFOVLevels(totalLevelCount)
		
		var date = Time.get_date_dict_from_system(true)
		GlobalGameStats.gameStats["Game started at"] = "%s/%s/%s" % [date.day, date.month, date.year]
		
		generateDungeon()

func loadGame():
	var dir = Directory.new()
	
	critters.create()
	$Critters.add_child(critters)
	
	items.loadItems($Save.loadData("Items", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave })))
	$Items.add_child(items)
	
	var _globalsData = $Save.loadData("GlobalsData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }))
	Globals.loadGlobalsData(_globalsData)
	
	var _globalItemData = $Save.loadData("GlobalItemData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }))
	GlobalItemInfo.loadGlobalItemData(_globalItemData)
	
	var _globalCritterData = $Save.loadData("GlobalCritterData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }))
	GlobalCritterInfo.loadGlobalCritterSaveData(_globalCritterData)
	
	var _globalGameStats = $Save.loadData("GlobalGameStats", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }))
	GlobalGameStats.loadGlobalGameStatsData(_globalGameStats)
	
	var baseLevel = load("res://Level Generation/BaseLevel.tscn")
	if dir.open("user://SaveSlot{selectedSave}/levels".format({ "selectedSave": StartingData.selectedSave })) == OK:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if !dir.current_is_dir():
				var _levelData = $Save.loadData(fileName.split(".")[0], "SaveSlot{selectedSave}/levels".format({ "selectedSave": StartingData.selectedSave }))
				var _level = baseLevel.instance()
				$Levels.add_child(_level)
				_level.loadLevel(_levelData)
				if _levelData.levelId == 1:
					levels.firstLevel = _level
				elif _levelData.dungeonLevelName.matchn("church"):
					churchLevel = _level
				else:
					levels[_levelData.dungeonSection].append(_level)
			fileName = dir.get_next()
	else:
		push_error("An error occurred when trying to access the path.")
	
	for _section in levels:
		if typeof(levels[_section]) == TYPE_ARRAY:
			levels[_section].sort_custom(self, "sortLevels")
	
	level = get_node("Levels/{currentLevelId}".format({ "currentLevelId": Globals.currentDungeonLevel }))
	
	if dir.open("user://SaveSlot{selectedSave}/items".format({ "selectedSave": StartingData.selectedSave })) == OK:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if !dir.current_is_dir():
				var _item = $Save.loadData(fileName.split(".")[0], "SaveSlot{selectedSave}/items".format({ "selectedSave": StartingData.selectedSave }))
				$Items/Items.createItem(_item, Vector2(0,0), _item.amount, false, {  }, null, false)
			fileName = dir.get_next()
	else:
		push_error("An error occurred when trying to access the path.")
	
	if dir.open("user://SaveSlot{selectedSave}/critters".format({ "selectedSave": StartingData.selectedSave })) == OK:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if !dir.current_is_dir() and !fileName.split(".")[0].matchn(0):
				var _critter = $Save.loadData(fileName.split(".")[0], "SaveSlot{selectedSave}/critters".format({ "selectedSave": StartingData.selectedSave }))
				_critter.texture = load(_critter.texture)
				$Critters/Critters.spawnCritter(_critter, Vector2(0,0), null, false)
			fileName = dir.get_next()
	else:
		push_error("An error occurred when trying to access the path.")
	
	var _fovData = $Save.loadData("FOVData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }))
	$FOV.loadFOVLevel(_fovData)
	
#	var _gameConsoleData = $Save.loadData("FOVData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }))
#	$FOV.loadFOVLevel(_fovData)
	
	var _equipmentAndRuneData = $Save.loadData("EquipmentData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }))
	$UI/UITheme/Equipment.loadEquipmentData(_equipmentAndRuneData)
	$UI/UITheme/Runes.loadRunesData(_equipmentAndRuneData)
	
	setUpGameObjects($Save.loadData(0, "SaveSlot{selectedSave}/critters".format({ "selectedSave": StartingData.selectedSave })))
	generationDone = true

func setUpDungeon():
	
	var _firstSectionRandomLevels = 2
	var _patchLevels = 0
	var _abandonedOutpostLevels = 0
	var _anthillLevels = 0
	
	### Dungeon 1
	var firstLevel = load(levelPaths.dungeon).instance()
	firstLevel.create("dungeon1", "dungeon1", "Dungeon 1", 10000)
	levels.firstLevel = firstLevel
	$Levels.add_child(firstLevel)
	level = levels.firstLevel

	for _level in range(randi() % 3 + 1):
		var newDungeon = load(levelPaths.dungeon).instance()
		newDungeon.create("dungeon1", "dungeon1", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() }), 10000)
		levels.dungeon1.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Library
	for _level in range(randi() % 2 + 3):
		var newlibrary = load(levelPaths.library).instance()
		newlibrary.create("library", "library", "Library {level}".format({ "level": 1 + levels.library.size() }), 10000)
		levels.library.append(newlibrary)
		$Levels.add_child(newlibrary)
	
	### Dungeon 2
	var _dungeon2Count = randi() % 3 + 3
	for _level in _dungeon2Count:
		var newDungeon
		if randi() % 7 == 0 and _firstSectionRandomLevels != 0 and _level < _dungeon2Count - 1:
			if randi() % 3 == 0:
				_patchLevels += 1
				newDungeon = load(levelPaths.patch).instance()
				newDungeon.create("patch", "dungeon2", "Patch {level}".format({ "level": _patchLevels }), 10000)
			elif randi() % 3 == 0:
				_abandonedOutpostLevels += 1
				newDungeon = load(levelPaths.abandonedOutpost).instance()
				newDungeon.create("abandonedOutpost", "dungeon2", "Abandoned Outpost {level}".format({ "level": _abandonedOutpostLevels }), 10000)
			else:
				_anthillLevels += 1
				newDungeon = load(levelPaths.anthill).instance()
				newDungeon.create("anthill", "dungeon2", "Anthill {level}".format({ "level": _anthillLevels }), 10000)
			_firstSectionRandomLevels -= 1
		else:
			newDungeon = load(levelPaths.dungeon).instance()
			newDungeon.create("dungeon2", "dungeon2", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() }), 10000)
		levels.dungeon2.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Beach
	var newBeach = load(levelPaths.beach).instance()
	newBeach.create("beach", "beach", "Beach {level}".format({ "level": levels.beach.size() + 1 }), 10000)
	levels.beach.append(newBeach)
	$Levels.add_child(newBeach)
	
	var newVacationResort = load(levelPaths.vacationResort).instance()
	newVacationResort.create("beach", "beach", "Vacation resort", 10000)
	levels.beach.append(newVacationResort)
	$Levels.add_child(newVacationResort)
	
	for _level in range(randi() % 2 + 1):
		var newBeach2 = load(levelPaths.beach).instance()
		newBeach2.create("beach", "beach", "Beach {level}".format({ "level": 1 + levels.beach.size() }), 10000)
		levels.beach.append(newBeach2)
		$Levels.add_child(newBeach2)
	
	### Dungeon 3
	var _dungeon3Count = randi() % 3 + 3
	for _level in _dungeon3Count:
		var newDungeon
		if randi() % 7 == 0 and _firstSectionRandomLevels != 0 and _level < _dungeon3Count - 1:
			if randi() % 3 == 0:
				_patchLevels += 1
				newDungeon = load(levelPaths.patch).instance()
				newDungeon.create("patch", "dungeon3", "Patch {level}".format({ "level": _patchLevels }), 10000)
			elif randi() % 3 == 0:
				_abandonedOutpostLevels += 1
				newDungeon = load(levelPaths.abandonedOutpost).instance()
				newDungeon.create("abandonedOutpost", "dungeon3", "Abandoned Outpost {level}".format({ "level": _abandonedOutpostLevels }), 10000)
			else:
				_anthillLevels += 1
				newDungeon = load(levelPaths.anthill).instance()
				newDungeon.create("anthill", "dungeon3", "Anthill {level}".format({ "level": _anthillLevels }), 10000)
			_firstSectionRandomLevels -= 1
		else:
			newDungeon = load(levelPaths.dungeon).instance()
			newDungeon.create("dungeon3", "dungeon3", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() + levels.dungeon3.size() }), 10000)
		levels.dungeon3.append(newDungeon)
		$Levels.add_child(newDungeon)

	### Mines of Tidoh
	for _level in range(randi() % 2 + 2):
		var newCave = load(levelPaths.minesOfTidoh).instance()
		newCave.create("minesOfTidoh", "minesOfTidoh", "Mines of tidoh {level}".format({ "level": 1 + levels.minesOfTidoh.size() }), 2)
		levels.minesOfTidoh.append(newCave)
		$Levels.add_child(newCave)

	var newMiningOutpost
	if randi() % 2 == 0:
		newMiningOutpost = load(levelPaths.tidohMiningOutpost1).instance()
	else:
		newMiningOutpost = load(levelPaths.tidohMiningOutpost2).instance()
	newMiningOutpost.create("minesOfTidoh", "minesOfTidoh", "Tidoh mining outpost", 5)
	levels.minesOfTidoh.append(newMiningOutpost)
	$Levels.add_child(newMiningOutpost)

	for _level in range(randi() % 2 + 2):
		var newCave = load(levelPaths.depthsOfTidoh).instance()
		newCave.create("depthsOfTidoh", "depthsOfTidoh", "Depths of Tidoh {level}".format({ "level": 1 + levels.depthsOfTidoh.size() }), 1)
		levels.depthsOfTidoh.append(newCave)
		$Levels.add_child(newCave)

	var newMinesEnd
	if randi() % 2 == 0:
		newMinesEnd = load(levelPaths.tidohMinesEnd1).instance()
	else:
		newMinesEnd = load(levelPaths.tidohMinesEnd2).instance()
	newMinesEnd.create("depthsOfTidoh", "depthsOfTidoh", "Mines end", 1)
	levels.depthsOfTidoh.append(newMinesEnd)
	$Levels.add_child(newMinesEnd)
	
	### Dungeon 4
	for _level in range(3):
		var newDungeon
		if randi() % 7 == 0 and _firstSectionRandomLevels != 0 and _level < 2:
			if randi() % 3 == 0:
				_patchLevels += 1
				newDungeon = load(levelPaths.patch).instance()
				newDungeon.create("patch", "dungeon4", "Patch {level}".format({ "level": _patchLevels }), 10000)
			elif randi() % 3 == 0:
				_abandonedOutpostLevels += 1
				newDungeon = load(levelPaths.abandonedOutpost).instance()
				newDungeon.create("abandonedOutpost", "dungeon4", "Abandoned Outpost {level}".format({ "level": _abandonedOutpostLevels }), 10000)
			else:
				_anthillLevels += 1
				newDungeon = load(levelPaths.anthill).instance()
				newDungeon.create("anthill", "dungeon4", "Anthill {level}".format({ "level": _anthillLevels }), 10000)
			_firstSectionRandomLevels -= 1
		else:
			newDungeon = load(levelPaths.dungeon).instance()
			newDungeon.create("dungeon4", "dungeon4", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() + levels.dungeon3.size() + levels.dungeon4.size() }), 10000)
		levels.dungeon4.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Bandit warcamp
	for _level in range(2):
		var newBanditWarcamp = load(levelPaths.banditWarcamp).instance()
		newBanditWarcamp.create("banditWarcamp", "banditWarcamp", "Bandit warcamp {level}".format({ "level": 1 + levels.banditWarcamp.size() }), 10000)
		levels.banditWarcamp.append(newBanditWarcamp)
		$Levels.add_child(newBanditWarcamp)
	
	var newBanditWarcampLevel
	if randi() % 2 == 0:
		newBanditWarcampLevel = load(levelPaths.banditWarcamp1).instance()
	else:
		newBanditWarcampLevel = load(levelPaths.banditWarcamp2).instance()
	newBanditWarcampLevel.create("banditWarcamp", "banditWarcamp", "Bandit warcamp", 10000)
	levels.banditWarcamp.append(newBanditWarcampLevel)
	$Levels.add_child(newBanditWarcampLevel)
	
	for _level in range(2):
		var newBanditWarcamp = load(levelPaths.banditWarcamp).instance()
		newBanditWarcamp.create("banditWarcamp", "banditWarcamp", "Bandit warcamp {level}".format({ "level": 1 + levels.banditWarcamp.size() }), 10000)
		levels.banditWarcamp.append(newBanditWarcamp)
		$Levels.add_child(newBanditWarcamp)
	
	var newCompound
	if randi() % 2 == 0:
		newCompound = load(levelPaths.banditCompound1).instance()
	else:
		newCompound = load(levelPaths.banditCompound2).instance()
	newCompound.create("banditWarcamp", "banditWarcamp", "Bandit compound", 10000)
	levels.banditWarcamp.append(newCompound)
	$Levels.add_child(newCompound)
	
	### Storage area
	var newStorageArea
	if randi() % 2 == 0:
		newStorageArea = load(levelPaths.storageArea1).instance()
	else:
		newStorageArea = load(levelPaths.storageArea2).instance()
	newStorageArea.create("storageArea", "storageArea", "Storage Area", 10000)
	levels.storageArea.append(newStorageArea)
	$Levels.add_child(newStorageArea)
	
	### Dungeon halls 1
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = load(levelPaths.dungeonHallways).instance()
		newDungeonHallways.create("dungeonHalls1", "dungeonHalls1", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonHalls1.size() }), 10000)
		levels.dungeonHalls1.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)
	
	### Dungeon halls 2
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = load(levelPaths.dungeonHallways).instance()
		newDungeonHallways.create("dungeonHalls2", "dungeonHalls2", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonHalls1.size() + levels.dungeonHalls2.size() }), 10000)
		levels.dungeonHalls2.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)
	
	### Dungeon halls 3
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = load(levelPaths.dungeonHallways).instance()
		newDungeonHallways.create("dungeonHalls3", "dungeonHalls3", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonHalls1.size() + levels.dungeonHalls2.size() + levels.dungeonHalls3.size() }), 10000)
		levels.dungeonHalls3.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)
	
	### Labyrinth
	for _level in range(5):
		var newlabyrinth = load(levelPaths.labyrinth).instance()
		newlabyrinth.create("labyrinth", "labyrinth", "Labyrinth {level}".format({ "level": 1 + levels.labyrinth.size() }), 10000)
		levels.labyrinth.append(newlabyrinth)
		$Levels.add_child(newlabyrinth)
	
	### Dragons peak
	for _level in range(randi() % 2 + 3):
		var newDragonsPeak = load(levelPaths.dragonsPeak).instance()
		newDragonsPeak.create("dragonsPeak", "dragonsPeak", "Dragons peak {level}".format({ "level": 1 + levels.dragonsPeak.size() }), 10000)
		levels.dragonsPeak.append(newDragonsPeak)
		$Levels.add_child(newDragonsPeak)
	
	var newElderDragonsLair
	if randi() % 2 == 0:
		newElderDragonsLair = load(levelPaths.elderDragonsLair1).instance()
	else:
		newElderDragonsLair = load(levelPaths.elderDragonsLair2).instance()
	newElderDragonsLair.create("dragonsPeak", "dragonsPeak", "Elder dragons lair", 10000)
	levels.dragonsPeak.append(newElderDragonsLair)
	$Levels.add_child(newElderDragonsLair)
	
	### The Great Shadows
	for _level in range(3):
		var newGreatShadows = load(levelPaths.theGreatShadows).instance()
		newGreatShadows.create("theGreatShadows", "theGreatShadows", "The Great Shadows {level}".format({ "level": 1 + levels.theGreatShadows.size() }), 10000)
		levels.theGreatShadows.append(newGreatShadows)
		$Levels.add_child(newGreatShadows)
	
	### Fortress
	var newFortressEntrance = load(levelPaths.fortressEntrance).instance()
	newFortressEntrance.create("fortress", "fortress", "Fortress entrance", 10000)
	levels.fortress.append(newFortressEntrance)
	$Levels.add_child(newFortressEntrance)
	for _level in range(randi() % 3 + 3):
		var newFortress = load(levelPaths.fortress).instance()
		newFortress.create("fortress", "fortress", "Fortress {level}".format({ "level": levels.fortress.size() }), 10000)
		levels.fortress.append(newFortress)
		$Levels.add_child(newFortress)
	
	### Iovars lair
	var newIovarsLair
	if randi() % 2 == 0:
		newIovarsLair = load(levelPaths.iovarsLair1).instance()
	else:
		newIovarsLair = load(levelPaths.iovarsLair2).instance()
	newIovarsLair.create("iovarsLair", "iovarsLair", "Iovars lair", 10000)
	levels.iovarsLair.append(newIovarsLair)
	$Levels.add_child(newIovarsLair)
	
	### Church
	var newChurch = load(levelPaths.church).instance()
	newChurch.create("church", "church", "Church", 10000)
	churchLevel = newChurch
	$Levels.add_child(newChurch)



####################################
### Dungeon generation functions ###
####################################

func generateDungeon():
	churchLevel.createNewLevel()
	threadDungeon1 = Thread.new()
	threadDungeon1.start(self, "createDungeon", threadDungeon1)
	threadDungeon2 = Thread.new()
	threadDungeon2.start(self, "createDungeon", threadDungeon2)
	threadDungeon3 = Thread.new()
	threadDungeon3.start(self, "createDungeon", threadDungeon3)
	threadDungeon4 = Thread.new()
	threadDungeon4.start(self, "createDungeon", threadDungeon4)
	threadDungeon5 = Thread.new()
	threadDungeon5.start(self, "createDungeon", threadDungeon5)
	threadDungeon6 = Thread.new()
	threadDungeon6.start(self, "createDungeon", threadDungeon6)
	threadDungeon7 = Thread.new()
	threadDungeon7.start(self, "createDungeon", threadDungeon7)
	threadDungeon8 = Thread.new()
	threadDungeon8.start(self, "createDungeon", threadDungeon8)

func createDungeon(_thread):
	while(dungeonGenLevel < totalLevelCount):
		Globals.mutex.lock()
		var _level = getNextDungeonGenLevel()
		Globals.mutex.unlock()
		if !checkIfGenerateLevelWithStair(_level):
			_level.createNewLevel()
	call_deferred("checkIfThreadsAreDone")
	_thread.call_deferred("wait_to_finish")

func getNextDungeonGenLevel():
	for _section in levels:
		if typeof(levels[_section]) != TYPE_ARRAY:
			if levels[_section].levelId == dungeonGenLevel:
				dungeonGenLevel += 1
				return levels[_section]
		else:
			for _level in levels[_section]:
				if _level.levelId == dungeonGenLevel:
					dungeonGenLevel += 1
					return _level

func checkIfGenerateLevelWithStair(_level):
	if _level == levels.dungeon1.back():
		_level.createNewLevel(["makeSecondDownStair"])
		return true
	if _level == levels.dungeon3.back():
		_level.createNewLevel(["makeSecondDownStair"])
		return true
	if _level == levels.library.back():
		_level.createNewLevel(["noDownStair"])
		return true
	if _level == levels.dungeonHalls1.back():
		_level.createNewLevel(["makeSecondDownStair"])
		return true
	if _level == levels.dungeonHalls2.back():
		_level.createNewLevel(["makeSecondUpStair"])
		return true
	if _level == levels.labyrinth.back():
		_level.createNewLevel(["noDownStair"])
		return true
	return false

func checkIfThreadsAreDone():
	if (
		threadDungeon1 != null and
		!threadDungeon1.is_alive() and
		threadDungeon2 != null and
		!threadDungeon2.is_alive() and
		threadDungeon3 != null and
		!threadDungeon3.is_alive() and
		threadDungeon4 != null and
		!threadDungeon4.is_alive() and
		threadDungeon5 != null and
		!threadDungeon5.is_alive() and
		threadDungeon6 != null and
		!threadDungeon6.is_alive() and
		threadDungeon7 != null and
		!threadDungeon7.is_alive() and
		threadDungeon8 != null and
		!threadDungeon8.is_alive()
	):
		$UI/UITheme/"Dancing Dragons".call_deferred("setLoadingText", "Setting up game objects...")
		gameSetUpThread = Thread.new()
		gameSetUpThread.start(self, "setUpGameObjects")

func _exit_tree():
	if gameSetUpThread != null and !gameSetUpThread.is_alive():
		print("game set up")
		gameSetUpThread.wait_to_finish()
	if saveGameThread != null and !saveGameThread.is_alive():
		print("game saved")
		saveGameThread.wait_to_finish()
