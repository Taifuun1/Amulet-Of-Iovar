extends BaseLevel
class_name WaveFunctionCollapse

var gridSize = Vector2(68,32)
var entropyVariation = 0

var allInputs
var generatedGrid = []
var edgeTiles = []
var nonLegibleTiles = []

class edgeTile:
	var position
	var matches
	
	func setValues(_position, _matches = null):
		position = _position
		matches = _matches

func sortToLowestEntropy(a, b):
	return a.matches.size() < b.matches.size()

func resetGeneration():
	generatedGrid = []
	edgeTiles.clear()
	allInputs.clear()
	nonLegibleTiles.clear()
#	for x in range(gridSize.x):
#		for y in range(gridSize.y):
#			set_cellv(Vector2(x, y), -1)

func generateMap(_entropyVariation = null):
	if _entropyVariation != null:
		entropyVariation = _entropyVariation
	
	createGenerationGrid()
	
	allInputs = getAllInputs()
	
	placeCornerPatterns()
	
	while !edgeTiles.empty():
		var _tile = getRandomLowestEntropyEdgeTile()
		if _tile == null:
			return false
		if !isTileLegible(_tile):
			edgeTiles.erase(_tile)
			nonLegibleTiles.append(_tile.position)
		
		getMatchesForEdgeTiles()
		edgeTiles.sort_custom(self, "sortToLowestEntropy")
	return true

func isTileLegible(_tile):
	_tile.matches.shuffle()
	for _match in _tile.matches:
		var _legibleInputs = doesTileHaveLegibleInputs(_tile, _match)
		if typeof(_legibleInputs) != TYPE_BOOL:
			for _legibleTile in _legibleInputs.grid:
				generatedGrid[_legibleTile.x][_legibleTile.y].tile = _legibleInputs.grid[_legibleTile]
#				set_cellv(Vector2(_legibleTile.x, _legibleTile.y), _legibleInputs.grid[_legibleTile])
			edgeTiles = _legibleInputs.edgeTiles.duplicate(true)
			return true
	
	return false



####################################
### Edge tile updating functions ###
####################################

func doesTileHaveLegibleInputs(_tile, _randomMatch):
	### Tiles to be changed
	var _testGrid = addToTestGrid(_tile.position, _randomMatch, {})
	
	### Tiles to be checked for edgetiles
	var _testGridTiles = addToTestGridTiles(_tile.position, [])
	
	### Edgetiles to be looped through
	var _testEdgeTiles = getEdgeTilesForTile(_tile.position, edgeTiles, _testGrid)
	
	### Legible edgetiles loop
	while !_testEdgeTiles.empty():
		var _testEdgeTile = _testEdgeTiles.front()
		var _partialPattern = getPartialPatternForTile(_testEdgeTile.position, _testGrid)
		var _matches = findAllPartialPatternMatches(_partialPattern)
		if typeof(_matches) == TYPE_BOOL:
			_testEdgeTiles.erase(_testEdgeTile)
#			return false
		else:
			if _matches.size() == 1:
				_testGrid = addToTestGrid(_testEdgeTile.position, _matches[0], _testGrid)
				_testGridTiles = addToTestGridTiles(_testEdgeTile.position, _testGridTiles)
				_testEdgeTiles = getEdgeTilesForTile(_testEdgeTile.position, _testEdgeTiles, _testGrid)
			else:
				_testEdgeTiles.erase(_testEdgeTile)
	
	### Check what the new edgetiles will be
	var _newTestEdgeTiles = getNewEdgeTiles(_testGrid, _testGridTiles)
	
	return {
		"grid": _testGrid,
		"edgeTiles": _newTestEdgeTiles
	}

func getEdgeTilesForTile(_tile, _edgeTiles, _grid = null):
	var _newEdgeTiles = _edgeTiles.duplicate(true)
	for x in range(_tile.x - 1,  _tile.x + 2):
		for y in range(_tile.y - 1,  _tile.y + 2):
			var _newEdgeTilesTileIndex = checkIfArrayOfClassesHasValue(_newEdgeTiles, "position", Vector2(x,y))
			if x < 2 or y < 2 or x > gridSize.x - 3 or y > gridSize.y - 3:
				continue
			elif _tile == Vector2(x,y) and _newEdgeTilesTileIndex != -1:
				_newEdgeTiles.remove(_newEdgeTilesTileIndex)
			else:
				var _tileCount = getEdgetileTileCount(Vector2(x,y), _grid)
				if (_tileCount >= 3 and _tileCount != 9 and !nonLegibleTiles.has(Vector2(x,y)) and _newEdgeTilesTileIndex == -1):
					var _newEdgeTile = edgeTile.new()
					_newEdgeTile.setValues(Vector2(x,y))
					_newEdgeTiles.append(_newEdgeTile)
				elif _newEdgeTilesTileIndex != -1 and (_tileCount < 3 or _tileCount == 9):
					_newEdgeTiles.remove(_newEdgeTilesTileIndex)
	return _newEdgeTiles

