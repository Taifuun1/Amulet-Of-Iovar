extends TileMap

onready var player = preload("res://Objects/Player/Player.tscn").instance()

onready var critters = preload("res://Objects/Critter/Critters.tscn").instance()
onready var items = preload("res://Objects/Item/Items.tscn").instance()

onready var dungeon1 = preload("res://Random Generators/Dungeon Levels/Dungeon1.tscn")
onready var minesOfTidoh = preload("res://Random Generators/Mines Of Tidoh/MinesOfTidoh.tscn")
onready var tidohMiningOutpost = preload("res://Random Generators/Mines Of Tidoh/TidohMiningOutpost.tscn")

var updateObjects = true
var checkNewCritterSpawn = 0

enum uI {
	GAME
	INVENTORY
	PICK_UP_ITEMS
	DROP_ITEMS
	READ
	QUAFF
	EQUIPMENT
}

var level = null
var levels = {
	"firstLevel": null,
	"dungeon1": [],
	"minesOfTidoh": [],
	"dungeon2": [],
	"beach": [],
	"dungeon3": [],
	"library": [],
	"dungeon4": [],
	"banditWarcamp": [],
	
	"arena": [],
	"fortress": [],
	"theGreatShadows": [],
	"halls1": [],
	"halls2": [],
	"halls3": []
}

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

var keepMoving = false

var inStartScreen = true
var inGame = false
var uIState = uI.GAME
var direction = null

func _ready():
	randomize()
	
	items.create()
	$Items.add_child(items)
	
	critters.create()
	$Critters.add_child(critters)
	
	$UI/GameConsole.create()
	$UI/ItemManagement.create()
	$UI/Equipment.create()
	$UI/PopupMenu.create()
	
	# Dungeon 1
	var firstLevel = dungeon1.instance()
	firstLevel.setName("dungeon1")
	levels.firstLevel = firstLevel
	$Levels.add_child(firstLevel)
	for _level in range(2):
		var newDungeon = dungeon1.instance()
		newDungeon.setName("dungeon1")
		levels.dungeon1.append(newDungeon)
		$Levels.add_child(newDungeon)
	# Mines of Tidoh
	for _level in range(3):
		var newCave = minesOfTidoh.instance()
		newCave.setName("minesOfTidoh")
		levels.minesOfTidoh.append(newCave)
		$Levels.add_child(newCave)
	var newMiningOutpost = tidohMiningOutpost.instance()
	newMiningOutpost.setName("minesOfTidoh")
	levels.minesOfTidoh.append(newMiningOutpost)
	$Levels.add_child(newMiningOutpost)
	for _level in range(3):
		var newCave = minesOfTidoh.instance()
		newCave.setName("minesOfTidoh")
		levels.minesOfTidoh.append(newCave)
		$Levels.add_child(newCave)
	# Dungeon 2
	for _level in range(3):
		var newDungeon = dungeon1.instance()
		newDungeon.setName("dungeon1")
		levels.dungeon2.append(newDungeon)
		$Levels.add_child(newDungeon)
	
	var levelCount = 0
	for section in levels:
		if typeof(levels[section]) != TYPE_ARRAY:
			levelCount += 1
		else:
			levelCount += levels[section].size()
	$FOV.createFOVLevels(levelCount)

