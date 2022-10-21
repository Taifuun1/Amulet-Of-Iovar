extends Sprite

func create(_texture, _color, _position, _angle):
	texture = _texture
	position = Vector2(_position.x * 32 + 16, _position.y * 32 + 16)
	rotation_degrees = _angle
	material.set_shader_param("old_color", Color("#00ff1c"))
	material.set_shader_param("new_color", Color(_color))
