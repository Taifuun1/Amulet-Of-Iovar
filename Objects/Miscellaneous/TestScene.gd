extends Node2D

onready var items = preload("res://Objects/Item/Items.tscn").instance()

func _ready():
	add_child(items)
	yield(get_tree().create_timer(0.1), "timeout")
	get_children()[0].randomizeRandomItems()
