extends Sprite

func create(_texture, _position, _color = null, _angle = null):
	texture = _texture
	position = Vector2(_position.x * 32 + 16, _position.y * 32 + 16)
	if _angle != null:
		rotation_degrees = _angle
	if _color != null:
		material.set_shader_param("old_color", Color("#00ff1c"))
		material.set_shader_param("new_color", Color(_color))
