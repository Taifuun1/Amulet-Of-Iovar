extends TileMap

onready var player = preload("res://Objects/Player/Player.tscn").instance()

onready var critters = preload("res://Objects/Critter/Critters.tscn").instance()
onready var items = preload("res://Objects/Item/Items.tscn").instance()

onready var dungeon1 = preload("res://Random Generators/Dungeon Levels/Dungeon1.tscn")
onready var minesOfTidoh = preload("res://Random Generators/Mines Of Tidoh/MinesOfTidoh.tscn")
onready var tidohMiningOutpost = preload("res://Random Generators/Mines Of Tidoh/TidohMiningOutpost.tscn")
onready var beach = preload("res://Random Generators/Beach/Beach.tscn")
onready var vacationResort = preload("res://Random Generators/Beach/VacationResort.tscn")

var hideObjectsWhenDrawingNextFrame = true
var checkNewCritterSpawn = 0

enum gameState {
	OUT_OF_PLAYERS_HANDS
	GAME
	INVENTORY
	PICK_UP_ITEMS
	DROP_ITEMS
	READ
	QUAFF
	CONSUME
	EQUIPMENT
	INTERACT
	ZAP
	USE
	KICK
}

var level = null
var levels = {
	"firstLevel": null,
	"dungeon1": [],
	"minesOfTidoh": [],
	"dungeon2": [],
	"beach": []
#	"dungeon3": [],
#	"library": [],
#	"dungeon4": [],
#	"banditWarcamp": [],
#
#	"arena": [],
#	"fortress": [],
#	"theGreatShadows": [],
#	"halls1": [],
#	"halls2": [],
#	"dragonsPeak": [],
#	"halls3": []
}

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2


var thread
var inStartScreen = true
var inGame = false
var currentGameState = gameState.GAME
var keepMoving = false

func _ready():
	set_process(true)
	
	randomize()
	
	items.create()
	$Items.add_child(items)
	
	critters.create()
	$Critters.add_child(critters)
	
	$UI/UITheme/GameConsole.create()
	$UI/UITheme/ItemManagement.create()
	$UI/UITheme/Equipment.create()
	$UI/UITheme/ListMenu.create()
	for _node in $UI/UITheme.get_children():
		_node.hide()
	$UI/UITheme/StartScreen.show()
	
	# Dungeon 1
	var firstLevel = dungeon1.instance()
	firstLevel.create("dungeon1", "Dungeon hallways 1", 10000)
	levels.firstLevel = firstLevel
	$Levels.add_child(firstLevel)
	for _level in range(2):
		var newDungeon = dungeon1.instance()
		newDungeon.create("dungeon1", "Dungeon hallways {level}".format({ "level": 1 + levels.dungeon1.size() + 1 }), 10000)
		levels.dungeon1.append(newDungeon)
		$Levels.add_child(newDungeon)
	# Mines of Tidoh
	for _level in range(3):
		var newCave = minesOfTidoh.instance()
		newCave.create("minesOfTidoh", "Mines of tidoh {level}".format({ "level": levels.minesOfTidoh.size() + 1 }), 2)
		levels.minesOfTidoh.append(newCave)
		$Levels.add_child(newCave)
	var newMiningOutpost = tidohMiningOutpost.instance()
	newMiningOutpost.create("minesOfTidoh", "Tidoh mining outpost", 5)
	levels.minesOfTidoh.append(newMiningOutpost)
	$Levels.add_child(newMiningOutpost)
	for _level in range(3):
		var newCave = minesOfTidoh.instance()
		newCave.create("minesOfTidoh", "Mines of Tidoh {level}".format({ "level": levels.minesOfTidoh.size() + 1 }), 1)
		levels.minesOfTidoh.append(newCave)
		$Levels.add_child(newCave)
	# Dungeon 2
	for _level in range(3):
		var newDungeon = dungeon1.instance()
		newDungeon.create("dungeon1", "Dungeon hallways {level}".format({ "level": 1 + levels.dungeon1.size() + levels.dungeon2.size() + 1 }), 10000)
		levels.dungeon2.append(newDungeon)
		$Levels.add_child(newDungeon)
	# Beach
	var newBeach = beach.instance()
	newBeach.create("beach", "Beach {level}".format({ "level": levels.beach.size() + 1 }), 10000)
	levels.beach.append(newBeach)
	$Levels.add_child(newBeach)
	var newVacationResort = vacationResort.instance()
	newVacationResort.create("beach", "Vacation resort", 10000)
	levels.beach.append(newVacationResort)
	$Levels.add_child(newVacationResort)
	for _level in range(3):
		var newBeach2 = beach.instance()
		newBeach2.create("beach", "Beach {level}".format({ "level": levels.beach.size() }), 10000)
		levels.beach.append(newBeach2)
		$Levels.add_child(newBeach2)
	
	var levelCount = 0
	for section in levels:
		if typeof(levels[section]) != TYPE_ARRAY:
			levelCount += 1
		else:
			levelCount += levels[section].size()
	$FOV.createFOVLevels(levelCount)

