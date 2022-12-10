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

func buildFOVLevel(_fovData = null):
	var grid = []
	for x in range(Globals.gridSize.x):
		grid.append([])
		for y in range(Globals.gridSize.y):
			if _fovData == null:
				grid[x].append(HIDDEN)
				set_cell(x, y, HIDDEN)
				continue
			grid[x].append(_fovData[str(x)][str(y)])
	return grid

func loadFOVLevel(_data):
	for _level in _data.fovLevels.values():
		fovLevels.append(buildFOVLevel(_level))
	currentFOVLevel = fovLevels[Globals.currentDungeonLevel - 1]

func moveLevel(_level):
	currentFOVLevel = fovLevels[_level]

func seeCell(x, y):
	currentFOVLevel[x][y] = -1
	set_cell(x, y, -1)

func greyCell(x, y):
	currentFOVLevel[x][y] = FOG
	set_cell(x, y, FOG)

func getFOVSaveData():
	var _fovLevels = { "fovLevels": {  } }
	for _fovLevel in fovLevels.size():
		_fovLevels.fovLevels[_fovLevel] = {  }
		for x in fovLevels[_fovLevel].size():
			_fovLevels.fovLevels[_fovLevel][x] = {  }
			for y in fovLevels[_fovLevel][x].size():
				_fovLevels.fovLevels[_fovLevel][x][y] = fovLevels[_fovLevel][x][y]
	return _fovLevels
