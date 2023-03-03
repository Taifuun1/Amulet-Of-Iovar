extends Control

var runeItem = load("res://UI/Runes/Rune Item.tscn")
var projectile = load("res://Objects/Projectile/Projectile.tscn")

var runeData = load("res://Objects/Data/RuneData.gd").new().runeData
var spellData = load("res://Objects/Data/SpellData.gd").new().spellData
var miasmaData = load("res://Objects/Data/SpellMiasmaData.gd").new()

const runesUITemplatePaths = {
	"eario": "res://Assets/UI/RuneEario.png",
	"luirio": "res://Assets/UI/RuneLuirio.png",
	"heario": "res://Assets/UI/RuneHeario.png"
}

var runes = {
	"eario": null,
	"luirio": null,
	"heario": null
}

var spellDamage = [{
	"dmg": [0,0],
	"bonusDmg": {},
	"armorPen": 0,
	"magicDmg": {
		"dmg": [0,0],
		"element": null
	}
}]

var mpUsage = 0
var bonusMagicDmg = 0

var hoveredRune = null

func sortRunes(_equipmentIdA, _equipmentIdB):
	if get_node("/root/World/Items/{itemId}".format({ "itemId": _equipmentIdA })).itemName < get_node("/root/World/Items/{itemId}".format({ "itemId": _equipmentIdB })).itemName:
		return true
	return false

func create():
	name = "Runes"
	hide()



###########################
### Rune menu functions ###
###########################

func showRunes(_items):
	_items.sort_custom(self, "sortRunes")
	for _item in _items:
		var _newItem = runeItem.instance()
		_newItem.setValues(get_node("/root/World/Items/{item}".format({ "item": _item })))
		$ItemsContainer/ItemsContentContainer/ItemList.add_child(_newItem)
	show()

func hideRunes():
	for _item in $ItemsContainer/ItemsContentContainer/ItemList.get_children():
		_item.queue_free()
	hide()



#############################
### Rune change functions ###
#############################

func setRunes(_id):
	var _rune = get_node("/root/World/Items/{id}".format({ "id": _id }))
	if checkIfMatchingRuneAndSlot(_rune.type, _rune.category):
		runes[hoveredRune.to_lower()] = _id
		get_node("RuneContainer/{slot}/Sprite".format({ "slot": hoveredRune })).texture = _rune.getTexture()
		checkWhatRuneIsEquipped(_rune)
		calculateMagicDamage()
		$"/root/World".processGameTurn()

func _process(_delta):
	if Input.is_action_just_released("RIGHT_CLICK") and hoveredRune != null:
		var _rune = get_node("/root/World/Items/{id}".format({ "id": runes[hoveredRune.to_lower()] }))
		if _rune != null:
			runes[hoveredRune.to_lower()] = null
			get_node("RuneContainer/{slot}/Sprite".format({ "slot": hoveredRune })).texture = load(runesUITemplatePaths[hoveredRune.to_lower()])
			checkWhatRuneIsEquipped(_rune)
			calculateMagicDamage()
			$"/root/World".processGameTurn()



############################
### Spell cast functions ###
############################