func _input(_event):
	if (Input.is_action_just_pressed("START") and level == null):
		create()
		yield(get_tree().create_timer(0.1), "timeout")
		drawLevel()
	if !inStartScreen:
		var _playerTile = level.getCritterTile(0)
		if (
			Input.is_action_just_pressed("MOVE_UP") or
			Input.is_action_just_pressed("MOVE_UP_RIGHT") or
			Input.is_action_just_pressed("MOVE_RIGHT") or
			Input.is_action_just_pressed("MOVE_DOWN_RIGHT") or
			Input.is_action_just_pressed("MOVE_DOWN") or
			Input.is_action_just_pressed("MOVE_DOWN_LEFT") or
			Input.is_action_just_pressed("MOVE_LEFT") or
			Input.is_action_just_pressed("MOVE_UP_LEFT")
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
			if keepMoving and _tileToMoveTo != null:
				keepMovingLoop(_playerTile, _tileToMoveTo)
			else:
				processGameTurn(_playerTile, _tileToMoveTo)
		elif (
			Input.is_action_just_pressed("ASCEND") and
			level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.UP_STAIR and
			Globals.currentDungeonLevel > 1 and
			inGame
		):
			$"/root/World".hide()
			var stair = moveLevel(-1)
			updateTiles()
			if stair == null:
				level.placeCritter(Globals.tiles.DOWN_STAIR, 0)
			else:
				level.grid[stair.x][stair.y].critter = 0
			yield(get_tree().create_timer(0.1), "timeout")
			drawLevel()
			$"/root/World".show()
		elif (
			Input.is_action_just_pressed("DESCEND") and
			level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.DOWN_STAIR and
			Globals.currentDungeonLevel < 13 and
			levels.minesOfTidoh.back().levelId != Globals.currentDungeonLevel and
			inGame
		):
			$"/root/World".hide()
			var stair = moveLevel(1)
			updateTiles()
			if stair == null:
				level.placeCritter(Globals.tiles.UP_STAIR, 0)
			else:
				level.grid[stair.x][stair.y].critter = 0
			yield(get_tree().create_timer(0.1), "timeout")
			drawLevel()
			$"/root/World".show()
		elif Input.is_action_just_pressed("ACCEPT"):
			processGameTurn(_playerTile)
		elif (Input.is_action_just_pressed("BACK")):
			closeMenu()
		elif (Input.is_action_just_pressed("INVENTORY") and inGame):
			openMenu("inventory")
		elif (Input.is_action_just_pressed("PICK_UP") and inGame):
			openMenu("pick up", _playerTile)
		elif (Input.is_action_just_pressed("DROP") and inGame):
			openMenu("drop")
		elif (Input.is_action_just_pressed("EQUIPMENT") and inGame):
			openMenu("equipment")
		elif (Input.is_action_just_pressed("READ") and inGame):
			openMenu("read")
		elif (Input.is_action_just_pressed("QUAFF") and inGame):
			openMenu("quaff")
		elif Input.is_action_just_pressed("KEEP_MOVING") and inGame:
			keepMoving = true
		$"Critters/0".updatePlayerStats(Globals.currentDungeonLevel)

func processGameTurn(_playerTile = null, _tileToMoveTo = null):
	if _playerTile != null:
		processPlayerAction(_playerTile, _tileToMoveTo)
	processEnemyActions()
	processCrittersStatus()
	drawLevel()

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
			level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.WALL
		) and
		inGame
	):
		$"Critters/0".processPlayerAction(_playerTile, _tileToMoveTo, $Items/Items, level)
	elif (Input.is_action_pressed("ACCEPT") and !inGame):
		processAccept()

func processEnemyActions():
	var _playerTile = level.getCritterTile(0)
	if level.critters.size() != 0:
		for _enemy in level.critters:
			var _critterTile = level.getCritterTile(_enemy)
			get_node("Critters/{id}".format({ "id": _enemy })).processCritterAction(_critterTile, _playerTile, _enemy, level)

func processCrittersStatus():
	processStatsAndEffects()
	if checkNewCritterSpawn >= 30:
		$Critters/Critters.checkSpawnableCrittersLevel()
		$Critters/Critters.checkNewCritterSpawn(level)
		checkNewCritterSpawn = 0
	else:
		checkNewCritterSpawn += 1

func processStatsAndEffects():
	$"/root/World/Critters/0".processEffects()
	if level.critters.size() != 0:
		for _enemy in level.critters:
			get_node("Critters/{id}".format({ "id": _enemy })).processEffects()

func drawLevel():
	if updateObjects:
		for _critter in $Critters.get_children():
			_critter.hide()
		
		for _item in $Items.get_children():
			_item.hide()
		updateObjects = false
	
	drawFOV()
	drawCrittersAndItems()

