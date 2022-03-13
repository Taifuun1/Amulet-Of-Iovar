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
	"dungeon1": []
}

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var grid_size = Vector2(10,10)

var keepMoving = null

var uIState = uI.GAME

var safeRender = true

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
	if inGame:
		var _playerTile = getCreatureTile(0)
		if (
			event.is_action_pressed("MOVE_UP") or
			event.is_action_pressed("MOVE_UP_RIGHT") or
			event.is_action_pressed("MOVE_RIGHT") or
			event.is_action_pressed("MOVE_DOWN_RIGHT") or
			event.is_action_pressed("MOVE_DOWN") or
			event.is_action_pressed("MOVE_DOWN_LEFT") or
			event.is_action_pressed("MOVE_LEFT") or
			event.is_action_pressed("MOVE_UP_LEFT") or
			event.is_action_pressed("ASCEND") or
			event.is_action_pressed("DESCEND") or
			event.is_action_pressed("ACCEPT")
		):
			process_game_turn(_playerTile)
			call_deferred("drawLevel")
		elif (
			Input.is_action_pressed("PICK_UP")
		):
			openPickUpItemMenu(_playerTile)
		elif (Input.is_action_pressed("DROP")):
			openDropItemMenu(_playerTile)
		elif (Input.is_action_pressed("INVENTORY")):
			openInventory()
		elif (Input.is_action_pressed("WIELD")):
			openWieldItemMenu()
		elif (Input.is_action_pressed("DROP_MANY")
		):
			pass
		elif (
			Input.is_action_pressed("BACK")
		):
			closeMenu()
		elif event.is_action_pressed("KEEP_MOVING"):
			keepMoving = true
	
	if (
		Input.is_action_pressed("START")
	):
		create()

func process_game_turn(_playerTile, _keepMoving = null):
	processInput(_playerTile, _keepMoving)
	processEnemyMovement()

