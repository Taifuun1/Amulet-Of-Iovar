extends TileMap
class_name WorldManagement

onready var player = preload("res://Objects/Player/Player.tscn").instance()

signal turnPassed

enum gameState {
	GAME_OVER
	OUT_OF_PLAYERS_HANDS
	PAUSED
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
	THROW
	THROW_DIRECTION
	DIP_ITEM
	DIP
}

var level = null
var levels = {
	"firstLevel": null,
	"dungeon1": [],
	"library": [],
	"dungeon2": [],
	"beach": [],
	"dungeon3": [],
	"minesOfTidoh": [],
	"depthsOfTidoh": [],
	"dungeon4": [],
	"banditWarcamp": [],
	"storageArea": [],
	"dungeonHalls1": [],
	"labyrinth": [],
	"dungeonHalls2": [],
	"dragonsPeak": [],
	"dungeonHalls3": [],
	"theGreatShadows": [],
	"fortress": [],
	"iovarsLair": [],
	"church": []
}
var churchLevel = null

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

var gameSetUpThread
var saveGameThread

var hideObjectsWhenDrawingNextFrame = true
var checkNewCritterSpawn = 0
var inStartScreen = true
var generationDone = false
var inGame = false
var currentGameState = gameState.GAME
var keepMoving = false
var totalLevelCount = 1
var gameOver = false
var turnData = {
	processAnotherTurn = false,
	processEmptyTurn = false,
	turnProcessFinished = false,
	playerTile = null,
	tileToMoveTo = null,
	turnsLeft = 0,
	safety = true
}
var interactTurnData = {
	"interactTurn": false,
	"interactCompleted": false,
	"item": "",
	"interactType": ""
}

func _physics_process(_delta):
	if turnData.processAnotherTurn and turnData.turnProcessFinished:
		processGameTurn(turnData.playerTile, turnData.tileToMoveTo, turnData.turnsLeft, turnData.safety)
	elif interactTurnData.interactTurn and interactTurnData.interactCompleted and turnData.turnsLeft == 0:
		$Critters/"0".dealWithInteract(turnData.tileToMoveTo)
		interactTurnData = {
			"interactTurn": false,
			"interactCompleted": false,
			"item": "",
			"interactType": ""
		}
	elif inGame:
		if currentGameState != gameState.GAME_OVER and ($Critters/"0".statusEffects["stun"] > 0 or $Critters/"0".statusEffects["sleep"] > 0):
			if $Critters/"0".statusEffects["stun"] > 0: Globals.gameConsole.addLog("You are stunned!")
			if $Critters/"0".statusEffects["sleep"] > 0: Globals.gameConsole.addLog("You are asleep.")
			processGameTurn()
	elif generationDone:
		generationDone = false
		
		yield(get_tree(), "idle_frame")
		
		if !is_connected("turnPassed", self, "_onTurnPassed"):
			# warning-ignore:return_value_discarded
			connect("turnPassed", self, "_onTurnPassed")
		
		for _level in $Levels.get_children():
			_level.clearOutInputs()
		
		$Critters/"0".calculateHungerStats(true)
		$Critters/"0".calculateWeightStats(true)
		$Critters/"0".calculateStatusEffectsAndStatusStates()
		
		updateTiles()
		
		yield(VisualServer, "frame_post_draw")
		
		drawLevel()
		
		inStartScreen = false
		inGame = true
		
		$UI/UITheme/"Dancing Dragons".hide()
		show()

