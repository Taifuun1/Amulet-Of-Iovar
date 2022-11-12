extends TileMap

onready var player = preload("res://Objects/Player/Player.tscn").instance()

onready var critters = preload("res://Objects/Critter/Critters.tscn").instance()
onready var items = preload("res://Objects/Item/Items.tscn").instance()

##################################
### Generic dungeon generation ###
##################################
onready var dungeon = preload("res://Level Generation/Generic Generation/Dungeon Levels/Dungeon.tscn")
onready var tidohMiningOutpost = preload("res://Level Generation/Generic Generation/Mines Of Tidoh/TidohMiningOutpost.tscn")
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
onready var labyrinth = preload("res://Level Generation/WFC Generation/Labyrinth/Labyrinth.tscn")
onready var banditWarcamp = preload("res://Level Generation/WFC Generation/Bandit Warcamp/BanditWarcamp.tscn")
onready var dungeonHallways = preload("res://Level Generation/WFC Generation/Dungeon Halls/DungeonHalls.tscn")
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

var saveGameFile = 1

var hideObjectsWhenDrawingNextFrame = true
var checkNewCritterSpawn = 0

enum gameState {
	OUT_OF_PLAYERS_HANDS
	GAME
	INVENTORY
	PICK_UP_ITEMS
	DROP_ITEMS
	PICK_LOOTABLE
	LOOT
	READ
	RUNES
	QUAFF
	CONSUME
	EQUIPMENT
	INTERACT
	ZAP
	ZAP_DIRECTION
	CAST
	USE
	KICK
	DIP_ITEM
	DIP
}

var level = null
var levels = {
	"firstLevel": null,
	"dungeon1": [],
	"minesOfTidoh": [],
	"depthsOfTidoh": [],
	"dungeon2": [],
	"beach": [],
	"dungeon3": [],
	"library": [],
	"dungeon4": [],
	"banditWarcamp": [],
	"storageArea": [],
	"dungeonhalls1": [],
	"labyrinth": [],
	"dungeonhalls2": [],
#	"arena": [],
#	"dungeonhalls3": [],
	"dragonsPeak": [],
	"dungeonhalls3": [],
	"theGreatShadows": [],
	"fortress": [],
	"iovarsLair": []
}

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2


var thread
var inStartScreen = true
var generationDone = false
var inGame = false
var currentGameState = gameState.GAME
var keepMoving = false
var totalLevelCount = 0

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
	$UI/UITheme/StartScreen.show()
	
	createDungeon()
	
	var levelCount = 0
	for section in levels:
		if typeof(levels[section]) != TYPE_ARRAY:
			levelCount += 1
		else:
			levelCount += levels[section].size()
	
	$FOV.createFOVLevels(levelCount)

func _on_Game_Start(_className):
	thread = Thread.new()
	thread.start(self, "create", _className, Thread.PRIORITY_HIGH)

func create(_className):
	$Items/Items.randomizeRandomItems()
	
	level = get_node("Levels/{level}".format({ "level": levels.firstLevel })).createNewLevel()
	
	for _level in levels.dungeon1.size():
		if levels.dungeon1[_level] == levels.dungeon1.back():
			get_node("Levels/{level}".format({ "level": levels.dungeon1[_level] })).createNewLevel(true)
		else:
			get_node("Levels/{level}".format({ "level": levels.dungeon1[_level] })).createNewLevel()
	
	for _level in levels.minesOfTidoh:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.depthsOfTidoh:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	for _level in levels.dungeon2:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
#	for _level in levels.beach:
#		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
#
#	for _level in levels.dungeon3.size():
#		if levels.dungeon3[_level] == levels.dungeon3.back():
#			get_node("Levels/{level}".format({ "level": levels.dungeon3[_level] })).createNewLevel(true)
#		else:
#			get_node("Levels/{level}".format({ "level": levels.dungeon3[_level] })).createNewLevel()
#
#	for _level in levels.library:
#		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
#
#	for _level in levels.dungeon4:
#		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
#
#	for _level in levels.labyrinth:
#		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
#
#	for _level in levels.theGreatShadows:
#		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	$Critters.add_child(player, true)
	player.create(_className)
	level.placeCritterOnTypeOfTile(Globals.tiles.DOWN_STAIR_DUNGEON, 0)
	player.calculateEquipmentStats()
	
	for _level in $Levels.get_children():
		$Items/Items.generateItemsForLevel(_level)
	
	for _level in $Levels.get_children():
		$Critters/Critters.generateCrittersForLevel(_level)
	
	$Items/Items.createItem("scroll of identify", null, 1, true, { "alignment": "blessed" })
	$Items/Items.createItem("cloak of displacement", null, 1, true, { "alignment": "uncursed" })
	$Items/Items.createItem("gauntlets of balance", null, 1, true, { "alignment": "uncursed" })
	$Items/Items.createItem("bag of weight", null, 1, true, { "alignment": "blessed" })
	$Items/Items.createItem("bag of holding", null, 1, true, { "alignment": "uncursed" })
	$Items/Items.createItem("leather bag", null, 1, true, { "alignment": "uncursed" })
	$Items/Items.createItem("water potion", null, 1, true, { "alignment": "blessed" })
	$Items/Items.createItem("water potion", null, 1, true, { "alignment": "cursed" })
	$Items/Items.createItem("Dragonslayer", null, 1, true, { "alignment": "uncursed" })
	$Items/Items.createItem("Eario of Thunder", null, 1, true, { "alignment": "uncursed" })
	$Items/Items.createItem("Luirio of adjacent", null, 1, true, { "alignment": "uncursed" })
	$Items/Items.createItem("Heario of true", null, 1, true, { "alignment": "uncursed" })
