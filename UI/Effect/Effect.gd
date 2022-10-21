extends Sprite

var turnDuration

func create(_texture, _color, _position, _angle, _turnDuration):
	texture = _texture
	position = Vector2(_position.x * 32 + 16, _position.y * 32 + 16)
	rotation_degrees = _angle
	material.set_shader_param("old_color", Color("#00ff1c"))
	material.set_shader_param("new_color", Color(_color))
	turnDuration = _turnDuration

func tickTurn():
	turnDuration -= 1
	if turnDuration == 0:
		queue_free()
