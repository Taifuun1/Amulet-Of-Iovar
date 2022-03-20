extends TileMap

onready var player = preload("res://Objects/Player/Player.tscn").instance()

onready var critter = preload("res://Objects/Critter/Critter.tscn")
onready var critters = preload("res://Objects/Critter/Critters.tscn").instance()
onready var item = preload("res://Objects/Item/Item.tscn")
onready var items = preload("res://Objects/Item/Items.tscn").instance()
onready var itemManagement = preload("res://UI/ItemManagement/ItemManagement.tscn").instance()

onready var dungeon1 = preload("res://Random Generators/Dungeon Levels/Dungeon1.tscn")

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
	WIELD
}

var grid = null
var levels = {
	"firstLevel": 0,
	"dungeon1": [],
	"minesOfTidoh": [],
	
}

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var grid_size = Vector2(10,10)

var keepMoving = null

var uIState = uI.GAME

var safeRender = true

var inStartScreen = true
var inGame = false

func _ready():
	randomize()
	
	$FOV.createFOVLevels()
	
	items.create()
	$Items.add_child(items)
	
	critters.create()
	$Critters.add_child(critters)
	
	itemManagement.create()
	$UI.add_child(itemManagement)
	
	var firstLevel = dungeon1.instance()
	firstLevel.setName()
	$Levels.add_child(firstLevel)
	for _level in range(3):
		var newDungeon = dungeon1.instance()
		levels.dungeon1.append(newDungeon.setName())
		$Levels.add_child(newDungeon)

func _input(event):
	if !inStartScreen:
		var _playerTile = getCritterTile(0)
		if (
			event.is_action_pressed("MOVE_UP") or
			event.is_action_pressed("MOVE_UP_RIGHT") or
			event.is_action_pressed("MOVE_RIGHT") or
			event.is_action_pressed("MOVE_DOWN_RIGHT") or
			event.is_action_pressed("MOVE_DOWN") or
			event.is_action_pressed("MOVE_DOWN_LEFT") or
			event.is_action_pressed("MOVE_LEFT") or
			event.is_action_pressed("MOVE_UP_LEFT")
		):
			var _tileToMoveTo
			var _tile
			if event.is_action_pressed("MOVE_UP"):
				_tileToMoveTo = Vector2(_playerTile.x, _playerTile.y - 1)
			elif event.is_action_pressed("MOVE_UP_RIGHT"):
				_tileToMoveTo = Vector2(_playerTile.x + 1, _playerTile.y - 1)
			elif event.is_action_pressed("MOVE_RIGHT"):
				_tileToMoveTo = Vector2(_playerTile.x + 1, _playerTile.y)
			elif event.is_action_pressed("MOVE_DOWN_RIGHT"):
				_tileToMoveTo = Vector2(_playerTile.x + 1, _playerTile.y + 1)
			elif event.is_action_pressed("MOVE_DOWN"):
				_tileToMoveTo = Vector2(_playerTile.x, _playerTile.y + 1)
			elif event.is_action_pressed("MOVE_DOWN_LEFT"):
				_tileToMoveTo = Vector2(_playerTile.x - 1, _playerTile.y + 1)
			elif event.is_action_pressed("MOVE_LEFT"):
				_tileToMoveTo = Vector2(_playerTile.x - 1, _playerTile.y)
			elif event.is_action_pressed("MOVE_UP_LEFT"):
				_tileToMoveTo = Vector2(_playerTile.x - 1, _playerTile.y - 1)
			_tile = grid[_tileToMoveTo.x][_tileToMoveTo.y]
			process_game_turn(_playerTile, _tileToMoveTo, _tile)
		elif (
			event.is_action_pressed("ASCEND") or
			event.is_action_pressed("DESCEND") or
			event.is_action_pressed("ACCEPT")
		):
			process_game_turn(_playerTile)
		elif (Input.is_action_pressed("PICK_UP") and inGame):
			openPickUpItemMenu(_playerTile)
			inGame = false
		elif (Input.is_action_pressed("DROP") and inGame):
			openDropItemMenu()
			inGame = false
		elif (Input.is_action_pressed("INVENTORY") and inGame):
			openInventory()
		elif (Input.is_action_pressed("WIELD") and inGame):
			openWieldItemMenu()
			inGame = false
		elif (Input.is_action_pressed("DROP_MANY") and inGame):
			pass
		elif (Input.is_action_pressed("BACK")):
			closeMenu()
		elif event.is_action_pressed("KEEP_MOVING") and inGame:
			keepMoving = true
		call_deferred("drawLevel")
	if (
		Input.is_action_pressed("START")
	):
		create()

