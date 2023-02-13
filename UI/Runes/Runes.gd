extends Control

var runeItem = load("res://UI/Runes/Rune Item.tscn")
var spell = load("res://Objects/Spell/Spell.tscn")

var runeData = load("res://Objects/Spell/RuneData.gd").new()
var spellData = load("res://Objects/Spell/SpellData.gd").new()

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

var hoveredEquipment = null

func create():
	name = "Runes"
	hide()



###########################
### Rune menu functions ###
###########################

func showRunes(_items):
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
		runes[hoveredEquipment.to_lower()] = _id
		get_node("RuneContainer/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _rune.getTexture()
		checkWhatRuneIsEquipped(_rune)
		calculateMagicDamage()
		$"/root/World".processGameTurn()

func _process(_delta):
	if Input.is_action_just_released("RIGHT_CLICK") and hoveredEquipment != null:
		var _rune = get_node("/root/World/Items/{id}".format({ "id": runes[hoveredEquipment.to_lower()] }))
		if _rune != null:
			runes[hoveredEquipment.to_lower()] = null
			get_node("RuneContainer/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = load(runesUITemplatePaths[hoveredEquipment.to_lower()])
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
	
	var _newSpell = spell.instance()
	
	var _runeData = {
		"eario": null,
		"luirio": null,
		"heario": null
	}
	var _tiles = []
	
	for _rune in runes.keys():
		if runeData.runeData[_rune] != null and runes[_rune] != null:
			_runeData[_rune] = runeData.runeData[_rune][get_node("/root/World/Items/{id}".format({ "id": runes[_rune] })).value.to_lower()]
	
	if runes.heario == null:
		_runeData.heario = {
			"dmgMultiplier": 0.5,
			"effectMultiplier": 0.5,
			"texture": load("res://Assets/Spells/NoHeario.png")
		}
	
	if _tileToCastTo == null:
		var _adjacentTiles = []
		for _data in _runeData.luirio.spellDirections:
			_adjacentTiles.append({ "tile": _playerTile + _data.direction, "angle": _data.angle })
		_tiles.append(_adjacentTiles)
		_runeData.heario.texture = load("res://Assets/Spells/Adjacent.png")
	else:
		var _direction = _tileToCastTo - _playerTile
		if get_node("/root/World/Items/{id}".format({ "id": runes["luirio"] })).value.to_lower().matchn("point"):
			var _previousTile = _playerTile
			var _checkedTile = _playerTile + _direction
			for _i in range(_runeData.luirio.distance):
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
					break
				elif grid[_checkedTile.x][_checkedTile.y].critter != 0 and grid[_checkedTile.x][_checkedTile.y].critter != null:# and !get_node("/root/World/Critters/{critter}".format({ "critter": grid[_checkedTile.x][_checkedTile.y].critter })).aI.aI.matchn("neutral"):
					_tiles.append([{ "tile": _checkedTile, "angle": 0 }])
					break
				_previousTile += _direction
				_checkedTile += _direction
		if get_node("/root/World/Items/{id}".format({ "id": runes["luirio"] })).value.to_lower().matchn("line"):
			var _checkedTile = _playerTile + _direction
			for _i in range(_runeData.luirio.distance):
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
				elif grid[_checkedTile.x][_checkedTile.y].critter != null:# and !get_node("/root/World/Critters/{critter}".format({ "critter": grid[_checkedTile.x][_checkedTile.y].critter })).aI.aI.matchn("neutral"):
					_tiles.append([{ "tile": _checkedTile, "angle": _runeData.luirio.spellDirections[_direction].angle }])
					break
				else:
					_tiles.append([{ "tile": _checkedTile, "angle": 0 }])
					_checkedTile += _direction
		elif get_node("/root/World/Items/{id}".format({ "id": runes["luirio"] })).value.to_lower().matchn("cone") or get_node("/root/World/Items/{id}".format({ "id": runes["luirio"] })).value.to_lower().matchn("fourway"):
			var _spellDirections = _runeData.luirio.spellDirections[_direction].duplicate(true)
			for _i in range(_runeData.luirio.distance):
				var _lineTiles = []
				for _index in _spellDirections.size():
					if typeof(_spellDirections[_index].direction) != TYPE_BOOL:
						var _checkedTile = _playerTile + _spellDirections[_index].direction
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
							_spellDirections[_index].direction = false
						else:
							_lineTiles.append({ "tile": _checkedTile, "angle": _spellDirections[_index].angle })
							_spellDirections[_index].direction += _runeData.luirio.spellDirections[_direction][_index].direction
				if _lineTiles.empty():
					break
				_tiles.append(_lineTiles)
	
	_newSpell.create(_tiles, _runeData, true)
	$"/root/World/Animations".add_child(_newSpell)
	# warning-ignore:return_value_discarded
	$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).connect("playerAnimationDone", $"/root/World", "_on_Player_Animation_done")
	$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).animateCycle()
	
	$"/root/World/Critters/0".mp -= mpUsage



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
			hoveredEquipment.matchn("eario")
		):
			return true
		if (
			_category.matchn("luirio") and
			hoveredEquipment.matchn("luirio")
		):
			return true
		if (
			_category.matchn("heario") and
			hoveredEquipment.matchn("heario")
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
					"dmg": [int(spellData.spellData[_earioNode.value.to_lower()].baseDmg[0] * 0.5 + _magicDamageIncrease.dmg), int(spellData.spellData[_earioNode.value.to_lower()].baseDmg[1] * 0.5 + _magicDamageIncrease.dmg)],
					"element": _earioNode.value
				}
			})
		mpUsage = 0
		for _rune in runes:
			if !_rune.matchn("heario"):
				mpUsage += runeData.runeData[_rune][get_node("/root/World/Items/{id}".format({ "id": runes[_rune] })).value.to_lower()].mp
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
					"dmg": [int(spellData.spellData[_earioNode.value.to_lower()].baseDmg[0] * runeData.runeData.heario[_hearioNode.value.to_lower()].dmgMultiplier + _magicDamageIncrease.dmg), int(spellData.spellData[_earioNode.value.to_lower()].baseDmg[0] * runeData.runeData.heario[_hearioNode.value.to_lower()].dmgMultiplier + _magicDamageIncrease.dmg)],
					"element": _earioNode.value
				}
			})
		mpUsage = 0
		for _rune in runes:
			mpUsage += runeData.runeData[_rune][get_node("/root/World/Items/{id}".format({ "id": runes[_rune] })).value.to_lower()].mp
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
		
		if _stats.wisdom > 18:
			_d = 1
		
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
		
		if _stats.wisdom > 27:
			_d = 1
		
		return {
			"dmg": _stats.wisdom / 3 + _additionalDamage,
			"d": _d
		}
	if _type.matchn("gleeie'er"):
		var _additionalDamage = 0
		var _d = 0
		
		if _stats.wisdom > 17:
			_d = 2
		elif _stats.wisdom > 8:
			_d = 1
		
		if _critterClass.matchn("freedom fighter"):
			_additionalDamage += 2
		
		if _player.checkIfItemsTurnedOnHasItem("toga"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("fabric gloves"):
			_additionalDamage += 1
		
		if _player.checkIfItemsTurnedOnHasItem("boots of magic"):
			_additionalDamage += 1
		
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
	hoveredEquipment = _equipmentSlot

func _on_mouse_exited_rune_slot():
	hoveredEquipment = null