func setUpGameObjects(_playerData = null):
	Globals.mutex.lock()
	Globals.gameConsole = $"/root/World/UI/UITheme/GameConsole"
	Globals.gameStats = $"/root/World/UI/UITheme/GameStats"
	
	$Critters.add_child(player, true)
	player.create(_playerData)
	if _playerData == null:
		level.placeCritterOnTypeOfTile(Globals.tiles.UP_STAIR_DUNGEON, 0)
	player.calculateEquipmentStats()
	
	$Critters/Critters.setNeutralClasses()
	
	yield(VisualServer, "frame_post_draw")
	
	if _playerData == null:
		for _level in $Levels.get_children():
			$Items/Items.generateItemsForLevel(_level)
		
		for _level in $Levels.get_children():
			$Critters/Critters.generateCrittersForLevel(_level)
	
	for _node in $UI/UITheme.get_children():
		if _node.name == "GameConsole":
			_node.show()
		if _node.name == "GameStats":
			_node.show()
	$FOV.show()
	
	Globals.mutex.unlock()
	generationDone = true

func _input(_event):
	if !inStartScreen:
		if (
			inGame and
			currentGameState != gameState.OUT_OF_PLAYERS_HANDS and
			!gameOver and
			$Critters/"0".statusEffects["stun"] == 0 and
			$Critters/"0".statusEffects["sleep"] == 0
		):
			var _playerTile = level.getCritterTile(0)
			if _event is InputEventKey and _event.pressed and turnData.processAnotherTurn:
				keepMoving = false
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
				(
					currentGameState == gameState.GAME or
					currentGameState == gameState.INTERACT or
					currentGameState == gameState.KICK or
					currentGameState == gameState.CAST or
					currentGameState == gameState.ZAP_DIRECTION or
					currentGameState == gameState.THROW_DIRECTION
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
					
					if currentGameState == gameState.ZAP_DIRECTION:
						$"Critters/0".zapItem(_tileToMoveTo - _playerTile)
					elif(
						Globals.isTileFree(_tileToMoveTo, level.grid) or
						(
							Globals.isTileFree(_tileToMoveTo, level.grid, false) and
							$Critters/"0".inventory.checkIfItemInInventoryByName("pickaxe") and
							(
								level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.EMPTY or
								level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.WALL_CAVE or
								level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile == Globals.tiles.WALL_CAVE_DEEP
							) and
							$Critters/"0".autoMine
						)
					):
						if currentGameState == gameState.GAME:
							var _openTiles = level.checkAdjacentTilesForOpenSpace(_playerTile)
							if $Critters/"0".statusEffects["confusion"] > 0 and randi() % 3 == 0:
								var _randomOpenTiles = _openTiles.duplicate(true)
								_randomOpenTiles.shuffle()
								_tileToMoveTo = _randomOpenTiles[0]
							else:
								processGameTurn(_playerTile, _tileToMoveTo, 1 + $Critters/"0".turnsUntilAction)
						elif currentGameState == gameState.INTERACT:
							$Critters/"0".interactWith(_tileToMoveTo)
						elif currentGameState == gameState.KICK:
							$Critters/"0".kickAt(_tileToMoveTo)
						elif currentGameState == gameState.CAST:
							castAt(_playerTile, _tileToMoveTo)
						elif currentGameState == gameState.THROW_DIRECTION:
							$"Critters/0".throwItem(_tileToMoveTo - _playerTile)
			elif (
				Input.is_action_just_pressed("WAIT") and
				currentGameState == gameState.GAME
			):
				processGameTurn()
			elif (
				Input.is_action_just_pressed("ASCEND") and
				(
					level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.UP_STAIR_DUNGEON or
					level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.UP_STAIR_SAND
				) and
				currentGameState == gameState.GAME
			):
				moveLevel(-1)
			elif (
				Input.is_action_just_pressed("DESCEND") and
				(
					level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.DOWN_STAIR_DUNGEON or
					level.grid[_playerTile.x][_playerTile.y].tile == Globals.tiles.DOWN_STAIR_SAND
				) and
				currentGameState == gameState.GAME
			):
				moveLevel(1)
			elif Input.is_action_just_pressed("ACCEPT") and (currentGameState == gameState.PICK_UP_ITEMS or currentGameState == gameState.DROP_ITEMS):
				hideObjectsWhenDrawingNextFrame = true
				processGameTurn(_playerTile)
			elif (Input.is_action_just_pressed("BACK")):
				if Input.is_mouse_button_pressed(2) and (currentGameState == gameState.EQUIPMENT or currentGameState == gameState.RUNES):
					return
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
			elif Input.is_action_just_pressed("THROW") and currentGameState == gameState.GAME:
				openMenu("throw")
			elif Input.is_action_just_pressed("SAVE") and currentGameState == gameState.GAME:
				saveGameInThread()
			elif Input.is_action_just_pressed("PAUSE") and currentGameState == gameState.GAME:
				currentGameState = gameState.PAUSED
				$UI/UITheme/PauseMenu.show()
			elif Input.is_action_just_pressed("KEEP_MOVING") and currentGameState == gameState.GAME:
				keepMoving = true
			elif Input.is_action_just_pressed("GODS_WRATH") and currentGameState == gameState.GAME:
				$Critters/"0".takeDamage([
					{
						"dmg": [9999, 99999],
						"bonusDmg": {},
						"armorPen": 0,
						"magicDmg": {
							"dmg": [0,0],
							"element": null
						}
					}
				], _playerTile, "God")

func processGameTurn(_playerTile = null, _tileToMoveTo = null, _turnsToProcess = 1, _safety = false):
	var _turnsLeft = _turnsToProcess - 1
	processGameEvents(_playerTile, _tileToMoveTo, _turnsLeft, _safety)
	drawScreen()
	if keepMoving and $Critters/"0".statusEffects["confusion"] == 0 and _tileToMoveTo != null and _turnsLeft == 0:
		var _direction = _tileToMoveTo - _playerTile
		checkIfMoveAnotherTile(_tileToMoveTo, _tileToMoveTo + _direction)
	yield(VisualServer, "frame_post_draw")
	turnData.turnProcessFinished = true

func processGameEvents(_playerTile, _tileToMoveTo, _turnsLeft, _safety):
	if _playerTile != null and !turnData.processEmptyTurn:
		processPlayerAction(_playerTile, _tileToMoveTo)
	var _isPlayerHit = processGameTurnActions()
	if interactTurnData.interactTurn and _turnsLeft == 0:
		interactTurnData.interactCompleted = true
	if isGameOver():
		emit_signal("turnPassed", false)
	elif _isPlayerHit and !_safety and _turnsLeft != 0:
		emit_signal("turnPassed", true, false, null, null, _turnsLeft, _safety)
	elif _isPlayerHit and _safety:
		emit_signal("turnPassed", false)
	elif keepMoving and _turnsLeft != 0:
		emit_signal("turnPassed", true, true, _playerTile, _tileToMoveTo, _turnsLeft, _safety)
	else:
		emit_signal("turnPassed", false if _turnsLeft == 0 else true, false if _turnsLeft == 0 else true, _playerTile, _tileToMoveTo, _turnsLeft, _safety)

func processPlayerAction(_playerTile, _tileToMoveTo):
	if (
		(
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
				_tileToMoveTo != null and
				_tileToMoveTo.y >= 0 and
				_tileToMoveTo.y < level.grid[0].size() and
				_tileToMoveTo.x >= 0 and
				_tileToMoveTo.x < level.grid.size()
			)
		) or
		(
			keepMoving and
			_playerTile != null and
			_tileToMoveTo != null
		)
	):
		$"Critters/0".processPlayerAction(_playerTile, _tileToMoveTo, $Items/Items, level)
	elif Input.is_action_pressed("ACCEPT"):
		processAccept()

