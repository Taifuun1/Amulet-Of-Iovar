extends MarginContainer

var saveData = load("res://Objects/Miscellaneous/SaveData.gd").new().saveData

var saveGamePickScreenItem = load("res://UI/Save Game Pick Screen/Save Game Pick Screen Item.tscn")


func _ready():
	for _i in range(3):
		var _saveGamePickScreenItem = saveGamePickScreenItem.instance()
		_saveGamePickScreenItem.create(_i + 1, loadSaveData(_i + 1, saveData))
		$VBoxContainer/PanelContainer/CenterContainer/VBoxContainer.add_child(_saveGamePickScreenItem)

func loadSaveData(_saveSlot, _data):
	var file = File.new()
	var directory = Directory.new()
	if not directory.dir_exists("user://SaveSlot{saveSlot}".format({ "saveSlot": _saveSlot })):
		directory.make_dir("user://SaveSlot{saveSlot}".format({ "saveSlot": _saveSlot }))
	if not file.file_exists("user://SaveSlot{saveSlot}/SaveData.json".format({ "saveSlot": _saveSlot })):
		file.open("user://SaveSlot{saveSlot}/SaveData.json".format({ "saveSlot": _saveSlot }), File.WRITE)
		file.store_line(to_json({
			"saveSlot": _saveSlot,
			"hasSave": false,
			"className": "",
			"dungeonLevelName": "",
			"level": "",
			"points": null
		}))
		file.close()
	file.open("user://SaveSlot{saveSlot}/SaveData.json".format({ "saveSlot": _saveSlot }), File.READ)
	return parse_json(file.get_as_text())



func _on_Button_pressed():
	if get_tree().change_scene("res://UI/Start Screen/Start Screen.tscn") != OK:
		print ("Error changing to start screen.")
