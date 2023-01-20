extends PanelContainer

var RichTextLabelExtended = load("res://UI/RichTextLabel Extended/RichTextLabel Extended.tscn")

var stats
var ascended

func setValues(_title, _stats, _ascended = false):
	stats = _stats
	ascended = _ascended
	
	for _itemName in _stats.points.points:
		$"GameOverTabs/Points/PointsContainer/Points".createPointItem(_itemName, _stats.points.points[_itemName])
	
	for _log in _stats.consoleLogs:
		var _logItem = RichTextLabelExtended.instance()
		_logItem.createRichTextLabel(_log)
		$"GameOverTabs/Console log/Console Log/Console Log List".add_child(_logItem)
	
	var _inventoryItemsContainersCount = 0
	for _item in _stats.inventoryItems:
		var _inventoryItem = RichTextLabelExtended.instance()
		$"GameOverTabs/Inventory/Inventory/Inventory List".add_child(_inventoryItem)
		_inventoryItem.createRichTextLabel(_item, _stats.inventoryItems[_item].item.rarity)
		if _stats.inventoryItems[_item].has("items"):
			for _containerItem in _stats.inventoryItems[_item].items:
				var _containerNode = HBoxContainer.new()
				var _paddingNode = Control.new()
				var _containerItemNode = RichTextLabelExtended.instance()
				
				_containerNode.name = "ContainerContainer%s" % _inventoryItemsContainersCount
				_paddingNode.set_custom_minimum_size(Vector2(36,0))
				
				$"GameOverTabs/Inventory/Inventory/Inventory List".add_child(_containerNode)
				get_node("GameOverTabs/Inventory/Inventory/Inventory List/ContainerContainer%s" % _inventoryItemsContainersCount).add_child(_paddingNode)
				get_node("GameOverTabs/Inventory/Inventory/Inventory List/ContainerContainer%s" % _inventoryItemsContainersCount).add_child(_containerItemNode)
				
				_containerItemNode.createRichTextLabel(_containerItem, _stats.inventoryItems[_item].items[_containerItem].rarity)
				
				_inventoryItemsContainersCount += 1
	
	for _statType in _stats.gameStats:
		match _statType:
			"gameStats":
				for _stat in _stats.gameStats[_statType]:
					$"GameOverTabs/Game stats/Game Stats".createGameStatsItem(_stat, _stats.gameStats[_statType][_stat])
			"critters":
				for _critter in _stats.gameStats[_statType]:
					$"GameOverTabs/Kill count/Kill Count".createCritterKillCountItem(_critter, _stats.gameStats[_statType][_critter].killCount)


func _onSaveAndExitpressed():
	var _newLifeTimeStats = stats.gameStats.gameStats
	var _lifeTimeStats = GlobalSave.saveAndloadLifeTimeStats("LifeTimeStats")
	
	_lifeTimeStats["Turn count"] += _newLifeTimeStats["Turn count"]
	_lifeTimeStats["Times attacked"] += _newLifeTimeStats["Times attacked"]
	_lifeTimeStats["Damage dealt"] += _newLifeTimeStats["Damage dealt"]
	if _lifeTimeStats["Highest damage dealt"] < _newLifeTimeStats["Highest damage dealt"]:
		_lifeTimeStats["Highest damage dealt"] = _newLifeTimeStats["Highest damage dealt"]
	_lifeTimeStats["Damage taken"] += _newLifeTimeStats["Damage taken"]
	if _lifeTimeStats["Highest damage taken"] < _newLifeTimeStats["Highest damage taken"]:
		_lifeTimeStats["Highest damage taken"] = _newLifeTimeStats["Highest damage taken"]
	_lifeTimeStats["Items wished"] += _newLifeTimeStats["Items wished"]
	_lifeTimeStats["Species genocided"] += _newLifeTimeStats["Species genocided"]
	_lifeTimeStats["Times ascended"] += _newLifeTimeStats["Times ascended"]
	_lifeTimeStats["Game count"] += 1
	
	GlobalSave.saveAndloadLifeTimeStats("LifeTimeStats", _lifeTimeStats)
	
	var saveData = $"/root/World/Save".loadData("SaveData", "SaveSlot{selectedSave}".format({ "selectedSave": StartingData.selectedSave }))
	if saveData.hasSave:
		$"/root/World/Save".deleteData(StartingData.selectedSave)
	
	stats.ascended = ascended
	
	$"/root/World/Save".saveData("Game{gameCount}".format({ "gameCount": _lifeTimeStats["Game count"] }), "Games", stats)
	
	get_tree().quit()
