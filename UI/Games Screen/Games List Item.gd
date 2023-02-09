extends PanelContainer

var playerClasses = load("res://Objects/Player/PlayableClasses.gd").new()

var gameName
var gameData

func create(_gameName, _gameData):
	gameName = _gameName
	gameData = _gameData
	
	var _playerClassTexture = playerClasses[_gameData.playerStats.playerClass].texture
	
	$GameListItemContainer/PlayerClass.texture = _playerClassTexture
	if _gameData.ascended:
		$GameListItemContainer/Ascended.createRichTextLabel("	Ascended	", "green")
	else:
		$GameListItemContainer/Ascended.createRichTextLabel("	Dead	", "red")
	$GameListItemContainer/PlayerDataContainer/DateStarted.text = str("Game started: ", _gameData.gameStats.gameStats["Game started at"])
	$GameListItemContainer/PlayerDataContainer/DateEnded.text = str("Game ended: ", _gameData.gameStats.gameStats["Game ended at"])

func _on_Games_List_Item_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$"../../../../".showGame(gameName, gameData)

func _on_Games_List_Item_mouse_entered():
	var panelStylebox = get_stylebox("panel").duplicate()
	panelStylebox.set_border_color(Color("3b4284"))
	add_stylebox_override("panel", panelStylebox)

func _on_Games_List_Item_mouse_exited():
	var panelStylebox = get_stylebox("panel").duplicate()
	panelStylebox.set_border_color(Color("181e57"))
	add_stylebox_override("panel", panelStylebox)