func drawFOV():
	# FOV
	var playerTile = level.getCritterTile(0)
	var playerCenter = Vector2((playerTile.x + 0.5) * 32, (playerTile.y + 0.5) * 32)
	var spaceState = get_world_2d().get_direct_space_state()
	for _x in range(Globals.gridSize.x):
		for _y in range(Globals.gridSize.y):
			var x_dir = 1 if _x < playerTile.x else -1
			var y_dir = 1 if _y < playerTile.y else -1
			var testPoint = Vector2((_x + 0.5) * 32, (_y + 0.5) * 32) + Vector2(x_dir, y_dir) * 32 / 2
			var occlusion = spaceState.intersect_ray(playerCenter, testPoint)
			if !occlusion || (occlusion.position - testPoint).length() < 1:
				$FOV.seeCell(_x, _y)
			elif occlusion and $FOV.currentFOVLevel[_x][_y] == -1 and level.grid[_x][_y].tile != Globals.tiles.EMPTY:
				$FOV.greyCell(_x, _y)

func drawCrittersAndItems():
	# Critters, items and Globals.tiles
	for x in (Globals.gridSize.x):
		for y in (Globals.gridSize.y):
			if level.grid[x][y].critter != null:
				if $FOV.currentFOVLevel[x][y] == -1:
					get_node("Critters/{id}".format({ "id": level.grid[x][y].critter })).set_position(map_to_world(Vector2(x, y)) + half_tile_size)
					get_node("Critters/{id}".format({ "id": level.grid[x][y].critter })).show()
				else:
					get_node("Critters/{id}".format({ "id": level.grid[x][y].critter })).hide()
			if level.grid[x][y].items.size() != 0:
				get_node("Items/{id}".format({ "id": level.grid[x][y].items.back() })).set_position(map_to_world(Vector2(x, y)) + half_tile_size)
				get_node("Items/{id}".format({ "id": level.grid[x][y].items.back() })).show()