#	$Items/Items.createItem("scroll of genocide", null, 1, true, { "alignment": "cursed" })
#	$Items/Items.createItem("ring of protection", null, 1, true, { "alignment": "uncursed" })
#	$Items/Items.createItem("oil lamp", null, 1, true, { "alignment": "uncursed" })
#	$Items/Items.createItem("key", null, 1, true, { "alignment": "uncursed" })
#	$Items/Items.createItem("wand of summon critter", null, 1, true, { "alignment": "uncursed" })
#	$Items/Items.createItem("scroll of teleport", null, 1, true, { "alignment": "uncursed" })
#	$Items/Items.createItem("scroll of teleport", null, 1, true, { "alignment": "uncursed" })
#	$Items/Items.createItem("scroll of teleport", null, 1, true, { "alignment": "cursed" })
#	$Items/Items.createItem("scroll of teleport", null, 1, true, { "alignment": "cursed" })
#	$Items/Items.createItem("dwarvish laysword", null, 1, true, { "alignment": "uncursed" })
#	$Items/Items.createItem("eario of toxix", null, 1, true)
#	$Items/Items.createItem("eario of fleir", null, 1, true)
#	$Items/Items.createItem("eario of frost", null, 1, true)
#	$Items/Items.createItem("luirio of cone", null, 1, true)
#	$Items/Items.createItem("luirio of point", null, 1, true)
#	$Items/Items.createItem("heario of flow", null, 1, true)
	
	for _node in $UI/UITheme.get_children():
		if _node.name == "GameConsole":
			_node.show()
		if _node.name == "GameStats":
			_node.show()
	$UI/UITheme/StartScreen.hide()
	$FOV.show()
	
	generationDone = true

func createDungeon():
	### Dungeon 1
	var firstLevel = church.instance()
	firstLevel.create("minesOfTidoh", "Dungeon hallways 1", 10000)
	levels.firstLevel = firstLevel
	$Levels.add_child(firstLevel)
	for _level in range(1):
		var newDungeon = library.instance()
		newDungeon.create("dungeon1", "Dungeon hallways {level}".format({ "level": 1 + levels.dungeon1.size() + 1 }), 10000)
		levels.dungeon1.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	### Mines of Tidoh
	for _level in range(1):
		var newCave = minesOfTidoh.instance()
		newCave.create("minesOfTidoh", "Mines of tidoh {level}".format({ "level": levels.minesOfTidoh.size() + 1 }), 2)
		levels.minesOfTidoh.append(newCave)
		$Levels.add_child(newCave)
	var newMiningOutpost = tidohMiningOutpost2.instance()
	newMiningOutpost.create("minesOfTidoh", "Tidoh mining outpost", 5)
	levels.minesOfTidoh.append(newMiningOutpost)
	$Levels.add_child(newMiningOutpost)
	for _level in range(1):
		var newCave = depthsOfTidoh.instance()
		newCave.create("depthsOfTidoh", "Depths of Tidoh {level}".format({ "level": levels.depthsOfTidoh.size() + 1 }), 1)
		levels.minesOfTidoh.append(newCave)
		$Levels.add_child(newCave)
	
	### Dungeon 2
	for _level in range(1):
		var newDungeon = dungeon.instance()
		newDungeon.create("dungeon2", "Dungeon hallways {level}".format({ "level": 1 + levels.dungeon1.size() + levels.dungeon2.size() + 1 }), 10000)
		levels.dungeon2.append(newDungeon)
		$Levels.add_child(newDungeon)

#	### Beach
#	var newBeach = beach.instance()
#	newBeach.create("beach", "Beach {level}".format({ "level": levels.beach.size() + 1 }), 10000)
#	levels.beach.append(newBeach)
#	$Levels.add_child(newBeach)
#	var newVacationResort = vacationResort.instance()
#	newVacationResort.create("beach", "Vacation resort", 10000)
#	levels.beach.append(newVacationResort)
#	$Levels.add_child(newVacationResort)
#	for _level in range(1):
#		var newBeach2 = beach.instance()
#		newBeach2.create("beach", "Beach {level}".format({ "level": levels.beach.size() }), 10000)
#		levels.beach.append(newBeach2)
#		$Levels.add_child(newBeach2)
#
#	### Dungeon 3
#	for _level in range(1):
#		var newDungeon = dungeon.instance()
#		newDungeon.create("dungeon", "Dungeon hallways {level}".format({ "level": 1 + levels.dungeon1.size() + levels.dungeon2.size() + levels.dungeon3.size() + 1 }), 10000)
#		levels.dungeon3.append(newDungeon)
#		$Levels.add_child(newDungeon)
#
#	### Library
#	for _level in range(1):
#		var newlibrary = library.instance()
#		newlibrary.create("library", "Library {level}".format({ "level": levels.library.size() }), 10000)
#		levels.library.append(newlibrary)
#		$Levels.add_child(newlibrary)
#
#	### Dungeon 4
#	for _level in range(3):
#		var newDungeon = dungeon.instance()
#		newDungeon.create("dungeon", "Dungeon hallways {level}".format({ "level": 1 + levels.dungeon1.size() + levels.dungeon2.size() + levels.dungeon3.size() + levels.dungeon4.size() + 1 }), 10000)
#		levels.dungeon4.append(newDungeon)
#		$Levels.add_child(newDungeon)
#
#	### Labyrinth
#	for _level in range(1):
#		var newlabyrinth = labyrinth.instance()
#		newlabyrinth.create("labyrinth", "Labyrinth {level}".format({ "level": levels.labyrinth.size() }), 10000)
#		levels.labyrinth.append(newlabyrinth)
#		$Levels.add_child(newlabyrinth)
#
#	### The Great Shadows
#	for _level in range(3):
#		var newGreatShadows = theGreatShadows.instance()
#		newGreatShadows.create("theGreatShadows", "The Great Shadows {level}".format({ "level": levels.labyrinth.size() }), 10000)
#		levels.theGreatShadows.append(newGreatShadows)
#		$Levels.add_child(newGreatShadows)
#
#	for _levelSection in levels:
#		if typeof(_levelSection) == TYPE_STRING:
#			totalLevelCount += 1
#		else:
#			totalLevelCount += _levelSection.size()

func _process(_delta):
	if inGame:
		if $Critters/"0".statusEffects["stun"] > 0 or $Critters/"0".statusEffects["sleep"] > 0:
			if $Critters/"0".statusEffects["stun"] > 0: Globals.gameConsole.addLog("You are stunned!")
			if $Critters/"0".statusEffects["sleep"] > 0: Globals.gameConsole.addLog("You are asleep.")
			processGameTurn()
	if generationDone:
		yield(get_tree().create_timer(0.1), "timeout")
		
		for _level in $Levels.get_children():
			_level.cleanOutTilemap()
		
		updateTiles()
		drawLevel()
		
		$Critters/"0".calculateWeightStats()
		$Critters/"0".updatePlayerStats()
		
		inStartScreen = false
		inGame = true
		
		show()
		
		generationDone = false

