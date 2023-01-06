extends PanelContainer

var showing = false

func updateTooltip(_title, _description = null, _sprite = null):
	$TooltipContentContainer/TooltipTextContainer/TooltipTextContentContainer/Title.clear()
	$TooltipContentContainer/TooltipTextContainer/TooltipTextContentContainer/Title.append_bbcode(_title)
	$TooltipContentContainer/TooltipTextContainer/TooltipTextContentContainer/Description.clear()
	if _description == null:
		$TooltipContentContainer/TooltipTextContainer/TooltipTextContentContainer/Description.append_bbcode("?????")
	else:
		$TooltipContentContainer/TooltipTextContainer/TooltipTextContentContainer/Description.append_bbcode(_description)
	if _sprite == null:
		$TooltipContentContainer/Sprite.hide()
	else:
		$TooltipContentContainer/Sprite.texture = _sprite

func _process(_delta):
	if showing:
		var cursorPosition = get_global_mouse_position()
		var adjustedPosition = Vector2()
		adjustedPosition.x = clamp(cursorPosition.x, 0, OS.get_window_size().x - rect_size.x - 34) + 32
		adjustedPosition.y = clamp(cursorPosition.y, 0, OS.get_window_size().y - rect_size.y - 2)
		set_position(adjustedPosition)

func showTooltip():
	showing = true
	$"..".visible = true

func hideTooltip():
	showing = false
	$"..".visible = false