func keepMovingLoop(_playerTile, _tileToMoveTo):
	var _currentTile = _playerTile
	var _nextTile = _tileToMoveTo
	var _direction = _tileToMoveTo - _playerTile
	while keepMoving:
		if (
			(
				_nextTile.x >= 0 and
				_nextTile.x < level.grid.size() - 1 and
				_nextTile.y >= 0 and
				_nextTile.y < level.grid[0].size() - 1
			) and
			level.grid[_nextTile.x][_nextTile.y].tile != Globals.tiles.WALL and
			level.grid[_nextTile.x][_nextTile.y].tile != Globals.tiles.EMPTY and
			(
				level.grid[_currentTile.x][_currentTile.y - 1].critter == null
#				_currentTile.y - 1 < 0
			) and
			(
				level.grid[_currentTile.x + 1][_currentTile.y - 1].critter == null
#				_currentTile.y - 1 < 0 or
#				level.grid.size() < _currentTile.x + 1
			) and
			(
				level.grid[_currentTile.x + 1][_currentTile.y].critter == null
#				level.grid.size() < _currentTile.x + 1
			) and
			(
				level.grid[_currentTile.x + 1][_currentTile.y + 1].critter == null
#				level.grid.size() < _currentTile.x + 1 or
#				level.grid[0].size() < _currentTile.y + 1
			) and
			(
				level.grid[_currentTile.x][_currentTile.y + 1].critter == null
#				level.grid[0].size() < _currentTile.y + 1
			) and
			(
				level.grid[_currentTile.x - 1][_currentTile.y + 1].critter == null
#				_currentTile.x - 1 < 0 or
#				level.grid[0].size() < _currentTile.y + 1
			) and
			(
				level.grid[_currentTile.x - 1][_currentTile.y].critter == null
#				_currentTile.x - 1 < 0
			) and
			(
				level.grid[_currentTile.x - 1][_currentTile.y - 1].critter == null
#				_currentTile.x - 1 < 0 or
#				_currentTile.y - 1 < 0
			) and
			inGame
		):
			$"Critters/0".processPlayerAction(_currentTile, _nextTile, $Items/Items, level)
			processEnemyActions()
			processCrittersStatus()
			drawLevel()
			yield(get_tree().create_timer(0.01), "timeout")
		else:
			keepMoving = false
		_currentTile = _nextTile
		_nextTile = _nextTile + _direction

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
	
	$Critters.add_child(player, true)
	player.create("mercenary")
	level.placeCritter(Globals.tiles.UP_STAIR, 0)
	player.calculateEquipmentStats()
	
	$Items/Items.randomizeRandomItems()
	
	createItemsForEachLevel()
	createCrittersForEachLevel()
	
	var newItem = load("res://Objects/Item/Item.tscn").instance()
	newItem.createItem($"/root/World/Items/Items".getItemByName("scroll of identify"), { "alignment": "blessed" })
	$"/root/World/Items".add_child(newItem, true)
	$Critters/"0"/Inventory.addToInventory(newItem.id)
	
	var newItem2 = load("res://Objects/Item/Item.tscn").instance()
	newItem2.createItem($"/root/World/Items/Items".getItemByName("scroll of create food"), { "alignment": "blessed" })
	$"/root/World/Items".add_child(newItem2, true)
	$Critters/"0"/Inventory.addToInventory(newItem2.id)
	
	var newItem5 = load("res://Objects/Item/Item.tscn").instance()
	newItem5.createItem($"/root/World/Items/Items".getItemByName("scroll of genocide"), { "alignment": "blessed" })
	$"/root/World/Items".add_child(newItem5, true)
	$Critters/"0"/Inventory.addToInventory(newItem5.id)
	
	var newItem6 = load("res://Objects/Item/Item.tscn").instance()
	newItem6.createItem($"/root/World/Items/Items".getItemByName("scroll of create critter"), { "alignment": "blessed" })
	$"/root/World/Items".add_child(newItem6, true)
	$Critters/"0"/Inventory.addToInventory(newItem6.id)
	
	var newItem13 = load("res://Objects/Item/Item.tscn").instance()
	newItem13.createItem($"/root/World/Items/Items".getItemByName("potion of gain level"), { "alignment": "blessed" })
	$"/root/World/Items".add_child(newItem13, true)
	$Critters/"0"/Inventory.addToInventory(newItem13.id)
	
	var newItem3 = load("res://Objects/Item/Item.tscn").instance()
	newItem3.createItem($"/root/World/Items/Items".getItemByName("potion of gain level"), { "alignment": "uncursed" })
	$"/root/World/Items".add_child(newItem3, true)
	$Critters/"0"/Inventory.addToInventory(newItem3.id)
	
	var newItem16 = load("res://Objects/Item/Item.tscn").instance()
	newItem16.createItem($"/root/World/Items/Items".getItemByName("potion of gain level"), { "alignment": "cursed" })
	$"/root/World/Items".add_child(newItem16, true)
	$Critters/"0"/Inventory.addToInventory(newItem16.id)
	
	var newItem4 = load("res://Objects/Item/Item.tscn").instance()
	newItem4.createItem($"/root/World/Items/Items".getItemByName("battered buckler"), { "alignment": "uncursed" })
	$"/root/World/Items".add_child(newItem4, true)
	$Critters/"0"/Inventory.addToInventory(newItem4.id)
	
	var newItem10 = load("res://Objects/Item/Item.tscn").instance()
	newItem10.createItem($"/root/World/Items/Items".getItemByName("dwarvish laysword"), { "alignment": "uncursed" })
	$"/root/World/Items".add_child(newItem10, true)
	$Critters/"0"/Inventory.addToInventory(newItem10.id)
	
	updateTiles()
	
	inStartScreen = false
	inGame = true

func moveLevel(_direction):
	updateObjects = true
	if (
		(
			levels.dungeon1.back().levelId == Globals.currentDungeonLevel and
			_direction == 1
		) or
		(
			levels.dungeon2.front().levelId == Globals.currentDungeonLevel and
			_direction == -1
		) or
		(
			levels.minesOfTidoh.front().levelId == Globals.currentDungeonLevel and
			_direction == -1
		)
	):
		var goToStair
		for stair in level.stairs.keys():
			if level.stairs[stair] == level.getCritterTile(0):
				if stair == "downStair" and _direction == 1:
					Globals.currentDungeonLevel = levels.dungeon2.front().levelId
					goToStair = "upStair"
					break
				elif stair == "secondDownStair" and _direction == 1:
					Globals.currentDungeonLevel = levels.minesOfTidoh.front().levelId
					goToStair = "upStair"
					break
				elif stair == "upStair" and _direction == -1:
					if levels.minesOfTidoh.front().levelId == Globals.currentDungeonLevel:
						goToStair = "secondDownStair"
					elif levels.dungeon2.front().levelId == Globals.currentDungeonLevel:
						goToStair = "downStair"
					Globals.currentDungeonLevel = levels.dungeon1.back().levelId
					break
		level = get_node("Levels/{level}".format({ "level": Globals.currentDungeonLevel }))
		$FOV.moveLevel(Globals.currentDungeonLevel - 1)
		return level.stairs[goToStair]
	else:
		Globals.currentDungeonLevel += _direction
		level = get_node("Levels/{level}".format({ "level": Globals.currentDungeonLevel }))
		$FOV.moveLevel(Globals.currentDungeonLevel - 1)
	return null

