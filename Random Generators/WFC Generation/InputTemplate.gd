extends TileMap
class_name WaveFunctionCollapseTemplate

enum tiles { 
	EMPTY
	CORRIDOR
	WALL_DUNGEON
	FLOOR_DUNGEON
	SIDEWALK
	DOWN_STAIR_DUNGEON
	UP_STAIR_DUNGEON
	DOOR_CLOSED
	DOOR_OPEN
	GRASS
	SEA
	SAND
	SOIL
	WALL_SAND
	WALL_BRICK_SAND
	FLOOR_SAND
	DOWN_STAIR_SAND
	UP_STAIR_SAND
	WALL_BOARD
}

var gridSize = Vector2(0,0)

func create():
	var used_cells = get_used_cells()
	for position in used_cells:
		if position.x + 1 > gridSize.x:
			gridSize.x = int(position.x + 1)
		if position.y + 1 > gridSize.y:
			gridSize.y = int(position.y + 1)
