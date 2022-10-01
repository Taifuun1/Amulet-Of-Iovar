extends Control

var runeItem = load("res://UI/Runes/Rune Item.tscn")
var spell = load("res://Objects/Spell/Spell.tscn")

var runeData = load("res://Objects/Spell/RuneData.gd").new()
var spellData = load("res://Objects/Spell/SpellData.gd").new()

var runes = {
	"eario": null,
	"luirio": null,
	"heario": null
}

var spellDamage = {
	"dmg": null,
	"bonusDmg": [],
	"armorPen": 0,
	"magicDmg": {
		"dmg": 0,
		"element": null
	}
}

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
		$RunesBackground/RunesContainer/RunesList.add_child(_newItem)
	show()

func hideRunes():
	for _item in $RunesBackground/RunesContainer/RunesList.get_children():
		_item.queue_free()
	hide()



#############################
### Rune change functions ###
#############################

func setRunes(_id):
	var _rune = get_node("/root/World/Items/{id}".format({ "id": _id }))
	if checkIfMatchingRuneAndSlot(_rune.type, _rune.category):
		runes[hoveredEquipment.to_lower()] = _rune
		get_node("EquippedRunesBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = _rune.getTexture()
		checkWhatRuneIsEquipped(_rune)
		calculateMagicDamage()
		$"/root/World".processGameTurn()

func _process(_delta):
	if Input.is_action_just_released("RIGHT_CLICK") and hoveredEquipment != null:
		var _rune = get_node("/root/World/Items/{id}".format({ "id": runes[hoveredEquipment.to_lower()] }))
		if _rune != null:
			runes[hoveredEquipment.to_lower()] = null
			get_node("EquippedRunesBackground/{slot}/Sprite".format({ "slot": hoveredEquipment })).texture = null
			checkWhatRuneIsEquipped(_rune)
			calculateMagicDamage()
			$"/root/World".processGameTurn()



############################
### Spell cast functions ###
############################

func castSpell(_playerTile, _tileToCastTo = null, grid = null):
	yield(get_tree(), "idle_frame")
	var _newSpell = spell.instance()
	
	var _runeData = {
		"eario": null,
		"luirio": null,
		"heario": null
	}
	var _tiles = []
	
	for _rune in runes.keys():
		if runeData.runeData[_rune] != null and runes[_rune] != null:
			_runeData[_rune] = runeData.runeData[_rune][runes[_rune].value.to_lower()]
	
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
		if runes["luirio"].value.to_lower().matchn("point"):
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
		if runes["luirio"].value.to_lower().matchn("line"):
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
		elif runes.luirio.value.to_lower().matchn("cone") or runes.luirio.value.to_lower().matchn("fourway"):
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
	
	_newSpell.create(_tiles, _runeData)
	$"/root/World/Animations".add_child(_newSpell)
	# warning-ignore:return_value_discarded
	$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).connect("playerAnimationDone", $"/root/World", "_on_Player_Animation_done")
	$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).animateCycle()



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
	match _rune.identifiedItemName.to_lower():
		_:
			pass
#		"ring of slow digestion":
#			if _playerNode.itemsTurnedOn.has(_ring):
#				_playerNode.statusEffects["slow digestion"] = 0
#				_playerNode.itemsTurnedOn.erase(_ring)
#				Globals.gameConsole.addLog("Your belly feels faster.")
#			else:
#				_playerNode.statusEffects["slow digestion"] = -1
#				_playerNode.itemsTurnedOn.append(_ring)
#				Globals.gameConsole.addLog("Your belly feels constant.")
#		"ring of hunger":
#			if _playerNode.itemsTurnedOn.has(_ring):
#				_playerNode.statusEffects["hunger"] = 0
#				_playerNode.itemsTurnedOn.erase(_ring)
#				Globals.gameConsole.addLog("Your belly feels nourished.")
#			else:
#				_playerNode.statusEffects["hunger"] = -1
#				_playerNode.itemsTurnedOn.append(_ring)
#				Globals.gameConsole.addLog("Your belly feels like it has a hole.")
#		"ring of regen":
#			if _playerNode.itemsTurnedOn.has(_ring):
#				_playerNode.statusEffects["regen"] = 0
#				_playerNode.itemsTurnedOn.erase(_ring)
#				Globals.gameConsole.addLog("Your skin more stable.")
#			else:
#				_playerNode.statusEffects["regen"] = -1
#				_playerNode.itemsTurnedOn.append(_ring)
#				Globals.gameConsole.addLog("Your skin tingles.")
#		"ring of fumbling":
#			if _playerNode.itemsTurnedOn.has(_ring):
#				_playerNode.statusEffects["fumbling"] = 0
#				_playerNode.itemsTurnedOn.erase(_ring)
#				Globals.gameConsole.addLog("Your legs feel steady.")
#			else:
#				_playerNode.statusEffects["fumbling"] = -1
#				_playerNode.itemsTurnedOn.append(_ring)
#				Globals.gameConsole.addLog("Your legs feel like jelly.")
#		"ring of seeing":
#			if _playerNode.itemsTurnedOn.has(_ring):
#				_playerNode.statusEffects["seeing"] = 0
#				_playerNode.itemsTurnedOn.erase(_ring)
#				Globals.gameConsole.addLog("It feels like you cant see at all.")
#			else:
#				_playerNode.statusEffects["seeing"] = -1
#				_playerNode.itemsTurnedOn.append(_ring)
#				Globals.gameConsole.addLog("You can see everything!")
	_playerNode.checkAllItemsIdentification()

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
		if runes[_rune] != null and runes[_rune].id == _id:
			runes[_rune] = null
			get_node("EquippedRunesBackground/{slot}/Sprite".format({ "slot": _rune.capitalize() })).texture = null
			calculateMagicDamage()
			return

func isCastableRunes():
	if runes.eario != null and runes.luirio != null:
		if runes.luirio.value.matchn("fourway") or runes.luirio.value.matchn("line") or runes.luirio.value.matchn("cone") or runes.luirio.value.matchn("point"):
			return "direction"
		return "directionless"
	return "notCastable"

func calculateMagicDamage():
	if isCastableRunes() == "notCastable":
		spellDamage = [{
			"dmg": null,
			"bonusDmg": [],
			"armorPen": 0,
			"magicDmg": {
				"dmg": 0,
				"element": null
			}
		}]
	elif runes.heario == null:
		spellDamage = [{
			"dmg": null,
			"bonusDmg": [],
			"armorPen": 0,
			"magicDmg": {
				"dmg": int(spellData.spellData[runes.eario.value.to_lower()].dmg * 0.5),
				"element": runes.eario.value
			}
		}]
#	"effect": runeData.heario[runes.heario].effectMultiplier
	else:
		spellDamage = [{
			"dmg": null,
			"bonusDmg": [],
			"armorPen": 0,
			"magicDmg": {
				"dmg": int(spellData.spellData[runes.eario.value.to_lower()].dmg * runeData.runeData.heario[runes.heario.value.to_lower()].dmgMultiplier),
				"element": runes.eario.value
			}
		}]



########################
### Signal functions ###
########################

func _on_mouse_entered_rune_slot(_equipmentSlot):
	hoveredEquipment = _equipmentSlot

func _on_mouse_exited_rune_slot():
	hoveredEquipment = null
