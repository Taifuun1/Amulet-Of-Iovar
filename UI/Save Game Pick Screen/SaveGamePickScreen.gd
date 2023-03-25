extends MarginContainer

var saveGamePickScreenItem = load("res://UI/Save Game Pick Screen/SaveGamePickScreenItem.tscn")

var saveData = {
	"className": "-",
	"dungeonLevelName": "-",
	"level": 0,
	"points": "-"
}

func _ready():
	for _i in range(3):
		var _saveGamePickScreenItem = saveGamePickScreenItem.instance()
		_saveGamePickScreenItem.create(_i + 1, loadSaveData(_i + 1, saveData))
		$VBoxContainer/VBoxContainer/CenterContainer/HBoxContainer.add_child(_saveGamePickScreenItem)

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
			"className": null,
			"dungeonLevelName": null,
			"level": null,
			"points": 0
		}))
		file.close()
	file.open("user://SaveSlot{saveSlot}/SaveData.json".format({ "saveSlot": _saveSlot }), File.READ)
	return parse_json(file.get_as_text())



func _on_Button_pressed():
	if get_tree().change_scene("res://UI/Start Screen/StartScreen.tscn") != OK:
		push_error("Error changing to start screen.")
