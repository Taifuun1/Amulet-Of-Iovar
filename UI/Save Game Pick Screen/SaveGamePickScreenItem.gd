extends Button

var saveSlot
var saveExists
var className

func create(_saveSlot, _data):
	var _saveData
	if _data == null:
		_saveData = {
			"saveSlot": _saveSlot,
			"hasSave": false,
			"className": null,
			"dungeonLevelName": null,
			"level": null,
			"points": 0
		}
	else:
		_saveData = _data
	
	name = str(_saveSlot)
	saveSlot = _saveSlot
	saveExists = _saveData.hasSave
	className = _saveData.className
	
	var _saveSlotText = "Save %s" % saveSlot
	var _hasSaveText
	var _classTexture
	var _classNameText
	var _dungeonLevelNameText
	var _pointsText
	
	if _saveData.hasSave:
		$SaveContainer/NoSave.hide()
	else:
		$SaveContainer/SaveDataContainer.hide()
	if _saveData.className != null:
		_classTexture = load("res://Assets/Classes/{className}.png".format({ "className": _saveData.className.capitalize().replace(" ", "") }))
	else:
		_classTexture = null
	if _saveData.className != null:
		_classNameText = _saveData.className.capitalize()
	else:
		_classNameText = "-"
	if _saveData.dungeonLevelName != null:
		_dungeonLevelNameText = _saveData.dungeonLevelName
	else:
		_dungeonLevelNameText =  "-"
	if _saveData.points != null:
		_pointsText = _saveData.points
	else:
		_pointsText =  "-"
	
	$SaveContainer/SaveSlot.append_bbcode(_saveSlotText)
	$SaveContainer/SaveDataContainer/ClassTexture.texture = _classTexture
	
	$SaveContainer/SaveDataContainer/ClassContainer/ClassNameText.append_bbcode(_classNameText)
	$SaveContainer/SaveDataContainer/DungeonLevelContainer/DungeonLevelText.append_bbcode(str(_dungeonLevelNameText))
	$SaveContainer/SaveDataContainer/PointsContainer/PointsText.append_bbcode(str(_pointsText))

func _on_Save_Button_pressed():
	StartingData.selectedSave = saveSlot
	if saveExists:
		StartingData.selectedClass = className
		if get_tree().change_scene("res://Objects/World/World.tscn") != OK:
			push_error("Error changing to world screen.")
	elif get_tree().change_scene("res://UI/Character Creation/CharacterCreation.tscn") != OK:
		push_error("Error changing to character creation screen.")