func _on_Game_Start():
	thread = Thread.new()
	thread.start(self, "create", null, Thread.PRIORITY_HIGH)

func create():
	level = get_node("Levels/{level}".format({ "level": levels.firstLevel })).createNewLevel()
	for _level in range(levels.dungeon1.size()):
		if levels.dungeon1[_level] == levels.dungeon1.back():
			get_node("Levels/{level}".format({ "level": levels.dungeon1[_level] })).createNewLevel(true)
		else:
			get_node("Levels/{level}".format({ "level": levels.dungeon1[_level] })).createNewLevel()
	for _level in levels.minesOfTidoh:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	for _level in levels.dungeon2:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	for _level in levels.beach:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel()
	
	$Critters.add_child(player, true)
	player.create("mercenary")
	level.placeCritterOnTypeOfTile(Globals.tiles.UP_STAIR_DUNGEON, 0)
	player.calculateEquipmentStats()
	
	$Items/Items.randomizeRandomItems()
	
	for _level in $Levels.get_children():
		$Items/Items.generateItemsForLevel(_level)
	
	for _level in $Levels.get_children():
		$Critters/Critters.generateCrittersForLevel(_level)
	
	var newItem = load("res://Objects/Item/Item.tscn").instance()
	newItem.createItem($"/root/World/Items/Items".getItemByName("scroll of identify"), { "alignment": "blessed" })
	$"/root/World/Items".add_child(newItem, true)
	$Critters/"0"/Inventory.addToInventory(newItem)
	
	var newItem2 = load("res://Objects/Item/Item.tscn").instance()
	newItem2.createItem($"/root/World/Items/Items".getItemByName("blindfold"), { "alignment": "blessed" })
	$"/root/World/Items".add_child(newItem2, true)
	$Critters/"0"/Inventory.addToInventory(newItem2)
	
	var newItem5 = load("res://Objects/Item/Item.tscn").instance()
	newItem5.createItem($"/root/World/Items/Items".getItemByName("scroll of genocide"), { "alignment": "blessed" })
	$"/root/World/Items".add_child(newItem5, true)
	$Critters/"0"/Inventory.addToInventory(newItem5)
	
	var newItem6 = load("res://Objects/Item/Item.tscn").instance()
	newItem6.createItem($"/root/World/Items/Items".getItemByName("scroll of genocide"), { "alignment": "uncursed" })
	$"/root/World/Items".add_child(newItem6, true)
	$Critters/"0"/Inventory.addToInventory(newItem6)
	
	var newItem13 = load("res://Objects/Item/Item.tscn").instance()
	newItem13.createItem($"/root/World/Items/Items".getItemByName("scroll of genocide"), { "alignment": "cursed" })
	$"/root/World/Items".add_child(newItem13, true)
	$Critters/"0"/Inventory.addToInventory(newItem13)
	
	var newItem3 = load("res://Objects/Item/Item.tscn").instance()
	newItem3.createItem($"/root/World/Items/Items".getItemByName("ring of protection"), { "alignment": "uncursed" })
	$"/root/World/Items".add_child(newItem3, true)
	$Critters/"0"/Inventory.addToInventory(newItem3)
	
	var newItem333 = load("res://Objects/Item/Item.tscn").instance()
	newItem333.createItem($"/root/World/Items/Items".getItemByName("oil lamp"), { "alignment": "uncursed" })
	$"/root/World/Items".add_child(newItem333, true)
	$Critters/"0"/Inventory.addToInventory(newItem333)
	
	var newItem33 = load("res://Objects/Item/Item.tscn").instance()
	newItem33.createItem($"/root/World/Items/Items".getItemByName("key"), { "alignment": "uncursed" })
	$"/root/World/Items".add_child(newItem33, true)
	$Critters/"0"/Inventory.addToInventory(newItem33)
	
	var newItem16 = load("res://Objects/Item/Item.tscn").instance()
	newItem16.createItem($"/root/World/Items/Items".getItemByName("scroll of summon critter"), { "alignment": "cursed" })
	$"/root/World/Items".add_child(newItem16, true)
	$Critters/"0"/Inventory.addToInventory(newItem16)
	
	var newItem156 = load("res://Objects/Item/Item.tscn").instance()
	newItem156.createItem($"/root/World/Items/Items".getItemByName("wand of summon critter"), { "alignment": "uncursed" })
	$"/root/World/Items".add_child(newItem156, true)
	$Critters/"0"/Inventory.addToInventory(newItem156)
	
	var newItem4 = load("res://Objects/Item/Item.tscn").instance()
	newItem4.createItem($"/root/World/Items/Items".getItemByName("scroll of teleport"), { "alignment": "uncursed" })
	$"/root/World/Items".add_child(newItem4, true)
	$Critters/"0"/Inventory.addToInventory(newItem4)
	
	var newItem4321 = load("res://Objects/Item/Item.tscn").instance()
	newItem4321.createItem($"/root/World/Items/Items".getItemByName("scroll of teleport"), { "alignment": "uncursed" })
	$"/root/World/Items".add_child(newItem4321, true)
	$Critters/"0"/Inventory.addToInventory(newItem4321)
	
	var newItem412 = load("res://Objects/Item/Item.tscn").instance()
	newItem412.createItem($"/root/World/Items/Items".getItemByName("scroll of teleport"), { "alignment": "cursed" })
	$"/root/World/Items".add_child(newItem412, true)
	$Critters/"0"/Inventory.addToInventory(newItem412)
	
	var newItem411 = load("res://Objects/Item/Item.tscn").instance()
	newItem411.createItem($"/root/World/Items/Items".getItemByName("scroll of teleport"), { "alignment": "cursed" })
	$"/root/World/Items".add_child(newItem411, true)
	$Critters/"0"/Inventory.addToInventory(newItem411)
	
	var newItem10 = load("res://Objects/Item/Item.tscn").instance()
	newItem10.createItem($"/root/World/Items/Items".getItemByName("dwarvish laysword"), { "alignment": "uncursed" })
	$"/root/World/Items".add_child(newItem10, true)
	$Critters/"0"/Inventory.addToInventory(newItem10)
	
	updateTiles()
	drawLevel()
	
	for _node in $UI/UITheme.get_children():
		if _node.name == "GameConsole":
			_node.show()
		if _node.name == "GameStats":
			_node.show()
	$UI/UITheme/StartScreen.hide()
	
	$Critters/"0".processPlayerSpecificEffects()
	
	inStartScreen = false
	inGame = true
	
	show()

