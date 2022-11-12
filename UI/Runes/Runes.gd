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

var spellDamage = [{
	"dmg": [0,0],
	"bonusDmg": {},
	"armorPen": 0,
	"magicDmg": {
		"dmg": [0,0],
		"element": null
	}
}]

var manaUsage = 0

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
	
	if $"/root/World/Critters/0".mp - manaUsage < 0:
		Globals.gameConsole.addLog("You dont have mp to cast that spell!")
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
	
	$"/root/World/Critters/0".mp -= manaUsage



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
		return
	elif runes.heario == null:
		var _magicDamageIncrease = calculateMagicDamageIncrease(runes.eario.value)
		for _d in range(1 + _magicDamageIncrease.d):
			_magicAttacks.append({
				"dmg": [0,0],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [int(spellData.spellData[runes.eario.value.to_lower()].baseDmg[0] * 0.5 + _magicDamageIncrease.dmg), int(spellData.spellData[runes.eario.value.to_lower()].baseDmg[1] * 0.5 + _magicDamageIncrease.dmg)],
					"element": runes.eario.value
				}
			})
		manaUsage = 0
		for _rune in runes:
			if !_rune.matchn("heario"):
				manaUsage += runeData.runeData[_rune][runes[_rune].value.to_lower()].mp
#	"effect": runeData.heario[runes.heario].effectMultiplier
	else:
		var _magicDamageIncrease = calculateMagicDamageIncrease(runes.eario.value)
		for _d in range(1 + _magicDamageIncrease.d):
			_magicAttacks.append({
				"dmg": [0,0],
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [int(spellData.spellData[runes.eario.value.to_lower()].baseDmg[0] * runeData.runeData.heario[runes.heario.value.to_lower()].dmgMultiplier + _magicDamageIncrease.dmg), int(spellData.spellData[runes.eario.value.to_lower()].baseDmg[0] * runeData.runeData.heario[runes.heario.value.to_lower()].dmgMultiplier + _magicDamageIncrease.dmg)],
					"element": runes.eario.value
				}
			})
		manaUsage = 0
		for _rune in runes:
			manaUsage += runeData.runeData[_rune][runes[_rune].value.to_lower()].mp
	spellDamage = _magicAttacks
	$"/root/World/Critters/0".updatePlayerStats()

func calculateMagicDamageIncrease(_type):
	var _stats = $"/root/World/Critters/0".stats
	var _critterClass = $"/root/World/Critters/0".critterClass
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
		
		if _stats.visage > 18:
			_d = 1
		
		return {
			"dmg": _stats.visage / 3 + _additionalDamage,
			"d": _d
		}
	if _type.matchn("thunder"):
		var _additionalDamage = 0
		var _d = 0
		
		if _critterClass.matchn("savant"):
			_additionalDamage += 3
		
		if _stats.visage > 27:
			_d = 1
		
		return {
			"dmg": _stats.visage / 3 + _additionalDamage,
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
		
		return {
			"dmg": _stats.wisdom / 3 + _additionalDamage,
			"d": _d
		}
	if _type.matchn("toxix"):
		var _additionalDamage = 0
		var _d = 0
		
		if _critterClass.matchn("rogue"):
			_additionalDamage += 1
		
		if _stats.wisdom > 27:
			_d += 4
		elif _stats.wisdom > 21:
			_d += 3
		elif _stats.wisdom > 17:
			_d += 2
		elif _stats.wisdom > 15:
			_d += 1
		
		return {
			"dmg": _stats.wisdom / 4 + _additionalDamage,
			"d": _d
		}

func getRunesSaveData():
	return {
		runes = runes,
		spellDamage = spellDamage,
		manaUsage = manaUsage
	}



########################
### Signal functions ###
########################

func _on_mouse_entered_rune_slot(_equipmentSlot):
	hoveredEquipment = _equipmentSlot

func _on_mouse_exited_rune_slot():
	hoveredEquipment = null
