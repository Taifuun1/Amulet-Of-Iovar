extends Node

var aI = "Aggressive"
var aggroDistance = -1
var aggroTarget = null
var activationDistance

func create(_aI, _aggroDistance, _activationDistance = null):
	name = "aI"
	aI = _aI
	aggroDistance = _aggroDistance
	activationDistance = _activationDistance

func checkAggroTarget(_critterTile, _distanceFromPlayer, _hostileRaces, _level):
	var _closestHostileCritter = {
		"id": null,
		"distance": null
	}
	for _critterId in _level.critters:
		if _hostileRaces.has(get_node("/root/World/Critters/{critterId}".format({ "critterId": _critterId })).race):
			var _otherCritterTile = _level.getCritterTile(_critterId)
			_level.addPointToPathPathding(_otherCritterTile)
			var _distanceFromOtherCritter = _level.calculatePath(_critterTile, _otherCritterTile).size()
			_level.addPointToPathPathding(_otherCritterTile)
			if (
				(
					_distanceFromOtherCritter < _distanceFromPlayer and
					_closestHostileCritter.distance == null and
					_distanceFromOtherCritter < aggroDistance and
					_distanceFromOtherCritter != 0
				) or
				(
					_distanceFromOtherCritter < _distanceFromPlayer and
					_closestHostileCritter.distance != null and
					_distanceFromOtherCritter < _closestHostileCritter.distance and
					_distanceFromOtherCritter < aggroDistance and
					_distanceFromOtherCritter != 0
				)
			):
				_closestHostileCritter = {
					"id": _critterId,
					"distance": _distanceFromOtherCritter
				}
	if _closestHostileCritter.id != null:
		aggroTarget = _closestHostileCritter.id
	else:
		aggroTarget = null

func getCritterMove(_critterTile, _playerTile, _distanceFromPlayer, _hostileRaces, _level):
	if aggroTarget != null or aggroTarget == 0:
		_level.addPointToPathPathding(_critterTile)
		if !_level.critters.has(aggroTarget) or _level.calculatePath(_critterTile, _critterTile).size() == 0:
			aggroTarget = null
		_level.addPointToPathPathding(_critterTile)
	if aggroTarget == null and !_hostileRaces.empty():
		checkAggroTarget(_critterTile, _distanceFromPlayer, _hostileRaces, _level)
	if aggroTarget != null:
		var _otherCritterTile = _level.getCritterTile(aggroTarget)
		_level.addPointToEnemyPathding(_otherCritterTile)
		var _path = _level.calculatePathFindingPath(_critterTile, _otherCritterTile)
		_level.addPointToEnemyPathding(_otherCritterTile)
		return _path
	if aI.matchn("Aggressive"):
		return getAggressiveCritterMove(_critterTile, _playerTile, _level)
	elif aI.matchn("Slow Aggressive"):
		if randi() % 3 != 0:
			return []
		return getAggressiveCritterMove(_critterTile, _playerTile, _level)
	elif aI.matchn("Mimicking"):
		return getMimickingCritterMove(_critterTile, _playerTile, _level)
	elif aI.matchn("Deactivated"):
		return false
	elif aI.matchn("Miner"):
		return getMinerCritterMove(_critterTile, _level)
	elif aI.matchn("Neutral"):
		return getNeutralCritterMove(_critterTile, _level)
	else:
		return getNeutralCritterMove(_critterTile, _level)

func getAggressiveCritterMove(_critterTile, _playerTile, _level):
	var _path = _level.calculatePathFindingPath(_critterTile, _playerTile)
	if (_path.size() == 0 or _path.size() >= aggroDistance) and aggroDistance != -1:
		return getNeutralCritterMove(_critterTile, _level)
	return _path

func getMimickingCritterMove(_critterTile, _playerTile, _level):
	if $"../".isMimicked:
		return []
	var _path = _level.calculatePathFindingPath(_critterTile, _playerTile)
	if randi() % 12 == 0 or ((_path.size() == 0 or _path.size() >= aggroDistance) and aggroDistance != -1):
		return getNeutralCritterMove(_critterTile, _level)
	else:
		return _path

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
	elif randi() % 7 > 3:
		return []
	else:
		_chosenPoint = _points[randi() % _points.size()]
	if _chosenPoint.x >= 0 and _chosenPoint.y >= 0 and _chosenPoint.x < Globals.gridSize.x and _chosenPoint.y < Globals.gridSize.y and _level.grid[_chosenPoint.x][_chosenPoint.y].critter == null:
		return _level.calculatePathFindingPath(_critterTile, _chosenPoint)
	else:
		return []

func getMinerCritterMove(_critterTile, _level):
	var _chosenPoint
	var _openPoints = []
	var _minablePoints = []
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
		if (
			(
				_point.y >= 0 and
				_point.y < _level.grid[0].size() and
				_point.x >= 0 and
				_point.x < _level.grid.size()
			) and
			(
				_level.grid[_point.x][_point.y].tile == Globals.tiles.EMPTY or
				_level.grid[_point.x][_point.y].tile == Globals.tiles.WALL_CAVE or
				_level.grid[_point.x][_point.y].tile == Globals.tiles.WALL_CAVE_DEEP
			)
		):
			_minablePoints.append(Vector2(_point))
		elif _level.hasPoint(_point):
			_openPoints.append(Vector2(_point))
	
	if _minablePoints.size() != 0 and randi() % 18 == 0:
		return [_critterTile, _minablePoints[randi() % _minablePoints.size()]]
	elif(randi() % 3 + 1) == 1:
		return []
	else:
		_chosenPoint = _openPoints[randi() % _openPoints.size()]
	if _level.grid[_chosenPoint.x][_chosenPoint.y].critter == null:
		return _level.calculatePathFindingPath(_critterTile, _chosenPoint)
	else:
		return []