func _input(_event):
	if !inStartScreen:
		if inGame and currentGameState != gameState.OUT_OF_PLAYERS_HANDS:
			var _playerTile = level.getCritterTile(0)
			if (
				(
					Input.is_action_just_pressed("MOVE_UP") or
					Input.is_action_just_pressed("MOVE_UP_RIGHT") or
					Input.is_action_just_pressed("MOVE_RIGHT") or
					Input.is_action_just_pressed("MOVE_DOWN_RIGHT") or
					Input.is_action_just_pressed("MOVE_DOWN") or
					Input.is_action_just_pressed("MOVE_DOWN_LEFT") or
					Input.is_action_just_pressed("MOVE_LEFT") or
					Input.is_action_just_pressed("MOVE_UP_LEFT")
				) and
				(
					currentGameState == gameState.GAME or
					currentGameState == gameState.INTERACT or
					currentGameState == gameState.KICK or
					currentGameState == gameState.CAST or
					currentGameState == gameState.ZAP_DIRECTION
				)
			):
					var _tileToMoveTo
					if Input.is_action_just_pressed("MOVE_UP"):
						_tileToMoveTo = Vector2(_playerTile.x, _playerTile.y - 1)
					elif Input.is_action_just_pressed("MOVE_UP_RIGHT"):
						_tileToMoveTo = Vector2(_playerTile.x + 1, _playerTile.y - 1)
					elif Input.is_action_just_pressed("MOVE_RIGHT"):
						_tileToMoveTo = Vector2(_playerTile.x + 1, _playerTile.y)
					elif Input.is_action_just_pressed("MOVE_DOWN_RIGHT"):
						_tileToMoveTo = Vector2(_playerTile.x + 1, _playerTile.y + 1)
					elif Input.is_action_just_pressed("MOVE_DOWN"):
						_tileToMoveTo = Vector2(_playerTile.x, _playerTile.y + 1)
					elif Input.is_action_just_pressed("MOVE_DOWN_LEFT"):
						_tileToMoveTo = Vector2(_playerTile.x - 1, _playerTile.y + 1)
					elif Input.is_action_just_pressed("MOVE_LEFT"):
						_tileToMoveTo = Vector2(_playerTile.x - 1, _playerTile.y)
					elif Input.is_action_just_pressed("MOVE_UP_LEFT"):
						_tileToMoveTo = Vector2(_playerTile.x - 1, _playerTile.y - 1)
					
					if(
						Globals.isTileFree(_tileToMoveTo, level.grid) or
						(
							$Critters/"0".inventory.checkIfItemInInventoryByName("pickaxe") and
							(
								level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.EMPTY or
								level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.WALL_CAVE or
								level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.WALL_CAVE_DEEP
							)
						)
					):
						if currentGameState == gameState.GAME:
							var _openTiles = level.checkAdjacentTilesForOpenSpace(_playerTile)
							if $Critters/"0".statusEffects["confusion"] > 0 and randi() % 3 == 0:
								var _randomOpenTiles = _openTiles.duplicate(true)
								_randomOpenTiles.shuffle()
								_tileToMoveTo = _randomOpenTiles[0]
	#						for _openTile in _openTiles:
	#							if _openTile == _tileToMoveTo:
							if keepMoving and $Critters/"0".statusEffects["confusion"] == 0 and _tileToMoveTo != null:
								keepMovingLoop(_playerTile, _tileToMoveTo)
							else:
								processGameTurn(_playerTile, _tileToMoveTo)
	#						break
						elif currentGameState == gameState.INTERACT:
							interactWith(_tileToMoveTo)
						elif currentGameState == gameState.KICK:
							kickAt(_tileToMoveTo)
						elif currentGameState == gameState.CAST:
							castAt(_playerTile, _tileToMoveTo)
						elif currentGameState == gameState.ZAP_DIRECTION:
							$"Critters/0".zapItem(_tileToMoveTo - _playerTile)
							resetToDefaulGameState()
							processGameTurn()
			elif (
				Input.is_action_just_pressed("WAIT") and
				currentGameState == gameState.GAME
			):
				processGameTurn(_playerTile)
			elif (
				Input.is_action_just_pressed("ASCEND") and
				(
					level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.UP_STAIR_DUNGEON or
					level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.UP_STAIR_SAND
				) and
				Globals.currentDungeonLevel > 1 and
				currentGameState == gameState.GAME
			):
				moveLevel(-1)
			elif (
				Input.is_action_just_pressed("DESCEND") and
				(
					level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.DOWN_STAIR_DUNGEON or
					level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.DOWN_STAIR_SAND
				) and
#				levels.minesOfTidoh.back().levelId != Globals.currentDungeonLevel and
#				levels.library.back().levelId != Globals.currentDungeonLevel and
				Globals.currentDungeonLevel < Globals.generatedLevels and
				currentGameState == gameState.GAME
			):
				moveLevel(1)
			elif Input.is_action_just_pressed("ACCEPT") and (currentGameState == gameState.PICK_UP_ITEMS or currentGameState == gameState.DROP_ITEMS):
				processGameTurn(_playerTile)
			elif (Input.is_action_just_pressed("BACK")):
				closeMenu()
			elif (Input.is_action_just_pressed("INVENTORY") and currentGameState == gameState.GAME):
				openMenu("inventory")
			elif (Input.is_action_just_pressed("DROP") and currentGameState == gameState.GAME):
				openMenu("drop")
			elif (Input.is_action_just_pressed("PICK_UP") and currentGameState == gameState.GAME):
				openMenu("pick up", _playerTile)
			elif (Input.is_action_just_pressed("LOOT") and currentGameState == gameState.GAME):
				openMenu("loot", _playerTile)
			elif (Input.is_action_just_pressed("EQUIPMENT") and currentGameState == gameState.GAME):
				openMenu("equipment")
			elif (Input.is_action_just_pressed("RUNES") and currentGameState == gameState.GAME):
				openMenu("runes")
			elif (Input.is_action_just_pressed("READ") and currentGameState == gameState.GAME):
				openMenu("read")
			elif (Input.is_action_just_pressed("QUAFF") and currentGameState == gameState.GAME):
				openMenu("quaff")
			elif (Input.is_action_just_pressed("CONSUME") and currentGameState == gameState.GAME):
				openMenu("consume")
			elif (Input.is_action_just_pressed("ZAP") and currentGameState == gameState.GAME):
				openMenu("zap")
			elif (Input.is_action_just_pressed("DIP") and currentGameState == gameState.GAME):
				openMenu("dip")
			elif (Input.is_action_just_pressed("CAST") and currentGameState == gameState.GAME):
				castWith(_playerTile)
			elif Input.is_action_just_pressed("INTERACT") and currentGameState == gameState.GAME:
				currentGameState = gameState.INTERACT
				Globals.gameConsole.addLog("Interact with what? (Pick a direction with numpad)")
			elif Input.is_action_just_pressed("MOVE_TO_LEVEL") and currentGameState == gameState.GAME:
				$"UI/UITheme/Debug Menu".showMenu()
			elif Input.is_action_just_pressed("USE") and currentGameState == gameState.GAME:
				openMenu("use")
			elif Input.is_action_just_pressed("KICK") and currentGameState == gameState.GAME:
				currentGameState = gameState.KICK
				Globals.gameConsole.addLog("Kick at what? (Pick a direction with numpad)")
			elif Input.is_action_just_pressed("SAVE") and currentGameState == gameState.GAME:
				saveGame()
			elif Input.is_action_just_pressed("KEEP_MOVING") and currentGameState == gameState.GAME:
				keepMoving = true
		updateUI()

