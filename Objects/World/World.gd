extends TileMap

onready var player = preload("res://Objects/Player/Player.tscn").instance()

onready var critters = preload("res://Objects/Critter/Critters.tscn").instance()
onready var items = preload("res://Objects/Item/Items.tscn").instance()

onready var dungeon1 = preload("res://Random Generators/Dungeon Levels/Dungeon1.tscn")

var updateObjects = true

enum tiles { 
	EMPTY
	CORRIDOR
	DOOR
	FOUNTAIN
	FLOOR
	DOWN_STAIR
	WALL
	UP_STAIR
}

enum uI {
	GAME
	INVENTORY
	PICK_UP_ITEMS
	DROP_ITEMS
	EQUIPMENT
}

var level = null
var levels = {
	"firstLevel": 0,
	"dungeon1": [],
	"minesOfTidoh": [],
	"dungeon2": [],
	"arena": [],
	"dungeon3": [],
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
	
	$FOV.createFOVLevels()
	
	items.create()
	$Items.add_child(items)
	
	critters.create()
	$Critters.add_child(critters)
	
	$UI/ItemManagement.create()
	$UI/Equipment.create()
	
	var firstLevel = dungeon1.instance()
	firstLevel.setName()
	$Levels.add_child(firstLevel)
	for _level in range(3):
		var newDungeon = dungeon1.instance()
		newDungeon.setName()
		levels.dungeon1.append(newDungeon)
		$Levels.add_child(newDungeon)

func _input(event):
	if (Input.is_action_just_pressed("START") and level == null):
		create()
		yield(get_tree().create_timer(0.1), "timeout")
		drawLevel()
	if !inStartScreen:
		var _playerTile = getCritterTile(0)
		if (
			Input.is_action_pressed("MOVE_UP") or
			Input.is_action_pressed("MOVE_UP_RIGHT") or
			Input.is_action_pressed("MOVE_RIGHT") or
			Input.is_action_pressed("MOVE_DOWN_RIGHT") or
			Input.is_action_pressed("MOVE_DOWN") or
			Input.is_action_pressed("MOVE_DOWN_LEFT") or
			Input.is_action_pressed("MOVE_LEFT") or
			Input.is_action_pressed("MOVE_UP_LEFT")
		):
			var _tileToMoveTo
			if Input.is_action_pressed("MOVE_UP"):
				_tileToMoveTo = Vector2(_playerTile.x, _playerTile.y - 1)
			elif Input.is_action_pressed("MOVE_UP_RIGHT"):
				_tileToMoveTo = Vector2(_playerTile.x + 1, _playerTile.y - 1)
			elif Input.is_action_pressed("MOVE_RIGHT"):
				_tileToMoveTo = Vector2(_playerTile.x + 1, _playerTile.y)
			elif Input.is_action_pressed("MOVE_DOWN_RIGHT"):
				_tileToMoveTo = Vector2(_playerTile.x + 1, _playerTile.y + 1)
			elif Input.is_action_pressed("MOVE_DOWN"):
				_tileToMoveTo = Vector2(_playerTile.x, _playerTile.y + 1)
			elif Input.is_action_pressed("MOVE_DOWN_LEFT"):
				_tileToMoveTo = Vector2(_playerTile.x - 1, _playerTile.y + 1)
			elif Input.is_action_pressed("MOVE_LEFT"):
				_tileToMoveTo = Vector2(_playerTile.x - 1, _playerTile.y)
			elif Input.is_action_pressed("MOVE_UP_LEFT"):
				_tileToMoveTo = Vector2(_playerTile.x - 1, _playerTile.y - 1)
			processGameTurn(_playerTile, _tileToMoveTo)
		elif (
			Input.is_action_just_pressed("ASCEND") or
			Input.is_action_just_pressed("DESCEND")
		):
			if Input.is_action_just_pressed("ASCEND"):
				moveLevel(-1)
			elif Input.is_action_just_pressed("DESCEND"):
				moveLevel(1)
			updateTiles()
			if Input.is_action_just_pressed("ASCEND"):
				placeCritter(tiles.DOWN_STAIR, 0)
			elif Input.is_action_just_pressed("DESCEND"):
				placeCritter(tiles.UP_STAIR, 0)
			yield(get_tree().create_timer(0.1), "timeout")
			drawLevel()
		elif Input.is_action_just_pressed("ACCEPT"):
			processGameTurn(_playerTile)
		elif (Input.is_action_just_pressed("PICK_UP") and inGame):
			openPickUpItemMenu(_playerTile)
		elif (Input.is_action_just_pressed("DROP") and inGame):
			openDropItemMenu()
		elif (Input.is_action_just_pressed("INVENTORY") and inGame):
			openInventory()
		elif (Input.is_action_just_pressed("EQUIPMENT") and inGame):
			openEquipmentItemMenu()
		elif (Input.is_action_just_pressed("BACK")):
			closeMenu()
		elif Input.is_action_just_pressed("KEEP_MOVING") and inGame:
			keepMoving = true
		$"Critters/0".updatePlayerStats()

func processGameTurn(_playerTile, _tileToMoveTo = null):
	if keepMoving and _tileToMoveTo != null:
		keepMovingLoop(_playerTile, _tileToMoveTo)
	else:
		processPlayerAction(_playerTile, _tileToMoveTo)
		processEnemyActions()
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
			level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != tiles.EMPTY and
			level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != tiles.WALL
		) and
		inGame
	):
		$"Critters/0".processPlayerAction(_playerTile, _tileToMoveTo, $Items/Items, level)
	elif (Input.is_action_pressed("ASCEND") and
		level.grid[_playerTile.x][_playerTile.y].tile == tiles.UP_STAIR and
		Globals.currentDungeonLevel != 1 and
		inGame
	):
		moveLevel(-1)
	elif (Input.is_action_pressed("DESCEND") and
		level.grid[_playerTile.x][_playerTile.y].tile == tiles.DOWN_STAIR and
		Globals.currentDungeonLevel != 4 and
		inGame
	 ):
		moveLevel(1)
	elif (Input.is_action_pressed("ACCEPT") and !inGame
	):
		processAccept()