func processGameTurnActions():
	processPlayerEffects()
	var _isPlayerHit = processEnemyActions()
	processEffects()
	processCrittersSpawnStatus()
	updateStats()
	return _isPlayerHit

func processEnemyActions():
	var _playerTile = level.getCritterTile(0)
	var _isPlayerHit = false
	if level.critters.size() != 0:
		for _enemy in level.critters:
			var _critterTile = level.getCritterTile(_enemy)
			var _critter = get_node("Critters/{id}".format({ "id": _enemy }))
			_critter.isCritterAwakened(_critterTile, _playerTile, level)
			if _critter.statusEffects.sleep == 1:
				Globals.gameConsole.addLog("The {critterName} wakes up!".format({ "critterName": _critter.critterName }))
			elif _critter.statusEffects.sleep > 0:
				Globals.gameConsole.addLog("The {critterName} is fast asleep.".format({ "critterName": _critter.critterName }))
			elif _critter.processCritterAction(_critterTile, _playerTile, _enemy, level):
				_isPlayerHit = true
				if $Critters/"0".statusEffects.sleep > 0:
					$Critters/"0".statusEffects.sleep = 0
					Globals.gameConsole.addLog("You wake up!")
			_critter.processCritterEffects()
	return _isPlayerHit

func processCrittersSpawnStatus():
	if checkNewCritterSpawn >= 25:
		$Critters/Critters.checkSpawnableCrittersLevel()
		$Critters/Critters.checkNewCritterSpawn(level)
		checkNewCritterSpawn = 0
	else:
		checkNewCritterSpawn += 1

