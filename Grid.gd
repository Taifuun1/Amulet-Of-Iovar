# Collection of functions to work with a Grid. Stores all its children in the grid array
extends TileMap

enum ENTITY_TYPES {PLAYER, WALL, LEVEL_END, DOOR, DOOR_SWITCH, ENEMY}

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var grid_size = Vector2(53, 30)

var grid = []

onready var Player = preload("res://Player.tscn")
onready var LevelEnd = preload("res://LevelEnd.tscn")
onready var Door = preload("res://DoorSwitch.tscn")
onready var Enemy = preload("res://Enemy.tscn")

func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	if get_tree().get_current_scene().get_name() == "Level1":
		
		# Player
		var new_player = Player.instance()
		new_player.set_position(map_to_world(Vector2(2,2)) + half_tile_size)
		new_player.set_name("Player")
		add_child(new_player)
		
		# Level End Block
		var new_level_end = LevelEnd.instance()
		new_level_end.set_position(map_to_world(Vector2(21,23)) + half_tile_size)
		new_level_end.set_name("Levelend")
		get_node("LevelEnd").add_child(new_level_end)
		
		# Add walls to the grid as "Wall"
		var walls = get_node("Walls").get_children()
		for wall in walls:
			var pos_on_grid = world_to_map(wall.get_position())
			grid[pos_on_grid.x][pos_on_grid.y] = self.WALL
		
		var l = get_node("LevelEnd").get_children()
		for le in l:
			var pos_lev_end = world_to_map(le.get_position())
			grid[pos_lev_end.x][pos_lev_end.y] = le.get_tile_type()
	
	
	
	elif get_tree().get_current_scene().get_name() == "Level2":
		
		# Player
		var new_player = Player.instance()
		new_player.set_position(map_to_world(Vector2(1,1)) + half_tile_size)
		new_player.set_name("Player")
		add_child(new_player)
		
		# Level End Block
		var new_level_end = LevelEnd.instance()
		new_level_end.set_position(map_to_world(Vector2(13,2)) + half_tile_size)
		new_level_end.set_name("Levelend")
		get_node("LevelEnd").add_child(new_level_end)
		
		# Add walls to the grid as "Wall"
		var walls = get_node("Walls").get_children()
		for wall in walls:
			var pos_on_grid = world_to_map(wall.get_position())
			grid[pos_on_grid.x][pos_on_grid.y] = self.WALL
		
		# Door
		var new_door = Door.instance()
		new_door.set_position(map_to_world(Vector2(7,13)) + half_tile_size)
		new_door.set_name("Door")
		add_child(new_door)
		get_node("Door").move_door(Vector2(10,2))
		
		var l = get_node("LevelEnd").get_children()
		for le in l:
			var pos_lev_end = world_to_map(le.get_position())
			grid[pos_lev_end.x][pos_lev_end.y] = le.get_tile_type()
	
	
	
	elif get_tree().get_current_scene().get_name() == "Level3":
		
		# Player
		var new_player = Player.instance()
		new_player.set_position(map_to_world(Vector2(1,1)) + half_tile_size)
		new_player.set_name("Player")
		add_child(new_player)
		
		# Level End Block
		var new_level_end = LevelEnd.instance()
		new_level_end.set_position(map_to_world(Vector2(13,2)) + half_tile_size)
		new_level_end.set_name("Levelend")
		get_node("LevelEnd").add_child(new_level_end)
		
		# Add walls to the grid as "Wall"
		var walls = get_node("Walls").get_children()
		for wall in walls:
			var pos_on_grid = world_to_map(wall.get_position())
			grid[pos_on_grid.x][pos_on_grid.y] = self.WALL
		
		var l = get_node("LevelEnd").get_children()
		for le in l:
			var pos_lev_end = world_to_map(le.get_position())
			grid[pos_lev_end.x][pos_lev_end.y] = le.get_tile_type()
		
		# Enemy
		var new_enemy = Enemy.instance()
		new_enemy.set_position(map_to_world(Vector2(5,5)) + half_tile_size)
		new_enemy.set_name("Enemy")
		add_child(new_enemy)

func is_cell_vacant(pos=Vector2(), direction=Vector2()):
	var grid_pos = world_to_map(pos) + direction

	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == null else false
	return false

func is_cell_level_end(pos=Vector2(), direction=Vector2()):
	var grid_pos = world_to_map(pos) + direction

	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == LEVEL_END else false
	return false

func is_cell_enemy(pos=Vector2(), direction=Vector2()):
	var grid_pos = world_to_map(pos) + direction

	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == ENEMY else false
	return false

func update_child_position(new_pos, direction, type):
	# Remove node from current cell, add it to the new cell, returns the new target move_to position
	var grid_pos = world_to_map(new_pos)
	grid[grid_pos.x][grid_pos.y] = null
	
	var new_grid_pos = grid_pos + direction
	grid[new_grid_pos.x][new_grid_pos.y] = type
	
	var target_pos = map_to_world(new_grid_pos) + half_tile_size
	return target_pos
