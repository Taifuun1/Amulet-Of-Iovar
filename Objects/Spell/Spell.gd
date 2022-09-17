extends Node2D

onready var SpellShaderMaterial = preload("res://Assets/Spells/SpellShaderMaterial.tres")
onready var SpellShader = preload("res://Assets/Spells/SpellShader.shader")

onready var spellTextureNode = preload("res://Objects/Spell/SpellTexture.tscn")

var tiles
var spellTexture
var color

func create(_tiles, _runeData):
	tiles = _tiles
	spellTexture = _runeData.heario.texture
	color = _runeData.eario

func animateCycle():
	var _cycleTiles = tiles.pop_front()
	if _cycleTiles == null:
		queue_free()
		return
	for _tile in _cycleTiles:
		animateTile(_tile.tile, _tile.angle)
	$Timer.start()

func animateTile(_position, _angle):
	var _spellTexture = spellTextureNode.instance()
	_spellTexture.setTexture(spellTexture, color, _position, _angle)
	add_child(_spellTexture)


func _on_Timer_timeout():
	animateCycle()