func processGameTurn(_playerTile = null, _tileToMoveTo = null):
	if _playerTile != null:
		processPlayerAction(_playerTile, _tileToMoveTo)
		processManyGameTurnsWithoutPlayerActionsAndWithoutSafety()
	processPlayerEffects()
	processEnemyActions()
	processEffects()
	processCrittersSpawnStatus()
#	checkIfGameOver()
	drawLevel()
	updateTiles()

func processManyGameTurnsWithoutPlayerActionsAndWithoutSafety():
	for _turn in $Critters/"0".turnsUntilAction:
		processPlayerEffects()
		processEnemyActions()
		processEffects()
		processCrittersSpawnStatus()
#		checkIfGameOver()
		drawLevel()
		updateTiles()

func processManyGameTurnsWithoutPlayerActionsAndWithSafety(_turnAmount = 1):
	for _turn in _turnAmount:
		processPlayerEffects()
		var _isPlayerHit = processEnemyActions()
		processEffects()
		processCrittersSpawnStatus()
#		checkIfGameOver()
		drawLevel()
		updateTiles()
		if _isPlayerHit:
			return false
	return true

func processPlayerAction(_playerTile, _tileToMoveTo):
	if (
		(
			Input.is_action_pressed("MOVE_UP") or
			Input.is_action_pressed("MOVE_UP_RIGHT") or
			Input.is_action_pressed("MOVE_RIGHT") or
			Input.is_action_pressed("MOVE_DOWN_RIGHT") or
			Input.is_action_pressed("MOVE_DOWN") or
			Input.is_action_pressed("MOVE_DOWN_LEFT") or
			Input.is_action_pressed("MOVE_LEFT") or
			Input.is_action_pressed("MOVE_UP_LEFT")
		) and
		(
			_tileToMoveTo.y >= 0 and
			_tileToMoveTo.y < level.grid[0].size() and
			_tileToMoveTo.x >= 0 and
			_tileToMoveTo.x < level.grid.size()
		)
	):
		$"Critters/0".processPlayerAction(_playerTile, _tileToMoveTo, $Items/Items, level)
	elif Input.is_action_pressed("ACCEPT"):
		processAccept()

func processEnemyActions():
	var _playerTile = level.getCritterTile(0)
	var _isPlayerHit = false
	if level.critters.size() != 0:
		for _enemy in level.critters:
			var _critterTile = level.getCritterTile(_enemy)
			var _critter = get_node("Critters/{id}".format({ "id": _enemy }))
			_critter.isCritterAwakened(_critterTile, _playerTile, level)
			if _critter.statusEffects.sleep > 0:
				Globals.gameConsole.addLog("The {critterName} is fast asleep.".format({ "critterName": _critter.critterName }))
			elif _critter.processCritterAction(_critterTile, _playerTile, _enemy, level):
				_isPlayerHit = true
				if $Critters/"0".statusEffects.sleep > 0:
					$Critters/"0".statusEffects.sleep = 0
					Globals.gameConsole.addLog("You wake up!")
			_critter.processCritterEffects()
	return _isPlayerHit

func processCrittersSpawnStatus():
	if checkNewCritterSpawn >= 50:
		$Critters/Critters.checkSpawnableCrittersLevel()
		$Critters/Critters.checkNewCritterSpawn(level, level.getCritterTile(0))
		checkNewCritterSpawn = 0
	else:
		checkNewCritterSpawn += 1

func processPlayerEffects():
	$"/root/World/Critters/0".processCritterEffects()
	$"/root/World/Critters/0".processPlayerSpecificEffects()

func processEffects():
	for _effect in $Effects.get_children():
		_effect.tickTurn()

func updateTiles():
	for x in (level.grid.size()):
		for y in (level.grid[x].size()):
			set_cellv(Vector2(x, y), level.grid[x][y].tile, level.grid[x][y].tileMetaData.xFlip, level.grid[x][y].tileMetaData.yFlip)
			$FOV.set_cellv(Vector2(x, y), $FOV.currentFOVLevel[x][y])
			if level.grid[x][y].interactable != null:
				$Interactables.set_cellv(Vector2(x, y), level.grid[x][y].interactable)
			else:
				$Interactables.set_cellv(Vector2(x, y), -1)

func drawLevel():
	yield(get_tree().create_timer(0.01), "timeout")
	if hideObjectsWhenDrawingNextFrame:
		for _critter in $Critters.get_children():
			_critter.hide()
		
		for _item in $Items.get_children():
			_item.hide()
		
		hideObjectsWhenDrawingNextFrame = false
	
	drawFOV()
	drawCrittersAndItems()