func getEdgetileTileCount(_tile, _grid = null):
	var _partialPattern = getPartialPatternForTile(_tile)
	var _adjacentTiles = PoolVector2Array([
		Vector2(0, 0),
		Vector2(0,-1),
		Vector2(1,-1),
		Vector2(1,0),
		Vector2(1,1),
		Vector2(0,1),
		Vector2(-1,1),
		Vector2(-1,0),
		Vector2(-1,-1)
	])
	var _tileCount = 0
	for _adjacentTile in _adjacentTiles:
		if (_grid != null and _grid.has(Vector2(_tile.x + _adjacentTile.x, _tile.y + _adjacentTile.y)) and _grid[Vector2(_tile.x + _adjacentTile.x, _tile.y + _adjacentTile.y)] != -1) or _partialPattern[1 + _adjacentTile.x][1 + _adjacentTile.y] != -1:
			_tileCount += 1
	return _tileCount

func getNewEdgeTiles(_testGrid, _testGridTiles):
	### New edgetiles
	var _newTestEdgeTiles = []
	
	### Existing edgetiles
	var _newEdgeTiles = edgeTiles.duplicate(true)
	for _edgeTile in _newEdgeTiles:
		var _tileCount = getEdgetileTileCount(_edgeTile.position, _testGrid)
		var _edgetilesTileIndex = checkIfArrayOfClassesHasValue(_newTestEdgeTiles, "position", _edgeTile.position)
		if checkIfPositionHasTile(_edgeTile.position, _testGrid) and _tileCount >= 3 and _tileCount != 9 and !nonLegibleTiles.has(_edgeTile.position) and _edgetilesTileIndex == -1 and !(_edgeTile.position.x < 2 or _edgeTile.position.y < 2 or _edgeTile.position.x > gridSize.x - 3 or _edgeTile.position.y > gridSize.y - 3):
			var _newEdgeTile = edgeTile.new()
			_newEdgeTile.setValues(_edgeTile.position)
			_newTestEdgeTiles.append(_newEdgeTile)
		elif _edgetilesTileIndex != -1:
			_newTestEdgeTiles.remove(_edgetilesTileIndex)
	
	### New edgetiles
	for _edgeTile in _testGridTiles:
		var _tileCount = getEdgetileTileCount(_edgeTile, _testGrid)
		var _edgetilesTileIndex = checkIfArrayOfClassesHasValue(_newTestEdgeTiles, "position", _edgeTile)
		if checkIfPositionHasTile(_edgeTile, _testGrid) and _tileCount >= 3 and _tileCount != 9 and !nonLegibleTiles.has(_edgeTile) and _edgetilesTileIndex == -1 and !(_edgeTile.x < 2 or _edgeTile.y < 2 or _edgeTile.x > gridSize.x - 3 or _edgeTile.y > gridSize.y - 3):
			var _newEdgeTile = edgeTile.new()
			_newEdgeTile.setValues(_edgeTile)
			_newTestEdgeTiles.append(_newEdgeTile)
		elif _edgetilesTileIndex != -1:
			_newTestEdgeTiles.remove(_edgetilesTileIndex)
	
	return _newTestEdgeTiles

func addToTestGrid(_tile, _pattern, _grid):
	var _testGrid = _grid.duplicate(true)
	for x in range(3):
		for y in range(3):
			if !_testGrid.has(Vector2(_tile.x + (x - 1), _tile.y + (y - 1))):
				_testGrid[Vector2(_tile.x + (x - 1), _tile.y + (y - 1))] = _pattern[x][y]
	return _testGrid

func addToTestGridTiles(_tile, _gridTiles):
	var _testGridTiles = _gridTiles.duplicate(true)
	for x in range(5):
		for y in range(5):
			if !_testGridTiles.has(Vector2(_tile.x + (x - 2), _tile.y + (y - 2))):
				_testGridTiles.append(Vector2(_tile.x + (x - 2), _tile.y + (y - 2)))
	return _testGridTiles

