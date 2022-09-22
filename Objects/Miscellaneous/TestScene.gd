extends Node2D

onready var beach = preload("res://Level Generation/Beach/Beach.tscn").instance()

func _ready():
	randomize()
	yield(get_tree().create_timer(0.1), "timeout")
