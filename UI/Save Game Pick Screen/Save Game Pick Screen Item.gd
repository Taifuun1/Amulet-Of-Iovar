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
			"className": "-",
			"dungeonLevelName": "-",
			"level": "-",
			"points": 0
		}
	else:
		_saveData = _data
	
	name = str(_saveSlot)
	saveSlot = _saveSlot
	saveExists = _saveData.hasSave
	className = _saveData.className
	
	$MarginContainer/HBoxContainer/VBoxContainer/SaveSlot.append_bbcode(str(_saveData.saveSlot))
	$MarginContainer/HBoxContainer/VBoxContainer/HasSave.append_bbcode(str(_saveData.hasSave))
	
	$MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/ClassNameText.append_bbcode(str(_saveData.className))
	$MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/DungeonLevelText.append_bbcode(str(_saveData.level))
	$MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/DungeonLevelNameText.append_bbcode(str(_saveData.dungeonLevelName))
	$MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer4/PointsText.append_bbcode(str(_saveData.points))

func _on_Save_Button_pressed():
	StartingData.selectedSave = saveSlot
	if saveExists:
		StartingData.selectedClass = className
		if get_tree().change_scene("res://Objects/World/World.tscn") != OK:
			push_error("Error changing to world screen.")
	elif get_tree().change_scene("res://UI/Character Creation/Character Creation.tscn") != OK:
		push_error("Error changing to character creation screen.")
