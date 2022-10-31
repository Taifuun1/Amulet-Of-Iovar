extends Node

func saveData(_fileName, _data = null):
	var file = File.new()
	file.open("user://{fileName}.json".format({ "fileName": _fileName }), File.WRITE)
	file.store_line(to_json(_data))
	file.close()

func loadData(_fileName, _data = null):
	var file = File.new()
	if not file.file_exists("user://{fileName}.json".format({ "fileName": _fileName })):
		saveData(_fileName, _data)
		file.open("user://{fileName}.json".format({ "fileName": _fileName }), File.READ)
		return parse_json(file.get_as_text())
	file.open("user://{fileName}.json".format({ "fileName": _fileName }), File.READ)
	return parse_json(file.get_as_text())
