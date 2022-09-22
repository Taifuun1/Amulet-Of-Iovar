extends TileMap
class_name WaveFunctionCollapseTemplate

var gridSize = Vector2(0,0)

func create():
	var used_cells = get_used_cells()
	for position in used_cells:
		if position.x + 1 > gridSize.x:
			gridSize.x = int(position.x + 1)
		if position.y + 1 > gridSize.y:
			gridSize.y = int(position.y + 1)