func updateTiles():
	for x in (level.grid.size()):
		for y in (level.grid[x].size()):
			set_cellv(Vector2(x, y), level.grid[x][y].tile)
			$FOV.set_cellv(Vector2(x, y), $FOV.currentFOVLevel[x][y])

func openMenu(_menu, _playerTile = null):
	match _menu:
		"inventory":
			if uIState == uI.GAME:
				$Critters/"0"/Inventory.showInventory()
				uIState = uI.INVENTORY
				inGame = false
		"pick up":
			if level.grid[_playerTile.x][_playerTile.y].items.size() == 1 and uIState == uI.GAME:
				$Critters/"0".pickUpItems(_playerTile, level.grid[_playerTile.x][_playerTile.y].items, level.grid)
				$"/root/World".processGameTurn()
			elif level.grid[_playerTile.x][_playerTile.y].items.size() != 0 and uIState == uI.GAME:
				$UI/ItemManagement.items = level.grid[_playerTile.x][_playerTile.y].items
				$UI/ItemManagement.showItemManagementList()
				uIState = uI.PICK_UP_ITEMS
				inGame = false
		"drop":
			if uIState == uI.GAME:
				$UI/ItemManagement.items = $Critters/"0"/Inventory.inventory
				$UI/ItemManagement.showItemManagementList()
				uIState = uI.DROP_ITEMS
				inGame = false
		"equipment":
			if uIState == uI.GAME:
				$UI/Equipment.showEquipment($Critters/"0"/Inventory.getItemsOfType(["weapon", "accessory", "wrmor"]))
				uIState = uI.EQUIPMENT     
				inGame = false
		"read":
			if uIState == uI.GAME:
				$UI/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["scroll"])
				$UI/ItemManagement.showItemManagementList(true)
				uIState = uI.READ
				inGame = false
		"quaff":
			if uIState == uI.GAME:
				$UI/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["potion"])
				$UI/ItemManagement.showItemManagementList(true)
				uIState = uI.QUAFF
				inGame = false

func processAccept():
	var _playerTile = level.getCritterTile(0)
	var _items = $UI/ItemManagement.selectedItems
	
	if uIState == uI.PICK_UP_ITEMS:
		$Critters/"0".pickUpItems(_playerTile, _items, level.grid)
	if uIState == uI.DROP_ITEMS:
		$Critters/"0".dropItems(_playerTile, _items, level.grid)
	
	closeMenu()
	$"/root/World".processGameTurn()

func closeMenu(_additionalChoices = false):
	if !_additionalChoices:
		if (
			uIState == uI.PICK_UP_ITEMS or
			uIState == uI.DROP_ITEMS or
			uIState == uI.READ or
			uIState == uI.QUAFF
		):
			$UI/ItemManagement.hideItemManagementList()
		if uIState == uI.EQUIPMENT:
			$UI/Equipment.hideEquipment()
		if uIState == uI.INVENTORY:
			$Critters/"0"/Inventory.hideInventory()
		$UI/ListMenu.hideListMenuList()
		uIState = uI.GAME
		inGame = true
		keepMoving = false
	else:
		pass

func createItemsForEachLevel():
	for _level in $Levels.get_children():
		$Items/Items.generateItemsForLevel(_level)

func createCrittersForEachLevel():
	for _level in $Levels.get_children():
		$Critters/Critters.generateCrittersForLevel(_level)