func _process(_delta):
	if inGame and $Critters/"0".statusEffects["stun"] > 0:
		processGameTurn()

func _input(_event):
	if !inStartScreen:
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
			currentGameState == gameState.GAME and
			inGame
		):
			var _openTiles = level.checkAdjacentTilesForOpenSpace(_playerTile)
			var _tileToMoveTo
			if $Critters/"0".statusEffects["confusion"] > 0 and randi() % 3 == 0:
				var _randomOpenTiles = _openTiles.duplicate(true)
				_randomOpenTiles.shuffle()
				_tileToMoveTo = _randomOpenTiles[0]
			else:
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
			for _openTile in _openTiles:
				if _openTile == _tileToMoveTo:
					if keepMoving and $Critters/"0".statusEffects["confusion"] == 0 and _tileToMoveTo != null:
						keepMovingLoop(_playerTile, _tileToMoveTo)
					else:
						processGameTurn(_playerTile, _tileToMoveTo)
					break
		elif (
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
			currentGameState == gameState.INTERACT and
			inGame
		):
			var _tileToInteractWith
			if Input.is_action_just_pressed("MOVE_UP"):
				_tileToInteractWith = Vector2(_playerTile.x, _playerTile.y - 1)
			elif Input.is_action_just_pressed("MOVE_UP_RIGHT"):
				_tileToInteractWith = Vector2(_playerTile.x + 1, _playerTile.y - 1)
			elif Input.is_action_just_pressed("MOVE_RIGHT"):
				_tileToInteractWith = Vector2(_playerTile.x + 1, _playerTile.y)
			elif Input.is_action_just_pressed("MOVE_DOWN_RIGHT"):
				_tileToInteractWith = Vector2(_playerTile.x + 1, _playerTile.y + 1)
			elif Input.is_action_just_pressed("MOVE_DOWN"):
				_tileToInteractWith = Vector2(_playerTile.x, _playerTile.y + 1)
			elif Input.is_action_just_pressed("MOVE_DOWN_LEFT"):
				_tileToInteractWith = Vector2(_playerTile.x - 1, _playerTile.y + 1)
			elif Input.is_action_just_pressed("MOVE_LEFT"):
				_tileToInteractWith = Vector2(_playerTile.x - 1, _playerTile.y)
			elif Input.is_action_just_pressed("MOVE_UP_LEFT"):
				_tileToInteractWith = Vector2(_playerTile.x - 1, _playerTile.y - 1)
			interactWith(_tileToInteractWith)
		elif (
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
			currentGameState == gameState.KICK and
			inGame
		):
			var _tileToInteractWith
			if Input.is_action_just_pressed("MOVE_UP"):
				_tileToInteractWith = Vector2(_playerTile.x, _playerTile.y - 1)
			elif Input.is_action_just_pressed("MOVE_UP_RIGHT"):
				_tileToInteractWith = Vector2(_playerTile.x + 1, _playerTile.y - 1)
			elif Input.is_action_just_pressed("MOVE_RIGHT"):
				_tileToInteractWith = Vector2(_playerTile.x + 1, _playerTile.y)
			elif Input.is_action_just_pressed("MOVE_DOWN_RIGHT"):
				_tileToInteractWith = Vector2(_playerTile.x + 1, _playerTile.y + 1)
			elif Input.is_action_just_pressed("MOVE_DOWN"):
				_tileToInteractWith = Vector2(_playerTile.x, _playerTile.y + 1)
			elif Input.is_action_just_pressed("MOVE_DOWN_LEFT"):
				_tileToInteractWith = Vector2(_playerTile.x - 1, _playerTile.y + 1)
			elif Input.is_action_just_pressed("MOVE_LEFT"):
				_tileToInteractWith = Vector2(_playerTile.x - 1, _playerTile.y)
			elif Input.is_action_just_pressed("MOVE_UP_LEFT"):
				_tileToInteractWith = Vector2(_playerTile.x - 1, _playerTile.y - 1)
			kickAt(_tileToInteractWith)
		elif (
			Input.is_action_just_pressed("WAIT") and
			currentGameState == gameState.GAME and
			inGame
		):
			processGameTurn(_playerTile)
		elif (
			Input.is_action_just_pressed("ASCEND") and
			(
				level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.UP_STAIR_DUNGEON or
				level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.UP_STAIR_SAND
			) and
			Globals.currentDungeonLevel > 1 and
			currentGameState == gameState.GAME and
			inGame
		):
			moveLevel(-1)
		elif (
			Input.is_action_just_pressed("DESCEND") and
			(
				level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.DOWN_STAIR_DUNGEON or
				level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.DOWN_STAIR_SAND
			) and
			levels.minesOfTidoh.back().levelId != Globals.currentDungeonLevel and
			levels.beach.back().levelId != Globals.currentDungeonLevel and
			currentGameState == gameState.GAME and
			inGame
		):
			moveLevel(1)
		elif Input.is_action_just_pressed("ACCEPT") and currentGameState != gameState.OUT_OF_PLAYERS_HANDS and currentGameState != gameState.GAME and !inGame:
			processGameTurn(_playerTile)
		elif (Input.is_action_just_pressed("BACK")):
			closeMenu()
		elif (Input.is_action_just_pressed("INVENTORY") and currentGameState == gameState.GAME and inGame):
			openMenu("inventory")
		elif (Input.is_action_just_pressed("PICK_UP") and currentGameState == gameState.GAME and inGame):
			openMenu("pick up", _playerTile)
		elif (Input.is_action_just_pressed("DROP") and currentGameState == gameState.GAME and inGame):
			openMenu("drop")
		elif (Input.is_action_just_pressed("EQUIPMENT") and currentGameState == gameState.GAME and inGame):
			openMenu("equipment")
		elif (Input.is_action_just_pressed("READ") and currentGameState == gameState.GAME and inGame):
			openMenu("read")
		elif (Input.is_action_just_pressed("QUAFF") and currentGameState == gameState.GAME and inGame):
			openMenu("quaff")
		elif (Input.is_action_just_pressed("CONSUME") and currentGameState == gameState.GAME and inGame):
			openMenu("consume")
		elif (Input.is_action_just_pressed("ZAP") and currentGameState == gameState.GAME and inGame):
			openMenu("zap")
		elif Input.is_action_just_pressed("INTERACT") and currentGameState == gameState.GAME and inGame:
			currentGameState = gameState.INTERACT
			Globals.gameConsole.addLog("Interact with what? (Pick a direction with numpad)")
		elif Input.is_action_just_pressed("MOVE_TO_LEVEL") and currentGameState == gameState.GAME and inGame:
			$"UI/UITheme/Debug Menu".show()
		elif Input.is_action_just_pressed("USE") and currentGameState == gameState.GAME and inGame:
			openMenu("use")
		elif Input.is_action_just_pressed("KICK") and currentGameState == gameState.GAME and inGame:
			currentGameState = gameState.KICK
			Globals.gameConsole.addLog("Kick at what? (Pick a direction with numpad)")
		elif Input.is_action_just_pressed("KEEP_MOVING") and currentGameState == gameState.GAME and inGame:
			keepMoving = true
		
		updateUI()

