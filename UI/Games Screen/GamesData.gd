extends VBoxContainer

onready var RichTextLabelExtended = preload("res://UI/RichTextLabel Extended/RichTextLabelExtended.tscn")

var dataId

func setValues(_gameData):
	$GamesDataScrollContainer.show()
	$EmptyGamesContainer.hide()
	for _node in $GamesDataScrollContainer/GamesDataContainer/GamesDataListContainer.get_children():
		_node.queue_free()
	yield(get_tree().create_timer(0.01), "timeout")
	if _gameData.ascended:
		$GamesDataScrollContainer/GamesDataContainer/Ascended.text = " You ascended! "
	else:
		$GamesDataScrollContainer/GamesDataContainer/Ascended.text = " You died! "
	for _stat in _gameData.gameStats.gameStats:
		createGameDataItem(_stat, _gameData.gameStats.gameStats[_stat])

func createGameDataItem(_stat, _value):
	var _statContainer = HBoxContainer.new()
	var _statTextLabel = RichTextLabelExtended.instance()
	var _statValueLabel = RichTextLabelExtended.instance()
	
	_statContainer.name = "StatContainer%s" % [_stat.replace(" ", "").replace(".", "").replace(":", "")]
	_statContainer.set_h_size_flags(SIZE_EXPAND_FILL)
	$"GamesDataScrollContainer/GamesDataContainer/GamesDataListContainer".add_child(_statContainer)
	get_node("GamesDataScrollContainer/GamesDataContainer/GamesDataListContainer/StatContainer%s" % [_stat.replace(" ", "").replace(".", "").replace(":", "")]).add_child(_statTextLabel)
	get_node("GamesDataScrollContainer/GamesDataContainer/GamesDataListContainer/StatContainer%s" % [_stat.replace(" ", "").replace(".", "").replace(":", "")]).add_child(_statValueLabel)
	
	_statTextLabel.createRichTextLabel(str(_stat))
	_statValueLabel.createRichTextLabel(str(_value))

func _on_Back_pressed():
	if get_tree().change_scene("res://UI/Start Screen/StartScreen.tscn") != OK:
		push_error("Error changing to start screen.")