func processInput(_playerTile, _keepMoving):
	if (
		Input.is_action_pressed("MOVE_UP") and
		_playerTile.y - 1 >= 0 and
		(grid[_playerTile.x][_playerTile.y - 1].tile != tiles.EMPTY and
		grid[_playerTile.x][_playerTile.y - 1].tile != tiles.WALL)
	):
		if(grid[_playerTile.x][_playerTile.y - 1].creature != null):
			get_node("Critters/{critter}".format({ "critter": grid[_playerTile.x][_playerTile.y - 1].creature })).hitCritter(get_node("Critters/{critter}".format({ "critter": 0 })).calculateHitDmg())
		else:
			moveCritter(_playerTile, _playerTile + Vector2(0, -1), 0)
	elif (
		Input.is_action_pressed("MOVE_UP_RIGHT") and
		_playerTile.y - 1 >= 0 and
		_playerTile.x + 1 < grid.size() and
		(grid[_playerTile.x + 1][_playerTile.y - 1].tile != tiles.EMPTY and
		grid[_playerTile.x + 1][_playerTile.y - 1].tile != tiles.WALL)
	):
		if(grid[_playerTile.x + 1][_playerTile.y - 1].creature != null):
			get_node("Critters/{critter}".format({ "critter": grid[_playerTile.x + 1][_playerTile.y - 1].creature })).hitCritter(get_node("Critters/{critter}".format({ "critter": 0 })).calculateHitDmg())
		else:
			moveCritter(_playerTile, _playerTile + Vector2(1, -1), 0)
	elif (
		Input.is_action_pressed("MOVE_RIGHT") and
		_playerTile.x + 1 < grid.size() and
		(grid[_playerTile.x + 1][_playerTile.y].tile != tiles.EMPTY and
		grid[_playerTile.x + 1][_playerTile.y].tile != tiles.WALL)
	):
		if(grid[_playerTile.x + 1][_playerTile.y].creature != null):
			get_node("Critters/{critter}".format({ "critter": grid[_playerTile.x + 1][_playerTile.y].creature })).hitCritter(get_node("Critters/{critter}".format({ "critter": 0 })).calculateHitDmg())
		else:
			moveCritter(_playerTile, _playerTile + Vector2(1, 0), 0)
	elif (
		Input.is_action_pressed("MOVE_DOWN_RIGHT") and
		_playerTile.x + 1 < grid.size() and
		_playerTile.y + 1 < grid[0].size() and
		(grid[_playerTile.x + 1][_playerTile.y + 1].tile != tiles.EMPTY and
		grid[_playerTile.x + 1][_playerTile.y + 1].tile != tiles.WALL)
	):
		if(grid[_playerTile.x + 1][_playerTile.y + 1].creature != null):
			get_node("Critters/{critter}".format({ "critter": grid[_playerTile.x + 1][_playerTile.y + 1].creature })).hitCritter(get_node("Critters/{critter}".format({ "critter": 0 })).calculateHitDmg())
		else:
			moveCritter(_playerTile, _playerTile + Vector2(1, 1), 0)
	elif (
		Input.is_action_pressed("MOVE_DOWN") and
		_playerTile.y + 1 < grid[0].size() and
		(grid[_playerTile.x][_playerTile.y + 1].tile != tiles.EMPTY and
		grid[_playerTile.x][_playerTile.y + 1].tile != tiles.WALL)
	):
		if(grid[_playerTile.x][_playerTile.y + 1].creature != null):
			get_node("Critters/{critter}".format({ "critter": grid[_playerTile.x][_playerTile.y + 1].creature })).hitCritter(get_node("Critters/{critter}".format({ "critter": 0 })).calculateHitDmg())
		else:
			moveCritter(_playerTile, _playerTile + Vector2(0, 1), 0)
	elif (
		Input.is_action_pressed("MOVE_DOWN_LEFT") and
		_playerTile.x - 1 >= 0 and
		_playerTile.y + 1 < grid[0].size() and
		(grid[_playerTile.x - 1][_playerTile.y + 1].tile != tiles.EMPTY and
		grid[_playerTile.x - 1][_playerTile.y + 1].tile != tiles.WALL)
	):
		if(grid[_playerTile.x - 1][_playerTile.y + 1].creature != null):
			get_node("Critters/{critter}".format({ "critter": grid[_playerTile.x - 1][_playerTile.y + 1].creature })).hitCritter(get_node("Critters/{critter}".format({ "critter": 0 })).calculateHitDmg())
		else:
			moveCritter(_playerTile, _playerTile + Vector2(-1, 1), 0)
	elif (
		Input.is_action_pressed("MOVE_LEFT") and
		_playerTile.x - 1 >= 0 and
		(grid[_playerTile.x - 1][_playerTile.y].tile != tiles.EMPTY and
		grid[_playerTile.x - 1][_playerTile.y].tile != tiles.WALL)
	):
		if(grid[_playerTile.x - 1][_playerTile.y].creature != null):
			get_node("Critters/{critter}".format({ "critter": grid[_playerTile.x - 1][_playerTile.y].creature })).hitCritter(get_node("Critters/{critter}".format({ "critter": 0 })).calculateHitDmg())
		else:
			moveCritter(_playerTile, _playerTile + Vector2(-1, 0), 0)
	elif (
		Input.is_action_pressed("MOVE_UP_LEFT") and
		_playerTile.x - 1 >= 0 and
		_playerTile.y - 1 >= 0 and
		(grid[_playerTile.x - 1][_playerTile.y - 1].tile != tiles.EMPTY and
		grid[_playerTile.x - 1][_playerTile.y - 1].tile != tiles.WALL)
	):
		if(grid[_playerTile.x - 1][_playerTile.y - 1].creature != null):
			get_node("Critters/{critter}".format({ "critter": grid[_playerTile.x][_playerTile.y - 1].creature })).hitCritter(get_node("Critters/{critter}".format({ "critter": 0 })).calculateHitDmg())
		else:
			moveCritter(_playerTile, _playerTile + Vector2(-1, -1), 0)
	elif (Input.is_action_pressed("ASCEND") and
		grid[_playerTile.x][_playerTile.y].tile == tiles.UP_STAIR and
		Globals.currentDungeonLevel != 1
	):
		moveLevel(-1)
	elif (Input.is_action_pressed("DESCEND") and
		grid[_playerTile.x][_playerTile.y].tile == tiles.DOWN_STAIR and
		Globals.currentDungeonLevel != 4
	 ):
		moveLevel(1)
	elif (Input.is_action_pressed("ACCEPT")
	):
		processAccept()
	elif (
		keepMoving and
		_playerTile.x + _keepMoving.x >= 0 and
		_playerTile.x + _keepMoving.x < grid.size() and
		_playerTile.y + _keepMoving.y >= 0 and
		_playerTile.y + _keepMoving.y < grid[0].size() and
		grid[_playerTile.x + _keepMoving.x][_playerTile.y + _keepMoving.y].tile != tiles.WALL and
		grid[_playerTile.x + _keepMoving.x][_playerTile.y + _keepMoving.y].tile != tiles.EMPTY and
		!grid[_playerTile.x + _keepMoving.x][_playerTile.y + _keepMoving.y].creature
	):
		moveCritter(_playerTile, _playerTile + _keepMoving, 0)
	keepMoving = false

func processEnemyMovement():
	pass

func drawLevel():
	var playerTile = getCreatureTile(0)
	
	for _item in $Items.get_children():
		_item.hide()
	
	# Critters, items and tiles
	for x in (grid.size()):
		for y in (grid[x].size()):
			set_cellv(Vector2(x, y), grid[x][y].tile)
			$FOV.set_cellv(Vector2(x, y), $FOV.getCurrentLevelCell(x, y))
			if grid[x][y].creature != null:
				get_node("Critters/{id}".format({ "id": grid[x][y].creature })).set_position(map_to_world(Vector2(x, y)) + half_tile_size)
				get_node("Critters/{id}".format({ "id": grid[x][y].creature })).show()
			if grid[x][y].items.size() != 0:
				for _id in grid[x][y].items:
					get_node("Items/{id}".format({ "id": _id })).set_position(map_to_world(Vector2(x, y)) + half_tile_size)
					get_node("Items/{id}".format({ "id": _id })).show()
	
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
	
	player.create()
	$Critters.add_child(player, true)
	placePlayer(tiles.UP_STAIR)
	
	placeItemTest()
	
	placeCritterTest()
	
	inGame = true
	
	call_deferred("drawLevel")