func drawFOV():
	# FOV
	var playerTile = level.getCritterTile(0)
	var playerCenter = Vector2((playerTile.x + 0.5) * 32, (playerTile.y + 0.5) * 32)
	var spaceState = get_world_2d().get_direct_space_state()
	var _playerNode = $Critters/"0"
	for x in range(Globals.gridSize.x):
		for y in range(Globals.gridSize.y):
			var x_dir = 1 if x < playerTile.x else -1
			var y_dir = 1 if y < playerTile.y else -1
			var testPoint = Vector2((x + 0.5) * 32, (y + 0.5) * 32) + Vector2(x_dir, y_dir) * 32 / 2
			var occlusion = spaceState.intersect_ray(playerCenter, testPoint)
			
			if (
				_playerNode.playerVisibility.distance == 0 and
				playerTile == Vector2(x, y)
			):
				$FOV.greyCell(x, y)
			elif (
				(
					_playerNode.playerVisibility.distance != 0 and
					(
						!occlusion or
						(occlusion.position - testPoint).length() < 1
					) and
					(
						(playerCenter - testPoint).length() < level.visibility * 32 or
						(
							(playerCenter - testPoint).length() < _playerNode.playerVisibility.distance * 32 and
							_playerNode.playerVisibility.distance != -1
						)
					)
				)
			):
				$FOV.seeCell(x, y)
			elif (
				$FOV.currentFOVLevel[x][y] == -1 and
				level.grid[x][y].tile != Globals.tiles.EMPTY and
				(
					occlusion or
					(playerCenter - testPoint).length() > level.visibility * 32 or
					(playerCenter - testPoint).length() > _playerNode.playerVisibility.distance * 32
				)
			):
				$FOV.greyCell(x, y)

func drawCrittersAndItems():
	# Critters and items
	for x in (Globals.gridSize.x):
		for y in (Globals.gridSize.y):
			if level.grid[x][y].critter != null:
				if (
					$FOV.currentFOVLevel[x][y] == -1 or
					level.grid[x][y].critter == 0 or
					(
						$Critters/"0".checkIfStatusEffectIsInEffect("seeing") and
						$Critters/"0".position.distance_to(map_to_world(Vector2(x,y))) < 32 * 12
					)
				):
					get_node("Critters/{id}".format({ "id": level.grid[x][y].critter })).set_position(map_to_world(Vector2(x, y)) + half_tile_size)
					get_node("Critters/{id}".format({ "id": level.grid[x][y].critter })).show()
				else:
					get_node("Critters/{id}".format({ "id": level.grid[x][y].critter })).hide()
			if level.grid[x][y].items.size() != 0:
				get_node("Items/{id}".format({ "id": level.grid[x][y].items.back() })).set_position(map_to_world(Vector2(x, y)) + half_tile_size)
				get_node("Items/{id}".format({ "id": level.grid[x][y].items.back() })).show()

func updateUI():
	$"Critters/0".updatePlayerStats()

func keepMovingLoop(_playerTile, _tileToMoveTo):
	var _currentTile = _playerTile
	var _nextTile = _tileToMoveTo
	var _direction = _tileToMoveTo - _playerTile
	while keepMoving:
		if (
			(
				_nextTile.x >= 0 and
				_nextTile.x < level.grid.size() and
				_nextTile.y >= 0 and
				_nextTile.y < level.grid[0].size()
			) and
			Globals.isTileFree(_nextTile, level.grid) and
			(
				level.grid[_currentTile.x][_currentTile.y - 1].critter == null or
				_currentTile.y - 1 < 0
			) and
			(
				(
					_currentTile.y - 1 < 0 or
					level.grid.size() - 1 < _currentTile.x + 1
				) or
				level.grid[_currentTile.x + 1][_currentTile.y - 1].critter == null
			) and
			(
				level.grid.size() - 1 < _currentTile.x + 1 or
				level.grid[_currentTile.x + 1][_currentTile.y].critter == null
			) and
			(
				(
					level.grid.size() - 1 < _currentTile.x + 1 or
					level.grid[0].size() - 1 < _currentTile.y + 1
				) or
				level.grid[_currentTile.x + 1][_currentTile.y + 1].critter == null
			) and
			(
				level.grid[0].size() - 1 < _currentTile.y + 1 or
				level.grid[_currentTile.x][_currentTile.y + 1].critter == null
			) and
			(
				(
					_currentTile.x - 1 < 0 or
					level.grid[0].size() - 1 < _currentTile.y + 1
				) or
				level.grid[_currentTile.x - 1][_currentTile.y + 1].critter == null
			) and
			(
				level.grid[_currentTile.x - 1][_currentTile.y].critter == null or
				_currentTile.x - 1 < 0
			) and
			(
				level.grid[_currentTile.x - 1][_currentTile.y - 1].critter == null or
				(
					_currentTile.x - 1 < 0 or
					_currentTile.y - 1 < 0
				)
			)
		):
			$"Critters/0".processPlayerAction(_currentTile, _nextTile, $Items/Items, level)
			processGameTurn()
			yield(get_tree().create_timer(0.01), "timeout")
		else:
			keepMoving = false
		_currentTile = _nextTile
		_nextTile = _nextTile + _direction

func moveLevel(_direction):
	$"/root/World".hide()
	hideObjectsWhenDrawingNextFrame = true
	var _playerPosition = level.getCritterTile(0)
	
	var _placePlayerOnStair = whichLevelAndStairIsPlayerPlacedUpon(_direction, _playerPosition)
	
	level.grid[_playerPosition.x][_playerPosition.y].critter = null
	level = get_node("Levels/{level}".format({ "level": Globals.currentDungeonLevel }))
	$FOV.moveLevel(Globals.currentDungeonLevel - 1)
	updateTiles()
	Globals.currentDungeonLevelName = level.dungeonLevelName
	level.grid[level.stairs[_placePlayerOnStair].x][level.stairs[_placePlayerOnStair].y].critter = 0
	
	if $Critters/"0".inventory.checkIfItemInInventoryByName("Amulet of Iovar") and randi() % 14 == 0:
		var _openTiles = level.checkAdjacentTilesForOpenSpace(level.stairs[_placePlayerOnStair], false, true)
		$Critters/Critters.spawnCritter("Iovar", _openTiles[randi() % _openTiles.size()])
		Globals.gameConsole.addLog("Iovar appears next to you!")
		Globals.gameConsole.addLog("Iovar: \"You cant escape, cur!\"")
	
	drawLevel()
	$"/root/World".show()

