extends Node

var aI = "Aggressive"

func getCritterMove(_critterTile, _playerTile, _level):
	if aI.matchn("Aggressive"):
		var _path = _level.calculatePathFindingPath(_critterTile, _playerTile)
		if _path.size() == 0:
			return getNeutralCritterMove(_critterTile, _level)
		return _path
	elif aI.matchn("Deactivated"):
		return []
#	elif aI == "Neutral":
	else:
		return getNeutralCritterMove(_critterTile, _level)

func getNeutralCritterMove(_critterTile, _level):
	var _chosenPoint
	var _points = []
	var _directionPoints = PoolVector2Array([
		Vector2(-1, -1),
		Vector2(0, -1),
		Vector2(1, -1),
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(0, 1),
		Vector2(-1, 1),
		Vector2(-1, 0)
	])
	for _direction in _directionPoints:
		var _point = _critterTile + _direction
		if _level.hasPoint(_point):
			_points.append(Vector2(_point))
	if _points.size() == 0:
		return []
	elif(randi() % 3 + 1) == 1:
		return []
	else:
		_chosenPoint = _points[randi() % _points.size()]
	if _level.grid[_chosenPoint.x][_chosenPoint.y].critter == null:
		return _level.calculatePathFindingPath(_critterTile, _chosenPoint)
	else:
		return []
