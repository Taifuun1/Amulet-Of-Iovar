extends Node

var statsData = load("res://Objects/Miscellaneous/LifeTimeStatsData.gd").new()

func _ready():
	var file = File.new()
	if not file.file_exists("user://LifeTimeStats/LifeTimeStats.json"):
		var _lifeTimeStats = saveAndloadLifeTimeStats("LifeTimeStats", statsData.lifetimeStats)
	if not file.file_exists("user://LifeTimeStats/Items.json"):
		var _itemList = saveAndloadLifeTimeStats("Items", statsData.items)
	if not file.file_exists("user://LifeTimeStats/Critters.json"):
		var _critterList = saveAndloadLifeTimeStats("Critters", statsData.critters)

func saveAndloadLifeTimeStats(_fileName, _data = null):
	var file = File.new()
	var directory = Directory.new()
	var _loadedData = {  }
	if not directory.dir_exists("user://LifeTimeStats"):
		directory.make_dir("user://LifeTimeStats")
	if _data != null:
		file.open("user://LifeTimeStats/{fileName}.json".format({ "fileName": _fileName }), File.WRITE)
		file.store_line(to_json(_data))
		file.close()
		return
	else:
		file.open("user://LifeTimeStats/{fileName}.json".format({ "fileName": _fileName }), File.READ)
	return parse_json(file.get_as_text())