func processPlayerEffects():
	$Critters/"0".calculateHungerStats()
	$Critters/"0".calculateWeightStats()
	$Critters/"0".calculateStatusEffectsAndStatusStates()
	$Critters/"0".processPlayerSpecificEffects()
	$Critters/"0".processCritterEffects()

func processEffects():
	for _effect in $Effects.get_children():
		if _effect.levelId == level.levelId:
			_effect.tickTurn(level)

func drawScreen():
	drawLevel()
	updateTiles()
	yield(VisualServer, "frame_post_draw")

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
	yield(get_tree(), "idle_frame")
	
	if hideObjectsWhenDrawingNextFrame:
		for _critter in $Critters.get_children():
			_critter.hide()
		
		for _item in $Items.get_children():
			_item.hide()
		
		hideObjectsWhenDrawingNextFrame = false
	
	drawFOV()
	drawCrittersAndItems()

	updateUI()

func drawFOV():
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
	$Critters/"0".inventory.updateWeight()
	$Critters/"0".processPlayerUIChanges()
	$Critters/"0".updatePlayerStats()

func updateStats():
	GlobalGameStats.gameStats["Turn count"] += 1

func isGameOver():
	if gameOver:
		return true
	elif $Critters/"0".hp <= 0:
		Globals.gameConsole.addLog("You die...")
		currentGameState = gameState.GAME_OVER
		$"UI/UITheme/Game Over Stats".setValues("You die!", $Critters/"0".getGameOverStats())
		$"UI/UITheme/Game Over Stats".saveGameData()
		$"UI/UITheme/Game Over Stats".show()
		gameOver = true
		yield(VisualServer, "frame_post_draw")
		return true
	return false

