extends Control

var statsData = load("res://Objects/Miscellaneous/StatsData.gd").new()

var statsList = load("res://UI/Stats/Stats List.tscn")


func _ready():
#	var dir = Directory.new()
#	dir.remove("user://lifetimeStats.json")
#	dir.remove("user://items.json")
#	dir.remove("user://critters.json")
	
	var _lifetimeList = statsList.instance()
	var _lifeTimeStats = loadLifeTimeStats("LifeTimeStats", statsData.lifetimeStats)
	_lifetimeList.create("Lifetime stats", _lifeTimeStats)
	$StatsContainer/VBoxContainer/ScrollContainer/VBoxContainer.add_child(_lifetimeList)
	
	var _itemList = statsList.instance()
	_itemList.create("Item knowledge", loadLifeTimeStats("Items", statsData.items))
	$StatsContainer/VBoxContainer/ScrollContainer/VBoxContainer.add_child(_itemList)
	
	var _critterList = statsList.instance()
	_critterList.create("Critter knowledge", loadLifeTimeStats("Critters", statsData.critters))
	$StatsContainer/VBoxContainer/ScrollContainer/VBoxContainer.add_child(_critterList)

func loadLifeTimeStats(_fileName, _data):
	var file = File.new()
	var directory = Directory.new()
	if not directory.dir_exists("user://LifeTimeStats"):
		directory.make_dir("user://LifeTimeStats")
	if not file.file_exists("user://LifeTimeStats/{fileName}.json".format({ "fileName": _fileName })):
		file.open("user://LifeTimeStats/{fileName}.json".format({ "fileName": _fileName }), File.WRITE_READ)
		file.store_line(to_json(_data))
	return parse_json(file.get_as_text())




func _on_Back_Button_pressed():
	if get_tree().change_scene("res://UI/Start Screen/Start Screen.tscn") != OK:
		push_error("Error changing to start screen.")
