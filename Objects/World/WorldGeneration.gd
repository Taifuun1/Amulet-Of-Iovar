extends WorldManagement

onready var critters = preload("res://Objects/Critter/Critters.tscn").instance()
onready var items = preload("res://Objects/Item/Items.tscn").instance()

##################################
### Generic dungeon generation ###
##################################
onready var dungeon = preload("res://Level Generation/Generic Generation/Dungeon Levels/Dungeon.tscn")
onready var beach = preload("res://Level Generation/Generic Generation/Beach/Beach.tscn")
onready var vacationResort = preload("res://Level Generation/Generic Generation/Beach/VacationResort.tscn")

######################
### WFC Generation ###
######################
onready var minesOfTidoh = preload("res://Level Generation/WFC Generation/Mines of Tidoh/MinesOfTidoh.tscn")
onready var depthsOfTidoh = preload("res://Level Generation/WFC Generation/Depths of Tidoh/DepthsOfTidoh.tscn")
onready var abandonedOutpost = preload("res://Level Generation/WFC Generation/Abandoned Outpost/AbandonedOutpost.tscn")
onready var anthill = preload("res://Level Generation/WFC Generation/Anthill/Anthill.tscn")
onready var patch = preload("res://Level Generation/WFC Generation/Patch/Patch.tscn")
onready var library = preload("res://Level Generation/WFC Generation/Library/Library.tscn")
onready var banditWarcamp = preload("res://Level Generation/WFC Generation/Bandit Warcamp/BanditWarcamp.tscn")
onready var dungeonHallways = preload("res://Level Generation/WFC Generation/Dungeon Halls/DungeonHalls.tscn")
onready var labyrinth = preload("res://Level Generation/WFC Generation/Labyrinth/Labyrinth.tscn")
onready var dragonsPeak = preload("res://Level Generation/WFC Generation/Dragons Peak/DragonsPeak.tscn")
onready var fortressEntrance = preload("res://Level Generation/WFC Generation/Fortress Entrance/FortressEntrance.tscn")
onready var fortress = preload("res://Level Generation/WFC Generation/Fortress/Fortress.tscn")
onready var theGreatShadows = preload("res://Level Generation/WFC Generation/The Great Shadows/TheGreatShadows.tscn")

#####################
### Premade levels ###
#####################
onready var banditCompound1 = preload("res://Level Generation/Premade Levels/Bandit Compound/BanditCompound1.tscn")
onready var banditCompound2 = preload("res://Level Generation/Premade Levels/Bandit Compound/BanditCompound2.tscn")
onready var banditWarcamp1 = preload("res://Level Generation/Premade Levels/Bandit Warcamp/BanditWarcamp1.tscn")
onready var banditWarcamp2 = preload("res://Level Generation/Premade Levels/Bandit Warcamp/BanditWarcamp2.tscn")
onready var elderDragonsLair1 = preload("res://Level Generation/Premade Levels/Elder Dragons Lair/ElderDragonsLair1.tscn")
onready var elderDragonsLair2 = preload("res://Level Generation/Premade Levels/Elder Dragons Lair/ElderDragonsLair2.tscn")
onready var storageArea1 = preload("res://Level Generation/Premade Levels/Storage Area/StorageArea1.tscn")
onready var storageArea2 = preload("res://Level Generation/Premade Levels/Storage Area/StorageArea2.tscn")
onready var tidohMinesEnd1 = preload("res://Level Generation/Premade Levels/Tidoh Mines End/TidohMinesEnd1.tscn")
onready var tidohMinesEnd2 = preload("res://Level Generation/Premade Levels/Tidoh Mines End/TidohMinesEnd2.tscn")
onready var tidohMiningOutpost1 = preload("res://Level Generation/Premade Levels/Tidoh Mining Outpost/TidohMiningOutpost1.tscn")
onready var tidohMiningOutpost2 = preload("res://Level Generation/Premade Levels/Tidoh Mining Outpost/TidohMiningOutpost2.tscn")
onready var iovarsLair1 = preload("res://Level Generation/Premade Levels/Iovars Lair/IovarsLair1.tscn")
onready var iovarsLair2 = preload("res://Level Generation/Premade Levels/Iovars Lair/IovarsLair2.tscn")
onready var church = preload("res://Level Generation/Premade Levels/Church/Church.tscn")

