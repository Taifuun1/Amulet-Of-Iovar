extends Node

var saveTypes = {
	"levelSave": load("res://Objects/SaveLevelSave.gd"),
	"fOVSave": load("res://Objects/FOVSave.gd"),
	"itemSave": load("res://Objects/ItemSave.gd"),
	"critterSave": load("res://Objects/CritterSave.gd"),
	"gameConsoleSave": load("res://Objects/GameConsoleSave.gd"),
	"gameStatsSave": load("res://Objects/GameStatsSave.gd"),
	"globalsSave": load("res://Objects/GlobalsSave.gd"),
	"equipmentSave": load("res://Objects/EquippedSave.gd")
}

func saveData(_fileName, _filePath, _data = null):
	var file = File.new()
	file.open("user://{_filePath}/{fileName}.json".format({ "filePath": _filePath, "fileName": _fileName }), File.WRITE)
	file.store_line(to_json(_data))
	file.close()



##########################
### Save and load game ###
##########################

func saveGameFile(_fileType, _fileName, _filePath, _data):
	var _newSaveFile = saveTypes[_fileType].new()
	for _dataKey in _data:
		_newSaveFile[_dataKey] = _data[_dataKey]
	saveData(_fileName, _filePath, _newSaveFile)
#	ResourceSaver.save("user://{filePath}/{fileName}.tres".format({ "filePath": _filePath, "fileName": _fileName }), _newSaveFile)



#####################################
### Save and load life time stats ###
#####################################

func loadDataLifeTimeStats(_fileName, _data = null):
	var file = File.new()
#	var directory = Directory.new()
#	if not directory.dir_exists("user://lifeTimeStats"):
#		directory.make_dir("user://lifeTimeStats")
	if not file.file_exists("user://lifeTimeStats/{fileName}.json".format({ "fileName": _fileName })):
		saveData(_fileName, "lifeTimeStats", _data)
		file.open("user://{fileName}.json".format({ "fileName": _fileName }), File.READ)
		return parse_json(file.get_as_text())
	file.open("user://{fileName}.json".format({ "fileName": _fileName }), File.READ)
	return parse_json(file.get_as_text())