func processEnemyActions():
	var _playerTile = getCritterTile(0)
	if level.critters.size() != 0:
		for _enemy in level.critters:
			var _critterTile = getCritterTile(_enemy)
			get_node("Critters/{id}".format({ "id": _enemy })).processCritterAction(_critterTile, _playerTile, _enemy, level, tiles)

func drawLevel():
	if updateObjects:
		for _critter in $Critters.get_children():
			_critter.hide()
		
		for _item in $Items.get_children():
			_item.hide()
		updateObjects = false
	
	drawFOV()
	drawCrittersAndItems()

func drawCrittersAndItems():
	# Critters, items and tiles
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

func drawFOV():
	# FOV
	var playerTile = getCritterTile(0)
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
			elif occlusion and $FOV.currentFOVLevel[_x][_y] == -1 and level.grid[_x][_y].tile != tiles.EMPTY:
				$FOV.greyCell(_x, _y)

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
			level.grid[_nextTile.x][_nextTile.y].tile != tiles.WALL and
			level.grid[_nextTile.x][_nextTile.y].tile != tiles.EMPTY and
			(
				level.grid[_currentTile.x][_currentTile.y - 1].critter == null and
				level.grid[_currentTile.x + 1][_currentTile.y - 1].critter == null and
				level.grid[_currentTile.x + 1][_currentTile.y].critter == null and
				level.grid[_currentTile.x + 1][_currentTile.y + 1].critter == null and
				level.grid[_currentTile.x][_currentTile.y + 1].critter == null and
				level.grid[_currentTile.x - 1][_currentTile.y + 1].critter == null and
				level.grid[_currentTile.x - 1][_currentTile.y].critter == null and
				level.grid[_currentTile.x - 1][_currentTile.y - 1].critter == null
			) and
			inGame
		):
			$"Critters/0".processPlayerAction(_currentTile, _nextTile, $Items/Items, level)
			processEnemyActions()
			drawLevel()
		else:
			keepMoving = false
		_currentTile = _nextTile
		_nextTile = _nextTile + _direction

