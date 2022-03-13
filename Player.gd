extends Node2D

var direction = Vector2()

const MAX_SPEED = 2000

var speed = 0
var velocity = Vector2()

var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false

var move_lock

var type
var grid
var pos

func _ready():
	grid = $".."
#	pos = grid.world_to_map(get_position())
#	grid.grid[pos.x][pos.y] = grid.PLAYER
	type = grid.PLAYER
	move_lock = 0
#	set_physics_process(true)

#func _physics_process(delta):
#	direction = Vector2()
#	speed = 0
#
#	if move_lock == 0:
#		if Input.is_action_pressed("move_up"):
#			direction.y = -1
#			move_lock = 0.13
#		elif Input.is_action_pressed("move_down"):
#			direction.y = 1
#			move_lock = 0.13
#
#		if Input.is_action_pressed("move_left"):
#			direction.x = -1
#			move_lock = 0.13
#		elif Input.is_action_pressed("move_right"):
#			direction.x = 1
#			move_lock = 0.13
#
#	if not is_moving and direction != Vector2():
#		target_direction = direction.normalized()
#		if grid.is_cell_enemy(get_position(), direction):
#			var enemy = get_tree().get_current_scene().get_node("Grid").get_node("Enemy")
#			enemy.on_hit()
#		elif grid.is_cell_level_end(get_position(), direction):
#			var popupwindow = get_parent().get_parent().get_node("ChangeLevel")
#			popupwindow.popup()
#		elif grid.is_cell_vacant(get_position(), direction):
#			target_pos = grid.update_child_position(get_position(), direction, type)
#			is_moving = true
#	elif is_moving:
#		speed = MAX_SPEED
#		velocity = speed * target_direction * delta
#
#		var pos = get_position()
#		var distance_to_target = pos.distance_to(target_pos)
#		var move_distance = velocity.length()
#
#		if move_distance > distance_to_target:
#			velocity = target_direction * distance_to_target
#			is_moving = false
#
#		move_and_collide(velocity)
#
#	if move_lock - delta <= 0:
#		move_lock = 0
#	else:
#		move_lock -= delta

func on_door_switch_activate(player):
	grid.get_node("Door").open_door()
