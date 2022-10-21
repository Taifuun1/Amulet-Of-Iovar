extends Position2D

var movement

func _process(delta):
	position -= movement * delta

func create(_position, _number, _color):
	position = _position * 32 + Vector2(16, 16)
	$Text.append_bbcode("[center][color=%s]%s[/color][/center]" % [_color, _number])
#	$Tween.interpolate_property(self, "scale", scale, scale, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	$Tween.start()
	movement = Vector2(randi() % 6 - 5, 48)

func _on_Tween_tween_all_completed():
	queue_free()


func _on_Timer_timeout():
	queue_free()