func process_game_turn(_playerTile, _tileToMoveTo = null, _tile = null):
	processInput(_playerTile, _tileToMoveTo, _tile)
	processEnemyMovement()
#	despawnObjects()

func processInput(_playerTile, _tileToMoveTo, _tile):
	if (
		Input.is_action_pressed("MOVE_UP") and
		_tileToMoveTo.y >= 0 and
		(_tile.tile != tiles.EMPTY and _tile.tile != tiles.WALL) and
		inGame
	):
		if(_tile.critter != null):
			if get_node("Critters/{critter}".format({ "critter": _tile.critter })).hitCritter($Critters/"0".calculateHitDmg()) == "dead":
				get_node("Critters/{critter}".format({ "critter": _tile.critter })).despawn(_tileToMoveTo, item.instance(), grid, get_node("Critters/{critter}".format({ "critter": _tile.critter })))
		else:
			moveCritter(_playerTile, _tileToMoveTo, 0)
	elif (
		Input.is_action_pressed("MOVE_UP_RIGHT") and
		_tileToMoveTo.y >= 0 and
		_tileToMoveTo.x < grid.size() and
		(_tile.tile != tiles.EMPTY and _tile.tile != tiles.WALL) and
		inGame
	):
		if(_tile.critter != null):
			if get_node("Critters/{critter}".format({ "critter": _tile.critter })).hitCritter($Critters/"0".calculateHitDmg()) == "dead":
				get_node("Critters/{critter}".format({ "critter": _tile.critter })).despawn(_tileToMoveTo, item.instance(), grid, get_node("Critters/{critter}".format({ "critter": _tile.critter })))
		else:
			moveCritter(_playerTile, _playerTile + Vector2(1, -1), 0)
	elif (
		Input.is_action_pressed("MOVE_RIGHT") and
		_tileToMoveTo.x < grid.size() and
		(_tile.tile != tiles.EMPTY and _tile.tile != tiles.WALL) and
		inGame
	):
		if(_tile.critter != null):
			if get_node("Critters/{critter}".format({ "critter": _tile.critter })).hitCritter($Critters/"0".calculateHitDmg()) == "dead":
				get_node("Critters/{critter}".format({ "critter": _tile.critter })).despawn(_tileToMoveTo, item.instance(), grid, get_node("Critters/{critter}".format({ "critter": _tile.critter })))
		else:
			moveCritter(_playerTile, _playerTile + Vector2(1, 0), 0)
	elif (
		Input.is_action_pressed("MOVE_DOWN_RIGHT") and
		_tileToMoveTo.x < grid.size() and
		_tileToMoveTo.y < grid[0].size() and
		(_tile.tile != tiles.EMPTY and _tile.tile != tiles.WALL) and
		inGame
	):
		if(_tile.critter != null):
			if get_node("Critters/{critter}".format({ "critter": _tile.critter })).hitCritter($Critters/"0".calculateHitDmg()) == "dead":
				get_node("Critters/{critter}".format({ "critter": _tile.critter })).despawn(_tileToMoveTo, item.instance(), grid, get_node("Critters/{critter}".format({ "critter": _tile.critter })))
		else:
			moveCritter(_playerTile, _playerTile + Vector2(1, 1), 0)
	elif (
		Input.is_action_pressed("MOVE_DOWN") and
		_tileToMoveTo.y < grid[0].size() and
		(_tile.tile != tiles.EMPTY and _tile.tile != tiles.WALL) and
		inGame
	):
		if(_tile.critter != null):
			if get_node("Critters/{critter}".format({ "critter": _tile.critter })).hitCritter($Critters/"0".calculateHitDmg()) == "dead":
				get_node("Critters/{critter}".format({ "critter": _tile.critter })).despawn(_tileToMoveTo, item.instance(), grid, get_node("Critters/{critter}".format({ "critter": _tile.critter })))
		else:
			moveCritter(_playerTile, _playerTile + Vector2(0, 1), 0)
	elif (
		Input.is_action_pressed("MOVE_DOWN_LEFT") and
		_tileToMoveTo.x >= 0 and
		_tileToMoveTo.y < grid[0].size() and
		(_tile.tile != tiles.EMPTY and _tile.tile != tiles.WALL) and
		inGame
	):
		if(_tile.critter != null):
			if get_node("Critters/{critter}".format({ "critter": _tile.critter })).hitCritter($Critters/"0".calculateHitDmg()) == "dead":
				get_node("Critters/{critter}".format({ "critter": _tile.critter })).despawn(_tileToMoveTo, item.instance(), grid, get_node("Critters/{critter}".format({ "critter": _tile.critter })))
		else:
			moveCritter(_playerTile, _playerTile + Vector2(-1, 1), 0)
	elif (
		Input.is_action_pressed("MOVE_LEFT") and
		_tileToMoveTo.x >= 0 and
		(_tile.tile != tiles.EMPTY and _tile.tile != tiles.WALL) and
		inGame
	):
		if(_tile.critter != null):
			if get_node("Critters/{critter}".format({ "critter": _tile.critter })).hitCritter($Critters/"0".calculateHitDmg()) == "dead":
				get_node("Critters/{critter}".format({ "critter": _tile.critter })).despawn(_tileToMoveTo, item.instance(), grid, get_node("Critters/{critter}".format({ "critter": _tile.critter })))
		else:
			moveCritter(_playerTile, _playerTile + Vector2(-1, 0), 0)
	elif (
		Input.is_action_pressed("MOVE_UP_LEFT") and
		_tileToMoveTo.x >= 0 and
		_tileToMoveTo.y >= 0 and
		(_tile.tile != tiles.EMPTY and _tile.tile != tiles.WALL) and
		inGame
	):
		if(_tile.critter != null):
			if get_node("Critters/{critter}".format({ "critter": _tile.critter })).hitCritter($Critters/"0".calculateHitDmg()) == "dead":
				get_node("Critters/{critter}".format({ "critter": _tile.critter })).despawn(_tileToMoveTo, item.instance(), grid, get_node("Critters/{critter}".format({ "critter": _tile.critter })))
		else:
			moveCritter(_playerTile, _playerTile + Vector2(-1, -1), 0)
	elif (Input.is_action_pressed("ASCEND") and
		grid[_playerTile.x][_playerTile.y].tile == tiles.UP_STAIR and
		Globals.currentDungeonLevel != 1 and
		inGame
	):
		moveLevel(-1)
	elif (Input.is_action_pressed("DESCEND") and
		grid[_playerTile.x][_playerTile.y].tile == tiles.DOWN_STAIR and
		Globals.currentDungeonLevel != 4 and
		inGame
	 ):
		moveLevel(1)
	elif (Input.is_action_pressed("ACCEPT") and !inGame
	):
		processAccept()
	elif (
		keepMoving and
		_tileToMoveTo.x >= 0 and
		_tileToMoveTo.x < grid.size() and
		_tileToMoveTo.y >= 0 and
		_tileToMoveTo.y < grid[0].size() and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != tiles.WALL and
		grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != tiles.EMPTY and
		!grid[_tileToMoveTo.x][_tileToMoveTo.y].critter and
		inGame
	):
		moveCritter(_playerTile, _tileToMoveTo, 0)
	keepMoving = false

