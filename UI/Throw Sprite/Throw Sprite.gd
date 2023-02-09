extends Sprite

func create(_texture, _position):
	texture = _texture
	position = Vector2(_position.x * 32 + 16, _position.y * 32 + 16)