func processGameTurn(_playerTile = null, _tileToMoveTo = null):
	if _playerTile != null:
		processManyGameTurnsWithoutPlayerActionsAndWithoutSafety()
		processPlayerAction(_playerTile, _tileToMoveTo)
	processPlayerEffects()
	processEnemyActions()
	processCrittersSpawnStatus()
	drawLevel()
	updateTiles()

func processManyGameTurnsWithoutPlayerActionsAndWithoutSafety():
	for _turn in $Critters/"0".turnsUntilAction:
		processPlayerEffects()
		processEnemyActions()
		processCrittersSpawnStatus()
		drawLevel()
		updateTiles()

func processManyGameTurnsWithoutPlayerActionsAndWithSafety(_turnAmount = 1):
	for _turn in _turnAmount:
		processPlayerEffects()
		var _isPlayerHit = processEnemyActions()
		processCrittersSpawnStatus()
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
		) and
		(
			level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.EMPTY and
			level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.WALL_DUNGEON and
			level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.WALL_SAND and
			level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.WALL_BRICK_SAND and
			level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.WALL_BOARD
		) and
		inGame
	):
		$"Critters/0".processPlayerAction(_playerTile, _tileToMoveTo, $Items/Items, level)
	elif (Input.is_action_pressed("ACCEPT") and !inGame):
		processAccept()

