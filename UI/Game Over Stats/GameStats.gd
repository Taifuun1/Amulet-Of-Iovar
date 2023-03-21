extends ScrollContainer

onready var RichTextLabelExtended = preload("res://UI/RichTextLabel Extended/RichTextLabelExtended.tscn")

var _gameStatsItemCount = 0

func createGameStatsItem(_stat, _amount):
	var _gameStatsContainer = HBoxContainer.new()
	var _statLabel = RichTextLabelExtended.instance()
	var _amountLabel = RichTextLabelExtended.instance()
	
	_gameStatsContainer.name = "GameStatsContainer%s" % [_gameStatsItemCount]
	_gameStatsContainer.set_h_size_flags(SIZE_EXPAND_FILL)
	$"Game Stats List".add_child(_gameStatsContainer)
	get_node("Game Stats List/GameStatsContainer%s" % [_gameStatsItemCount]).add_child(_statLabel)
	get_node("Game Stats List/GameStatsContainer%s" % [_gameStatsItemCount]).add_child(_amountLabel)
	
	_statLabel.createRichTextLabel(_stat)
	_amountLabel.createRichTextLabel(_amount, null, "right")
	
	_gameStatsItemCount += 1
