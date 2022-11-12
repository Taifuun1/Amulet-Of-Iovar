extends TileMap

enum {
	HIDDEN
	FOG
}

var currentFOVLevel = []
var fovLevels = []

func createFOVLevels(_levelCount):
	for _level in range(_levelCount):
		fovLevels.append(buildFOVLevel())
	currentFOVLevel = fovLevels[0]

func buildFOVLevel():
	var grid = []
	for x in range(Globals.gridSize.x):
		grid.append([])
		for y in range(Globals.gridSize.y):
			grid[x].append(HIDDEN)
			set_cell(x, y, HIDDEN)
	return grid

func moveLevel(_level):
	currentFOVLevel = fovLevels[_level]

func seeCell(x, y):
	currentFOVLevel[x][y] = -1
	set_cell(x, y, -1)

func greyCell(x, y):
	currentFOVLevel[x][y] = FOG
	set_cell(x, y, FOG)

func getFOVSaveData():
	var _fovLevels = {}
	for _fovLevel in fovLevels.size():
		_fovLevels[_fovLevel] = {  }
		for _fovLevelX in fovLevels[_fovLevel]:
			for _fovLevelY in _fovLevel[_fovLevel][_fovLevelX]:
				_fovLevels[_fovLevel][_fovLevelX][_fovLevelY] = fovLevels[_fovLevel][_fovLevelX][_fovLevelY]
	return _fovLevels