func checkIfMoveAnotherTile(_playerTile, _tileToMoveTo):
	if (
		Globals.isTileFree(_tileToMoveTo, level.grid) and
		level.grid[_tileToMoveTo.x][_tileToMoveTo.y].tile != Globals.tiles.DOOR_CLOSED and
		(
			_playerTile.y - 1 < 0 or
			level.grid[_playerTile.x][_playerTile.y - 1].critter == null
		) and
		(
			_playerTile.y - 1 < 0 or
			level.grid.size() - 1 < _playerTile.x + 1 or
			level.grid[_playerTile.x + 1][_playerTile.y - 1].critter == null
		) and
		(
			level.grid.size() - 1 < _playerTile.x + 1 or
			level.grid[_playerTile.x + 1][_playerTile.y].critter == null
		) and
		(
			level.grid.size() - 1 < _playerTile.x + 1 or
			level.grid[0].size() - 1 < _playerTile.y + 1 or
			level.grid[_playerTile.x + 1][_playerTile.y + 1].critter == null
		) and
		(
			level.grid[0].size() - 1 < _playerTile.y + 1 or
			level.grid[_playerTile.x][_playerTile.y + 1].critter == null
		) and
		(
			_playerTile.x - 1 < 0 or
			level.grid[0].size() - 1 < _playerTile.y + 1 or
			level.grid[_playerTile.x - 1][_playerTile.y + 1].critter == null
		) and
		(
			_playerTile.x - 1 < 0 or
			level.grid[_playerTile.x - 1][_playerTile.y].critter == null
		) and
		(
			_playerTile.x - 1 < 0 or
			_playerTile.y - 1 < 0 or
			level.grid[_playerTile.x - 1][_playerTile.y - 1].critter == null
		)
	):
		emit_signal("turnPassed", true, false, _playerTile, _tileToMoveTo, 1 + $Critters/"0".turnsUntilAction, turnData.safety)
		return
	else:
		keepMoving = false
	emit_signal("turnPassed", false)

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
	
	if $Critters/"0".inventory.checkIfItemInInventoryByName("Amulet of Iovar") and randi() % 8 == 0:
		var _openTiles = level.checkAdjacentTilesForOpenSpace(level.stairs[_placePlayerOnStair], false, true)
		$Critters/Critters.spawnCritter("Iovar", _openTiles[randi() % _openTiles.size()])
		Globals.gameConsole.addLog("Iovar appears before you!")
	
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