var threadDungeon1
var threadDungeon2
var threadDungeon3
var threadDungeon4
var threadHalls1
var threadHalls2
var threadHalls3
var threadHalls4

func _ready():
#	OS.window_size = Vector2(1280, 900)
#	get_tree().set_screen_stretch(2,1,Vector2(960, 540),.5)
	
	randomize()
	
	$UI/UITheme/"Dancing Dragons".startDancingDragons()
	
	var saveData = $Save.loadData("SaveData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }))
	
	$UI/UITheme/GameConsole.create()
	$UI/UITheme/ItemManagement.create()
	$UI/UITheme/Equipment.create()
	$UI/UITheme/ListMenu.create()
	$UI/UITheme/Container.create()
	$UI/UITheme/DialogMenu.create()
	for _node in $UI/UITheme.get_children():
		if !_node.name.matchn("dancing dragons"):
			_node.hide()
	
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
		
		setUpDungeon()
		
		var levelCount = 0
		for section in levels:
			if typeof(levels[section]) != TYPE_ARRAY:
				levelCount += 1
			else:
				levelCount += levels[section].size()
		
		$FOV.createFOVLevels(levelCount)
		
		generateDungeon()

func loadGame():
	var dir = Directory.new()
	
	critters.create()
	$Critters.add_child(critters)
	
	items.loadItems($Save.loadData("Items", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave })))
	$Items.add_child(items)
	
	var _globalsData = $Save.loadData("GlobalsData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }))
	Globals.loadGlobalsData(_globalsData)
	
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
				else:
					levels[_levelData.dungeonSection].append(_level)
			fileName = dir.get_next()
	else:
		push_error("An error occurred when trying to access the path.")
	
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
	var firstLevel = dungeon.instance()
	firstLevel.create("dungeon1", "dungeon1", "Dungeon 1", 10000)
	levels.firstLevel = firstLevel
	$Levels.add_child(firstLevel)

	for _level in range(randi() % 3 + 1):
		var newDungeon = dungeon.instance()
		newDungeon.create("dungeon1", "dungeon1", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() }), 10000)
		levels.dungeon1.append(newDungeon)
		$Levels.add_child(newDungeon)

	### Mines of Tidoh
	for _level in range(randi() % 3 + 2):
		var newCave = minesOfTidoh.instance()
		newCave.create("minesOfTidoh", "minesOfTidoh", "Mines of tidoh {level}".format({ "level": 1 + levels.minesOfTidoh.size() }), 2)
		levels.minesOfTidoh.append(newCave)
		$Levels.add_child(newCave)

	var newMiningOutpost
	if randi() % 2 == 0:
		newMiningOutpost = tidohMiningOutpost1.instance()
	else:
		newMiningOutpost = tidohMiningOutpost2.instance()
	newMiningOutpost.create("minesOfTidoh", "minesOfTidoh", "Tidoh mining outpost", 5)
	levels.minesOfTidoh.append(newMiningOutpost)
	$Levels.add_child(newMiningOutpost)

	for _level in range(randi() % 3 + 2):
		var newCave = depthsOfTidoh.instance()
		newCave.create("depthsOfTidoh", "depthsOfTidoh", "Depths of Tidoh {level}".format({ "level": 1 + levels.depthsOfTidoh.size() }), 1)
		levels.depthsOfTidoh.append(newCave)
		$Levels.add_child(newCave)

	var newMinesEnd
	if randi() % 2 == 0:
		newMinesEnd = tidohMinesEnd1.instance()
	else:
		newMinesEnd = tidohMinesEnd2.instance()
	newMinesEnd.create("depthsOfTidoh", "depthsOfTidoh", "Mines end", 1)
	levels.depthsOfTidoh.append(newMinesEnd)
	$Levels.add_child(newMinesEnd)
	
	### Dungeon 2
	var _dungeon2Count = randi() % 3 + 4
	for _level in _dungeon2Count:
		var newDungeon
		if randi() % 7 == 0 and _firstSectionRandomLevels != 0 and _level < _dungeon2Count - 1:
			if randi() % 3 == 0:
				_patchLevels += 1
				newDungeon = patch.instance()
				newDungeon.create("patch", "dungeon2", "Patch {level}".format({ "level": _patchLevels }), 10000)
			elif randi() % 3 == 0:
				_abandonedOutpostLevels += 1
				newDungeon = abandonedOutpost.instance()
				newDungeon.create("abandonedOutpost", "dungeon2", "Abandoned Outpost {level}".format({ "level": _abandonedOutpostLevels }), 10000)
			else:
				_anthillLevels += 1
				newDungeon = anthill.instance()
				newDungeon.create("anthill", "dungeon2", "Anthill {level}".format({ "level": _anthillLevels }), 10000)
			_firstSectionRandomLevels -= 1
		else:
			newDungeon = dungeon.instance()
			newDungeon.create("dungeon2", "dungeon2", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() }), 10000)
		levels.dungeon2.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Beach
	var newBeach = beach.instance()
	newBeach.create("beach", "beach", "Beach {level}".format({ "level": levels.beach.size() + 1 }), 10000)
	levels.beach.append(newBeach)
	$Levels.add_child(newBeach)
	
	var newVacationResort = vacationResort.instance()
	newVacationResort.create("beach", "beach", "Vacation resort", 10000)
	levels.beach.append(newVacationResort)
	$Levels.add_child(newVacationResort)
	
	for _level in range(randi() % 3 + 3):
		var newBeach2 = beach.instance()
		newBeach2.create("beach", "beach", "Beach {level}".format({ "level": 1 + levels.beach.size() }), 10000)
		levels.beach.append(newBeach2)
		$Levels.add_child(newBeach2)
	
	### Dungeon 3
	var _dungeon3Count = randi() % 3 + 4
	for _level in _dungeon3Count:
		var newDungeon
		if randi() % 7 == 0 and _firstSectionRandomLevels != 0 and _level < _dungeon3Count - 1:
			if randi() % 3 == 0:
				_patchLevels += 1
				newDungeon = patch.instance()
				newDungeon.create("patch", "dungeon3", "Patch {level}".format({ "level": _patchLevels }), 10000)
			elif randi() % 3 == 0:
				_abandonedOutpostLevels += 1
				newDungeon = abandonedOutpost.instance()
				newDungeon.create("abandonedOutpost", "dungeon3", "Abandoned Outpost {level}".format({ "level": _abandonedOutpostLevels }), 10000)
			else:
				_anthillLevels += 1
				newDungeon = anthill.instance()
				newDungeon.create("anthill", "dungeon3", "Anthill {level}".format({ "level": _anthillLevels }), 10000)
			_firstSectionRandomLevels -= 1
		else:
			newDungeon = dungeon.instance()
			newDungeon.create("dungeon3", "dungeon3", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() + levels.dungeon3.size() }), 10000)
		levels.dungeon3.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Library
	for _level in range(randi() % 3 + 3):
		var newlibrary = library.instance()
		newlibrary.create("library", "library", "Library {level}".format({ "level": 1 + levels.library.size() }), 10000)
		levels.library.append(newlibrary)
		$Levels.add_child(newlibrary)
	
	### Dungeon 4
	for _level in range(3):
		var newDungeon
		if randi() % 7 == 0 and _firstSectionRandomLevels != 0 and _level < 2:
			if randi() % 3 == 0:
				_patchLevels += 1
				newDungeon = patch.instance()
				newDungeon.create("patch", "dungeon4", "Patch {level}".format({ "level": _patchLevels }), 10000)
			elif randi() % 3 == 0:
				_abandonedOutpostLevels += 1
				newDungeon = abandonedOutpost.instance()
				newDungeon.create("abandonedOutpost", "Abandoned Outpost {level}".format({ "level": _abandonedOutpostLevels }), 10000)
			else:
				_anthillLevels += 1
				newDungeon = anthill.instance()
				newDungeon.create("anthill", "dungeon4", "Anthill {level}".format({ "level": _anthillLevels }), 10000)
			_firstSectionRandomLevels -= 1
		else:
			newDungeon = dungeon.instance()
			newDungeon.create("dungeon4", "dungeon4", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() + levels.dungeon3.size() + levels.dungeon4.size() }), 10000)
		levels.dungeon4.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Bandit warcamp
	for _level in range(2):
		var newBanditWarcamp = banditWarcamp.instance()
		newBanditWarcamp.create("banditWarcamp", "banditWarcamp", "Bandit warcamp {level}".format({ "level": 1 + levels.banditWarcamp.size() }), 10000)
		levels.banditWarcamp.append(newBanditWarcamp)
		$Levels.add_child(newBanditWarcamp)
	
	var newBanditWarcampLevel
	if randi() % 2 == 0:
		newBanditWarcampLevel = banditWarcamp1.instance()
	else:
		newBanditWarcampLevel = banditWarcamp2.instance()
	newBanditWarcampLevel.create("banditWarcamp", "banditWarcamp", "Bandit warcamp", 10000)
	levels.banditWarcamp.append(newBanditWarcampLevel)
	$Levels.add_child(newBanditWarcampLevel)
	
	for _level in range(2):
		var newBanditWarcamp = banditWarcamp.instance()
		newBanditWarcamp.create("banditWarcamp", "banditWarcamp", "Bandit warcamp {level}".format({ "level": 1 + levels.banditWarcamp.size() }), 10000)
		levels.banditWarcamp.append(newBanditWarcamp)
		$Levels.add_child(newBanditWarcamp)
	
	var newCompound
	if randi() % 2 == 0:
		newCompound = banditCompound1.instance()
	else:
		newCompound = banditCompound2.instance()
	newCompound.create("banditWarcamp", "banditWarcamp", "Bandit compound", 10000)
	levels.banditWarcamp.append(newCompound)
	$Levels.add_child(newCompound)
	
	### Storage area
	var newStorageArea
	if randi() % 2 == 0:
		newStorageArea = storageArea1.instance()
	else:
		newStorageArea = storageArea2.instance()
	newStorageArea.create("storageArea", "storageArea", "Storage Area", 10000)
	levels.storageArea.append(newStorageArea)
	$Levels.add_child(newStorageArea)
	
	### Dungeon halls 1
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = dungeonHallways.instance()
		newDungeonHallways.create("dungeonHalls1", "dungeonHalls1", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonHalls1.size() }), 10000)
		levels.dungeonHalls1.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)
	
	### Dungeon halls 2
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = dungeonHallways.instance()
		newDungeonHallways.create("dungeonHalls2", "dungeonHalls2", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonHalls1.size() + levels.dungeonHalls2.size() }), 10000)
		levels.dungeonHalls2.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)
	
	### Dungeon halls 3
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = dungeonHallways.instance()
		newDungeonHallways.create("dungeonHalls3", "dungeonHalls3", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonHalls1.size() + levels.dungeonHalls2.size() + levels.dungeonHalls3.size() }), 10000)
		levels.dungeonHalls3.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)
	
	### Labyrinth
	for _level in range(5):
		var newlabyrinth = labyrinth.instance()
		newlabyrinth.create("labyrinth", "labyrinth", "Labyrinth {level}".format({ "level": 1 + levels.labyrinth.size() }), 10000)
		levels.labyrinth.append(newlabyrinth)
		$Levels.add_child(newlabyrinth)
	
	### Dragons peak
	for _level in range(randi() % 2 + 3):
		var newDragonsPeak = dragonsPeak.instance()
		newDragonsPeak.create("dragonsPeak", "dragonsPeak", "Dragons peak {level}".format({ "level": 1 + levels.dragonsPeak.size() }), 10000)
		levels.dragonsPeak.append(newDragonsPeak)
		$Levels.add_child(newDragonsPeak)
	
	var newElderDragonsLair
	if randi() % 2 == 0:
		newElderDragonsLair = elderDragonsLair1.instance()
	else:
		newElderDragonsLair = elderDragonsLair2.instance()
	newElderDragonsLair.create("dragonsPeak", "dragonsPeak", "Elder dragons lair", 10000)
	levels.dragonsPeak.append(newElderDragonsLair)
	$Levels.add_child(newElderDragonsLair)
	
	### The Great Shadows
	for _level in range(3):
		var newGreatShadows = theGreatShadows.instance()
		newGreatShadows.create("theGreatShadows", "theGreatShadows", "The Great Shadows {level}".format({ "level": 1 + levels.theGreatShadows.size() }), 10000)
		levels.theGreatShadows.append(newGreatShadows)
		$Levels.add_child(newGreatShadows)
	
	### Fortress
	var newFortressEntrance = fortressEntrance.instance()
	newFortressEntrance.create("fortress", "fortress", "Fortress entrance", 10000)
	levels.fortress.append(newFortressEntrance)
	$Levels.add_child(newFortressEntrance)
	for _level in range(randi() % 3 + 3):
		var newFortress = fortress.instance()
		newFortress.create("fortress", "fortress", "Fortress {level}".format({ "level": levels.fortress.size() }), 10000)
		levels.fortress.append(newFortress)
		$Levels.add_child(newFortress)
	
	### Iovars lair
	var newIovarsLair
	if randi() % 2 == 0:
		newIovarsLair = iovarsLair1.instance()
	else:
		newIovarsLair = iovarsLair2.instance()
	newIovarsLair.create("iovarsLair", "iovarsLair", "Iovars lair", 10000)
	levels.iovarsLair.append(newIovarsLair)
	$Levels.add_child(newIovarsLair)
	
	### Church
	var newChurch = church.instance()
	newChurch.create("church", "church", "Church", 10000)
	churchLevel = newChurch
	$Levels.add_child(newChurch)
	
	for _levelSection in levels:
		if typeof(_levelSection) == TYPE_STRING:
			totalLevelCount += 1
		else:
			totalLevelCount += _levelSection.size()
	totalLevelCount += 1



