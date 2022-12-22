extends VBoxContainer

onready var RichTextLabelExtended = preload("res://UI/RichTextLabel Extended/RichTextLabel Extended.tscn")

var _pointItemCount = 0

#func _ready():
#	createPointItem("name", { rarity = "rare", amount = 1, points = 500 })

func createPointItem(_itemName, _item):
	var _pointsContainer = HBoxContainer.new()
	var _itemLabel = RichTextLabelExtended.instance()
	var _amountLabel = RichTextLabelExtended.instance()
	var _pointsLabel = RichTextLabelExtended.instance()
	
	_pointsContainer.name = "PointsContainer%s" % [_pointItemCount]
	_pointsContainer.set_h_size_flags(SIZE_EXPAND_FILL)
	add_child(_pointsContainer)
	get_node("PointsContainer%s" % [_pointItemCount]).add_child(_itemLabel)
	get_node("PointsContainer%s" % [_pointItemCount]).add_child(_amountLabel)
	get_node("PointsContainer%s" % [_pointItemCount]).add_child(_pointsLabel)
	
	_itemLabel.createRichTextLabel(_itemName, _item.rarity)
	_amountLabel.createRichTextLabel(_item.amount, null, "center")
	_pointsLabel.createRichTextLabel(_item.points, null, "right")
	_pointItemCount += 1
