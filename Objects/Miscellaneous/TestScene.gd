extends Node2D

onready var beach = preload("res://Random Generators/Beach/Beach.tscn").instance()

func _ready():
	randomize()
	add_child(beach)
	yield(get_tree().create_timer(0.1), "timeout")
	get_children()[0].pathFind()
	get_children()[0].createNewLevel()
