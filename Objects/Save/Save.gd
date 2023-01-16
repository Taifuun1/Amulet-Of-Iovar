extends Node

func saveData(_fileName, _filePath, _data = null):
	var file = File.new()
	var directory = Directory.new()
	if not directory.dir_exists("user://{filePath}".format({ "filePath": _filePath })):
		directory.make_dir("user://{filePath}".format({ "filePath": _filePath }))
	file.open("user://{filePath}/{fileName}.json".format({ "filePath": _filePath, "fileName": _fileName }), File.WRITE)
	file.store_line(to_json(_data))
	file.close()

func loadData(_fileName, _filePath):
	var _data = {  }
	var file = File.new()
	file.open("user://{filePath}/{fileName}.json".format({ "filePath": _filePath, "fileName": _fileName }), File.READ)
	while file.get_position() < file.get_len():
		var _lineData = parse_json(file.get_line())
		for _dataKey in _lineData:
			_data[_dataKey] = _lineData[_dataKey]
	file.close()
	return _data
