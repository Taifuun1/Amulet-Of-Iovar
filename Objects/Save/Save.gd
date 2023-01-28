extends Node

func saveData(_fileName, _filePath, _data = null):
	var _file = File.new()
	var _directory = Directory.new()
	if not _directory.dir_exists("user://{filePath}".format({ "filePath": _filePath })):
		_directory.make_dir("user://{filePath}".format({ "filePath": _filePath }))
	_file.open("user://{filePath}/{fileName}.json".format({ "filePath": _filePath, "fileName": _fileName }), File.WRITE)
	_file.store_line(to_json(_data))
	_file.close()

func loadData(_fileName, _filePath):
	var _data = {  }
	var _file = File.new()
	_file.open("user://{filePath}/{fileName}.json".format({ "filePath": _filePath, "fileName": _fileName }), File.READ)
	while _file.get_position() < _file.get_len():
		var _lineData = parse_json(_file.get_line())
		for _dataKey in _lineData:
			_data[_dataKey] = _lineData[_dataKey]
	_file.close()
	return _data

func deleteData(_save):
	var _directory = Directory.new()
	removeRecursive("user://SaveSlot{save}".format({ "save": _save }))
	_directory.remove("user://SaveSlot{save}".format({ "save": _save }))

func removeRecursive(_path):
	var _directory = Directory.new()
	if _directory.open(_path) == OK:
		_directory.list_dir_begin(true)
		var _file_name = _directory.get_next()
		while _file_name != "":
			if _directory.current_is_dir():
				removeRecursive(_path + "/" + _file_name)
			else:
				_directory.remove(_file_name)
			_file_name = _directory.get_next()
		_directory.remove(_path)
	else:
		push_error("Error removing " + _path)
