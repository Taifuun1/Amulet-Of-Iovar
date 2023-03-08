extends Node2D

onready var projectileSprite = preload("res://UI/Projectile Sprite/Projectile Sprite.tscn")

signal playerAnimationDone

var tiles
var texture
var color
var damage

var isPlayer
var checkIfCritterHit

var lastSprite = null

func create(_tiles, _projectileData, _checkIfCritterHit = false, _isPlayer = true):
	tiles = _tiles
	
	if _projectileData.has("texture"):
		texture = _projectileData.texture
	if _projectileData.has("color"):
		color = _projectileData.color
	if _projectileData.has("damage"):
		damage = _projectileData.damage
	
	isPlayer = _isPlayer
	checkIfCritterHit = _checkIfCritterHit

func animateCycle():
	var _cycleTiles = tiles.pop_front()
	if _cycleTiles == null:
		if isPlayer:
			emit_signal("playerAnimationDone")
		else:
			emit_signal("critterAnimationDone")
		queue_free()
		return
	for _tile in _cycleTiles:
		if typeof(_tile) == TYPE_VECTOR2:
			animateTile(_tile)
		else:
			animateTile(_tile.tile, _tile.angle)
			if checkIfCritterHit:
				checkIfCritterIsHit(_tile.tile)
	$Timer.start()

func animateTile(_position, _angle = null):
	var _projectileSprite = projectileSprite.instance()
	if _angle == null:
		if lastSprite != null:
			lastSprite.queue_free()
		_projectileSprite.create(texture, _position)
		add_child(_projectileSprite)
		lastSprite = _projectileSprite
		return
	_projectileSprite.create(texture, _position, color, _angle)
	add_child(_projectileSprite)

func checkIfCritterIsHit(_tile):
	var _hitCritter = $"/root/World".level.grid[_tile.x][_tile.y].critter
	if _hitCritter != null:
		var _critterExp = get_node("/root/World/Critters/{critter}".format({ "critter": _hitCritter })).takeDamage(damage, _tile, $"/root/World/Critters/0".critterName)
		if _critterExp != null:
			$"/root/World/Critters/0".addExp(_critterExp)


func _on_Timer_timeout():
	animateCycle()
