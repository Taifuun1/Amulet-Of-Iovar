extends AStarPath
class_name BaseLevel

var dungeonType

var levelId
var grid = []
var rooms = []
var spawnableFloors = []
var stairs = {}

var critters = []

func setName(_dungeonType):
	levelId = Globals.levelId
	name = str(Globals.levelId)
	Globals.levelId += 1
	dungeonType = _dungeonType

func placeCritter(_tile, _critter):
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if _tile == grid[x][y].tile:
				grid[x][y].critter = _critter
				return

func getCritterTile(_critter):
	for x in range(grid.size()):
		for y in range(grid[x].size()):
			if grid[x][y].critter == _critter:
				return Vector2(x, y)
	return false
