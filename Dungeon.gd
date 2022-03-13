extends TileMap

onready var Room = preload("res://Random Generators/Room.tscn")

enum {FLOOR}

const room_positions = [
	Vector2(0,0),Vector2(0,1),Vector2(0,2),
	Vector2(1,0),Vector2(1,1),Vector2(1,2),
	Vector2(2,0),Vector2(2,1),Vector2(2,2),
	Vector2(3,0),Vector2(3,1),Vector2(3,2),
	Vector2(4,0),Vector2(4,1),Vector2(4,2)
]

const target_positions = [
	Vector2(0,-1),
	Vector2(-1,0),
	Vector2(0,1),
	Vector2(1,0)
]

var tile_size = get_cell_size()
var grid_size = Vector2(5,3)

var room_amount = 1

var grid = []
var room_grid = []

func _ready():
	
	randomize ( )
	
	#make grid
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	#make random rooms in grid cells
	while true:
		for i in range(room_positions.size()):
			if randi() % 2 == 1:
				make_room(i)
		if(grid.size() != 0):
			break
	
	#make doors
	var rooms = get_node("Rooms").get_children()
	for room in rooms:
		is_next_to_room(room.get_position(),room)
	
	#connect rooms into groups of rooms in a separate array
	make_room_grid()
	
	#make teleporters
	#connect_rooms()
	
	var s = ""
	for room_positions in room_grid:
		s += str(room_positions)+"\n"
	

func make_room(i):
	var new_room = Room.instance()
	new_room.set_position(map_to_world(room_positions[i]))
	var name = "Room"+str(room_amount)
	room_amount += 1
	new_room.set_name(str(name))
	var pos_on_grid = world_to_map(new_room.get_position())
	grid[pos_on_grid.x][pos_on_grid.y] = self.FLOOR
	get_node("Rooms").add_child(new_room)

func is_next_to_room(position = Vector2(),room=Object()):
	for i in range(4):
		var grid_pos = world_to_map(position) + target_positions[i]
		if grid_pos.x < grid_size.x and grid_pos.x >= 0:
			if grid_pos.y < grid_size.y and grid_pos.y >= 0:
				if grid[grid_pos.x][grid_pos.y] == FLOOR:
					room.make_door(target_positions[i])

func make_room_grid():
	var new_room = true
	#checked room position templates
	var room1 = []
	var room2 = []
	for i in range(2):
		room1.append(null)
		room2.append(null)
	#check all rooms in the original grid
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			#finds a room
			if grid[x][y] == FLOOR:
				new_room = true
				room1[0] = false
				room2[0] = false
				room1[1] = null
				room2[1] = null
				#check up and left
				for direction in range(2):
					#this is the checked adjacent room
					var grid_pos = Vector2(x,y) + target_positions[direction]
					#check if the target grid_pos is in the grid and is a room
					if (grid_pos.x < grid_size.x) and (grid_pos.x >= 0) and (grid_pos.y < grid_size.y) and (grid_pos.y >= 0):
						if(grid[grid_pos.x][grid_pos.y] == FLOOR):
							#checks if adjacent room is in a previous room grid
							#if both checked adjacent rooms are in a grid...
							#moves the bigger index contents to the lower index...
							#and deletes the bigger index contents
							#adjusts rooms accordingly
							for room_grid_array in room_grid:
								for room_grid_cell in room_grid_array:
									if room_grid_cell == grid_pos and room1[0] and !room2[0]:
										room2[0] = true
										room2[1] = room_grid.find(room_grid_array)
										if room1[0] and room2[0] and (room1[1] != room2[1]):
											for i in range(room_grid[room1[1]].size()):
												room_grid[room2[1]].append(room_grid[room1[1]][i])
											room_grid[room1[1]].clear()
									elif room_grid_cell == grid_pos and !room1[0] and !room2[0]:
										room_grid[room_grid.find(room_grid_array)].append(Vector2(x,y))
										room1[0] = true
										room1[1] = room_grid.find(room_grid_array)
										new_room = false
				#makes a new room if the checked room wasnt in any arrays
				if new_room:
					room_grid.append([])
					room_grid[room_grid.size() - 1].append(Vector2(x,y))
	
	#finally, sort the grid so we can remove the empty arrays from the complete room_grid
	room_grid.sort()
	
	#remove empty arrays
	for room_grid_array in room_grid:
		if(room_grid_array.empty()):
			room_grid.resize(room_grid.find(room_grid_array))

func connect_rooms():
	pass
	