func create():
	$UI/GameConsole.create()
	
	level = get_node("Levels/{level}".format({ "level": levels.firstLevel })).createNewLevel(tiles, true)
	for _level in levels.dungeon1:
		get_node("Levels/{level}".format({ "level": _level })).createNewLevel(tiles)
	
	$Critters.add_child(player, true)
	player.create()
	placeCritter(tiles.UP_STAIR, 0)
	
	
	createItemsForEachLevel()
	createCrittersForEachLevel()
	
	updateTiles()
	
	inStartScreen = false
	inGame = true

func moveLevel(_direction):
	var nextLevelInArray = Globals.currentDungeonLevel + _direction - 1
	level = get_node("Levels/{level}".format({ "level": nextLevelInArray }))
	$FOV.moveLevel(nextLevelInArray)
	Globals.currentDungeonLevel += _direction
	updateObjects = true

func updateTiles():
	for x in (level.grid.size()):
		for y in (level.grid[x].size()):
			set_cellv(Vector2(x, y), level.grid[x][y].tile)
			$FOV.set_cellv(Vector2(x, y), $FOV.currentFOVLevel[x][y])

func placeCritter(_tile, _critter):
	for x in range(level.grid.size()):
		for y in range(level.grid[x].size()):
			var _checkedTile = level.grid[x][y].tile
			if _checkedTile == _tile:
				level.grid[x][y].critter = _critter
				return

func getCritterTile(_critter):
	for x in range(level.grid.size()):
		for y in range(level.grid[x].size()):
			if level.grid[x][y].critter == _critter:
				return Vector2(x, y)
	return false

func openInventory():
	if uIState == uI.GAME:
		$Critters/"0"/Inventory.showInventory()
		uIState = uI.INVENTORY
		inGame = false

func openPickUpItemMenu(_playerTile):
	if level.grid[_playerTile.x][_playerTile.y].items.size() != 0 and uIState == uI.GAME:
		$UI/ItemManagement.items = level.grid[_playerTile.x][_playerTile.y].items
		$UI/ItemManagement.showItemManagementList()
		uIState = uI.PICK_UP_ITEMS
		inGame = false

func openDropItemMenu():
	if uIState == uI.GAME:
		$UI/ItemManagement.items = $Critters/"0"/Inventory.inventory
		$UI/ItemManagement.showItemManagementList()
		uIState = uI.DROP_ITEMS
		inGame = false

func openEquipmentItemMenu():
	if uIState == uI.GAME:
		$UI/Equipment.showEquipment($Critters/"0"/Inventory.getItemsOfType(["Weapon", "Accessory", "Armor"]))
		uIState = uI.EQUIPMENT     
		inGame = false

func processAccept():
	var _playerTile = getCritterTile(0)
	var _items = $UI/ItemManagement.selectedItems
	
	if uIState == uI.PICK_UP_ITEMS:
		$Critters/"0".pickUpItems(_playerTile, _items, level.grid)
	if uIState == uI.DROP_ITEMS:
		$Critters/"0".dropItems(_playerTile, _items, level.grid)
	
	closeMenu()

func closeMenu():
	if uIState == uI.PICK_UP_ITEMS or uIState == uI.DROP_ITEMS:
		$UI/ItemManagement.hideItemManagementList()
	if uIState == uI.EQUIPMENT:
		$UI/Equipment.hideEquipment()
	if uIState == uI.INVENTORY:
		$Critters/"0"/Inventory.hideInventory()
	uIState = uI.GAME
	inGame = true
	keepMoving = false

func createItemsForEachLevel():
	for _level in $Levels.get_children():
		$Items/Items.generateItemsForLevel(_level)

func createCrittersForEachLevel():
	for _level in $Levels.get_children():
		$Critters/Critters.generateCrittersForLevel(_level)