func getMatchesForEdgeTiles():
	var _newEdgeTiles = []
	for _edgeTile in edgeTiles:
		if _edgeTile.matches == null:
			var _matches = findAllPartialPatternMatches(getPartialPatternForTile(_edgeTile.position))
			if typeof(_matches) == TYPE_BOOL and _matches == false:
				nonLegibleTiles.append(_edgeTile.position)
			else:
				_edgeTile.matches = _matches
				_newEdgeTiles.append(_edgeTile)
		else:
			_newEdgeTiles.append(_edgeTile)
	edgeTiles = _newEdgeTiles



###############################
### Pattern match functions ###
###############################

func getPartialPatternForTile(_tile, _grid = null):
	var _partialPattern = makeNewPattern()
	for x in range(3):
		for y in range(3):
			if _grid != null and _grid.has(Vector2(x,y)):
				_partialPattern[x][y] = _grid[Vector2(x,y)]
			else:
				_partialPattern[x][y] = generatedGrid[_tile.x + (x - 1)][_tile.y + (y - 1)].tile
#				get_cellv(Vector2(_tile.x + (x - 1), _tile.y + (y - 1)))
	return _partialPattern

func findAllPartialPatternMatches(_partialPattern):
	var _matches = []
	for _input in allInputs:
		for _inputPattern in _input:
			var _match = isPartialPatternAMatch(_partialPattern, _inputPattern)
			if _match and !checkMatchesDoesntHavePattern(_partialPattern, _matches):
				_matches.append(_inputPattern)
	if _matches.empty():
		return false
	return _matches

func isPartialPatternAMatch(_partialPattern, _inputPattern):
	for x in range(3):
		for y in range(3):
			if _partialPattern[x][y] != -1 and _partialPattern[x][y] != _inputPattern[x][y]:
				return false
	return true

func checkMatchesDoesntHavePattern(_newInputPattern, _array):
	for _inputPattern in _array:
		if checkIfInputsAreEqual(_newInputPattern, _inputPattern):
			return true
	return false



################################
### Tile placement functions ###
###############################

func drawPattern(_tile, _pattern):
	for x in range(3):
		for y in range(3):
			generatedGrid[_tile.x + (x - 1)][_tile.y + (y - 1)].tile = _pattern[x][y]
#			set_cellv(Vector2(_tile.x + (x - 1), _tile.y + (y - 1)), _pattern[x][y])

func drawPatternWithGrid(_grid):
	for tile in _grid.keys():
		pass
#		set_cellv(Vector2(tile.x, tile.y), _grid[tile])

func changeReplaceables(_replaceables):
	for x in Globals.gridSize.x:
		for y in Globals.gridSize.y:
			if grid[x][y].tile == Globals.tiles.REPLACEABLE1:
				grid[x][y].tile = Globals.tiles[_replaceables[randi() % _replaceables.size()]]

func placeTilesInArea(_placement):
	if _placement.has("side"):
		if _placement.side.matchn("west"):
			for x in _placement.tilesFromSide:
				for y in Globals.gridSize.y:
					grid[x][y].tile = generatedGrid[x][y].tile
					grid[x][y].tileMetaData = generatedGrid[x][y].tileMetaData
		elif _placement.side.matchn("east"):
			for x in range(int(Globals.gridSize.x) - 1, int(Globals.gridSize.x) - _placement.tilesFromSide, -1):
				for y in Globals.gridSize.y - 1:
					grid[x][y].tile = generatedGrid[x][y].tile
					grid[x][y].tileMetaData = generatedGrid[x][y].tileMetaData
	if _placement.has("splotches"):
		for _splotch in _placement.splotches:
			for x in Globals.gridSize.x:
				for y in Globals.gridSize.y:
					if calculatePath(Vector2(x,y), _splotch.spot).size() < _splotch.distance:
						grid[x][y].tile = generatedGrid[x][y].tile
						grid[x][y].tileMetaData = generatedGrid[x][y].tileMetaData



##########################################
### Input pattern processing functions ###
##########################################

func addInputs(_name, _path):
	var dir = Directory.new()
	var inputs = []
	if dir.open(_path) == OK:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			if not dir.current_is_dir() and fileName.get_extension().matchn("tscn"):
				inputs.append(fileName)
			fileName = dir.get_next()
	for fileName in inputs:
		$Inputs.add_child(load("res://Level Generation/WFC Generation/{name}/Inputs/{fileName}".format({ name = _name, fileName = fileName })).instance())