func whichLevelAndStairIsPlayerPlacedUpon(_direction, _playerTile):
	var _stair
	for _stairDirection in level.stairs.keys():
		if level.stairs[_stairDirection] == _playerTile:
			_stair = _stairDirection
			break
	if _direction == 1:
		if levels.dungeon1.back().levelId == Globals.currentDungeonLevel:
			if _stair.matchn("secondDownStair"):
				Globals.currentDungeonLevel = levels.library.front().levelId
				return "upStair"
			if _stair.matchn("downStair"):
				Globals.currentDungeonLevel = levels.dungeon2.front().levelId
				return "upStair"
		elif levels.dungeon2.back().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.beach.front().levelId
			return "upStair"
		elif levels.beach.back().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeon3.front().levelId
			return "upStair"
		elif levels.dungeon3.back().levelId == Globals.currentDungeonLevel:
			if _stair.matchn("secondDownStair"):
				Globals.currentDungeonLevel = levels.minesOfTidoh.front().levelId
				return "upStair"
			if _stair.matchn("downStair"):
				Globals.currentDungeonLevel = levels.dungeon4.front().levelId
				return "upStair"
		elif levels.dungeon4.back().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.banditWarcamp.front().levelId
			return "upStair"
		elif levels.banditWarcamp.back().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.storageArea.front().levelId
			return "upStair"
		elif levels.dungeonHalls1.back().levelId == Globals.currentDungeonLevel:
			if _stair.matchn("secondDownStair"):
				Globals.currentDungeonLevel = levels.labyrinth.front().levelId
				return "upStair"
			if _stair.matchn("downStair"):
				Globals.currentDungeonLevel = levels.dungeonHalls2.front().levelId
				return "upStair"
		elif levels.dungeonHalls2.back().levelId == Globals.currentDungeonLevel:
			if _stair.matchn("secondUpStair"):
				Globals.currentDungeonLevel = levels.dragonsPeak.front().levelId
				return "downStair"
			if _stair.matchn("downStair"):
				Globals.currentDungeonLevel = levels.dungeonHalls3.front().levelId
				return "upStair"
		elif levels.dungeonHalls3.back().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.theGreatShadows.front().levelId
			return "upStair"
		elif levels.theGreatShadows.back().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.fortress.front().levelId
			return "upStair"
		elif levels.fortress.back().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.iovarsLair.front().levelId
			return "upStair"
		elif churchLevel.levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.firstLevel.levelId
			return "upStair"
		else:
			Globals.currentDungeonLevel += _direction
			return "upStair"
	elif _direction == -1:
		if levels.dungeon2.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeon1.back().levelId
			return "downStair"
		elif levels.library.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeon1.back().levelId
			return "secondDownStair"
		elif levels.beach.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeon2.back().levelId
			return "downStair"
		elif levels.dungeon3.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.beach.back().levelId
			return "downStair"
		elif levels.minesOfTidoh.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeon3.back().levelId
			return "secondDownStair"
		elif levels.dungeon4.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeon3.back().levelId
			return "downStair"
		elif levels.banditWarcamp.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeon4.back().levelId
			return "downStair"
		elif levels.storageArea.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.banditWarcamp.back().levelId
			return "downStair"
		elif levels.dungeonHalls1.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.storageArea.back().levelId
			return "downStair"
		elif levels.dungeonHalls2.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeonHalls1.back().levelId
			return "downStair"
		elif levels.labyrinth.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeonHalls1.back().levelId
			return "secondDownStair"
		elif levels.dungeonHalls3.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeonHalls2.back().levelId
			return "downStair"
		elif levels.dragonsPeak.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeonHalls2.back().levelId
			return "secondUpStair"
		elif levels.theGreatShadows.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.dungeonHalls3.back().levelId
			return "downStair"
		elif levels.fortress.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.theGreatShadows.back().levelId
			return "downStair"
		elif levels.iovarsLair.front().levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = levels.fortress.back().levelId
			return "downStair"
		elif levels.firstLevel.levelId == Globals.currentDungeonLevel:
			Globals.currentDungeonLevel = churchLevel.levelId
			return "downStair"
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
				$UI/UITheme/ItemManagement.showItemManagementList("Pick up what?", false)
				currentGameState = gameState.PICK_UP_ITEMS
		"drop":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.inventory
				$UI/UITheme/ItemManagement.showItemManagementList("Drop what?", false)
				currentGameState = gameState.DROP_ITEMS
		"loot":
			if currentGameState == gameState.GAME:
				var _items
				_items = $Critters/"0"/Inventory.getItemsOfType(["tool"], "Container")
				for _itemId in level.grid[_playerTile.x][_playerTile.y].items:
					if get_node("Items/{itemId}".format({ "itemId": _itemId })).category != null and get_node("Items/{itemId}".format({ "itemId": _itemId })).category.matchn("container"):
						_items.append(_itemId)
				$UI/UITheme/ItemManagement.items = _items
				$UI/UITheme/ItemManagement.showItemManagementList("Loot what?")
				currentGameState = gameState.PICK_LOOTABLE
		"equipment":
			if currentGameState == gameState.GAME:
				$UI/UITheme/Equipment.showEquipment($Critters/"0"/Inventory.getItemsOfType(["accessory", "armor", "belt", "cloak", "gauntlets", "weapon"]))
				currentGameState = gameState.EQUIPMENT
		"read":
			if currentGameState == gameState.GAME:
				var _items = $Critters/"0"/Inventory.getItemsOfType(["scroll"])
				var _tools = $Critters/"0"/Inventory.getItemsOfType(["tool"])
				for _itemId in _tools:
					if get_node("Items/{itemId}".format({ "itemId": _itemId })).identifiedItemName.matchn("tome of knowledge"):
						_items.append(_itemId)
				$UI/UITheme/ItemManagement.items = _items
				$UI/UITheme/ItemManagement.showItemManagementList("Read what?")
				currentGameState = gameState.READ
		"runes":
			if currentGameState == gameState.GAME:
				$UI/UITheme/Runes.showRunes($Critters/"0"/Inventory.getItemsOfType(["rune"]))
				currentGameState = gameState.RUNES
		"quaff":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["potion"])
				$UI/UITheme/ItemManagement.showItemManagementList("Quaff what?")
				currentGameState = gameState.QUAFF
		"consume":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["comestible"])
				$UI/UITheme/ItemManagement.showItemManagementList("Consume what?")
				currentGameState = gameState.CONSUME
		"zap":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["wand"])
				$UI/UITheme/ItemManagement.showItemManagementList("Zap what?")
				currentGameState = gameState.ZAP
		"throw":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["potion"])
				$UI/UITheme/ItemManagement.showItemManagementList("Throw what?")
				currentGameState = gameState.THROW
		"dip":
			if currentGameState == gameState.GAME:
				$UI/UITheme/ItemManagement.items = $Critters/"0"/Inventory.getItemsOfType(["scroll", "wand"])
				$UI/UITheme/ItemManagement.showItemManagementList("Dip what?")
				currentGameState = gameState.DIP_ITEM
		"use":
			if currentGameState == gameState.GAME:
				var _items
				_items = $Critters/"0"/Inventory.getItemsOfType(["potion", "tool"], null, ["corpse"])
				for _itemId in _items:
					if (
						(
							get_node("Items/{itemId}".format({ "itemId": _itemId })).category != null and
							get_node("Items/{itemId}".format({ "itemId": _itemId })).category.matchn("container")
						) or
						get_node("Items/{itemId}".format({ "itemId": _itemId })).identifiedItemName.matchn("credit card") or
						get_node("Items/{itemId}".format({ "itemId": _itemId })).identifiedItemName.matchn("lockpick") or
						get_node("Items/{itemId}".format({ "itemId": _itemId })).identifiedItemName.matchn("key") or
						get_node("Items/{itemId}".format({ "itemId": _itemId })).identifiedItemName.matchn("magic key")
					):
						_items.erase(_itemId)
				$UI/UITheme/ItemManagement.items = _items
				$UI/UITheme/ItemManagement.showItemManagementList("Use what?")
				currentGameState = gameState.USE

