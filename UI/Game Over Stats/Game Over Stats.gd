extends PanelContainer

var RichTextLabelExtended = load("res://UI/RichTextLabel Extended/RichTextLabel Extended.tscn")

func setValues(_title, _stats):
	for _itemName in _stats.points.points:
		$"GameOverTabs/Points".createPointItem(_itemName, _stats.points.points[_itemName])
	
	for _log in _stats.consoleLogs.values():
		var _logItem = RichTextLabelExtended.instance()
		_logItem.createRichTextLabel(_log)
		$"GameOverTabs/Console Log/Console Log List".add_child(_logItem)
	
	var _inventoryItemsContainersCount = 0
	for _item in _stats.inventoryItems:
		var _inventoryItem = RichTextLabelExtended.instance()
		$"GameOverTabs/Inventory/Inventory List".add_child(_inventoryItem)
		_inventoryItem.createRichTextLabel(_item, _stats.inventoryItems[_item].item.rarity)
		if _stats.inventoryItems[_item].has("items"):
			for _containerItem in _stats.inventoryItems[_item].items:
				var _containerNode = HBoxContainer.new()
				var _paddingNode = Control.new()
				var _containerItemNode = RichTextLabelExtended.instance()
				
				_containerNode.name = "ContainerContainer%s" % _inventoryItemsContainersCount
				_paddingNode.set_custom_minimum_size(Vector2(36,0))
				
				$"GameOverTabs/Inventory/Inventory List".add_child(_containerNode)
				get_node("GameOverTabs/Inventory/Inventory List/ContainerContainer%s" % _inventoryItemsContainersCount).add_child(_paddingNode)
				get_node("GameOverTabs/Inventory/Inventory List/ContainerContainer%s" % _inventoryItemsContainersCount).add_child(_containerItemNode)
				
				_containerItemNode.createRichTextLabel(_containerItem, _stats.inventoryItems[_item].items[_containerItem].rarity)
				
				_inventoryItemsContainersCount += 1
	
	for _statType in _stats.gameStats:
		match _statType:
			"gameStats":
				for _stat in _stats.gameStats[_statType]:
					$"GameOverTabs/Game Stats".createGameStatsItem(_stat, _stats.gameStats[_statType][_stat])
			"critters":
				for _critter in _stats.gameStats[_statType]:
					$"GameOverTabs/Kill Count".createCritterKillCountItem(_critter, _stats.gameStats[_statType][_critter].killCount)