func goToLevel(_tile, _level):
	$"/root/World".hide()
	hideObjectsWhenDrawingNextFrame = true
	
	var _playerPosition = level.getCritterTile(0)
	level.grid[_playerPosition.x][_playerPosition.y].critter = null
	
	Globals.currentDungeonLevel = _level.levelId
	
	level = get_node("Levels/{level}".format({ "level": Globals.currentDungeonLevel }))
	$FOV.moveLevel(Globals.currentDungeonLevel - 1)
	updateTiles()
	Globals.currentDungeonLevelName = level.dungeonLevelName
	level.grid[_tile.x][_tile.y].critter = 0
	drawLevel()
	$"/root/World".show()

func whichStairIsPlayerOn(_playerTile):
	for stair in level.stairs.keys():
		if level.stairs[stair] == _playerTile:
			return stair
	return false

func whichLevelAndStairIsPlayerPlacedUpon(_direction, _playerPosition):
	var _stair = whichStairIsPlayerOn(_playerPosition)
	if _direction == 1:
		if levels.dungeon1.back().levelId == Globals.currentDungeonLevel:
			if _stair.matchn("secondDownStair"):
				Globals.currentDungeonLevel = levels.minesOfTidoh.front().levelId
				return "upStair"
			if _stair.matchn("downStair"):
				Globals.currentDungeonLevel = levels.dungeon2.front().levelId
				return "upStair"
#		elif levels.dungeon3.back().levelId == Globals.currentDungeonLevel:
#			if _stair.matchn("secondDownStair"):
#				Globals.currentDungeonLevel = levels.library.front().levelId
#				return "upStair"
#			if _stair.matchn("downStair"):
#				Globals.currentDungeonLevel = levels.dungeon4.front().levelId
#				return "upStair"
		else:
			Globals.currentDungeonLevel += _direction
			return "upStair"
	elif _direction == -1:
		if levels.dungeon2.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeon1.back().levelId
			return "downStair"
		elif levels.minesOfTidoh.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeon1.back().levelId
			return "secondDownStair"
#		elif levels.dungeon4.front().levelId == Globals.currentDungeonLevel:
#			Globals.currentDungeonLevel = levels.dungeon3.back().levelId
#			return "downStair"
#		elif levels.library.front().levelId == Globals.currentDungeonLevel:
#			Globals.currentDungeonLevel = levels.dungeon3.back().levelId
#			return "secondDownStair"
		else:
			Globals.currentDungeonLevel += _direction
			return "downStair"

func openMenu(_menu, _playerTile = null):
	match _menu:
		"inventory":
			if currentGameState == gameState.GAME:
				$Critters/"0"/Inventory.showInventory()
				currentGameState = gameState.INVENTORY
		"pick up":
			if level.grid[_playerTile.x][_playerTile.y].items.size() == 1 and currentGameState == gameState.GAME:
				$Critters/"0".pickUpItems(_playerTile, level.grid[_playerTile.x][_playerTile.y].items, level.grid)
				$"/root/World".processGameTurn()
			elif level.grid[_playerTile.x][_playerTile.y].items.size() != 0 and currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = level.grid[_playerTile.x][_playerTile.y].items
				$UI/UITheme/ItemManagement.showItemManagementList()
				currentGameState = gameState.PICK_UP_ITEMS
		"drop":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.inventory
				$UI/UITheme/ItemManagement.showItemManagementList()
				currentGameState = gameState.DROP_ITEMS
		"loot":
			if currentGameState == gameState.GAME:
				var _items
				_items = $Critters/"0"/Inventory.getItemsOfType(["tool"], "Container")
				for _itemId in level.grid[_playerTile.x][_playerTile.y].items:
					if get_node("Items/{itemId}".format({ "itemId": _itemId })).category != null and get_node("Items/{itemId}".format({ "itemId": _itemId })).category.matchn("container"):
						_items.append(_itemId)
				$UI/UITheme/ItemManagement.items = _items
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.PICK_LOOTABLE
		"equipment":
			if currentGameState == gameState.GAME:
				$UI/UITheme/Equipment.showEquipment($Critters/"0"/Inventory.getItemsOfType(["accessory", "armor", "belt", "cloak", "gauntlets", "weapon"]))
				currentGameState = gameState.EQUIPMENT
		"read":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["scroll"])
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.READ
		"runes":
			if currentGameState == gameState.GAME:
				$UI/UITheme/Runes.showRunes($Critters/"0"/Inventory.getItemsOfType(["rune"]))
				currentGameState = gameState.RUNES
		"quaff":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["potion"])
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.QUAFF
		"consume":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["comestible"])
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.CONSUME
		"zap":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["wand"])
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.ZAP
		"dip":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["amulet", "armor", "belt", "cloak", "gauntlets", "comestible", "gem", "ring", "rune", "scroll", "tool", "wand", "weapon"])
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.DIP_ITEM
		"use":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["tool"], null, ["corpse"])
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.USE

func castWith(_playerTile):
	match $UI/UITheme/Runes.isCastableRunes():
		"direction":
			currentGameState = gameState.CAST
			Globals.gameConsole.addLog("Cast towards what? (Pick a direction with numpad)")
		"directionless":
			$UI/UITheme/Runes.castSpell(_playerTile)
#			yield($UI/UITheme/Runes.castSpell(_playerTile), "completed")
		"notCastable":
			Globals.gameConsole.addLog("Your currently worn runes are not enough to cast a spell.")