func castWith(_playerTile):
	match $UI/UITheme/Runes.isCastableRunes():
		"direction":
			currentGameState = gameState.CAST
			Globals.gameConsole.addLog("Cast towards what? (Pick a direction with numpad)")
		"directionless":
			$UI/UITheme/Runes.castSpell(_playerTile)
		"notCastable":
			Globals.gameConsole.addLog("Your currently worn runes are not enough to cast a spell.")

func castAt(_playerTile, _tileToCastAt):
	currentGameState = gameState.OUT_OF_PLAYERS_HANDS
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
	if currentGameState == gameState.THROW:
		$UI/UITheme/ItemManagement.hideItemManagementList()
		if _pickDirection:
			currentGameState = gameState.THROW_DIRECTION
			Globals.gameConsole.addLog("Throw at what? (Pick a direction with numpad)")
			return
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
		if currentGameState == gameState.PAUSED:
			$UI/UITheme/PauseMenu.hide()
		$UI/UITheme/ListMenu.hideListMenuList()
	resetToDefaulGameState()

func resetToDefaulGameState():
	$"Critters/0".selectedItem = null
	$UI/UITheme/Equipment.hoveredEquipment = null
	currentGameState = gameState.GAME
	inGame = true
	keepMoving = false

func saveGameInThread():
	currentGameState = gameState.OUT_OF_PLAYERS_HANDS
	$UI/UITheme/"Dancing Dragons".setLoadingText("Saving game...")
	$UI/UITheme/"Dancing Dragons".startDancingDragons()
	saveGameThread = Thread.new()
	yield(VisualServer, "frame_post_draw")
	saveGameThread.start(self, "saveGame")