func processEnemyActions():
	var _playerTile = level.getCritterTile(0)
	var _isPlayerHit = false
	if level.critters.size() != 0:
		for _enemy in level.critters:
			var _critterTile = level.getCritterTile(_enemy)
			if get_node("Critters/{id}".format({ "id": _enemy })).processCritterAction(_critterTile, _playerTile, _enemy, level):
				_isPlayerHit = true
			get_node("Critters/{id}".format({ "id": _enemy })).processCritterEffects()
	return _isPlayerHit

func processCrittersSpawnStatus():
	if checkNewCritterSpawn >= 30:
		$Critters/Critters.checkSpawnableCrittersLevel()
		$Critters/Critters.checkNewCritterSpawn(level)
		checkNewCritterSpawn = 0
	else:
		checkNewCritterSpawn += 1

func processPlayerEffects():
	$"/root/World/Critters/0".processCritterEffects()
	$"/root/World/Critters/0".processPlayerSpecificEffects()

func updateTiles():
	for x in (level.grid.size()):
		for y in (level.grid[x].size()):
			set_cellv(Vector2(x, y), level.grid[x][y].tile)
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
	for _x in range(Globals.gridSize.x):
		for _y in range(Globals.gridSize.y):
			var x_dir = 1 if _x < playerTile.x else -1
			var y_dir = 1 if _y < playerTile.y else -1
			var testPoint = Vector2((_x + 0.5) * 32, (_y + 0.5) * 32) + Vector2(x_dir, y_dir) * 32 / 2
			var occlusion = spaceState.intersect_ray(playerCenter, testPoint)
			if (
				_playerNode.playerVisibility == 0 and
				playerTile == Vector2(_x, _y)
			):
				$FOV.greyCell(_x, _y)
			elif (
				(
					_playerNode.playerVisibility != 0 and
					(
						!occlusion or
						(occlusion.position - testPoint).length() < 1
					) and
					(
						(playerCenter - testPoint).length() < level.visibility * 32 or
						(
							(playerCenter - testPoint).length() < _playerNode.playerVisibility * 32 and
							_playerNode.playerVisibility != -1
						)
					)
				)
			):
				$FOV.seeCell(_x, _y)
			elif (
				$FOV.currentFOVLevel[_x][_y] == -1 and
				level.grid[_x][_y].tile != Globals.tiles.EMPTY and
				(
					occlusion or
					(playerCenter - testPoint).length() > level.visibility * 32 or
					(playerCenter - testPoint).length() > _playerNode.playerVisibility * 32
				)
			):
				$FOV.greyCell(_x, _y)