func castSpell(_playerTile, _tileToCastTo = null, grid = null):
	yield(get_tree(), "idle_frame")
	
	if $"/root/World/Critters/0".mp - mpUsage < 0:
		$"/root/World".resetToDefaulGameState()
		Globals.gameConsole.addLog("You don't have mp to cast that spell!")
		return
	
	var _projectile = projectile.instance()
	
	var _eario = get_node("/root/World/Items/{itemId}".format({ "itemId": runes.eario })).value.to_lower()
	var _luirio = get_node("/root/World/Items/{itemId}".format({ "itemId": runes.luirio })).value.to_lower()
	var _heario = null
	if runes.heario != null:
		_heario = get_node("/root/World/Items/{itemId}".format({ "itemId": runes.heario })).value.to_lower()
	var _projectileData = {
		"color": spellData[_eario].color,
		"damage": spellDamage
	}
	var _tiles = []
	
	if _tileToCastTo == null:
		_projectileData.texture = load("res://Assets/Spells/Adjacent.png")
		var _adjacentTiles = []
		for _data in runeData.luirio.adjacent.spellDirections:
			_adjacentTiles.append({ "tile": _playerTile + _data.direction, "angle": _data.angle })
			if _eario.matchn("toxix") or (_heario != null and _heario.matchn("gas")):
				createMiasma(_playerTile + _data.direction, _eario)
		_tiles.append(_adjacentTiles)
	else:
		var _direction = _tileToCastTo - _playerTile
		if _luirio.matchn("point"):
			var _previousTile = _playerTile
			var _checkedTile = _playerTile + _direction
			for _i in range(runeData.luirio[_luirio].distance):
				if (
					!Globals.isTileFree(_checkedTile, grid) or
					grid[_checkedTile.x][_checkedTile.y].tile == Globals.tiles.DOOR_CLOSED or
					(
						_checkedTile.x < 0 or
						_checkedTile.y < 0 or
						_checkedTile.x > Globals.gridSize.x - 1 or
						_checkedTile.y > Globals.gridSize.y - 1
					)
				):
					_tiles.append([{ "tile": _previousTile, "angle": 0 }])
					if _eario.matchn("toxix") or (_heario != null and _heario.matchn("gas")):
						createMiasma(_previousTile, _eario)
					break
				elif grid[_checkedTile.x][_checkedTile.y].critter != null and grid[_checkedTile.x][_checkedTile.y].critter != 0:
					_tiles.append([{ "tile": _checkedTile, "angle": 0 }])
					if _eario.matchn("toxix") or (_heario != null and _heario.matchn("gas")):
						createMiasma(_checkedTile, _eario)
					break
				_previousTile += _direction
				_checkedTile += _direction
		if _luirio.matchn("line"):
			var _checkedTile = _playerTile + _direction
			for _i in range(runeData.luirio[_luirio].distance):
				if (
					!Globals.isTileFree(_checkedTile, grid) or
					grid[_checkedTile.x][_checkedTile.y].tile == Globals.tiles.DOOR_CLOSED or
					(
						_checkedTile.x < 0 or
						_checkedTile.y < 0 or
						_checkedTile.x > Globals.gridSize.x - 1 or
						_checkedTile.y > Globals.gridSize.y - 1
					)
				):
					break
				_tiles.append([{ "tile": _checkedTile, "angle": runeData.luirio[_luirio].spellDirections[_direction].angle }])
				if _eario.matchn("toxix") or (_heario != null and _heario.matchn("gas")):
					createMiasma(_checkedTile, _eario)
				if grid[_checkedTile.x][_checkedTile.y].critter != null:
					break
				else:
					_checkedTile += _direction
		elif _luirio.matchn("cone") or _luirio.matchn("fourway"):
			var _spellDirections = runeData.luirio[_luirio].spellDirections[_direction].duplicate(true)
			for _i in range(runeData.luirio[_luirio].distance):
				var _lineTiles = []
				for _spellDirectionIndex in _spellDirections.size():
					if typeof(_spellDirections[_spellDirectionIndex].direction) != TYPE_BOOL:
						var _checkedTile = _playerTile + _spellDirections[_spellDirectionIndex].direction
						if (
							!Globals.isTileFree(_checkedTile, grid) or
							grid[_checkedTile.x][_checkedTile.y].tile == Globals.tiles.DOOR_CLOSED or
							(
								_checkedTile.x < 0 or
								_checkedTile.y < 0 or
								_checkedTile.x > Globals.gridSize.x - 1 or
								_checkedTile.y > Globals.gridSize.y - 1
							)
						):
							_spellDirections[_spellDirectionIndex].direction = false
						else:
							_lineTiles.append({ "tile": _checkedTile, "angle": _spellDirections[_spellDirectionIndex].angle })
							if _eario.matchn("toxix") or (_heario != null and _heario.matchn("gas")):
								createMiasma(_checkedTile, _eario)
							_spellDirections[_spellDirectionIndex].direction += runeData.luirio[_luirio].spellDirections[_direction][_spellDirectionIndex].direction
				if _lineTiles.empty():
					break
				_tiles.append(_lineTiles)
	if runes.heario == null:
		_projectileData.texture = load("res://Assets/Spells/NoHeario.png")
	else:
		_projectileData.texture = runeData.heario[get_node("/root/World/Items/{itemId}".format({ "itemId": runes.heario })).value.to_lower()].texture
	
	_projectile.create(_tiles, _projectileData, true)
	$"/root/World/Animations".add_child(_projectile)
	# warning-ignore:return_value_discarded
	$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).connect("playerAnimationDone", $"/root/World", "_onPlayerAnimationDone")
	$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).animateCycle()
	
	$"/root/World/Critters/0".mp -= mpUsage

