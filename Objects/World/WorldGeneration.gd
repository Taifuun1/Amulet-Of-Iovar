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
onready var patch = preload("res://Level Generation/WFC Generation/Patch/Patch.tscn")
onready var antHill = preload("res://Level Generation/WFC Generation/Ant Hill/AntHill.tscn")
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
	
	$"/root/World/UI/UITheme/Dancing Dragons".show()
	$"/root/World/UI/UITheme/Dancing Dragons".call_deferred("startDancingDragons")
	
	yield(get_tree().create_timer(0.1), "timeout")
	
	randomize()
	
	items.create()
	$Items.add_child(items)
	
	critters.create()
	$Critters.add_child(critters)
	
	$UI/UITheme/GameConsole.create()
	$UI/UITheme/ItemManagement.create()
	$UI/UITheme/Equipment.create()
	$UI/UITheme/ListMenu.create()
	$UI/UITheme/Container.create()
	$UI/UITheme/DialogMenu.create()
	for _node in $UI/UITheme.get_children():
		if !_node.name.matchn("dancing dragons"):
			_node.hide()
	
	setUpDungeonLevels()
	
	var levelCount = 0
	for section in levels:
		if typeof(levels[section]) != TYPE_ARRAY:
			levelCount += 1
		else:
			levelCount += levels[section].size()
	
	$FOV.createFOVLevels(levelCount)
	
	generateDungeon()

func setUpDungeonLevels():
	setUpDungeon()
	setUpDungeonSidepaths()
	setUpHalls()
	setUpHallsSidepaths()

