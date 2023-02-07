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
		$GameListItemContainer/PlayerDataContainer/Ascended.createRichTextLabel("	Ascended", "green")
	else:
		$GameListItemContainer/Ascended.createRichTextLabel("	Dead", "red")
	$GameListItemContainer/PlayerDataContainer/DateStarted.text = str("Game started: ", _gameData.gameStats.gameStats["Game started at"])
	$GameListItemContainer/PlayerDataContainer/DateEnded.text = str("Game ended: ", _gameData.gameStats.gameStats["Game ended at"])


func _on_Games_List_Item_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$"../../../../".showGame(gameName, gameData)
