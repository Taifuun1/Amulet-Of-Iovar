extends TileMap

var currentFOVLevel = []
var fovLevels = []

func createFOVLevels():
	for _level in range(4):
		var response = buildFOVLevel()
		if typeof(response) != TYPE_ARRAY:
			push_error(response)
		fovLevels.append(response)
	currentFOVLevel = fovLevels[0]

func buildFOVLevel():
	var grid = []
	for _x in range(Globals.gridSize.x):
		grid.append([])
		for _y in range(Globals.gridSize.y):
			grid[_x].append(0)
			set_cell(_x, _y, 0)
	return grid

func moveLevel(_level):
	currentFOVLevel = fovLevels[_level]

func getCurrentLevelCell(_x, _y):
	return currentFOVLevel[_x][_y]

func seeCell(_x, _y):
	currentFOVLevel[_x][_y] = -1
	set_cell(_x, _y, -1)

func greyCell(_x, _y):
	currentFOVLevel[_x][_y] = 1
	set_cell(_x, _y, 1)