func getAllInputs():
	var _allInputs = []
	for _inputNode in $Inputs.get_children():
		_inputNode.create()
		var _input = createNodeInputGrid(_inputNode)
		for _i in range(4):
			var _newInputPatterns = getInputPatterns(_input, _allInputs)
			if !_newInputPatterns.empty():
				_allInputs.append(_newInputPatterns)
			_input = turnInput(_input)
	for _inputNode in $Inputs.get_children():
		_inputNode.queue_free()
	
	return _allInputs

func createNodeInputGrid(_inputNode):
	var _input = []
	for x in range(_inputNode.gridSize.x):
		_input.append([])
		for y in range(_inputNode.gridSize.y):
			_input[x].append(_inputNode.get_cellv(Vector2(x,y)))
#			_input[x].append(_inputNode.get_cellv(Vector2(x,y)))
	return _input

func createInputGrid(_input):
	var _inputGrid = []
	for x in range(_input.size()):
		_inputGrid.append([])
		for y in range(_input[x].size()):
			_inputGrid[x].append(_input[x][y])
	return _inputGrid

func getInputPatterns(_input, _allInputs):
	var _newInput = []
	for x in range(1, _input.size() - 1):
		for y in range(1, _input[x].size() - 1):
			var _inputPattern = getInputPatternWithGrid(_input, x, y)
			if !checkIfInputIsAlreadyAnInput(_inputPattern, _newInput, _allInputs):
				_newInput.append(_inputPattern)
	return _newInput

func turnInput(_input):
	var _turnedInput = createInputGrid(_input)
	var _inputIndex = _input.size() - 1
	for x in _input.size():
		for y in _input[x].size():
			_turnedInput[x][y] = _input[y][_inputIndex]
		_inputIndex -= 1
	return _turnedInput

func getInputPatternWithGrid(_input, x, y):
	var _inputPattern = makeNewPattern()
	var _inputPatternX = 0
	var _inputPatternY = 0
	for patternX in range(x - 1, x + 2):
		for patternY in range(y - 1, y + 2):
			_inputPattern[_inputPatternX][_inputPatternY] = _input[patternX][patternY]
			_inputPatternY += 1
		_inputPatternX += 1
		_inputPatternY = 0
	return _inputPattern

func checkIfInputIsAlreadyAnInput(_newInputPattern, _newInput, _allInputs):
	for _inputPattern in _newInput:
		if checkIfInputsAreEqual(_newInputPattern, _inputPattern):
			return true
	for _input in _allInputs:
		for _inputPattern in _input:
			if checkIfInputsAreEqual(_newInputPattern, _inputPattern):
				return true
	return false

func checkIfInputsAreEqual(_newInputPattern, _inputPattern):
	for x in range(3):
		for y in range(3):
			if _newInputPattern[x][y] != _inputPattern[x][y]:
				return false
	return true


########################
### Helper functions ###
########################

func makeNewPattern():
	var _newInputPattern = []
	for x in range(3):
		_newInputPattern.append([])
		for _y in range(3):
			_newInputPattern[x].append(-1)
	return _newInputPattern

func getRandomPattern():
	var _randomInput = randi() % allInputs.size()
	var _randomPattern = allInputs[_randomInput][randi() % allInputs[_randomInput].size()]
	return _randomPattern

func getRandomLowestEntropyEdgeTile():
	var _lowestEntropyEdgeTiles = []
	var _lowestEntropyEdgeTileSize = edgeTiles.front().matches.size() + entropyVariation
	for _edgeTile in edgeTiles:
		if _edgeTile.matches.size() <= _lowestEntropyEdgeTileSize and checkIfArrayOfClassesHasValue(_lowestEntropyEdgeTiles, "position", _edgeTile.position) == -1:
			_lowestEntropyEdgeTiles.append(_edgeTile)
		else:
			break
	return _lowestEntropyEdgeTiles[randi() % _lowestEntropyEdgeTiles.size()]