func createMiasma(_tile, _eario):
	var _miasmaNode = load("res://UI/Effect/Effect.tscn").instance()
	var _miasmaData = miasmaData["{eario}Miasma".format({ "eario": _eario }).replace("'", "")]
	_miasmaNode.create(load("res://Assets/Spells/Gas.png"), spellData[_eario].color, _tile, _miasmaData.name, $"/root/World".level.levelId, _miasmaData.duration, _miasmaData.attacks)
	$"/root/World/Effects".add_child(_miasmaNode)
	$"/root/World".level.grid[_tile.x][_tile.y].effects.append(_miasmaData.name)



########################
### Helper functions ###
########################

func checkWhatRuneIsEquipped(_rune):
	if (
		GlobalItemInfo.globalItemInfo.has(_rune.identifiedItemName) and
		GlobalItemInfo.globalItemInfo[_rune.identifiedItemName].identified == false
	):
		GlobalItemInfo.globalItemInfo[_rune.identifiedItemName].identified = true
		Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _rune.identifiedItemName, "unidentifiedItemName": _rune.unidentifiedItemName }))
	var _playerNode = $"/root/World/Critters/0"
	_playerNode.checkAllIdentification(true)

func checkIfMatchingRuneAndSlot(_type, _category):
	if _type.matchn("rune"):
		if (
			_category.matchn("eario") and
			hoveredRune.matchn("eario")
		):
			return true
		if (
			_category.matchn("luirio") and
			hoveredRune.matchn("luirio")
		):
			return true
		if (
			_category.matchn("heario") and
			hoveredRune.matchn("heario")
		):
			return true
	return false

func takeOfRuneWhenDroppingItem(_id):
	for _rune in runes.keys():
		if runes[_rune] != null and runes[_rune] == _id:
			runes[_rune] = null
			get_node("RuneContainer/{slot}/Sprite".format({ "slot": _rune.capitalize() })).texture = load(runesUITemplatePaths[_rune.to_lower()])
			calculateMagicDamage()
			return

func isCastableRunes():
	if runes.eario != null and runes.luirio != null:
		if get_node("/root/World/Items/{id}".format({ "id": runes["luirio"] })).value.matchn("fourway") or get_node("/root/World/Items/{id}".format({ "id": runes["luirio"] })).value.matchn("line") or get_node("/root/World/Items/{id}".format({ "id": runes["luirio"] })).value.matchn("cone") or get_node("/root/World/Items/{id}".format({ "id": runes["luirio"] })).value.matchn("point"):
			return "direction"
		return "directionless"
	return "notCastable"

func isOnlyEarioEquipped():
	if runes.eario != null and runes.luirio == null and runes.heario == null:
		return get_node("/root/World/Items/{id}".format({ "id": runes.eario })).value.to_lower()
	return false

func calculateMagicDamage():
	var _magicAttacks = []
	if isCastableRunes() == "notCastable":
		spellDamage = [{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [0,0],
				"element": null
			}
		}]
		mpUsage = 0
		return
	elif runes.heario == null:
		var _earioNode = get_node("/root/World/Items/{id}".format({ "id": runes["eario"] }))
		var _magicDamageIncrease = calculateMagicDamageIncrease(_earioNode.value)
		for _d in range(1 + _magicDamageIncrease.d):
			_magicAttacks.append({
				"dmg": [0,0],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [int(spellData[_earioNode.value.to_lower()].baseDmg[0] * 0.5 + _magicDamageIncrease.dmg), int(spellData[_earioNode.value.to_lower()].baseDmg[1] * 0.5 + _magicDamageIncrease.dmg)],
					"element": _earioNode.value
				}
			})
		mpUsage = 0
		for _rune in runes:
			if !_rune.matchn("heario"):
				mpUsage += runeData[_rune][get_node("/root/World/Items/{id}".format({ "id": runes[_rune] })).value.to_lower()].mp
