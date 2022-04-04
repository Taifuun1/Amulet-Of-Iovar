extends Node

var aI = "Aggressive"

func getCritterMove(_critterTile, _playerTile, _level):
	if aI == "Aggressive":
		return _level.calculatePathFindingPath(_critterTile, _playerTile)
