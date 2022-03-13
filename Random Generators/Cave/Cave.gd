extends Node

enum { PLAYER, FLOOR, WALL }

var grid = []

var grid_size = rand_range(50, 100)

func _ready():
	for x in range(grid_size):
		grid.append([])
		for y in range(grid_size):
			grid[x].append(FLOOR)

func new():
	
	pass
