extends Node2D

onready var SpellShaderMaterial = preload("res://Assets/Spells/SpellShaderMaterial.tres")
onready var SpellShader = preload("res://Assets/Spells/SpellShader.shader")

onready var spell = preload("res://UI/Spell Sprite/SpellSprite.tscn")

signal critterAnimationDone

var tiles
var spellTexture
var color
var spellDamage

func create(_tiles, _spellData):
	tiles = _tiles
	spellTexture = _spellData.texture
	color = _spellData.color
	spellDamage = _spellData.spellDamage

func animateCycle():
	var _cycleTiles = tiles.pop_front()
	if _cycleTiles == null:
		emit_signal("critterAnimationDone")
		queue_free()
		return
	for _tile in _cycleTiles:
		animateTile(_tile.tile, _tile.angle)
	$Timer.start()

func animateTile(_position, _angle):
	var _spell = spell.instance()
	_spell.create(spellTexture, color, _position, _angle)
	add_child(_spell)


func _on_Timer_timeout():
	animateCycle()