func interactWith(_tileToInteractWith):
#	Globals.gameConsole.addLog("You cant interact with the {critter}".format({ "critter": $"Critters/{critterid}".format({ "critterId": level.grid[_tileToInteractWith.x][_tileToInteractWith.y].critter }).critterName }))
	if level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable != null:
		if level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable == Globals.interactables.HIDDEN_ITEM:
			if $Critters/"0"/Inventory.checkIfItemInInventoryByName("shovel"):
				Globals.gameConsole.addLog("You dig up the item from the sand.")
				if randi() % 3 == 0:
					$Items/Items.createItem("message in a bottle", _tileToInteractWith)
					Globals.gameConsole.addLog("You discover a message in a bottle!")
				else:
					$Items/Items.createItem($Items/Items.getRandomItem(), _tileToInteractWith)
					Globals.gameConsole.addLog("You discover an item!")
				level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
				processGameTurn()
			else:
				Globals.gameConsole.addLog("You need a shovel to dig up that item.")
		if level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable == Globals.interactables.LOCKED:
			if $Critters/"0"/Inventory.checkIfItemInInventoryByName("magic key"):
				level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
				Globals.gameConsole.addLog("You unlock the door with your magic key.")
				processGameTurn()
			elif $Critters/"0"/Inventory.checkIfItemInInventoryByName("key"):
				if processManyGameTurnsWithoutPlayerActionsAndWithSafety(2):
					level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
					Globals.gameConsole.addLog("You unlock the door with your key.")
			elif $Critters/"0"/Inventory.checkIfItemInInventoryByName("lockpick"):
				if processManyGameTurnsWithoutPlayerActionsAndWithSafety(3):
					level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
					Globals.gameConsole.addLog("You unlock the door with your lockpick.")
			elif $Critters/"0"/Inventory.checkIfItemInInventoryByName("credit card"):
				if processManyGameTurnsWithoutPlayerActionsAndWithSafety(4):
					level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
					Globals.gameConsole.addLog("You unlock the door with your credit card.")
		if level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable == Globals.interactables.HIDDEN_ITEM:
			if $Critters/"0"/Inventory.checkIfItemInInventoryByName("shovel"):
				Globals.gameConsole.addLog("You dig up the item from the sand.")
				if randi() % 3 == 0:
					$Items/Items.createItem("message in a bottle", _tileToInteractWith)
					Globals.gameConsole.addLog("You discover a message in a bottle!")
				else:
					$Items/Items.createItem($Items/Items.getRandomItem(), _tileToInteractWith)
					Globals.gameConsole.addLog("You discover an item!")
				level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
				processGameTurn()
			else:
				Globals.gameConsole.addLog("You need a shovel to dig up that item.")
		if level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable == Globals.interactables.PLANT:
			if randi() % 5 == 0:
				$Items/Items.createItem("carrot", _tileToInteractWith)
				Globals.gameConsole.addLog("You pick a carrot from the plant.")
				level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
			elif randi() % 5 == 0:
				$Items/Items.createItem("beans", _tileToInteractWith)
				Globals.gameConsole.addLog("You pick beans from the plant.")
				level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
			elif randi() % 16 == 0:
				$Items/Items.createItem("tomato", _tileToInteractWith)
				Globals.gameConsole.addLog("You pick a tomato from the plant.")
				level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
			else:
				level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
				Globals.gameConsole.addLog("The plant is empty.")
			processGameTurn()
		if level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable == Globals.interactables.PLANT_CARROT:
			$Items/Items.createItem("carrot", _tileToInteractWith)
			Globals.gameConsole.addLog("You pick a carrot from the plant.")
			level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
			processGameTurn()
		if level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable == Globals.interactables.PLANT_TOMATO:
			$Items/Items.createItem("tomato", _tileToInteractWith)
			Globals.gameConsole.addLog("You pick a tomato from the plant.")
			level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
			processGameTurn()
		if level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable == Globals.interactables.PLANT_BEAN:
			$Items/Items.createItem("beans", _tileToInteractWith)
			Globals.gameConsole.addLog("You pick beans from the plant.")
			level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
			processGameTurn()
		if level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable == Globals.interactables.PLANT_ORANGE:
			$Items/Items.createItem("orange", _tileToInteractWith)
			Globals.gameConsole.addLog("You pick an orange from the plant.")
			level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = null
			processGameTurn()
	elif level.grid[_tileToInteractWith.x][_tileToInteractWith.y].tile == Globals.tiles.DOOR_CLOSED:
		if level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable == null:
			if $Critters/"0"/Inventory.checkIfItemInInventoryByName("magic key"):
				level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = Globals.interactables.LOCKED
				Globals.gameConsole.addLog("You lock the door with your magic key.")
				processGameTurn()
			elif $Critters/"0"/Inventory.checkIfItemInInventoryByName("key"):
				if processManyGameTurnsWithoutPlayerActionsAndWithSafety(2):
					level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = Globals.interactables.LOCKED
					Globals.gameConsole.addLog("You lock the door with your key.")
			elif $Critters/"0"/Inventory.checkIfItemInInventoryByName("lockpick"):
				if processManyGameTurnsWithoutPlayerActionsAndWithSafety(3):
					level.grid[_tileToInteractWith.x][_tileToInteractWith.y].interactable = Globals.interactables.LOCKED
					Globals.gameConsole.addLog("You lock the door with your lockpick.")
	elif level.grid[_tileToInteractWith.x][_tileToInteractWith.y].tile == Globals.tiles.DOOR_OPEN:
		if level.grid[_tileToInteractWith.x][_tileToInteractWith.y].critter != null:
			Globals.gameConsole.addLog("The {critter} is blocking the door.".format({ "critter": get_node("Critters/{critter}".format({ "critter": level.grid[_tileToInteractWith.x][_tileToInteractWith.y].critter })).critterName }))
		elif !level.grid[_tileToInteractWith.x][_tileToInteractWith.y].items.empty():
			Globals.gameConsole.addLog("There's some items blocking the door.")
		else:
			level.grid[_tileToInteractWith.x][_tileToInteractWith.y].tile = Globals.tiles.DOOR_CLOSED
			level.removePointFromEnemyPathfinding(_tileToInteractWith)
			Globals.gameConsole.addLog("You close the door.")
			processGameTurn()
	else:
		Globals.gameConsole.addLog("There doesn't seem to be anything to interact with there.")
	drawLevel()
	updateTiles()
	resetToDefaulGameState()

