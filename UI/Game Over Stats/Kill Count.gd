extends ScrollContainer

onready var RichTextLabelExtended = preload("res://UI/RichTextLabel Extended/RichTextLabel Extended.tscn")

var _critterKillCountItemCount = 0

func createCritterKillCountItem(_critterName, _amount):
	var _critterKillCountContainer = HBoxContainer.new()
	var _critterLabel = RichTextLabelExtended.instance()
	var _amountLabel = RichTextLabelExtended.instance()
	
	_critterKillCountContainer.name = "CritterKillCountContainer%s" % [_critterKillCountItemCount]
	_critterKillCountContainer.set_h_size_flags(SIZE_EXPAND_FILL)
	$"Kill Count List".add_child(_critterKillCountContainer)
	get_node("Kill Count List/CritterKillCountContainer%s" % [_critterKillCountItemCount]).add_child(_critterLabel)
	get_node("Kill Count List/CritterKillCountContainer%s" % [_critterKillCountItemCount]).add_child(_amountLabel)
	
	_critterLabel.createRichTextLabel(_critterName)
	_amountLabel.createRichTextLabel(_amount, null, "right")
	
	_critterKillCountItemCount += 1
