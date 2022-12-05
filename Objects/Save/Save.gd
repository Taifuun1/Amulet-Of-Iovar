extends Node

#var saveTypes = {
#	"levelSave": load("res://Objects/Save/LevelSave.gd"),
#	"fOVSave": load("res://Objects/Save/FOVSave.gd"),
#	"itemSave": load("res://Objects/Save/ItemSave.gd"),
#	"critterSave": load("res://Objects/Save/CritterSave.gd"),
#	"gameConsoleSave": load("res://Objects/Save/GameConsoleSave.gd"),
#	"gameStatsSave": load("res://Objects/Save/GameStatsSave.gd"),
#	"globalsSave": load("res://Objects/Save/GlobalsSave.gd"),
#	"equipmentSave": load("res://Objects/Save/EquipmentSave.gd"),
#	"saveDataSave": load("res://Objects/Save/SaveDataSave.gd")
#}

func saveData(_fileName, _filePath, _data = null):
	var file = File.new()
	var directory = Directory.new()
	if not directory.dir_exists("user://{filePath}".format({ "filePath": _filePath })):
		directory.make_dir("user://{filePath}".format({ "filePath": _filePath }))
	file.open("user://{filePath}/{fileName}.json".format({ "filePath": _filePath, "fileName": _fileName }), File.WRITE)
	file.store_line(to_json(_data))
	file.close()

func loadData(_fileName, _filePath, isJson = true):
	var _data = {  }
	var file = File.new()
	if isJson:
		file.open("user://{filePath}/{fileName}.json".format({ "filePath": _filePath, "fileName": _fileName }), File.READ)
	else:
		file.open("user://{filePath}/{fileName}.tscn".format({ "filePath": _filePath, "fileName": _fileName }), File.READ)
	while file.get_position() < file.get_len():
		var _lineData = parse_json(file.get_line())
		for _dataKey in _lineData:
			_data[_dataKey] = _lineData[_dataKey]
	file.close()
	return _data

func saveResourceData(_resourceName, _resourcePath, _resource):
	var directory = Directory.new()
	if not directory.dir_exists("user://{filePath}".format({ "filePath": _resourcePath })):
		directory.make_dir("user://{filePath}".format({ "filePath": _resourcePath }))
	if ResourceSaver.save("user://{filePath}/{fileName}.tres".format({ "filePath": _resourcePath, "fileName": _resourceName }), _resource) != OK:
		push_error("Error calling ResourceSaver.")

func loadDataLifeTimeStats(_fileName, _data = null):
	var file = File.new()
	var directory = Directory.new()
	if not directory.dir_exists("user://lifeTimeStats"):
		directory.make_dir("user://lifeTimeStats")
	if not file.file_exists("user://lifeTimeStats/{fileName}.json".format({ "fileName": _fileName })):
		saveData(_fileName, "lifeTimeStats", _data)
	file.open("user://lifeTimeStats/{fileName}.json".format({ "fileName": _fileName }), File.READ)
	return parse_json(file.get_as_text())