func processEnemyMovement():
	pass

func drawLevel():
	var playerTile = getCritterTile(0)
	
	for _critter in $Critters.get_children():
		_critter.hide()
	
	for _item in $Items.get_children():
		_item.hide()
	
	# Critters, items and tiles
	for x in (grid.size()):
		for y in (grid[x].size()):
			set_cellv(Vector2(x, y), grid[x][y].tile)
			$FOV.set_cellv(Vector2(x, y), $FOV.getCurrentLevelCell(x, y))
			if grid[x][y].critter != null:
				get_node("Critters/{id}".format({ "id": grid[x][y].critter })).set_position(map_to_world(Vector2(x, y)) + half_tile_size)
				get_node("Critters/{id}".format({ "id": grid[x][y].critter })).show()
			if grid[x][y].items.size() != 0:
				get_node("Items/{id}".format({ "id": grid[x][y].items.back() })).set_position(map_to_world(Vector2(x, y)) + half_tile_size)
				get_node("Items/{id}".format({ "id": grid[x][y].items.back() })).show()
	
	# Wait some frames to avoid crash
	if safeRender:
		safeRender = false
		yield(get_tree().create_timer(0.1), "timeout")
	
	# FOV
	var playerCenter = tileToPixelCenter(playerTile.x, playerTile.y)
	var spaceState = get_world_2d().get_direct_space_state()
	for _x in range(Globals.gridSize.x):
		for _y in range(Globals.gridSize.y):
			var x_dir = 1 if _x < playerTile.x else -1
			var y_dir = 1 if _y < playerTile.y else -1
			var testPoint = tileToPixelCenter(_x, _y) + Vector2(x_dir, y_dir) * 32 / 2
			var occlusion = spaceState.intersect_ray(playerCenter, testPoint)
			if !occlusion || (occlusion.position - testPoint).length() < 1:
				$FOV.seeCell(_x, _y)
			elif occlusion and $FOV.getCurrentLevelCell(_x, _y) == -1 and grid[_x][_y].tile != tiles.EMPTY:
				$FOV.greyCell(_x, _y)