####################################
### Dungeon generation functions ###
####################################

func generateDungeon():
	threadDungeon1 = Thread.new()
	threadDungeon1.start(self, "createDungeon1", null, Thread.PRIORITY_NORMAL)
	threadDungeon2 = Thread.new()
	threadDungeon2.start(self, "createDungeon2", null, Thread.PRIORITY_NORMAL)
	threadDungeon3 = Thread.new()
	threadDungeon3.start(self, "createDungeon3", null, Thread.PRIORITY_NORMAL)
	threadDungeon4 = Thread.new()
	threadDungeon4.start(self, "createDungeon4", null, Thread.PRIORITY_NORMAL)
	
	threadHalls1 = Thread.new()
	threadHalls1.start(self, "createHalls1", null, Thread.PRIORITY_NORMAL)
	threadHalls2 = Thread.new()
	threadHalls2.start(self, "createHalls2", null, Thread.PRIORITY_NORMAL)
	threadHalls3 = Thread.new()
	threadHalls3.start(self, "createHalls3", null, Thread.PRIORITY_NORMAL)
	threadHalls4 = Thread.new()
	threadHalls4.start(self, "createHalls4", null, Thread.PRIORITY_NORMAL)

func createDungeon1(_nothing):
	level = levels.firstLevel.createNewLevel()
	churchLevel = churchLevel.createNewLevel()
	
	for _level in levels.dungeon1:
		if _level == levels.dungeon1.back():
			_level.createNewLevel("downStair")
		else:
			_level.createNewLevel()
	
	for _level in levels.dungeon2:
		if _level == levels.dungeon2.back():
			_level.createNewLevel()
		else:
			_level.createNewLevel()
	
	for _level in levels.beach:
		_level.createNewLevel()
	
	for _level in levels.dungeon3:
		if _level == levels.dungeon3.back():
			_level.createNewLevel("downStair")
		else:
			_level.createNewLevel()
	for _level in levels.dungeon4:
		_level.createNewLevel()
	
	for _level in levels.theGreatShadows:
		_level.createNewLevel()
	
	for _level in levels.iovarsLair:
		_level.createNewLevel()
	
	print("dungeon1")
	call_deferred("checkIfThreadsAreDone")
	threadDungeon1.call_deferred("wait_to_finish")