func saveGame():
	var dir = Directory.new()
	
	if dir.open("user://SaveSlot{selectedSave}/items".format({ "selectedSave": StartingData.selectedSave })) == OK:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if !dir.current_is_dir():
				dir.remove("user://SaveSlot{selectedSave}/items/{fileName}".format({ "selectedSave": StartingData.selectedSave, "fileName": fileName }))
			fileName = dir.get_next()
	else:
		push_error("An error occurred when trying to access the path.")
	
	if dir.open("user://SaveSlot{selectedSave}/critters".format({ "selectedSave": StartingData.selectedSave })) == OK:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if !dir.current_is_dir():
				dir.remove("user://SaveSlot{selectedSave}/critters/{fileName}".format({ "selectedSave": StartingData.selectedSave, "fileName": fileName }))
			fileName = dir.get_next()
	else:
		push_error("An error occurred when trying to access the path.")
	
	for _item in $Items.get_children():
		if _item.name.matchn("Items"):
			var _itemData = _item.getItemsSaveData()
			$Save.saveData("Items", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }), _itemData)
			continue
		var _itemData = _item.getItemSaveData()
		$Save.saveData(_itemData.id, "SaveSlot{selectedSave}/items".format({ "selectedSave": StartingData.selectedSave }), _itemData)
	
	for _critter in $Critters.get_children():
		if _critter.name.matchn("Critters"):
			continue
		var _critterData = _critter.getCritterSaveData()
		$Save.saveData(_critterData.id, "SaveSlot{selectedSave}/critters".format({ "selectedSave": StartingData.selectedSave }), _critterData)
	
	for _levelSection in levels.values():
		if typeof(_levelSection) != TYPE_ARRAY:
			var _levelData = _levelSection.getLevelSaveData()
			$Save.saveData(_levelData.levelId, "SaveSlot{selectedSave}/levels".format({ "selectedSave": StartingData.selectedSave }), _levelData)
		else:
			for _level in _levelSection:
				var _levelData = _level.getLevelSaveData()
				$Save.saveData(_levelData.levelId, "SaveSlot{selectedSave}/levels".format({ "selectedSave": StartingData.selectedSave }), _levelData)
	var _levelData = churchLevel.getLevelSaveData()
	$Save.saveData(_levelData.levelId, "SaveSlot{selectedSave}/levels".format({ "selectedSave": StartingData.selectedSave }), _levelData)
	
	var _fovData = $FOV.getFOVSaveData()
	$Save.saveData("FOVData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }), _fovData)
	
	var _globalsData = Globals.getGlobalsSaveData()
	$Save.saveData("GlobalsData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }), _globalsData)
	
	var _globalItemData = GlobalItemInfo.getGlobalItemSaveData()
	$Save.saveData("GlobalItemData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }), _globalItemData)
	
	var _globalCritterData = GlobalCritterInfo.getGlobalCritterSaveData()
	$Save.saveData("GlobalCritterData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }), _globalCritterData)
	
	var _globalGameStats = GlobalGameStats.getGlobalGameStats()
	$Save.saveData("GlobalGameStats", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }), _globalGameStats)
	
	var _equipmentData = $UI/UITheme/Equipment.getEquipmentSaveData()
	_equipmentData.merge($UI/UITheme/Runes.getRunesSaveData())
	$Save.saveData("EquipmentData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }), _equipmentData)
	
	var _saveData = {
		"saveSlot": StartingData.selectedSave,
		"hasSave": true,
		"className": $Critters/"0".critterClass,
		"dungeonLevelName": Globals.currentDungeonLevelName,
		"level": Globals.currentDungeonLevel,
		"points": $Critters/"0"/Inventory.getPoints().totalPoints
	}
	$Save.saveData("SaveData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }), _saveData)
	
	saveGameThread.call_deferred("wait_to_finish")
	get_tree().quit()



######################################
### Signal and debug functions ###
######################################

func _onPlayerAnimationDone():
	processGameTurn()
	resetToDefaulGameState()

func _on_Critter_Animation_done():
	pass
#	if $Animations.get_child_count() == 1:
#		resetToDefaulGameState()

func _onTurnPassed(_processAnotherTurn = null, processEmptyTurn = false, _playerTile = null, _tileToMoveTo = null, _turnsLeft = 0, _safety = true):
	if _processAnotherTurn != null:
		turnData = {
			processAnotherTurn = _processAnotherTurn,
			processEmptyTurn = processEmptyTurn,
			turnProcessFinished = false,
			playerTile = _playerTile,
			tileToMoveTo = _tileToMoveTo,
			turnsLeft = _turnsLeft,
			safety = _safety
		}

func __debug__go_to_level(_level):
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