func placeCornerPatterns():
	var _corners = PoolVector2Array([
		Vector2(2, 2),
#		Vector2(2, gridSize.y - 3),
#		Vector2(gridSize.x - 3, gridSize.y - 3),
#		Vector2(gridSize.x - 3, 2)
	])
	for _corner in _corners:
		drawPattern(_corner, getRandomPattern())
	
	var _edgeTiles = []
	for _corner in _corners:
		for x in range(_corner.x - 1,  _corner.x + 2):
			for y in range(_corner.y - 1,  _corner.y + 2):
				if x < 2 or y < 2 or x > gridSize.x - 3 or y > gridSize.y - 3:
					continue
				elif _corner == Vector2(x,y):
					_edgeTiles.erase(_corner)
				else:
					var _tileCount = getEdgetileTileCount(Vector2(x,y))
					if (_tileCount >= 3 and _tileCount != 9):
						var _newEdgeTile = edgeTile.new()
						_newEdgeTile.setValues(Vector2(x,y))
						_edgeTiles.append(_newEdgeTile)
					elif _tileCount < 3 or _tileCount == 9:
						_edgeTiles.erase(_corner)
	for _edgeTile in _edgeTiles:
		var _matches = findAllPartialPatternMatches(getPartialPatternForTile(_edgeTile.position))
		if typeof(_matches) == TYPE_BOOL:
			continue
		_edgeTile.setValues(_edgeTile.position, _matches)
		edgeTiles.append(_edgeTile)
	edgeTiles.shuffle()

func createGenerationGrid(_isGenerationGridSize = true):
	generatedGrid = []
	var _gridSize = gridSize
	if !_isGenerationGridSize:
		_gridSize = Globals.gridSize
	for x in range(_gridSize.x):
		generatedGrid.append([])
		for _y in range(_gridSize.y):
			generatedGrid[x].append({
				"tile": -1,
				"tileMetaData": null
			})

func checkIfArrayOfClassesHasValue(_array, _property, _value):
	for _index in _array.size():
		if _array[_index][_property] == _value:
			return _index
	return -1

func checkIfPositionHasTile(_position, _testGrid):
	if generatedGrid[_position.x][_position.y].tile != -1 or (_testGrid.has(_position) and _testGrid[_position] != -1):
		return true
	return false

func getGenerationGrid():
	for x in range(generatedGrid.size()):
		for y in range(generatedGrid[x].size()):
#			grid[x][y].tile = get_cellv(Vector2(x,y))
#			grid[x][y].tileMetaData = {
#				"xFlip": is_cell_x_flipped(x, y),
#				"yFlip": is_cell_y_flipped(x, y)
#			}
			generatedGrid[x][y].tileMetaData = {
				"xFlip": is_cell_x_flipped(x, y),
				"yFlip": is_cell_y_flipped(x, y)
			}

func trimGenerationEdges():
	var _trimmedGrid = []
	var _generatedGridCopy = generatedGrid.duplicate(true)
	for x in range(gridSize.x - 8):
		_trimmedGrid.append([])
		for y in range(gridSize.y - 8):
			_trimmedGrid[x].append(_generatedGridCopy[x + 4][y + 4].tile)
	createGenerationGrid(false)
	for x in _trimmedGrid.size():
		for y in _trimmedGrid[x].size():
			generatedGrid[x][y].tile = _trimmedGrid[x][y]
#			set_cellv(Vector2(x,y), grid[x][y])

func fillEmptyGenerationTiles(_tile, _fillEdges = null):
	for x in range(generatedGrid.size()):
		for y in range(generatedGrid[x].size()):
			if generatedGrid[x][y].tile == -1:
				generatedGrid[x][y].tile = Globals.tiles[_tile]
	if _fillEdges != null:
		for x in range(generatedGrid.size()):
			if generatedGrid[x][0].tile == Globals.tiles.DOOR_CLOSED:
				generatedGrid[x][0].tile = Globals.tiles[_fillEdges]
		for x in range(generatedGrid.size()):
			if generatedGrid[x][generatedGrid[x].size() - 1].tile == Globals.tiles.DOOR_CLOSED:
				generatedGrid[x][generatedGrid[x].size() - 1].tile = Globals.tiles[_fillEdges]
		for y in range(1, generatedGrid[0].size() - 1):
			if generatedGrid[0][y].tile == Globals.tiles.DOOR_CLOSED:
				generatedGrid[0][y].tile = Globals.tiles[_fillEdges]
		for y in range(1, generatedGrid[0].size() - 1):
			if generatedGrid[generatedGrid.size() - 1][y].tile == Globals.tiles.DOOR_CLOSED:
				generatedGrid[generatedGrid.size() - 1][y].tile = Globals.tiles[_fillEdges]

func getUsedCells():
	var _usedCells = 0
	for x in generatedGrid.size():
		for y in generatedGrid[x].size():
			if generatedGrid[x][y].tile != -1:
				_usedCells += 1
	return _usedCells

func fillGridWithGeneratedGrid():
	for x in generatedGrid.size():
		for y in generatedGrid[x].size():
			grid[x][y].tile = generatedGrid[x][y].tile
			grid[x][y].tileMetaData = generatedGrid[x][y].tileMetaData
