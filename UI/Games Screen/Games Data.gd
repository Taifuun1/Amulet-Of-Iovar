extends VBoxContainer

onready var RichTextLabelExtended = preload("res://UI/RichTextLabel Extended/RichTextLabel Extended.tscn")

func setValues(_gameData):
	$GamesDataContainer.show()
	$EmptyGamesContainer.hide()
	if _gameData.ascended:
		$GamesDataContainer/Ascended.createRichTextLabel("You ascended!")
	else:
		$GamesDataContainer/Ascended.createRichTextLabel("You died!")
	for _stat in _gameData.gameStats.gameStats:
		var _statContainer = HBoxContainer.new()
		var _statTextLabel = RichTextLabelExtended.instance()
		var _statValueLabel = RichTextLabelExtended.instance()
		
		_statContainer.name = "StatContainer%s" % [_stat]
		_statContainer.set_h_size_flags(SIZE_EXPAND_FILL)
		$"GamesDataContainer/GamesDataListContainer".add_child(_statContainer)
		get_node("GamesDataContainer/GamesDataListContainer/StatContainer%s" % [_stat]).add_child(_statTextLabel)
		get_node("GamesDataContainer/GamesDataListContainer/StatContainer%s" % [_stat]).add_child(_statValueLabel)
		
		_statTextLabel.createRichTextLabel(str(_stat))
		_statValueLabel.createRichTextLabel(str(_gameData.gameStats.gameStats[_stat]))

func _on_Back_pressed():
	if get_tree().change_scene("res://UI/Start Screen/Start Screen.tscn") != OK:
		push_error("Error changing to start screen.")