func despawnObjects():
	for _critter in $Critters.get_children():
		if _critter.despawning:
			_critter.queue_free()

func tileToPixelCenter(x, y):
	return Vector2((x + 0.5) * 32, (y + 0.5) * 32)

func create():
	grid = get_node("Levels/{level}".format({ "level": levels.firstLevel })).createNewLevel(tiles, true)
	if typeof(grid) != TYPE_ARRAY:
		return grid.error
	for _level in levels.dungeon1:
		var response = get_node("Levels/{level}".format({ "level": _level })).createNewLevel(tiles)
		if typeof(response) != TYPE_ARRAY:
			push_error(response)
	
	$Critters.add_child(player, true)
	player.create()
	placePlayer(tiles.UP_STAIR)
	
	createItemsForEachLevel()
	createCrittersForEachLevel()
	
	inStartScreen = false
	inGame = true
	
	call_deferred("drawLevel")

func moveLevel(_direction):
	var nextLevelInArray = Globals.currentDungeonLevel + _direction - 1
	grid = get_node("Levels/{level}".format({ "level": nextLevelInArray })).grid
	$FOV.moveLevel(nextLevelInArray)
	if _direction == -1:
		placePlayer(tiles.DOWN_STAIR)
	else:
		placePlayer(tiles.UP_STAIR)
	Globals.currentDungeonLevel += _direction
	safeRender = true

func placePlayer(_stair):
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			var upStair = grid[x][y].tile
			if upStair == _stair:
				grid[x][y].critter = 0
				return

func getCritterTile(_critter):
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if grid[x][y].critter == _critter:
				return Vector2(x, y)
	return false

func moveCritter(_from, _to, _critter):
	grid[_from.x][_from.y].critter = null
	grid[_to.x][_to.y].critter = _critter
	if keepMoving:
		var nextTile = _to + (_to - _from)
		process_game_turn(_to, nextTile,  grid[nextTile.x][nextTile.y])

func openInventory():
	if uIState == uI.GAME:
		$Critters/"0".openInventory()
		uIState = uI.INVENTORY
		inGame = false

func openPickUpItemMenu(_playerTile):
	if grid[_playerTile.x][_playerTile.y].items.size() != 0 and uIState == uI.GAME:
		$UI/ItemManagement.setItems(grid[_playerTile.x][_playerTile.y].items)
		$UI/ItemManagement.showItemManagementList()
		uIState = uI.PICK_UP_ITEMS

func openDropItemMenu():
	if uIState == uI.GAME:
		$UI/ItemManagement.setItems($Critters/"0"/Inventory.getInventory())
		$UI/ItemManagement.showItemManagementList()
		uIState = uI.DROP_ITEMS

func openWieldItemMenu():
	if uIState == uI.GAME:
		$UI/ItemManagement.setItems($Critters/"0"/Inventory.getInventory())
		$UI/ItemManagement.showItemManagementList()
		uIState = uI.WIELD

func processAccept():
	var _playerTile = getCritterTile(0)
	var _items = $UI/ItemManagement.getSelectedItems()
	
	if uIState == uI.PICK_UP_ITEMS:
		$Critters/"0".pickUpItems(_playerTile, _items, grid)
	if uIState == uI.DROP_ITEMS:
		$Critters/"0".dropItems(_playerTile, _items, grid)
	if uIState == uI.WIELD:
		$Critters/"0".wieldWeapon(_items)
	
	closeMenu()

func closeMenu():
	if uIState == uI.PICK_UP_ITEMS or uIState == uI.DROP_ITEMS or uIState == uI.WIELD:
		$UI/ItemManagement.hideItemManagementList()
	if uIState == uI.INVENTORY:
		$Critters/"0"/Inventory.hideInventoryList()
	uIState = uI.GAME
	inGame = true

func createItemsForEachLevel():
	for level in $Levels.get_children():
		$Items/Items.generateItemsForLevel(level)

func createCrittersForEachLevel():
	for level in $Levels.get_children():
		$Critters/Critters.generateCrittersForLevel(level)