func drawCrittersAndItems():
	# Critters, items and Globals.tiles
	for x in (Globals.gridSize.x):
		for y in (Globals.gridSize.y):
			if level.grid[x][y].critter != null:
				if $FOV.currentFOVLevel[x][y] == -1 or level.grid[x][y].critter == 0:
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
			(
				level.grid[_nextTile.x][_nextTile.y].tile != Globals.tiles.EMPTY and
				level.grid[_nextTile.x][_nextTile.y].tile != Globals.tiles.WALL_DUNGEON and
				level.grid[_nextTile.x][_nextTile.y].tile != Globals.tiles.WALL_SAND and
				level.grid[_nextTile.x][_nextTile.y].tile != Globals.tiles.WALL_BRICK_SAND and
				level.grid[_nextTile.x][_nextTile.y].tile != Globals.tiles.WALL_BOARD and
				level.grid[_nextTile.x][_nextTile.y].tile != Globals.tiles.DOOR_CLOSED and
				level.grid[_nextTile.x][_nextTile.y].tile != Globals.tiles.DOOR_OPEN
			) and
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
			) and
			inGame
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
	
	var _placePlayerOnStair = whichLevelAndStairIsPlayerPlacedUpon(_direction)
	
	level = get_node("Levels/{level}".format({ "level": Globals.currentDungeonLevel }))
	$FOV.moveLevel(Globals.currentDungeonLevel - 1)
	updateTiles()
	Globals.currentDungeonLevelName = level.dungeonLevelName
	level.grid[level.stairs[_placePlayerOnStair].x][level.stairs[_placePlayerOnStair].y].critter = 0
	drawLevel()
	$"/root/World".show()

func goToLevel(_tile, _level):
	$"/root/World".hide()
	hideObjectsWhenDrawingNextFrame = true
	
	Globals.currentDungeonLevel = _level.levelId
	
	level = get_node("Levels/{level}".format({ "level": Globals.currentDungeonLevel }))
	$FOV.moveLevel(Globals.currentDungeonLevel - 1)
	updateTiles()
	Globals.currentDungeonLevelName = level.dungeonLevelName
	level.grid[_tile.x][_tile.y].critter = 0
	drawLevel()
	$"/root/World".show()

func whichStairIsPlayerOn():
	var _playerTile = level.getCritterTile(0)
	for stair in level.stairs.keys():
		if level.stairs[stair] == _playerTile:
			return stair
	return false

func whichLevelAndStairIsPlayerPlacedUpon(_direction):
	var _stair = whichStairIsPlayerOn()
	if _direction == 1:
		if levels.dungeon1.back().levelId == Globals.currentDungeonLevel:
			if _stair.matchn("secondDownStair"):
				Globals.currentDungeonLevel = levels.minesOfTidoh.front().levelId
				return "upStair"
			if _stair.matchn("downStair"):
				Globals.currentDungeonLevel = levels.dungeon2.front().levelId
				return "upStair"
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
		else:
			Globals.currentDungeonLevel += _direction
			return "downStair"

