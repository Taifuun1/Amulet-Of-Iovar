extends TileMap

enum {
	HIDDEN
	FOG
}

var currentFOVLevel = []
var fovLevels = []

func createFOVLevels(_levelCount):
	for _level in range(_levelCount):
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
			set_cell(_x, _y, HIDDEN)
	return grid

func moveLevel(_level):
	currentFOVLevel = fovLevels[_level]

func seeCell(_x, _y):
	currentFOVLevel[_x][_y] = -1
	set_cell(_x, _y, -1)

func greyCell(_x, _y):
	currentFOVLevel[_x][_y] = FOG
	set_cell(_x, _y, FOG)
