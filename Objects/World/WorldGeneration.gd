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

func _ready():
#	OS.window_size = Vector2(1280, 900)
#	get_tree().set_screen_stretch(2,1,Vector2(960, 540),.5)
	
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
		_node.hide()
	
	setUpDungeon()
	
	var levelCount = 0
	for section in levels:
		if typeof(levels[section]) != TYPE_ARRAY:
			levelCount += 1
		else:
			levelCount += levels[section].size()
	
	$FOV.createFOVLevels(levelCount)
	
	$"/root/World/UI/UITheme/Dancing Dragons".call_deferred("startDancingDragons")
	generateDungeon()

func setUpDungeon():
	### Dungeon 1
	var firstLevel = dungeon.instance()
	firstLevel.create("dungeon1", "Dungeon hallways 1", 10000)
	levels.firstLevel = firstLevel
	$Levels.add_child(firstLevel)
	
	for _level in range(randi() % 3 + 1):
		var newDungeon = dungeon.instance()
		newDungeon.create("dungeon1", "Dungeon hallways {level}".format({ "level": 2 + levels.dungeon1.size() }), 10000)
		levels.dungeon1.append(newDungeon)
		$Levels.add_child(newDungeon)
	
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
	
	### Dungeon 2
	for _level in range(randi() % 3 + 4):
		var newDungeon = dungeon.instance()
		newDungeon.create("dungeon2", "Dungeon hallways {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() + 1 }), 10000)
		levels.dungeon2.append(newDungeon)
		$Levels.add_child(newDungeon)
		
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
	
	### Dungeon 3
	for _level in range(randi() % 3 + 4):
		var newDungeon = dungeon.instance()
		newDungeon.create("dungeon3", "Dungeon hallways {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() + levels.dungeon3.size() + 1 }), 10000)
		levels.dungeon3.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Library
	for _level in range(randi() % 3 + 4):
		var newlibrary = library.instance()
		newlibrary.create("library", "Library {level}".format({ "level": 1 + levels.library.size() }), 10000)
		levels.library.append(newlibrary)
		$Levels.add_child(newlibrary)
	
	### Dungeon 4
	for _level in range(3):
		var newDungeon = dungeon.instance()
		newDungeon.create("dungeon", "Dungeon hallways {level}".format({ "level": 2 + levels.dungeon1.size() + levels.dungeon2.size() + levels.dungeon3.size() + levels.dungeon4.size() + 1 }), 10000)
		levels.dungeon4.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Bandit warcamp
	for _level in range(randi() % 4 + 2):
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
	newStorageArea.create("storageArea", "Storage Area", 10000)
	levels.storageArea.append(newStorageArea)
	$Levels.add_child(newStorageArea)
	
	### Dungeon halls 1
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = dungeonHallways.instance()
		newDungeonHallways.create("dungeonHallways1", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonhalls1.size() }), 10000)
		levels.dungeonhalls1.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)
	
	### Labyrinth
	for _level in range(5):
		var newlabyrinth = labyrinth.instance()
		newlabyrinth.create("labyrinth", "Labyrinth {level}".format({ "level": 1 + levels.labyrinth.size() }), 10000)
		levels.labyrinth.append(newlabyrinth)
		$Levels.add_child(newlabyrinth)
	
	### Dungeon halls 2
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = dungeonHallways.instance()
		newDungeonHallways.create("dungeonHallways1", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonhalls1.size() + levels.dungeonhalls2.size() }), 10000)
		levels.dungeonhalls2.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)
	
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
	
	### Dungeon halls 3
	for _level in range(randi() % 4 + 3):
		var newDungeonHallways = dungeonHallways.instance()
		newDungeonHallways.create("dungeonHallways1", "Dungeon halls {level}".format({ "level": 1 + levels.dungeonhalls1.size() + levels.dungeonhalls2.size() + levels.dungeonhalls3.size() }), 10000)
		levels.dungeonhalls3.append(newDungeonHallways)
		$Levels.add_child(newDungeonHallways)
	
	### The Great Shadows
	for _level in range(4):
		var newGreatShadows = theGreatShadows.instance()
		newGreatShadows.create("theGreatShadows", "The Great Shadows {level}".format({ "level": 1 + levels.theGreatShadows.size() }), 10000)
		levels.theGreatShadows.append(newGreatShadows)
		$Levels.add_child(newGreatShadows)
	
	### Fortress
	var newFortressEntrance = fortressEntrance.instance()
	newFortressEntrance.create("fortress", "Fortress entrance", 10000)
	levels.fortress.append(newFortressEntrance)
	$Levels.add_child(newFortressEntrance)
	for _level in range(randi() % 4 + 4):
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
	newIovarsLair.create("iovarsLair", "Iovars lair", 10000)
	levels.iovarsLair.append(newIovarsLair)
	$Levels.add_child(newIovarsLair)
	
	### Church
	var newChurch = church.instance()
	newChurch.create("church", "Church", 10000)
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
	threads.threadDungeons = Thread.new()
	threads.threadDungeons.start(self, "createDungeons", Thread.PRIORITY_HIGH)
	
	threads.threadDungeonsSidepaths = Thread.new()
	threads.threadDungeonsSidepaths.start(self, "createDungeonsSidepaths", Thread.PRIORITY_HIGH)
	
	threads.threadHalls = Thread.new()
	threads.threadHalls.start(self, "createHalls", Thread.PRIORITY_HIGH)
	
	threads.threadHallsSidepaths = Thread.new()
	threads.threadHallsSidepaths.start(self, "createHallsSidepaths", Thread.PRIORITY_HIGH)

func createDungeons():
	for _level in levels.dungeon1.size():
		if levels.dungeon1[_level] == levels.dungeon1.back():
			get_node("Levels/{level}".format({ "level": levels.dungeon1[_level] })).createNewLevel(true)
		else:
			get_node("Levels/{level}".format({ "level": levels.dungeon1[_level] })).createNewLevel()
	
	for _level in levels.dungeon2.size():
		if levels.dungeon2[_level] == levels.dungeon2.back():
			get_node("Levels/{level}".format({ "level": levels.dungeon2[_level] })).createNewLevel(true)
		else:
			get_node("Levels/{level}".format({ "level": levels.dungeon2[_level] })).createNewLevel()
	
	for _level in levels.dungeon3.size():
		if levels.dungeon3[_level] == levels.dungeon3.back():
			get_node("Levels/{level}".format({ "level": levels.dungeon3[_level] })).createNewLevel(true)
		else:
			get_node("Levels/{level}".format({ "level": levels.dungeon3[_level] })).createNewLevel()
	
	for _level in levels.dungeon4.size():
		get_node("Levels/{level}".format({ "level": levels.dungeon4[_level] })).createNewLevel()
	
	for _level in levels.beach:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.banditWarcamp:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.storageArea:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()

func createDungeonsSidepaths():
	for _level in levels.minesOfTidoh:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.depthsOfTidoh:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.library:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()

func createHalls():
	for _level in levels.dungeonhalls1:
		if levels.dungeonhalls1[_level] == levels.dungeonhalls1.back():
			get_node("Levels/{level}".format({ "level": levels.dungeonhalls1[_level] })).createNewLevel(true)
		else:
			get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.dungeonhalls2:
		if levels.dungeonhalls2[_level] == levels.dungeonhalls2.back():
			get_node("Levels/{level}".format({ "level": levels.dungeonhalls2[_level] })).createNewLevel(true)
		else:
			get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.dungeonhalls3:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()

func createHallsSidepaths():
	for _level in levels.labyrinth:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.dragonsPeak:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.theGreatShadows:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.fortress:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.iovarsLair:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
