extends Node2D

onready var SpellShaderMaterial = preload("res://Assets/Spells/SpellShaderMaterial.tres")
onready var SpellShader = preload("res://Assets/Spells/SpellShader.shader")

onready var projectile = preload("res://UI/Spell Sprite/Spell Sprite.tscn")

signal playerAnimationDone

var tiles

var projectileTexture
var color
var damage

var isPlayer

func create(_tiles, _texture, _color, _damage, _isPlayer = false):
	tiles = _tiles
	projectileTexture = _texture
	color = _color
	damage = _damage
	
	isPlayer = _isPlayer

func animateCycle():
	var _cycleTiles = tiles.pop_front()
	if _cycleTiles == null:
		emit_signal("playerAnimationDone")
		queue_free()
		return
	for _tile in _cycleTiles:
		animateTile(_tile.tile, _tile.angle)
		checkIfCritterIsHit(_tile.tile)
	$Timer.start()

func animateTile(_position, _angle):
	var _projectile = projectile.instance()
	_projectile.create(projectileTexture, color, _position, _angle)
	add_child(_projectile)

func checkIfCritterIsHit(_tile):
	var _hitCritter = $"/root/World".level.grid[_tile.x][_tile.y].critter
	if _hitCritter != null:
		var _didCritterDespawn
		if isPlayer:
			_didCritterDespawn = get_node("/root/World/Critters/{critter}".format({ "critter": _hitCritter })).takeDamage(damage, _tile, $"/root/World/Critters/0".critterName)
		else:
			_didCritterDespawn = get_node("/root/World/Critters/{critter}".format({ "critter": _hitCritter })).takeDamage(damage, _tile, "")
		if _didCritterDespawn != null and isPlayer:
			$"/root/World/Critters/0".addExp(_didCritterDespawn)


func _on_Timer_timeout():
	animateCycle()
