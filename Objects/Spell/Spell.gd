extends Node2D

onready var SpellShaderMaterial = preload("res://Assets/Spells/SpellShaderMaterial.tres")
onready var SpellShader = preload("res://Assets/Spells/SpellShader.shader")

onready var spell = preload("res://UI/Spell Sprite/SpellSprite.tscn")

signal playerAnimationDone

var tiles
var spellTexture
var color

func create(_tiles, _runeData):
	tiles = _tiles
	spellTexture = _runeData.heario.texture
	color = _runeData.eario.color

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
	var _spell = spell.instance()
	_spell.create(spellTexture, color, _position, _angle)
	add_child(_spell)

func checkIfCritterIsHit(_tile):
	var _hitCritter = $"/root/World".level.grid[_tile.x][_tile.y].critter
	if _hitCritter != null:
		get_node("/root/World/Critters/{critter}".format({ "critter": _hitCritter })).takeDamage($"/root/World/UI/UITheme/Runes".spellDamage, _tile)


func _on_Timer_timeout():
	animateCycle()