func moveLevel(_direction):
	var nextLevelInArray = Globals.currentDungeonLevel + _direction - 1
	grid = get_node("Levels/{level}".format({ "level": nextLevelInArray })).getlevel()
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
				grid[x][y].creature = 0
				get_node("Critters/0").set_position(map_to_world(Vector2(x, y)) + half_tile_size)
				return

func getCreatureTile(_creature):
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if grid[x][y].creature == _creature:
				return Vector2(x, y)
	return false

func moveCritter(_from, _to, _creature):
	grid[_from.x][_from.y].creature = null
	grid[_to.x][_to.y].creature = _creature
	get_node("Critters/{critter}".format({ "critter": _creature })).set_position(map_to_world( _to ) + half_tile_size)
	if keepMoving:
		process_game_turn(_to, _to - _from)

func openInventory():
	if uIState == uI.GAME:
		$Critters/Player/Inventory.showInventoryList()
		uIState = uI.INVENTORY

func pickUpItems():
	var _playerTile = getCreatureTile(0)
	var _items = $UI/ItemManagement.getSelectedItems()
	if _items.size() != 0:
		for _item in _items:
			pickUpItem(_item, _playerTile)
	closeMenu()

func pickUpItem(_item, _playerTile):
	for _itemOnGround in range(grid[_playerTile.x][_playerTile.y].items.size()):
		if grid[_playerTile.x][_playerTile.y].items[_itemOnGround] == _item:
			grid[_playerTile.x][_playerTile.y].items.remove(_itemOnGround)
			get_node("Critters/0/Inventory").addToInventory(get_node("Items/{id}".format({ "id": _item })).id)
			get_node("Items/{id}".format({ "id": _item })).hide()
			return

func dropItems():
	var _playerTile = getCreatureTile(0)
	var _items = $UI/ItemManagement.getSelectedItems()
	if _items.size() != 0:
		for _item in _items:
			dropItem(_item, _playerTile)
	closeMenu()

func dropItem(_item, _playerTile):
	grid[_playerTile.x][_playerTile.y].items.append(get_node("Items/{id}".format({ "id": _item })).id)
	get_node("Critters/0/Inventory").dropFromInventory(get_node("Items/{id}".format({ "id": _item })).id)
	get_node("Items/{id}".format({ "id": _item })).setPosition(Vector2(_playerTile.x, _playerTile.y))
	get_node("Items/{id}".format({ "id": _item })).show()
	return

func wieldWeapon():
	var _items = $UI/ItemManagement.getSelectedItems()
	get_node("Critters/0/Equipment").wieldWeapon(_items[0], "right")
	closeMenu()

func openPickUpItemMenu(_playerTile):
	if grid[_playerTile.x][_playerTile.y].items.size() != 0 and uIState == uI.GAME:
		$UI/ItemManagement.setItems(grid[_playerTile.x][_playerTile.y].items)
		$UI/ItemManagement.showItemManagementList()
		uIState = uI.PICK_UP_ITEMS

func openDropItemMenu(_playerTile):
	if uIState == uI.GAME:
		$UI/ItemManagement.setItems(get_node("Critters/0/Inventory").getInventory())
		$UI/ItemManagement.showItemManagementList()
		uIState = uI.DROP_ITEMS

func openWieldItemMenu():
	if uIState == uI.GAME:
		$UI/ItemManagement.setItems(get_node("Critters/0/Inventory").getInventory())
		$UI/ItemManagement.showItemManagementList()
		uIState = uI.WIELD

func processAccept():
	if uIState == uI.PICK_UP_ITEMS:
		pickUpItems()
	if uIState == uI.DROP_ITEMS:
		dropItems()
	if uIState == uI.INVENTORY:
		closeMenu()
	if uIState == uI.WIELD:
		wieldWeapon()
	uIState = uI.GAME

func closeMenu():
	if uIState == uI.PICK_UP_ITEMS or uIState == uI.DROP_ITEMS or uIState == uI.WIELD:
		$UI/ItemManagement.hideItemManagementList()
	if uIState == uI.INVENTORY:
		$Critters/Player/Inventory.hideInventoryList()
	uIState = uI.GAME

func placeItemTest():
	var newItem = item.instance()
	newItem.createItemByName("Iron sword", $Items/Items)
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if grid[x][y].creature == 0:
				grid[x][y].items.append(newItem.id)
				newItem.setPosition(Vector2(x, y))
				$Items.add_child(newItem, true)
				return

func placeCritterTest():
	var newt = critter.instance()
	newt.createCritter("Newt", $Critters/Critters)
	for _i in range(100):
		var x = randi() % (grid.size() - 1)
		var y = randi() % (grid[x].size() - 1)
		if(grid[x][y].tile == tiles.FLOOR and grid[x][y].creature == null):
			grid[x][y].creature = newt.id
			break
	$Critters.add_child(newt)