func createDungeon2(_nothing):
	for _level in levels.banditWarcamp:
		_level.createNewLevel()
	
	print("dungeon2")
	call_deferred("checkIfThreadsAreDone")
	threadDungeon2.call_deferred("wait_to_finish")

func createDungeon3():
	for _level in levels.minesOfTidoh:
		_level.createNewLevel()
	
	for _level in levels.depthsOfTidoh:
		_level.createNewLevel()
	
	print("dungeon3")
	call_deferred("checkIfThreadsAreDone")
	threadDungeon3.call_deferred("wait_to_finish")

func createDungeon4():
	for _level in levels.storageArea:
		_level.createNewLevel()
	
	print("dungeon4")
	call_deferred("checkIfThreadsAreDone")
	threadDungeon4.call_deferred("wait_to_finish")

func createHalls1():
	for _level in levels.dungeonHalls1:
		if _level == levels.dungeonHalls1.back():
			_level.createNewLevel("downStair")
		else:
			_level.createNewLevel()
	
	for _level in levels.dungeonHalls2:
		if _level == levels.dungeonHalls2.back():
			_level.createNewLevel("upStair")
		else:
			_level.createNewLevel()
	
	for _level in levels.dungeonHalls3:
		_level.createNewLevel()
	
	print("halls1")
	call_deferred("checkIfThreadsAreDone")
	threadHalls1.call_deferred("wait_to_finish")