#	"effect": runeData.heario[runes.heario].effectMultiplier
	else:
		var _earioNode = get_node("/root/World/Items/{id}".format({ "id": runes["eario"] }))
		var _hearioNode = get_node("/root/World/Items/{id}".format({ "id": runes["heario"] }))
		var _magicDamageIncrease = calculateMagicDamageIncrease(_earioNode.value)
		for _d in range(1 + _magicDamageIncrease.d):
			_magicAttacks.append({
				"dmg": [0,0],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [int(spellData[_earioNode.value.to_lower()].baseDmg[0] * runeData.heario[_hearioNode.value.to_lower()].dmgMultiplier + _magicDamageIncrease.dmg), int(spellData[_earioNode.value.to_lower()].baseDmg[0] * runeData.heario[_hearioNode.value.to_lower()].dmgMultiplier + _magicDamageIncrease.dmg)],
					"element": _earioNode.value
				}
			})
		mpUsage = 0
		for _rune in runes:
			mpUsage += runeData[_rune][get_node("/root/World/Items/{id}".format({ "id": runes[_rune] })).value.to_lower()].mp
	if _magicAttacks[0].magicDmg.dmg[0] != 0 and _magicAttacks[0].magicDmg.dmg[1] != 0:
		_magicAttacks[0].magicDmg.dmg = [_magicAttacks[0].magicDmg.dmg[0] + bonusMagicDmg, _magicAttacks[0].magicDmg.dmg[1] + bonusMagicDmg]
	spellDamage = _magicAttacks
	$"/root/World/Critters/0".updatePlayerStats()

func calculateMagicDamageIncrease(_type):
	var _stats = $"/root/World/Critters/0".stats
	var _critterClass = $"/root/World/Critters/0".critterClass
	var _player = $"/root/World/Critters/0"
	if _type.matchn("fleir"):
		var _additionalDamage = 0
		
		if _critterClass.matchn("exterminator"):
			_additionalDamage += 2
		
		return {
			"dmg": _stats.belief / 2 + _additionalDamage,
			"d": 0
		}
	if _type.matchn("frost"):
		var _additionalDamage = 0
		var _d = 0
		
		if _critterClass.matchn("savant"):
			_additionalDamage += 3
		
		if _player.checkIfItemsTurnedOnHasItem("toga"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("fabric gloves"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("alchemists robes"):
			_additionalDamage += 2
		
		if _player.checkIfItemsTurnedOnHasItem("boots of magic"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("cool mikeys"):
			_additionalDamage += 2
		
		if _stats.wisdom > 18:
			_additionalDamage += 3
		
		return {
			"dmg": _stats.wisdom / 3 + _additionalDamage,
			"d": _d
		}
	if _type.matchn("thunder"):
		var _additionalDamage = 0
		var _d = 0
		
		if _critterClass.matchn("savant"):
			_additionalDamage += 3
		
		if _player.checkIfItemsTurnedOnHasItem("toga"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("fabric gloves"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("alchemists robes"):
			_additionalDamage += 2
		
		if _player.checkIfItemsTurnedOnHasItem("boots of magic"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("cool mikeys"):
			_additionalDamage += 2
		
		if _stats.wisdom > 27:
			_additionalDamage += 3
		
		return {
			"dmg": _stats.wisdom / 3 + _additionalDamage,
			"d": _d
		}
	if _type.matchn("gleeie'er"):
		var _additionalDamage = 0
		var _d = 0
		
		if _critterClass.matchn("freedom fighter"):
			_additionalDamage += 2
		
		if _player.checkIfItemsTurnedOnHasItem("toga"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("fabric gloves"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("boots of magic"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("cool mikeys"):
			_additionalDamage += 2
		
		if _stats.visage > 32:
			_d = 2
		elif _stats.visage > 19:
			_d = 1
		
		return {
			"dmg": _stats.visage / 3 + _additionalDamage,
			"d": _d
		}
	if _type.matchn("toxix"):
		var _additionalDamage = 0
		var _d = 0
		
		if _critterClass.matchn("rogue"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("toga"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("fabric gloves"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("boots of magic"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("cool mikeys"):
			_additionalDamage += 2
		
		if _stats.visage > 30:
			_d += 4
		elif _stats.visage > 23:
			_d += 3
		elif _stats.visage > 18:
			_d += 2
		elif _stats.visage > 15:
			_d += 1
		
		return {
			"dmg": _additionalDamage,
			"d": _d
		}

func loadRunesData(_data):
	runes = _data.runes
	spellDamage = _data.spellDamage
	mpUsage = int(_data.mpUsage)
	
	setRuneTextures()

func setRuneTextures():
	for _rune in runes.keys():
		if runes[_rune] != null:
			var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": runes[_rune] }))
			get_node("RuneContainer/{slot}/Sprite".format({ "slot": _rune.capitalize() })).texture = _item.getTexture()

func getRunesSaveData():
	return {
		runes = runes,
		spellDamage = spellDamage,
		mpUsage = mpUsage
	}



########################
### Signal functions ###
########################

func _on_mouse_entered_rune_slot(_equipmentSlot):
	hoveredRune = _equipmentSlot

func _on_mouse_exited_rune_slot():
	hoveredRune = null
