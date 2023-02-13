extends Control

var selectedGame = null

func sortFileNames(_fileA, _fileB):
	if int(_fileA.gameNumber) < int(_fileB.gameNumber):
		return true
	return false

func _ready():
	var _files = []
	var directory = Directory.new()
	var file = File.new()
	if directory.open("user://Games") == OK:
		directory.list_dir_begin()
		var fileName = directory.get_next()
		while fileName != "":
			if !directory.current_is_dir():
				file.open("user://Games/{fileName}".format({ "fileName": fileName }), File.READ)
				var _fileData = parse_json(file.get_as_text())
				_fileData.gameName = fileName.split(".")[0]
				_files.append(_fileData)
				file.close()
			fileName = directory.get_next()
	else:
		push_error("An error occurred when trying to access the path.")
	
	_files.sort_custom(self, "sortFileNames")
	_files.invert()
	for _fileData in _files:
		addGame(_fileData.gameName, _fileData)

func addGame(_gameName, _gameData):
	var _gameScreenListItem = load("res://UI/Games Screen/Games List Item.tscn").instance()
	$GamesScreenListContainer/GamesListScroll/GamesList.add_child(_gameScreenListItem)
	_gameScreenListItem.create(_gameName, _gameData)

func showGame(_gameName, _gameData):
	if selectedGame == null or !_gameName.matchn(selectedGame):
		selectedGame = _gameName
		$"Games Data".setValues(_gameData)
