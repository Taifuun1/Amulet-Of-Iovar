extends Control

var selectedGame = null

func _ready():
	var _fileNames = []
	var directory = Directory.new()
	if directory.open("user://Games") == OK:
		directory.list_dir_begin()
		var fileName = directory.get_next()
		while fileName != "":
			if !directory.current_is_dir():
				_fileNames.append(fileName)
			fileName = directory.get_next()
	else:
		push_error("An error occurred when trying to access the path.")
	
	_fileNames.invert()
	var file = File.new()
	for _fileName in _fileNames:
		file.open("user://Games/{fileName}".format({ "fileName": _fileName }), File.READ)
		addGame(_fileName.split(".")[0], parse_json(file.get_as_text()))
		file.close()

func addGame(_gameName, _gameData):
	var _gameScreenListItem = load("res://UI/Games Screen/Games List Item.tscn").instance()
	$GamesScreenListContainer/GamesListScroll/GamesList.add_child(_gameScreenListItem)
	_gameScreenListItem.create(_gameName, _gameData)

func showGame(_gameName, _gameData):
	if selectedGame == null or !_gameName.matchn(selectedGame):
		selectedGame = _gameName
		$"Games Data".setValues(_gameData)