func openMenu(_menu, _playerTile = null):
	match _menu:
		"inventory":
			if currentGameState == gameState.GAME:
				$Critters/"0"/Inventory.showInventory()
				currentGameState = gameState.INVENTORY
				inGame = false
		"pick up":
			if level.grid[_playerTile.x][_playerTile.y].items.size() == 1 and currentGameState == gameState.GAME:
				$Critters/"0".pickUpItems(_playerTile, level.grid[_playerTile.x][_playerTile.y].items, level.grid)
				$"/root/World".processGameTurn()
			elif level.grid[_playerTile.x][_playerTile.y].items.size() != 0 and currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = level.grid[_playerTile.x][_playerTile.y].items
				$UI/UITheme/ItemManagement.showItemManagementList()
				currentGameState = gameState.PICK_UP_ITEMS
				inGame = false
		"drop":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.inventory
				$UI/UITheme/ItemManagement.showItemManagementList()
				currentGameState = gameState.DROP_ITEMS
				inGame = false
		"equipment":
			if currentGameState == gameState.GAME:
				$UI/UITheme/Equipment.showEquipment($Critters/"0"/Inventory.getItemsOfType(["weapon", "accessory", "armor"]))
				currentGameState = gameState.EQUIPMENT     
				inGame = false
		"read":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["scroll"])
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.READ
				inGame = false
		"quaff":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["potion"])
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.QUAFF
				inGame = false
		"consume":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["comestible"])
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.CONSUME
				inGame = false
		"zap":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["wand"])
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.ZAP
				inGame = false
		"use":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["tool"])
				$UI/UITheme/ItemManagement.showItemManagementList(true)
				currentGameState = gameState.USE
				inGame = false

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
					$Items/Items.createItem($Items/Items.returnRandomItem(), _tileToInteractWith)
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
	resetToDefaulGameState()
	processGameTurn()

func processAccept():
	var _playerTile = level.getCritterTile(0)
	var _items = $UI/UITheme/ItemManagement.selectedItems
	
	if currentGameState == gameState.PICK_UP_ITEMS:
		$Critters/"0".pickUpItems(_playerTile, _items, level.grid)
	if currentGameState == gameState.DROP_ITEMS:
		$Critters/"0".dropItems(_playerTile, _items, level.grid)
	
	closeMenu()

func closeMenu(_additionalChoices = false):
	if !_additionalChoices:
		if (
			currentGameState == gameState.PICK_UP_ITEMS or
			currentGameState == gameState.DROP_ITEMS or
			currentGameState == gameState.READ or
			currentGameState == gameState.QUAFF or
			currentGameState == gameState.CONSUME or
			currentGameState == gameState.ZAP or
			currentGameState == gameState.USE
		):
			$UI/UITheme/ItemManagement.hideItemManagementList()
		if currentGameState == gameState.EQUIPMENT:
			$UI/UITheme/Equipment.hideEquipment()
		if currentGameState == gameState.INVENTORY:
			$Critters/"0"/Inventory.hideInventory()
		$UI/UITheme/ListMenu.hideListMenuList()
		resetToDefaulGameState()
	else:
		pass

func resetToDefaulGameState():
		currentGameState = gameState.GAME
		inGame = true
		keepMoving = false

func _debug__go_to_level(_level):
	$"/root/World".hide()
	hideObjectsWhenDrawingNextFrame = true
	
	Globals.currentDungeonLevel = _level
	
	level = get_node("Levels/{level}".format({ "level": Globals.currentDungeonLevel }))
	$FOV.moveLevel(Globals.currentDungeonLevel - 1)
	updateTiles()
	
	var _upStairTile1 = level.getTilePosition(Globals.tiles.UP_STAIR_DUNGEON)
	var _upStairTile2 = level.getTilePosition(Globals.tiles.UP_STAIR_SAND)
	Globals.currentDungeonLevelName = level.dungeonLevelName
	if !typeof(_upStairTile1) == TYPE_BOOL:
		level.grid[_upStairTile1.x][_upStairTile1.y].critter = 0
	else:
		level.grid[_upStairTile2.x][_upStairTile2.y].critter = 0
	drawLevel()
	$"UI/Debug Menu".hide()
	$"/root/World".show()

func _exit_tree():
	print("exited")
	thread.wait_to_finish()