func createHalls2():
	for _level in levels.library:
		_level.createNewLevel()
	
	print("halls2")
	call_deferred("checkIfThreadsAreDone")
	threadHalls2.call_deferred("wait_to_finish")

func createHalls3():
	for _level in levels.labyrinth:
		_level.createNewLevel()
	
	for _level in levels.dragonsPeak:
		_level.createNewLevel()
	
	print("halls3")
	call_deferred("checkIfThreadsAreDone")
	threadHalls3.call_deferred("wait_to_finish")

func createHalls4():
	for _level in levels.fortress:
		_level.createNewLevel()
	
	print("halls4")
	call_deferred("checkIfThreadsAreDone")
	threadHalls4.call_deferred("wait_to_finish")

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
		threadHalls1 != null and
		!threadHalls1.is_alive() and
		threadHalls2 != null and
		!threadHalls2.is_alive() and
		threadHalls3 != null and
		!threadHalls3.is_alive() and
		threadHalls4 != null and
		!threadHalls4.is_alive()
	):
		$UI/UITheme/"Dancing Dragons".call_deferred("setLoadingText", "Setting up game objects...")
		gameSetUpThread = Thread.new()
		gameSetUpThread.start(self, "setUpGameObjects")

func _exit_tree():
	if gameSetUpThread != null:
		gameSetUpThread.wait_to_finish()