func setUpDungeon():
	### Dungeon 1
	var firstLevel = dungeon.instance()
	firstLevel.create("dungeon1", "Dungeon 1", 10000)
	levels.firstLevel = firstLevel
	$Levels.add_child(firstLevel)
	
	for _level in range(randi() % 3 + 1):
		var newDungeon = dungeon.instance()
		newDungeon.create("dungeon1", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() }), 10000)
		levels.dungeon1.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Dungeon 2
	for _level in range(randi() % 3 + 4):
		var newDungeon = dungeon.instance()
		newDungeon.create("dungeon2", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() + 1 }), 10000)
		levels.dungeon2.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Dungeon 3
	for _level in range(randi() % 3 + 4):
		var newDungeon = dungeon.instance()
		newDungeon.create("dungeon3", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() + levels.dungeon3.size() + 1 }), 10000)
		levels.dungeon3.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Dungeon 4
	for _level in range(3):
		var newDungeon = dungeon.instance()
		newDungeon.create("dungeon4", "Dungeon {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() + levels.dungeon3.size() + levels.dungeon4.size() + 1 }), 10000)
		levels.dungeon4.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Bandit warcamp
	for _level in range(randi() % 3 + 1):
		var newBanditWarcamp = banditWarcamp.instance()
		newBanditWarcamp.create("banditWarcamp", "Bandit warcamp {level}".format({ "level": 1 + levels.banditWarcamp.size() }), 10000)
		levels.banditWarcamp.append(newBanditWarcamp)
		$Levels.add_child(newBanditWarcamp)
	
	var newBanditWarcampLevel
	if randi() % 2 == 0:
		newBanditWarcampLevel = banditWarcamp1.instance()
	else:
		newBanditWarcampLevel = banditWarcamp2.instance()
	newBanditWarcampLevel.create("banditWarcamp", "Bandit warcamp", 10000)
	levels.banditWarcamp.append(newBanditWarcampLevel)
	$Levels.add_child(newBanditWarcampLevel)
	
	for _level in range(2):
		var newBanditWarcamp = banditWarcamp.instance()
		newBanditWarcamp.create("banditWarcamp", "Bandit warcamp {level}".format({ "level": 1 + levels.banditWarcamp.size() }), 10000)
		levels.banditWarcamp.append(newBanditWarcamp)
		$Levels.add_child(newBanditWarcamp)
	
	var newCompound
	if randi() % 2 == 0:
		newCompound = banditCompound1.instance()
	else:
		newCompound = banditCompound2.instance()
	newCompound.create("banditWarcamp", "Bandit compound", 10000)
	levels.banditWarcamp.append(newCompound)
	$Levels.add_child(newCompound)
	
	### Storage area
	var newStorageArea
	if randi() % 2 == 0:
		newStorageArea = storageArea1.instance()
	else:
		newStorageArea = storageArea2.instance()
	newStorageArea.create("", "Storage Area", 10000)
	levels.storageArea.append(newStorageArea)
	$Levels.add_child(newStorageArea)
	
	### Church
	var newChurch = church.instance()
	newChurch.create("", "Church", 10000)
	churchLevel = newChurch
	$Levels.add_child(newChurch)
	
	for _levelSection in levels:
		if typeof(_levelSection) == TYPE_STRING:
			totalLevelCount += 1
		else:
			totalLevelCount += _levelSection.size()
	totalLevelCount += 1

func setUpDungeonSidepaths():
	### Mines of Tidoh
	for _level in range(randi() % 3 + 2):
		var newCave = minesOfTidoh.instance()
		newCave.create("minesOfTidoh", "Mines of tidoh {level}".format({ "level": 1 + levels.minesOfTidoh.size() }), 2)
		levels.minesOfTidoh.append(newCave)
		$Levels.add_child(newCave)

	var newMiningOutpost
	if randi() % 2 == 0:
		newMiningOutpost = tidohMiningOutpost1.instance()
	else:
		newMiningOutpost = tidohMiningOutpost2.instance()
	newMiningOutpost.create("minesOfTidoh", "Tidoh mining outpost", 5)
	levels.minesOfTidoh.append(newMiningOutpost)
	$Levels.add_child(newMiningOutpost)

	for _level in range(randi() % 3 + 2):
		var newCave = depthsOfTidoh.instance()
		newCave.create("depthsOfTidoh", "Depths of Tidoh {level}".format({ "level": 1 + levels.depthsOfTidoh.size() }), 1)
		levels.depthsOfTidoh.append(newCave)
		$Levels.add_child(newCave)

	var newMinesEnd
	if randi() % 2 == 0:
		newMinesEnd = tidohMinesEnd1.instance()
	else:
		newMinesEnd = tidohMinesEnd2.instance()
	newMinesEnd.create("depthsOfTidoh", "Mines end", 1)
	levels.depthsOfTidoh.append(newMinesEnd)
	$Levels.add_child(newMinesEnd)
	
	### Beach
	var newBeach = beach.instance()
	newBeach.create("beach", "Beach {level}".format({ "level": levels.beach.size() + 1 }), 10000)
	levels.beach.append(newBeach)
	$Levels.add_child(newBeach)
	
	var newVacationResort = vacationResort.instance()
	newVacationResort.create("beach", "Vacation resort", 10000)
	levels.beach.append(newVacationResort)
	$Levels.add_child(newVacationResort)
	
	for _level in range(randi() % 3 + 3):
		var newBeach2 = beach.instance()
		newBeach2.create("beach", "Beach {level}".format({ "level": 1 + levels.beach.size() }), 10000)
		levels.beach.append(newBeach2)
		$Levels.add_child(newBeach2)
	
	### Library
	for _level in range(randi() % 3 + 3):
		var newlibrary = library.instance()
		newlibrary.create("library", "Library {level}".format({ "level": 1 + levels.library.size() }), 10000)
		levels.library.append(newlibrary)
		$Levels.add_child(newlibrary)

func setUpHalls():
	### Dungeon halls 1
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = dungeonHallways.instance()
		newDungeonHallways.create("dungeonHalls1", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonhalls1.size() }), 10000)
		levels.dungeonhalls1.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)
	
	### Dungeon halls 2
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = dungeonHallways.instance()
		newDungeonHallways.create("dungeonHalls2", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonhalls1.size() + levels.dungeonhalls2.size() }), 10000)
		levels.dungeonhalls2.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)
	
	### Dungeon halls 3
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = dungeonHallways.instance()
		newDungeonHallways.create("dungeonHalls3", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonhalls1.size() + levels.dungeonhalls2.size() + levels.dungeonhalls3.size() }), 10000)
		levels.dungeonhalls3.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)

