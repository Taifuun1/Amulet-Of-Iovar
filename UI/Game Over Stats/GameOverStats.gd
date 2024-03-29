extends PanelContainer

var RichTextLabelExtended = load("res://UI/RichTextLabel Extended/RichTextLabelExtended.tscn")

var stats
var ascended

func setValues(_title, _stats, _ascended = false):
	$GameOverTabs/Points/GameOverText.text = _title
	
	stats = _stats
	ascended = _ascended
	
	for _itemName in _stats.points.points:
		$"GameOverTabs/Points/PointsContainer/Points".createPointItem(_itemName, _stats.points.points[_itemName])
	
	for _log in _stats.consoleLogs:
		var _logItem = RichTextLabelExtended.instance()
		_logItem.createRichTextLabel(_log)
		$"GameOverTabs/Console log/ConsoleLogContainer/Console Log/Console Log List".add_child(_logItem)
	
	var _inventoryItemsContainersCount = 0
	for _item in _stats.inventoryItems:
		var _inventoryItem = RichTextLabelExtended.instance()
		$"GameOverTabs/Inventory/InventoryContainer/Inventory/Inventory List".add_child(_inventoryItem)
		_inventoryItem.createRichTextLabel(_item, _stats.inventoryItems[_item].item.rarity)
		if _stats.inventoryItems[_item].has("items"):
			for _containerItem in _stats.inventoryItems[_item].items:
				var _containerNode = HBoxContainer.new()
				var _paddingNode = Control.new()
				var _containerItemNode = RichTextLabelExtended.instance()
				
				_containerNode.name = "ContainerContainer%s" % _inventoryItemsContainersCount
				_paddingNode.set_custom_minimum_size(Vector2(36,0))
				
				$"GameOverTabs/Inventory/InventoryContainer/Inventory/Inventory List".add_child(_containerNode)
				get_node("GameOverTabs/Inventory/InventoryContainer/Inventory/Inventory List/ContainerContainer%s" % _inventoryItemsContainersCount).add_child(_paddingNode)
				get_node("GameOverTabs/Inventory/InventoryContainer/Inventory/Inventory List/ContainerContainer%s" % _inventoryItemsContainersCount).add_child(_containerItemNode)
				
				_containerItemNode.createRichTextLabel(_containerItem, _stats.inventoryItems[_item].items[_containerItem].rarity)
				
				_inventoryItemsContainersCount += 1
	
	for _statType in _stats.gameStats:
		match _statType:
			"gameStats":
				for _stat in _stats.gameStats[_statType]:
					$"GameOverTabs/Game stats/GameStatsContainer/Game Stats".createGameStatsItem(_stat, _stats.gameStats[_statType][_stat])
			"critters":
				for _critter in _stats.gameStats[_statType]:
					$"GameOverTabs/Kill count/KillCountContainer/Kill Count".createCritterKillCountItem(_critter, _stats.gameStats[_statType][_critter].killCount)

func saveGameData():
	var _newLifeTimeStats = stats.gameStats.gameStats
	var _lifeTimeStats = GlobalSave.saveAndloadLifeTimeStats("LifeTimeStats")
	
	_lifeTimeStats["Turn count"] += _newLifeTimeStats["Turn count"]
	if _lifeTimeStats["Highest physical damage dealt"] < _newLifeTimeStats["Highest physical damage dealt"]:
		_lifeTimeStats["Highest physical damage dealt"] += _newLifeTimeStats["Highest physical damage dealt"]
	if _lifeTimeStats["Highest physical damage with magic dealt"] < _newLifeTimeStats["Highest physical damage with magic dealt"]:
		_lifeTimeStats["Highest physical damage with magic dealt"] += _newLifeTimeStats["Highest physical damage with magic dealt"]
	_lifeTimeStats["Times attacked in melee"] += _newLifeTimeStats["Times attacked in melee"]
	_lifeTimeStats["Damage dealt in melee"] += _newLifeTimeStats["Damage dealt in melee"]
	if _lifeTimeStats["Highest spell damage dealt"] < _newLifeTimeStats["Highest spell damage dealt"]:
		_lifeTimeStats["Highest spell damage dealt"] += _newLifeTimeStats["Highest spell damage dealt"]
	_lifeTimeStats["Times attacked with spells"] += _newLifeTimeStats["Times attacked with spells"]
	_lifeTimeStats["Damage dealt with spells"] += _newLifeTimeStats["Damage dealt with spells"]
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
	stats.gameNumber = _lifeTimeStats["Game count"]
	
	$"/root/World/Save".saveData("Game{gameCount}".format({ "gameCount": _lifeTimeStats["Game count"] }), "Games", stats)


func _onExitpressed():
	get_tree().quit()
