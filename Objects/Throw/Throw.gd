extends Node2D

onready var throwSprite = preload("res://UI/Throw Sprite/Throw Sprite.tscn")

signal playerAnimationDone

var tiles
var throwTexture

var lastSprite = null

func create(_tiles, _throwTexture):
	tiles = _tiles
	throwTexture = _throwTexture

func animateCycle():
	var _tile = tiles.pop_front()
	if _tile == null or checkIfCritterIsHit(_tile):
		emit_signal("playerAnimationDone")
		queue_free()
		return
	animateTile(_tile)
	$Timer.start()

func animateTile(_position):
	if lastSprite != null:
		lastSprite.queue_free()
	var _throwSprite = throwSprite.instance()
	_throwSprite.create(throwTexture, _position)
	add_child(_throwSprite)
	lastSprite = _throwSprite

func checkIfCritterIsHit(_tile):
	var _hitCritter = $"/root/World".level.grid[_tile.x][_tile.y].critter
	if _hitCritter != null:
		return true
	return false


func _on_Timer_timeout():
	animateCycle()