func setUpHallsSidepaths():
	### Labyrinth
	for _level in range(5):
		var newlabyrinth = labyrinth.instance()
		newlabyrinth.create("labyrinth", "Labyrinth {level}".format({ "level": 1 + levels.labyrinth.size() }), 10000)
		levels.labyrinth.append(newlabyrinth)
		$Levels.add_child(newlabyrinth)
	
	### Dragons peak
	for _level in range(randi() % 2 + 3):
		var newDragonsPeak = dragonsPeak.instance()
		newDragonsPeak.create("dragonsPeak", "Dragons peak {level}".format({ "level": 1 + levels.dragonsPeak.size() }), 10000)
		levels.dragonsPeak.append(newDragonsPeak)
		$Levels.add_child(newDragonsPeak)
	
	var newElderDragonsLair
	if randi() % 2 == 0:
		newElderDragonsLair = elderDragonsLair1.instance()
	else:
		newElderDragonsLair = elderDragonsLair2.instance()
	newElderDragonsLair.create("dragonsPeak", "Elder dragons lair", 10000)
	levels.dragonsPeak.append(newElderDragonsLair)
	$Levels.add_child(newElderDragonsLair)
	
	### The Great Shadows
	for _level in range(3):
		var newGreatShadows = theGreatShadows.instance()
		newGreatShadows.create("theGreatShadows", "The Great Shadows {level}".format({ "level": 1 + levels.theGreatShadows.size() }), 10000)
		levels.theGreatShadows.append(newGreatShadows)
		$Levels.add_child(newGreatShadows)
	
	### Fortress
	var newFortressEntrance = fortressEntrance.instance()
	newFortressEntrance.create("fortress", "Fortress entrance", 10000)
	levels.fortress.append(newFortressEntrance)
	$Levels.add_child(newFortressEntrance)
	for _level in range(randi() % 3 + 3):
		var newFortress = fortress.instance()
		newFortress.create("fortress", "Fortress {level}".format({ "level": levels.fortress.size() }), 10000)
		levels.fortress.append(newFortress)
		$Levels.add_child(newFortress)
	
	### Iovars lair
	var newIovarsLair
	if randi() % 2 == 0:
		newIovarsLair = iovarsLair1.instance()
	else:
		newIovarsLair = iovarsLair2.instance()
	newIovarsLair.create("", "Iovars lair", 10000)
	levels.iovarsLair.append(newIovarsLair)
	$Levels.add_child(newIovarsLair)



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
			_level.createNewLevel("downStair")
		else:
			_level.createNewLevel()
	
	for _level in levels.beach:
		_level.createNewLevel()
	
	for _level in levels.dungeon3:
		if _level == levels.dungeon3.back():
			_level.createNewLevel("downStair")
		else:
			_level.createNewLevel()
	
	for _level in levels.theGreatShadows:
		_level.createNewLevel()
	
	for _level in levels.iovarsLair:
		_level.createNewLevel()
	
	print("dungeon1")
	call_deferred("checkIfThreadsAreDone")

func createDungeon2(_nothing):
	for _level in levels.banditWarcamp:
		_level.createNewLevel()
	
	for _level in levels.storageArea:
		_level.createNewLevel()
	
	print("dungeon2")
	call_deferred("checkIfThreadsAreDone")

func createDungeon3():
	for _level in levels.minesOfTidoh:
		_level.createNewLevel()
	
	for _level in levels.depthsOfTidoh:
		_level.createNewLevel()
	
	for _level in levels.dungeon4:
		_level.createNewLevel()
	
	print("dungeon3")
	call_deferred("checkIfThreadsAreDone")

func createDungeon4():
	for _level in levels.library:
		_level.createNewLevel()
	
	print("dungeon4")
	call_deferred("checkIfThreadsAreDone")

func createHalls1():
	for _level in levels.dungeonhalls1:
		if _level == levels.dungeonhalls1.back():
			_level.createNewLevel("downStair")
		else:
			_level.createNewLevel()
	
	for _level in levels.dungeonhalls2:
		if _level == levels.dungeonhalls2.back():
			_level.createNewLevel("upStair")
		else:
			_level.createNewLevel()
	
	print("halls1")
	call_deferred("checkIfThreadsAreDone")

func createHalls2():
	for _level in levels.dungeonhalls3:
		_level.createNewLevel()
	
	print("halls2")
	call_deferred("checkIfThreadsAreDone")

func createHalls3():
	for _level in levels.labyrinth:
		_level.createNewLevel()
	
	for _level in levels.dragonsPeak:
		_level.createNewLevel()
	
	print("halls3")
	call_deferred("checkIfThreadsAreDone")

func createHalls4():
	for _level in levels.fortress:
		_level.createNewLevel()
	
	print("halls4")
	call_deferred("checkIfThreadsAreDone")

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
		threadHalls3 != null and
		!threadHalls4.is_alive()
	): 
		$"/root/World/UI/UITheme/Dancing Dragons".call_deferred("setLoadingText", "Setting up game objects...")
		gameSetUpThread = Thread.new()
		gameSetUpThread.start(self, "setUpGameObjects")

func _exit_tree():
	gameSetUpThread.wait_to_finish()