func kickAt(_tileToKickAt):
	if level.grid[_tileToKickAt.x][_tileToKickAt.y].tile == Globals.tiles.DOOR_CLOSED:
		if randi () % 20 == 0:
			level.grid[_tileToKickAt.x][_tileToKickAt.y].tile = Globals.tiles.DOOR_OPEN
			level.grid[_tileToKickAt.x][_tileToKickAt.y].interactable = null
			Globals.gameConsole.addLog("CRASH!")
		else:
			Globals.gameConsole.addLog("WHAM!")
	else:
		Globals.gameConsole.addLog("You kick nothing!")
	processGameTurn()
	resetToDefaulGameState()

func castAt(_playerTile, _tileToCastAt):
	currentGameState = gameState.OUT_OF_PLAYERS_HANDS
#	yield($UI/UITheme/Runes.castSpell(_playerTile, _tileToCastAt, level.grid), "completed")
	$UI/UITheme/Runes.castSpell(_playerTile, _tileToCastAt, level.grid)

func processAccept():
	var _playerTile = level.getCritterTile(0)
	var _items = $UI/UITheme/ItemManagement.selectedItems
	
	if currentGameState == gameState.PICK_UP_ITEMS:
		$Critters/"0".pickUpItems(_playerTile, _items, level.grid)
	if currentGameState == gameState.DROP_ITEMS:
		$Critters/"0".dropItems(_playerTile, _items, level.grid)
	
	closeMenu()

func closeMenu(_additionalChoices = false, _pickDirection = false):
	if currentGameState == gameState.ZAP:
		$UI/UITheme/ItemManagement.hideItemManagementList()
		if _pickDirection:
			currentGameState = gameState.ZAP_DIRECTION
			Globals.gameConsole.addLog("Zap at what? (Pick a direction with numpad)")
			return
		resetToDefaulGameState()
	if !_additionalChoices and !_pickDirection:
		if (
			currentGameState == gameState.PICK_UP_ITEMS or
			currentGameState == gameState.DROP_ITEMS or
			currentGameState == gameState.READ or
			currentGameState == gameState.QUAFF or
			currentGameState == gameState.CONSUME or
			currentGameState == gameState.DIP_ITEM or
			currentGameState == gameState.DIP or
			currentGameState == gameState.USE or
			currentGameState == gameState.PICK_LOOTABLE
		):
			$UI/UITheme/ItemManagement.hideItemManagementList()
		if currentGameState == gameState.EQUIPMENT:
			$UI/UITheme/Equipment.hideEquipment()
		if currentGameState == gameState.RUNES:
			$UI/UITheme/Runes.hideRunes()
		if currentGameState == gameState.INVENTORY:
			$Critters/"0"/Inventory.hideInventory()
		if currentGameState == gameState.LOOT:
			$UI/UITheme/Container.hideContainerList()
		$UI/UITheme/ListMenu.hideListMenuList()
		resetToDefaulGameState()

func resetToDefaulGameState():
	$"Critters/0".selectedItem = null
	currentGameState = gameState.GAME
	inGame = true
	keepMoving = false

func saveGame():
	for _item in $Items.get_children():
		if _item.name == "Items":
			continue
		var _itemData = _item.getItemSaveData()
		$Save.saveGameFile("itemSave", _itemData.id, "{saveGameFile}/items".format({ "saveGameFile": saveGameFile }), _itemData)
	for _critter in $Critters.get_children():
		if _critter.name.matchn("Critters"):
			continue
		var _critterData = _critter.getCritterSaveData()
		$Save.saveGameFile("critterSave", _critterData.id, "{saveGameFile}/critters".format({ "saveGameFile": saveGameFile }), _critterData)
	for _level in levels:
		var _data = _level.getLevelSaveData()
		$Save.saveGameFile("levelSave", _data.levelId, "{saveGameFile}/levels".format({ "saveGameFile": saveGameFile }), _data)
	var _fOVData = $FOV.getFOVSaveData()
	$Save.saveGameFile("fOVSave", "fov", "{saveGameFile}".format({ "saveGameFile": saveGameFile }), _fOVData)
	var _gameConsoleData = $UI/UITheme/GameConsole.getGameConsoleSaveData()
	$Save.saveGameFile("gameConsoleSave", "gameConsole", "{saveGameFile}".format({ "saveGameFile": saveGameFile }), _gameConsoleData)
	var _globalsData = Globals.getGlobalsSaveData()
	$Save.saveGameFile("globalsSave", "globals", "{saveGameFile}".format({ "saveGameFile": saveGameFile }), _globalsData)
	var _equipmentData = $UI/UITheme/Equipment.getEquipmentSaveData().merge($UI/UITheme/Runes.getERunesSaveData())
	$Save.saveGameFile("equipmentSave", "equipment", "{saveGameFile}".format({ "saveGameFile": saveGameFile }), _equipmentData)
#	ResourceSaver.save("user://gameData{saveGameNumber}.save".format({ "saveGameNumber": 1 }), get_node("."))



######################################
### Signal and debuggind functions ###
######################################

func _on_Player_Animation_done():
	processGameTurn()
	resetToDefaulGameState()

func _on_Critter_Animation_done():
	pass
#	if $Animations.get_child_count() == 1:
#		resetToDefaulGameState()

func _debug__go_to_level(_level):
	$"/root/World".hide()
	hideObjectsWhenDrawingNextFrame = true
	
	Globals.currentDungeonLevel = _level
	
	var _playerPosition = level.getCritterTile(0)
	level.grid[_playerPosition.x][_playerPosition.y].critter = null
	
	level = get_node("Levels/{level}".format({ "level": Globals.currentDungeonLevel }))
	$FOV.moveLevel(Globals.currentDungeonLevel - 1)
	updateTiles()
	
	var _upStairTile1 = level.getTilePosition(Globals.tiles.UP_STAIR_DUNGEON)
	var _upStairTile2 = level.getTilePosition(Globals.tiles.UP_STAIR_SAND)
	
	Globals.currentDungeonLevelName = level.dungeonLevelName
	if typeof(_upStairTile1) != TYPE_BOOL:
		level.grid[_upStairTile1.x][_upStairTile1.y].critter = 0
	else:
		level.grid[_upStairTile2.x][_upStairTile2.y].critter = 0
	drawLevel()
	$"UI/UITheme/Debug Menu"._on_Hide_pressed()
	$"/root/World".show()

func _exit_tree():
	if thread != null:
		thread.wait_to_finish()
