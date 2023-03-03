extends Sprite

onready var spellShader = preload("res://Assets/Spells/SpellShader.shader")

var levelId
var tile
var effectName
var attacks
var turnDuration

func create(_texture, _color, _position, _effectName, _levelId, _turnDuration, _attacks):
	texture = _texture
	
	var _material = ShaderMaterial.new()
	_material.shader = spellShader
	material = _material
	material.set_shader_param("old_color", Color("#00ff1c"))
	material.set_shader_param("new_color", Color(_color))
	
	position = Vector2(_position.x * 32 + 16, _position.y * 32 + 16)
	
	tile = _position
	effectName = _effectName
	levelId = _levelId
	turnDuration = _turnDuration
	attacks = _attacks

func tickTurn(_level):
	if _level.grid[tile.x][tile.y].critter != null:
		get_node("/root/World/Critters/{critterId}".format({ "critterId": _level.grid[tile.x][tile.y].critter })).takeDamage(
			attacks,
			tile,
			effectName
		)
	turnDuration -= 1
	if turnDuration == 0:
		queue_free()
