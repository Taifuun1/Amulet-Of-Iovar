extends Player

var sacrificeGifts = load("res://Objects/Data/SacrificeGiftsData.gd").new()

func readItem(_id):
	var _readItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _readItem.type.matchn("scroll"):
		Globals.gameConsole.addLog("You read a {itemName}.".format({ "itemName": _readItem.itemName }))
		match _readItem.identifiedItemName.to_lower():
			"blank scroll":
				Globals.gameConsole.addLog("Its a blank scroll. Wow.")
				Globals.isItemIdentified(_readItem)
			"official mail":
				Globals.gameConsole.addLog("Its a grocery list of milk and eggs. Riveting.")
				Globals.gameConsole.addLog("The mail disappears!")
				Globals.isItemIdentified(_readItem)
			"scroll of identify":
				var _items = $"/root/World/Critters/0/Inventory".inventory.duplicate(true)
				if _items.empty():
					Globals.gameConsole.addLog("Nothing happens...")
				else:
					var _identifiableItemsInInventory = false
					if !_readItem.piety.matchn("blasphemous"):
						if _readItem.piety.matchn("reverent"):
							for _item in _items:
								var _itemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									(
										GlobalItemInfo.globalItemInfo.has(_itemInInventory.identifiedItemName) and
										GlobalItemInfo.globalItemInfo[_itemInInventory.identifiedItemName].identified == false
									) or
									_itemInInventory.notIdentified.name == false or
									_itemInInventory.notIdentified.piety == false or
									_itemInInventory.notIdentified.enchantment == false
								):
									_identifiableItemsInInventory = true
									_itemInInventory.identifyItem(true, true, true)
									Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _itemInInventory.identifiedItemName, "unidentifiedItemName": _itemInInventory.unidentifiedItemName }))
									Globals.isItemIdentified(_readItem)
						else:
							while true:
								if _items.empty():
									break
								var _item = _items[randi() % _items.size()]
								var _randomItemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									(
										GlobalItemInfo.globalItemInfo.has(_randomItemInInventory.identifiedItemName) and
										GlobalItemInfo.globalItemInfo[_randomItemInInventory.identifiedItemName].identified == false
									) or
									_randomItemInInventory.notIdentified.name == false or
									_randomItemInInventory.notIdentified.piety == false or
									_randomItemInInventory.notIdentified.enchantment == false
								):
									_randomItemInInventory.identifyItem(true, true, true)
									_identifiableItemsInInventory = true
									Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _randomItemInInventory.identifiedItemName, "unidentifiedItemName": _randomItemInInventory.unidentifiedItemName }))
									Globals.isItemIdentified(_readItem)
									break
								_items.erase(_item)
					if !_identifiableItemsInInventory:
						_items = $"/root/World/Critters/0/Inventory".inventory.duplicate(true)
						if _readItem.piety.matchn("reverent"):
							for _item in _items:
								var _itemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									_itemInInventory.notIdentified.piety == false or
									_itemInInventory.notIdentified.enchantment == false
								):
									_itemInInventory.identifyItem(true, true, true)
									Globals.gameConsole.addLog("You know more about {itemName}.".format({ "itemName": _itemInInventory.itemName }))
									Globals.isItemIdentified(_readItem)
						else:
							while true:
								if _items.empty():
									Globals.gameConsole.addLog("Nothing happens...")
									break
								var _item = _items[randi() % _items.size()]
								var _randomItemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									_randomItemInInventory.notIdentified.piety == false or
									_randomItemInInventory.notIdentified.enchantment == false
								):
									_randomItemInInventory.identifyItem(false, true, true)
									Globals.gameConsole.addLog("You know more about {itemName}.".format({ "itemName": _randomItemInInventory.itemName }))
									Globals.isItemIdentified(_readItem)
									break
								_items.erase(_item)
			"scroll of confusion":
				if statusEffects.confusion != -1:
					if _readItem.piety.matchn("reverent"):
						statusEffects.confusion += 4
						Globals.gameConsole.addLog("You feel slightly disoriented.")
					elif _readItem.piety.matchn("formal"):
						statusEffects.confusion += 10
						Globals.gameConsole.addLog("You feel confused.")
					elif _readItem.piety.matchn("blasphemous"):
						statusEffects.confusion += 22
						Globals.gameConsole.addLog("The world spins!")
				else:
					Globals.gameConsole.addLog("You already feel confused enough!")
				Globals.isItemIdentified(_readItem)
			"scroll of teleport":
				if dealWithTeleport(0, _readItem.piety):
					Globals.gameConsole.addLog("Whoosh! You reappear somewhere!")
					if _readItem.piety.matchn("blasphemous"):
						Globals.gameConsole.addLog("It looks pretty different here...")
					Globals.isItemIdentified(_readItem)
				else:
					Globals.gameConsole.addLog("Nothing happens...")
			"scroll of remove curse":
				var _equipmentNode = $"/root/World/UI/UITheme/Equipment"
				var _uncursableItems = []
				for _itemId in _equipmentNode.hands.values():
					if _itemId != null:
						var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
						if _item != null and _item.binds != null:
							_uncursableItems.append(_item)
				if (
					(!_uncursableItems.empty() and _readItem.piety.matchn("reverent")) or
					_uncursableItems.empty()
				):
					for _itemId in _equipmentNode.accessories.values():
						if _itemId != null:
							var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
							if _item.binds != null:
								_uncursableItems.append(_item)
				if (
					(!_uncursableItems.empty() and _readItem.piety.matchn("reverent")) or
					_uncursableItems.empty()
				):
					for _itemId in _equipmentNode.equipment.values():
						if _itemId != null:
							var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
							if _item.binds != null:
								_uncursableItems.append(_item)
				if (
					(!_uncursableItems.empty() and _readItem.piety.matchn("reverent")) or
					_uncursableItems.empty()
				):
					for _itemId in $Inventory.inventory:
						if _itemId != null:
							var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
							if _item.binds != null:
								_uncursableItems.append(_item)
				if !_uncursableItems.empty():
					for _item in _uncursableItems:
						if _readItem.piety.matchn("blasphemous"):
							_item.binds.state = "Bound"
							Globals.gameConsole.addLog("The {itemName} glows with a violet light.".format({ "itemName": _item.itemName }))
							continue
						_item.binds.state = "Unbound"
						Globals.gameConsole.addLog("The {itemName} glows with a light yellow light.".format({ "itemName": _item.itemName }))
					Globals.isItemIdentified(_readItem)
				else:
					Globals.gameConsole.addLog("Nothing happens...")
			"scroll of enchant weapon":
				var _equipmentNode = $"/root/World/UI/UITheme/Equipment"
				var _areHandsEmpty = true
				for _itemId in _equipmentNode.hands:
					if _itemId != null:
						_areHandsEmpty = false
				if !_areHandsEmpty:
					if _readItem.piety.matchn("reverent"):
						for _itemId in _equipmentNode.hands.values():
							if _itemId != null:
								var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
								if _item.enchantment < 3:
									_item.enchantment += 1
									Globals.gameConsole.addLog("The {itemName} glows with a light green light.".format({ "itemName": _item.itemName }))
								else:
									Globals.gameConsole.addLog("The {itemName} vibrates slightly.".format({ "itemName": _item.itemName }))
					elif _readItem.piety.matchn("formal"):
						for _itemId in _equipmentNode.hands.values():
							if _itemId != null:
								var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
								if _item.enchantment < 3:
									_item.enchantment += 1
									Globals.gameConsole.addLog("The {itemName} glows with a light green light.".format({ "itemName": _item.itemName }))
								else:
									Globals.gameConsole.addLog("The {itemName} vibrates slightly.".format({ "itemName": _item.itemName }))
								break
					elif _readItem.piety.matchn("blasphemous"):
						for _itemId in _equipmentNode.hands.values():
							if _itemId != null:
								var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
								if _item.enchantment > -3:
									_item.enchantment -= 1
									Globals.gameConsole.addLog("The {itemName} glows with a cyan light.".format({ "itemName": _item.itemName }))
								else:
									Globals.gameConsole.addLog("The {itemName} vibrates slightly.".format({ "itemName": _item.itemName }))
					Globals.isItemIdentified(_readItem)
				else:
					Globals.gameConsole.addLog("Nothing happens...")
			"scroll of enchant armor":
				var _equipmentNode = $"/root/World/UI/UITheme/Equipment"
				var _areEquipmentEmpty = true
				for _itemId in _equipmentNode.equipment:
					if _itemId != null:
						_areEquipmentEmpty = false
				if !_areEquipmentEmpty:
					if _readItem.piety.matchn("reverent"):
						var _enchantCount = 0
						for _itemId in _equipmentNode.equipment.values():
							if _itemId != null:
								var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
								if _item.enchantment < 3:
									_item.enchantment += 1
									Globals.gameConsole.addLog("The {itemName} glows with a light green light.".format({ "itemName": _item.itemName }))
								else:
									Globals.gameConsole.addLog("The {itemName} vibrates slightly.".format({ "itemName": _item.itemName }))
								_enchantCount += 1
								if _enchantCount == 2:
									break
					elif _readItem.piety.matchn("formal"):
						for _itemId in _equipmentNode.equipment.values():
							if _itemId != null:
								var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
								if _item.enchantment < 3:
									_item.enchantment += 1
									Globals.gameConsole.addLog("The {itemName} glows with a light green light.".format({ "itemName": _item.itemName }))
								else:
									Globals.gameConsole.addLog("The {itemName} vibrates slightly.".format({ "itemName": _item.itemName }))
								break
					elif _readItem.piety.matchn("blasphemous"):
						for _itemId in _equipmentNode.equipment.values():
							if _itemId != null:
								var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
								if _item.enchantment > -3:
									_item.enchantment -= 1
									Globals.gameConsole.addLog("The {itemName} glows with a cyan light.".format({ "itemName": _item.itemName }))
								else:
									Globals.gameConsole.addLog("The {itemName} vibrates slightly.".format({ "itemName": _item.itemName }))
					Globals.isItemIdentified(_readItem)
				else:
					Globals.gameConsole.addLog("Nothing happens...")
			"scroll of destroy armor":
				var _equipmentNode = $"/root/World/UI/UITheme/Equipment"
				var _areEquipmentEmpty = true
				for _itemId in _equipmentNode.equipment:
					if _itemId != null:
						_areEquipmentEmpty = false
				if !_areEquipmentEmpty:
					if _readItem.piety.matchn("reverent"):
						for _itemId in _equipmentNode.equipment.values():
							if _itemId != null:
								var _item = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId }))
								if _item.enchantment > -5:
									_item.enchantment -= 1
									Globals.gameConsole.addLog("The {itemName} glows with a cyan light.".format({ "itemName": _item.itemName }))
								else:
									Globals.gameConsole.addLog("The {itemName} vibrates slightly.".format({ "itemName": _item.itemName }))
								break
					else:
						for _itemId in _equipmentNode.equipment.values():
							if _itemId != null:
								$"/root/World/Items/Items".removeItem(_itemId)
								Globals.gameConsole.addLog("The {itemName} turns to dust!".format({ "itemName": get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).itemName }))
								break
					Globals.isItemIdentified(_readItem)
				else:
					Globals.gameConsole.addLog("Nothing happens...")
			"scroll of summon critter":
				var _playerPosition = $"/root/World".level.getCritterTile(0)
				if _readItem.piety.matchn("reverent"):
					var _neutralClass = neutralClasses[randi() % neutralClasses.size()]
					var _critter = $"/root/World/Critters/Critters".critters[_neutralClass][randi() % $"/root/World/Critters/Critters".critters[_neutralClass].size()]
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
					if !_tiles.empty():
						for _tile in _tiles:
							Globals.gameConsole.addLog("A {critterName} appears beside you. It seems friendly.".format({ "critterName": $"/root/World/Critters/Critters".spawnCritter(_critter, _tile) }))
						Globals.isItemIdentified(_readItem)
					else:
						Globals.gameConsole.addLog("Nothing happens...")
				elif _readItem.piety.matchn("formal"):
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
					if !_tiles.empty():
						for _tile in _tiles:
							Globals.gameConsole.addLog("A {critterName} appears beside you!".format({ "critterName": $"/root/World/Critters/Critters".spawnRandomCritter(_tile) }))
						Globals.isItemIdentified(_readItem)
					else:
						Globals.gameConsole.addLog("Nothing happens...")
				elif _readItem.piety.matchn("blasphemous"):
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, false, true)
					if !_tiles.empty():
						for _tile in _tiles:
							$"/root/World/Critters/Critters".spawnRandomCritter(_tile)
						Globals.gameConsole.addLog("A bucketload of critters appear around you!")
						Globals.isItemIdentified(_readItem)
					else:
						Globals.gameConsole.addLog("Nothing happens...")
			"scroll of create food":
				var _playerPosition = $"/root/World".level.getCritterTile(0)
				if _readItem.piety.matchn("reverent"):
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition)
					if !_tiles.empty():
						for _tile in _tiles:
							var newItem = load("res://Objects/Item/Item.tscn").instance()
							var _rarity = $"/root/World/Items/Items".items["comestible"].keys()[randi() % $"/root/World/Items/Items".items["comestible"].keys().size()]
							var _item = $"/root/World/Items/Items".items["comestible"][_rarity][randi() % $"/root/World/Items/Items".items["comestible"][_rarity].size()]
							newItem.createItem(_item)
							$"/root/World/Items".add_child(newItem, true)
							$"/root/World".level.grid[_tile.x][_tile.y].items.append(newItem.id)
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["comestible"].keys()[randi() % $"/root/World/Items/Items".items["comestible"].keys().size()]
					var _item = $"/root/World/Items/Items".items["comestible"][_rarity][randi() % $"/root/World/Items/Items".items["comestible"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("A bucketload of items appears around you!")
				elif _readItem.piety.matchn("formal"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["comestible"].keys()[randi() % $"/root/World/Items/Items".items["comestible"].keys().size()]
					var _item = $"/root/World/Items/Items".items["comestible"][_rarity][randi() % $"/root/World/Items/Items".items["comestible"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("{itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.piety.matchn("blasphemous"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					newItem.createItem($"/root/World/Items/Items".getItemByName("cherries"))
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("{itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				Globals.isItemIdentified(_readItem)
			"scroll of create potion":
				var _playerPosition = $"/root/World".level.getCritterTile(0)
				if _readItem.piety.matchn("reverent"):
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition)
					if !_tiles.empty():
						for _tile in _tiles:
							var newItem = load("res://Objects/Item/Item.tscn").instance()
							var _rarity = $"/root/World/Items/Items".items["potion"].keys()[randi() % $"/root/World/Items/Items".items["potion"].keys().size()]
							var _item = $"/root/World/Items/Items".items["potion"][_rarity][randi() % $"/root/World/Items/Items".items["potion"][_rarity].size()]
							newItem.createItem(_item)
							$"/root/World/Items".add_child(newItem, true)
							$"/root/World".level.grid[_tile.x][_tile.y].items.append(newItem.id)
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["potion"].keys()[randi() % $"/root/World/Items/Items".items["potion"].keys().size()]
					var _item = $"/root/World/Items/Items".items["potion"][_rarity][randi() % $"/root/World/Items/Items".items["potion"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("A bucketload of items appears around you!")
				elif _readItem.piety.matchn("formal"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["potion"].keys()[randi() % $"/root/World/Items/Items".items["potion"].keys().size()]
					var _item = $"/root/World/Items/Items".items["potion"][_rarity][randi() % $"/root/World/Items/Items".items["potion"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("{itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.piety.matchn("blasphemous"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					newItem.createItem($"/root/World/Items/Items".getItemByName("potion of toxix"))
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("{itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				Globals.isItemIdentified(_readItem)
			"tome of knowledge":
				var _allItems = GlobalSave.saveAndloadLifeTimeStats("Items")
				var _allCritters = GlobalSave.saveAndloadLifeTimeStats("Critters")
				var _items = []
				var _critters = []
				for _item in _allItems:
					if !_allItems[_item].knowledge:
						_items.append(_item)
				for _critter in _allCritters:
					if !_allCritters[_critter].knowledge:
						_critters.append(_critter)
				if (_items.size() != 0 and randi() % 2 == 0) or (_items.size() != 0 and _critters.size() == 0):
					var _newKnowledge = _items[randi() % _items.size()]
					for _item in _allItems:
						if _newKnowledge.matchn(_item):
							_allItems[_item].knowledge = true
					GlobalSave.saveAndloadLifeTimeStats("Items", _allItems)
					Globals.gameConsole.addLog("You gain knowledge of {itemName}.".format({ "itemName": _newKnowledge }))
				elif _critters.size() != 0:
					var _newKnowledge = _critters[randi() % _critters.size()]
					for _critter in _allCritters:
						if _newKnowledge.matchn(_critter):
							_allCritters[_critter].knowledge = true
					GlobalSave.saveAndloadLifeTimeStats("Critters", _allCritters)
					Globals.gameConsole.addLog("You gain knowledge of {critterName}.".format({ "critterName": _newKnowledge }))
				else:
					Globals.gameConsole.addLog("You're already very knowledgeable. Wow!")
			"scroll of reverent scripture":
				var _playerPosition = $"/root/World".level.getCritterTile(0)
				if $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items != null and $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.size() != 0:
					if _readItem.piety.matchn("reverent"):
						var _alignedItem = get_node("/root/World/Items/{id}".format({ "id": $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items[randi() % $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.size()] }))
						_alignedItem.piety = "Reverent"
						Globals.gameConsole.addLog("{itemName} glows white.".format({ "itemName": _alignedItem.itemName }))
					elif _readItem.piety.matchn("formal"):
						var _alignedItem = get_node("/root/World/Items/{id}".format({ "id": $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items[randi() % $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.size()] }))
						_alignedItem.piety = "Reverent"
						Globals.gameConsole.addLog("{itemName} glows white.".format({ "itemName": _alignedItem.itemName }))
					elif _readItem.piety.matchn("blasphemous"):
						var _alignedItem = get_node("/root/World/Items/{id}".format({ "id": $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items[randi() % $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.size()] }))
						_alignedItem.piety = "Blasphemous"
						Globals.gameConsole.addLog("{itemName} glows black.".format({ "itemName": _alignedItem.itemName }))
			"scroll of blasphemous scripture":
				var _playerPosition = $"/root/World".level.getCritterTile(0)
				if $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items != null and $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.size() != 0:
					if _readItem.piety.matchn("reverent"):
						var _alignedItem = get_node("/root/World/Items/{id}".format({ "id": $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items[randi() % $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.size()] }))
						_alignedItem.piety = "Blasphemous"
						Globals.gameConsole.addLog("{itemName} glows black.".format({ "itemName": _alignedItem.itemName }))
					elif _readItem.piety.matchn("formal"):
						var _alignedItem = get_node("/root/World/Items/{id}".format({ "id": $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items[randi() % $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.size()] }))
						_alignedItem.piety = "Blasphemous"
						Globals.gameConsole.addLog("{itemName} glows black.".format({ "itemName": _alignedItem.itemName }))
					elif _readItem.piety.matchn("blasphemous"):
						var _alignedItem = get_node("/root/World/Items/{id}".format({ "id": $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items[randi() % $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.size()] }))
						_alignedItem.piety = "Reverent"
						Globals.gameConsole.addLog("{itemName} glows white.".format({ "itemName": _alignedItem.itemName }))
			"scroll of genocide":
				var _aliveCritters = []
				if _readItem.piety.matchn("reverent"):
					for _critterRace in $"/root/World/Critters/Critters".critters.keys():
						if !_critterRace.matchn("bosses"):
							for _critterName in $"/root/World/Critters/Critters".critters[_critterRace]:
								if GlobalCritterInfo.globalCritterInfo[_critterName.critterName].population != 0:
									_aliveCritters.append(_critterRace)
									break
				elif _readItem.piety.matchn("formal") or _readItem.piety.matchn("blasphemous"):
					for _critterName in GlobalCritterInfo.globalCritterInfo.keys():
						if (
							GlobalCritterInfo.globalCritterInfo[_critterName].population != 0 and
							!(
								_critterName.matchn("Iovar") or
								_critterName.matchn("Elder Dragon") or
								_critterName.matchn("Mad Banana-hunter Ogre") or
								_critterName.matchn("Shin'kor Leve'er") or
								_critterName.matchn("Elhybar") or
								_critterName.matchn("Tidoh Tel'hydrad")
							)
						):
							_aliveCritters.append(_critterName)
				$"/root/World".closeMenu()
				$"/root/World/UI/UITheme/ListMenu".showListMenuList("Genocide what?", _aliveCritters, _readItem)
				_additionalChoices = true
				Globals.isItemIdentified(_readItem)
			_:
				Globals.gameConsole.addLog("Thats not a scroll...")
		checkAllIdentification(true)
		$"/root/World".hideObjectsWhenDrawingNextFrame = true
		if !_readItem.identifiedItemName.to_lower().matchn("blank scroll"):
			if _readItem.amount > 1:
				_readItem.amount -= 1
			else:
				$"/root/World/Items/Items".removeItem(_id)
	$"/root/World".closeMenu(_additionalChoices)

func quaffItem(_id):
	var _quaffedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	if _quaffedItem.type.matchn("potion"):
		Globals.gameConsole.addLog("You quaff a {itemName}.".format({ "itemName": _quaffedItem.itemName }))
		match _quaffedItem.identifiedItemName.to_lower():
			"water potion":
				if _quaffedItem.piety.matchn("reverent"):
					Globals.gameConsole.addLog("This tastes fantastic!")
				if _quaffedItem.piety.matchn("formal"):
					Globals.gameConsole.addLog("This tastes like water.")
				if _quaffedItem.piety.matchn("blasphemous"):
					Globals.gameConsole.addLog("This doesn't taste very good. Ughhhh...")
			"soda bottle":
				if _quaffedItem.piety.matchn("reverent"):
					calories += 100
					Globals.gameConsole.addLog("Its orange juice! Damn thats good!")
				if _quaffedItem.piety.matchn("formal"):
					calories += 80
					Globals.gameConsole.addLog("Its apple juice. Tastes nice!")
				if _quaffedItem.piety.matchn("blasphemous"):
					calories += 50
					Globals.gameConsole.addLog("Its radish juice. Uggghh...")
			"potion of heal":
				var _amountToHeal = 0
				if _quaffedItem.piety.matchn("reverent"):
					_amountToHeal = 6 + (level * 4)
					Globals.gameConsole.addLog("The {potion} heals you. That felt good!".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.piety.matchn("formal"):
					_amountToHeal = 4 + (level * 3)
					Globals.gameConsole.addLog("The {potion} heals you.".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.piety.matchn("blasphemous"):
					_amountToHeal = 2 + (level * 2)
					Globals.gameConsole.addLog("The {potion} heals you. That felt a little off.".format({ "potion": _quaffedItem.itemName }))
				if hp + _amountToHeal >= maxhp:
					if _quaffedItem.piety.matchn("reverent"):
						maxhp = maxhp + 1
						Globals.gameConsole.addLog("You feel a little more vigorous.")
					hp = maxhp
				else:
					hp += _amountToHeal
			"potion of confusion":
				if statusEffects.confusion != -1:
					if _quaffedItem.piety.matchn("reverent"):
						statusEffects.confusion = 4
						Globals.gameConsole.addLog("You feel slightly disoriented.")
					elif _quaffedItem.piety.matchn("formal"):
						statusEffects.confusion += 10
						Globals.gameConsole.addLog("You feel confused.")
					elif _quaffedItem.piety.matchn("blasphemous"):
						statusEffects.confusion += 22
						Globals.gameConsole.addLog("The world spins!")
				else:
					Globals.gameConsole.addLog("You already feel confused enough!")
			"potion of toxix":
				if _quaffedItem.piety.matchn("reverent"):
					statusEffects.toxix = 2
					Globals.gameConsole.addLog("The {potion} tastes slightly acidic. Bleagh!".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.piety.matchn("formal"):
					statusEffects.toxix = 8
					hp -= 4
					Globals.gameConsole.addLog("The {potion} tastes bitter. Urgh!".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.piety.matchn("blasphemous"):
					statusEffects.toxix = 16
					hp -= 8
					Globals.gameConsole.addLog("The {potion} burns your mouth. Uhhhh...".format({ "potion": _quaffedItem.itemName }))
					maxhp -= 1
					hp -= 1
					Globals.gameConsole.addLog("You feel a little less sturdy.")
			"potion of healaga":
				var _amountToHeal = 0
				if _quaffedItem.piety.matchn("reverent"):
					_amountToHeal = 14 + (level * 8)
					Globals.gameConsole.addLog("The {potion} heals you alot. That felt good!".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.piety.matchn("formal"):
					_amountToHeal = 9 + (level * 6)
					Globals.gameConsole.addLog("The {potion} heals you alot.".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.piety.matchn("blasphemous"):
					_amountToHeal = 4 + (level * 4)
					Globals.gameConsole.addLog("The {potion} heals you alot. That felt a little off.".format({ "potion": _quaffedItem.itemName }))
				if hp + _amountToHeal >= maxhp:
					if _quaffedItem.piety.matchn("reverent"):
						maxhp = maxhp + 2
						Globals.gameConsole.addLog("You feel a little more vigorous.")
					hp = maxhp
				else:
					hp += _amountToHeal
			"potion of sleep":
				if _quaffedItem.piety.matchn("reverent"):
					statusEffects.sleep = 3
					Globals.gameConsole.addLog("The {potion} gives you sweet dreams.".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.piety.matchn("formal"):
					statusEffects.sleep = 7
					Globals.gameConsole.addLog("The {potion} puts you asleep.".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.piety.matchn("blasphemous"):
					statusEffects.sleep = 13
					Globals.gameConsole.addLog("The {potion} knocks you out.".format({ "potion": _quaffedItem.itemName }))
			"potion of hunger":
				if _quaffedItem.piety.matchn("reverent"):
					calories += 300
					Globals.gameConsole.addLog("You feel nourished.")
				if _quaffedItem.piety.matchn("formal"):
					calories += -450
					Globals.gameConsole.addLog("You feel malnourished.")
				if _quaffedItem.piety.matchn("blasphemous"):
					calories += -1000
					Globals.gameConsole.addLog("You feel like you lost half your weight!")
			"potion of blindness":
				if !checkIfStatusEffectIsPermanent("blindness"):
					if _quaffedItem.piety.matchn("reverent"):
						statusEffects.blindness = 4
						Globals.gameConsole.addLog("You can't see!")
					elif _quaffedItem.piety.matchn("formal"):
						statusEffects.blindness = 8
						Globals.gameConsole.addLog("You're blind!")
					elif _quaffedItem.piety.matchn("blasphemous"):
						statusEffects.blindness = 27
						Globals.gameConsole.addLog("It's all dark!")
				else:
					Globals.gameConsole.addLog("You already feel blind enough!")
			"potion of paralysis":
				if _quaffedItem.piety.matchn("reverent"):
					statusEffects.stun = 2
					Globals.gameConsole.addLog("You feel a jolt go down your spine!")
				elif _quaffedItem.piety.matchn("formal"):
					statusEffects.stun = 4
					Globals.gameConsole.addLog("You're stunned!")
				elif _quaffedItem.piety.matchn("blasphemous"):
					statusEffects.stun = 8
					Globals.gameConsole.addLog("You're completely stunned!")
			"potion of gain level":
				if _quaffedItem.piety.matchn("reverent"):
					addExp(experienceNeededForLevelGainAmount)
					Globals.gameConsole.addLog("You gain a level! You feel like you gained extra experience.")
				if _quaffedItem.piety.matchn("formal"):
					addExp(experienceNeededForLevelGainAmount - experiencePoints)
					Globals.gameConsole.addLog("You gain a level!")
				if _quaffedItem.piety.matchn("blasphemous"):
					addExp(experienceNeededForPreviousLevelGainAmount - experiencePoints)
					Globals.gameConsole.addLog("You feel a little more stupid.")
			_:
				Globals.gameConsole.addLog("Thats not a potion...")
		Globals.isItemIdentified(_quaffedItem)
		checkAllIdentification(true)
		if _quaffedItem.amount > 1:
			_quaffedItem.amount -= 1
		else:
			$"/root/World/Items/Items".removeItem(_id)
	$"/root/World".closeMenu()

func consumeItem(_id):
	var _eatenItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	if _eatenItem.type.matchn("comestible"):
		if calories > 4250:
			calories += _eatenItem.value / 3
		else:
			if critterClass.matchn("herbalogue"):
				calories += _eatenItem.value + _eatenItem.value / 3
			else:
				calories += _eatenItem.value
		checkAllIdentification(true)
		if _eatenItem.amount > 1:
			_eatenItem.amount -= 1
		else:
			$"/root/World/Items/Items".removeItem(_id)
		match _eatenItem.itemName.to_lower():
			"apple", "egg", "orange":
				Globals.gameConsole.addLog("You eat an {comestible}.".format({ "comestible": _eatenItem.itemName.to_lower() }))
			"brownie", "carrot", "tomato", "chocolate bar", "cookie":
				Globals.gameConsole.addLog("You eat a {comestible}.".format({ "comestible": _eatenItem.itemName.to_lower() }))
			"potatoes", "cherries":
				Globals.gameConsole.addLog("You eat the {comestible}.".format({ "comestible": _eatenItem.itemName.to_lower() }))
			"rfg ration":
				Globals.gameConsole.addLog("You eat the {comestible}.".format({ "comestible": _eatenItem.itemName }))
			"cc ration":
				Globals.gameConsole.addLog("You eat the chocolate cookie ration.")
			"bean can":
				Globals.gameConsole.addLog("You open up the {comestible} and eat the beans.".format({ "comestible": _eatenItem.itemName.to_lower() }))
			"spam":
				Globals.gameConsole.addLog("You open up the {comestible} can and eat the {comestible}.".format({ "comestible": _eatenItem.itemName }))
		match _eatenItem.itemName.to_lower():
			"brownie":
				Globals.gameConsole.addLog("Wow, that's delicious!")
			"cookie":
				Globals.gameConsole.addLog("Just like grandma used to make.")
		if calories > 4250:
			Globals.gameConsole.addLog("You feel full.")
	$"/root/World".closeMenu()

func zapItem(_direction):
	var _grid = $"/root/World".level.grid
	var _playerPosition = $"/root/World".level.getCritterTile(0)
	var _projectile = load("res://Objects/Projectile/Projectile.tscn").instance()
	var spellData = load("res://Objects/Data/SpellData.gd").new().spellData
	var _tiles = []
	var _projectileData = { "texture": load("res://Assets/Spells/Bolt.png"), "color": "#FFFFFF" }
	var _checkIfCritterHit = false
	var _zappedItem = get_node("/root/World/Items/{id}".format({ "id": selectedItem }))
	selectedItem = null
	var _additionalChoices = false
	if _zappedItem.type.matchn("wand"):
		Globals.gameConsole.addLog("You zap the {itemName}.".format({ "itemName": _zappedItem.itemName }))
		if _zappedItem.value.charges > 0:
			match _zappedItem.identifiedItemName.to_lower():
				"wand of light":
					if _zappedItem.piety.matchn("reverent"):
						playerVisibility = {
							"distance": 10,
							"duration": 80
						}
						Globals.gameConsole.addLog("The light illuminates your surroundings brightly!")
					elif _zappedItem.piety.matchn("formal"):
						playerVisibility = {
							"distance": 7,
							"duration": 35
						}
						Globals.gameConsole.addLog("The light illuminates your surroundings.")
					elif _zappedItem.piety.matchn("blasphemous"):
						playerVisibility = {
							"distance": 4,
							"duration": 10
						}
						Globals.gameConsole.addLog("The light illuminates your surroundings dimly.")
					$"/root/World".drawLevel()
					Globals.isItemIdentified(_zappedItem)
					$"/root/World".closeMenu(_additionalChoices)
					$"/root/World".processGameTurn()
					return
				"wand of turn lock":
					for i in range(1, _zappedItem.value.distance):
						var _tile = _playerPosition + _direction * i
						if !Globals.isTileFree(_tile, _grid) or _grid[_tile.x][_tile.y].tile == Globals.tiles.DOOR_CLOSED:
							if _zappedItem.piety.matchn("reverent") or _zappedItem.piety.matchn("formal"):
								if _grid[_tile.x][_tile.y].interactable == null:
									_grid[_tile.x][_tile.y].interactable = Globals.interactables.LOCKED
								else:
									_grid[_tile.x][_tile.y].interactable = null
								Globals.gameConsole.addLog("The doors lock turns!")
							elif _zappedItem.piety.matchn("blasphemous"):
								if randi() % 4 == 0:
									if _grid[_tile.x][_tile.y].interactable == null:
										_grid[_tile.x][_tile.y].interactable = Globals.interactables.LOCKED
									else:
										_grid[_tile.x][_tile.y].interactable = null
									Globals.gameConsole.addLog("The doors lock turns!")
								else:
									Globals.gameConsole.addLog("Doors lock doesn't move...")
							Globals.isItemIdentified(_zappedItem)
							break
						_tiles.append([{ "tile": _tile, "angle": spellData.spellDirections[_direction].angle }])
				"wand of digging":
					var _level = $"/root/World".level
					var _isTileMined = false
					for i in range(1, _zappedItem.value.distance[_zappedItem.piety.to_lower()]):
						var _tile = _playerPosition + _direction * i
						if _level.grid[_tile.x][_tile.y].tile == Globals.tiles.EMPTY or _level.grid[_tile.x][_tile.y].tile == Globals.tiles.WALL_CAVE:
							_level.grid[_tile.x][_tile.y].tile = Globals.tiles.FLOOR_CAVE
							_level.addPointToEnemyPathding(_tile)
							_level.addPointToPathPathding(_tile)
							_isTileMined = true
						if _level.grid[_tile.x][_tile.y].tile == Globals.tiles.WALL_CAVE_DEEP:
							_level.grid[_tile.x][_tile.y].tile = Globals.tiles.FLOOR_CAVE_DEEP
							_level.addPointToEnemyPathding(_tile)
							_level.addPointToPathPathding(_tile)
							_isTileMined = true
						if !Globals.isTileFree(_tile, _level.grid) or _level.grid[_tile.x][_tile.y].tile == Globals.tiles.DOOR_CLOSED:
							break
						_tiles.append([{ "tile": _tile, "angle": spellData.spellDirections[_direction].angle }])
					if _isTileMined:
						$"/root/World".updateTiles()
						$"/root/World".drawLevel()
						Globals.gameConsole.addLog("The {itemName} bores through the wall!".format({ "itemName": _zappedItem.itemName }))
						Globals.isItemIdentified(_zappedItem)
				"wand of teleport":
					for i in range(1, _zappedItem.value.distance):
						var _tile = _playerPosition + _direction * i
						if !Globals.isTileFree(_tile, _grid) or _grid[_tile.x][_tile.y].tile == Globals.tiles.DOOR_CLOSED:
							break
						_tiles.append([{ "tile": _tile, "angle": spellData.spellDirections[_direction].angle }])
						if _grid[_tile.x][_tile.y].critter != null:
							var _critterName = get_node("/root/World/Critters/{critterId}".format({ "critterId": _grid[_tile.x][_tile.y].critter })).critterName
							if _zappedItem.piety.matchn("blasphemous"):
								Globals.gameConsole.addLog("The {critterName} vibrates... But nothing happens.".format({ "critterName": get_node("/root/World/Critters/{critterId}".format({ "critterId": _grid[_tile.x][_tile.y].critter })).critterName }))
								break
							dealWithTeleport(_grid[_tile.x][_tile.y].critter, _zappedItem.piety, _zappedItem.type)
							Globals.gameConsole.addLog("The {critterName} disappears!".format({ "critterName": _critterName }))
							Globals.isItemIdentified(_zappedItem)
							break
				"wand of summon critter":
					if _zappedItem.piety.matchn("reverent"):
						var _neutralClass = neutralClasses[randi() % neutralClasses.size()]
						var _critter = $"/root/World/Critters/Critters".critters[_neutralClass][randi() % $"/root/World/Critters/Critters".critters[_neutralClass].size()]
						var _adjacentTiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
						if !_adjacentTiles.empty():
							for _tile in _adjacentTiles:
								Globals.gameConsole.addLog("A {critterName} appears beside you. It seems friendly.".format({ "critterName": $"/root/World/Critters/Critters".spawnCritter(_critter, _tile) }))
						else:
							Globals.gameConsole.addLog("Nothing happens...")
					elif _zappedItem.piety.matchn("formal"):
						var _adjacentTiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
						if !_adjacentTiles.empty():
							for _tile in _adjacentTiles:
								Globals.gameConsole.addLog("A {critterName} appears beside you!".format({ "critterName": $"/root/World/Critters/Critters".spawnRandomCritter(_tile) }))
						else:
							Globals.gameConsole.addLog("Nothing happens...")
					elif _zappedItem.piety.matchn("blasphemous"):
						var _adjacentTiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, false, true)
						if !_adjacentTiles.empty():
							for _tile in _adjacentTiles:
								$"/root/World/Critters/Critters".spawnRandomCritter(_tile)
							Globals.gameConsole.addLog("A bucketload of critters appear around you!")
						else:
							Globals.gameConsole.addLog("Nothing happens...")
					Globals.isItemIdentified(_zappedItem)
					$"/root/World".closeMenu(_additionalChoices)
					$"/root/World".processGameTurn()
					return
				"wand of sleep":
					for i in range(1, _zappedItem.value.distance):
						var _tile = _playerPosition + _direction * i
						if !Globals.isTileFree(_tile, _grid) or _grid[_tile.x][_tile.y].tile == Globals.tiles.DOOR_CLOSED:
							break
						_tiles.append([{ "tile": _tile, "angle": spellData.spellDirections[_direction].angle }])
						if _grid[_tile.x][_tile.y].critter != null:
							var _critter = get_node("/root/World/Critters/{critterId}".format({ "critterId": _grid[_tile.x][_tile.y].critter }))
							if _zappedItem.piety.matchn("reverent"):
								_critter.statusEffects.sleep = 3
								Globals.gameConsole.addLog("{critterName} falls into a light sleep.".format({ "critterName": _critter.critterName }))
							elif _zappedItem.piety.matchn("formal"):
								_critter.statusEffects.sleep = 11
								Globals.gameConsole.addLog("{critterName} falls asleep.".format({ "critterName": _critter.critterName }))
							elif _zappedItem.piety.matchn("blasphemous"):
								_critter.statusEffects.sleep = 24
								Globals.gameConsole.addLog("{critterName} falls into a deep sleep!".format({ "critterName": _critter.critterName }))
							Globals.isItemIdentified(_zappedItem)
							break
				"wand of magic sphere", "wand of fleir", "wand of frost", "wand of thunder":
					for i in range(1, _zappedItem.value.distance[_zappedItem.piety.to_lower()]):
						var _tile = _playerPosition + _direction * i
						if !Globals.isTileFree(_tile, _grid) or _grid[_tile.x][_tile.y].tile == Globals.tiles.DOOR_CLOSED:
							break
						_tiles.append([{ "tile": _tile, "angle": spellData.spellDirections[_direction].angle }])
						if _grid[_tile.x][_tile.y].critter != null:
							_checkIfCritterHit = true
					if !_zappedItem.identifiedItemName.matchn("wand of magic sphere"):
						_projectileData.color = load("res://Objects/Data/RuneData.gd").new().runeData.eario[_zappedItem.value.dmg[_zappedItem.piety.to_lower()][0].magicDmg.element.to_lower()].color
				"wand of backwards magic sphere":
					if _zappedItem.piety.matchn("reverent"):
						Globals.gameConsole.addLog("{itemName} somehow misses you!".format({ "itemName": _zappedItem.itemName }))
					elif _zappedItem.piety.matchn("formal"):
						takeDamage(_zappedItem.value.dmg[_zappedItem.piety.to_lower()], _playerPosition, _zappedItem.itemName)
						Globals.gameConsole.addLog("{itemName} hits you!".format({ "itemName": _zappedItem.itemName }))
					elif _zappedItem.piety.matchn("blasphemous"):
						takeDamage(_zappedItem.value.dmg[_zappedItem.piety.to_lower()], _playerPosition, _zappedItem.itemName)
						Globals.gameConsole.addLog("{itemName} knocks the wind out of you!".format({ "itemName": _zappedItem.itemName }))
					Globals.isItemIdentified(_zappedItem)
					$"/root/World".closeMenu(_additionalChoices)
					$"/root/World".processGameTurn()
					return
				"wand of item polymorph":
					for i in range(1, _zappedItem.value.distance):
						var _tile = _playerPosition + _direction * i
						if !Globals.isTileFree(_tile, _grid) or _grid[_tile.x][_tile.y].tile == Globals.tiles.DOOR_CLOSED:
							break
						_tiles.append([{ "tile": _tile, "angle": spellData.spellDirections[_direction].angle }])
						var _itemCount = 0
						if _zappedItem.piety.matchn("reverent"):
							if _grid[_tile.x][_tile.y].items.size() != 0:
								var _newItems = []
								var _newItemIds = []
								for _itemId in _grid[_tile.x][_tile.y].items.duplicate(true):
									var _category = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).category
									if _category == null or !_category.matchn("container"):
										_newItems.append($"/root/World/Items/Items".getRandomItem())
										$"/root/World/Items/Items".removeItem(_itemId, _tile)
										_itemCount += 1
									if _category != null and _category.matchn("container"):
										_newItemIds.append(_itemId)
								for _itemId in _newItems:
									$"/root/World/Items/Items".createItem(_itemId, _tile)
									_newItemIds.append(Globals.itemId - 1)
								_grid[_tile.x][_tile.y].items = _newItemIds
								if _itemCount == 1:
									Globals.gameConsole.addLog("Item on the ground vibrates.")
									Globals.isItemIdentified(_zappedItem)
									continue
								Globals.gameConsole.addLog("Items on the ground vibrate.")
								Globals.isItemIdentified(_zappedItem)
						elif _zappedItem.piety.matchn("formal"):
							if _grid[_tile.x][_tile.y].items.size() != 0:
								var _newItems = []
								var _newItemIds = []
								for _itemId in _grid[_tile.x][_tile.y].items.duplicate(true):
									var _category = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).category
									if randi() % 2 == 0:
										if(_category == null or !_category.matchn("container")):
											_newItems.append($"/root/World/Items/Items".getRandomItem())
											$"/root/World/Items/Items".removeItem(_itemId, _tile)
											_itemCount += 1
									if _category != null and _category.matchn("container"):
										_newItemIds.append(_itemId)
								for _itemId in _newItems:
									$"/root/World/Items/Items".createItem(_itemId, _tile)
									_newItemIds.append(Globals.itemId - 1)
								_grid[_tile.x][_tile.y].items = _newItemIds
								if _itemCount > 0:
									Globals.gameConsole.addLog("Some items on the ground vibrate.")
									Globals.isItemIdentified(_zappedItem)
						elif _zappedItem.piety.matchn("blasphemous"):
							if _grid[_tile.x][_tile.y].items.size() != 0:
								var _newItems = []
								var _newItemIds = []
								for _itemId in _grid[_tile.x][_tile.y].items.duplicate(true):
									var _category = get_node("/root/World/Items/{itemId}".format({ "itemId": _itemId })).category
									if randi() % 4 == 0:
										if _category == null or !_category.matchn("container"):
											_newItems.append($"/root/World/Items/Items".getRandomItem())
											$"/root/World/Items/Items".removeItem(_itemId, _tile)
											_itemCount += 1
									if _category != null and _category.matchn("container"):
										_newItemIds.append(_itemId)
								for _itemId in _newItems:
									$"/root/World/Items/Items".createItem(_itemId, _tile)
									_newItemIds.append(Globals.itemId - 1)
								_grid[_tile.x][_tile.y].items = _newItemIds
							if _itemCount > 0:
								Globals.gameConsole.addLog("A few items on the ground vibrate.")
								Globals.isItemIdentified(_zappedItem)
					$"/root/World".hideObjectsWhenDrawingNextFrame = true
				"wand of wishing":
					Globals.isItemIdentified(_zappedItem)
					var _itemTypes = []
					for _type in $"/root/World/Items/Items".items:
						_itemTypes.append(_type)
					$"/root/World/UI/UITheme/ListMenu".showListMenuList("Wish for what item type?", _itemTypes, _zappedItem, true)
					_additionalChoices = true
				_:
					Globals.gameConsole.addLog("Thats not a wand...")
			_zappedItem.value.charges -= 1
			checkAllIdentification(true)
		else:
			Globals.gameConsole.addLog("The wand seems a little flaccid. There's no charges left.")
	if _checkIfCritterHit:
		Globals.isItemIdentified(_zappedItem)
	$"/root/World".closeMenu(_additionalChoices)
	if (
		_zappedItem.identifiedItemName.matchn("wand of magic sphere") or
		_zappedItem.identifiedItemName.matchn("wand of fleir") or
		_zappedItem.identifiedItemName.matchn("wand of frost") or
		_zappedItem.identifiedItemName.matchn("wand of thunder")
	):
		if !_zappedItem.identifiedItemName.matchn("wand of magic sphere"):
			_projectileData.color = load("res://Objects/Data/RuneData.gd").new().runeData.eario[_zappedItem.value.dmg[_zappedItem.piety.to_lower()][0].magicDmg.element.to_lower()].color
		_projectileData.damage = _zappedItem.value.dmg[_zappedItem.piety.to_lower()]
	_projectile.create(_tiles, _projectileData, _checkIfCritterHit)
	$"/root/World/Animations".add_child(_projectile)
	# warning-ignore:return_value_discarded
	$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).connect("playerAnimationDone", $"/root/World", "_onPlayerAnimationDone")
	$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).animateCycle()

func throwItem(_direction):
	var _playerPosition = $"/root/World".level.getCritterTile(0)
	var _thrownItem = get_node("/root/World/Items/{id}".format({ "id": selectedItem }))
	selectedItem = null
	if _thrownItem.type.matchn("potion"):
		Globals.gameConsole.addLog("You throw the {itemName}.".format({ "itemName": _thrownItem.itemName }))
		var _grid = $"/root/World".level.grid
		var _critter = null
		var _tile
		var _tiles = []
		for i in range(1, 6):
			var _checkedTile = _playerPosition + _direction * i
			if !Globals.isTileFree(_checkedTile, _grid) or _grid[_checkedTile.x][_checkedTile.y].tile == Globals.tiles.DOOR_CLOSED:
				break
			_tiles.append(_checkedTile)
			if _grid[_checkedTile.x][_checkedTile.y].critter != null:
				_critter = get_node("/root/World/Critters/{critterId}".format({ "critterId": _grid[_checkedTile.x][_checkedTile.y].critter }))
				_tile = _checkedTile
				break
		if _critter != null:
			Globals.gameConsole.addLog("The {itemName} crashes on {critterName}!".format({ "itemName": _thrownItem.itemName, "critterName": _critter.critterName }))
			match _thrownItem.identifiedItemName.to_lower():
				"potion of confusion":
					if statusEffects.confusion != -1:
						if _thrownItem.piety.matchn("reverent"):
							_critter.statusEffects.confusion += 4
							Globals.gameConsole.addLog("The {critterName} seems slightly disoriented.".format({ "critterName": _critter.critterName }))
						elif _thrownItem.piety.matchn("formal"):
							_critter.statusEffects.confusion += 10
							Globals.gameConsole.addLog("The {critterName} seems confused.".format({ "critterName": _critter.critterName }))
						elif _thrownItem.piety.matchn("blasphemous"):
							_critter.statusEffects.confusion += 22
							Globals.gameConsole.addLog("The {critterName} seems very confused!".format({ "critterName": _critter.critterName }))
						Globals.isItemIdentified(_thrownItem)
				"potion of toxix":
					if _thrownItem.piety.matchn("reverent"):
						_critter.statusEffects.toxix = 2
						Globals.gameConsole.addLog("The {potion} burns the {critterName}!".format({ "potion": _thrownItem.itemName, "critterName": _critter.critterName }))
					elif _thrownItem.piety.matchn("formal"):
						_critter.statusEffects.toxix = 8
						_critter.takeDamage(
							[
								{
									"dmg": [0,0],
									"bonusDmg": {},
									"armorPen": 0,
									"magicDmg": {
										"dmg": [4,4],
										"element": "Toxix"
									}
								}
							],
							_tile,
							_critter.critterName
						)
						Globals.gameConsole.addLog("The {potion} burns the {critterName}!".format({ "potion": _thrownItem.itemName, "critterName": _critter.critterName }))
					elif _thrownItem.piety.matchn("blasphemous"):
						_critter.statusEffects.toxix = 16
						_critter.takeDamage(
							{
								"dmg": [0,0],
								"bonusDmg": {},
								"armorPen": 0,
								"magicDmg": {
									"dmg": [8,8],
									"element": "Toxix"
								}
							},
							_tile,
							_critter.critterName
						)
						Globals.gameConsole.addLog("The {potion} burns the {critterName} badly!".format({ "potion": _thrownItem.itemName, "critterName": _critter.critterName }))
					Globals.isItemIdentified(_thrownItem)
				"potion of heal":
					var _amountToHeal = 0
					if _thrownItem.piety.matchn("reverent"):
						_amountToHeal = 6 + (_critter.level * 4)
						Globals.gameConsole.addLog("The {critterName} looks alot better!".format({ "critterName": _critter.critterName }))
					if _thrownItem.piety.matchn("formal"):
						_amountToHeal = 4 + (_critter.level * 3)
						Globals.gameConsole.addLog("The {critterName} looks more healthy.".format({ "critterName": _critter.critterName }))
					if _thrownItem.piety.matchn("blasphemous"):
						_amountToHeal = 2 + (_critter.level * 2)
						Globals.gameConsole.addLog("The {critterName} looks better.".format({ "critterName": _critter.critterName }))
					if _critter.hp + _amountToHeal >= _critter.maxhp:
						if _thrownItem.piety.matchn("reverent"):
							_critter.maxhp = _critter.maxhp + 1
							Globals.gameConsole.addLog("The {critterName} feel a little more vigorous.".format({ "critterName": _critter.critterName }))
						_critter.hp = _critter.maxhp
					else:
						_critter.hp += _amountToHeal
					Globals.isItemIdentified(_thrownItem)
				"potion of healaga":
					var _amountToHeal = 0
					if _thrownItem.piety.matchn("reverent"):
						_amountToHeal = 14 + (_critter.level * 8)
						Globals.gameConsole.addLog("The {critterName} looks way better!".format({ "critterName": _critter.critterName }))
					if _thrownItem.piety.matchn("formal"):
						_amountToHeal = 9 + (_critter.level * 6)
						Globals.gameConsole.addLog("The {critterName} looks healthy.".format({ "critterName": _critter.critterName }))
					if _thrownItem.piety.matchn("blasphemous"):
						_amountToHeal = 4 + (_critter.level * 4)
						Globals.gameConsole.addLog("The {critterName} looks better.".format({ "critterName": _critter.critterName }))
					if _critter.hp + _amountToHeal >= _critter.maxhp:
						if _thrownItem.piety.matchn("reverent"):
							_critter.maxhp = _critter.maxhp + 2
							Globals.gameConsole.addLog("The {critterName} feel a little more vigorous.".format({ "critterName": _critter.critterName }))
						_critter.hp = _critter.maxhp
					else:
						_critter.hp += _amountToHeal
					Globals.isItemIdentified(_thrownItem)
				"potion of sleep":
					if _thrownItem.piety.matchn("reverent"):
						_critter.statusEffects.sleep = 3
					if _thrownItem.piety.matchn("formal"):
						_critter.statusEffects.sleep = 7
					if _thrownItem.piety.matchn("blasphemous"):
						_critter.statusEffects.sleep = 13
					Globals.gameConsole.addLog("The {critterName} falls asleep.".format({ "crittetName": _critter.critterName }))
					Globals.isItemIdentified(_thrownItem)
				"potion of blindness":
					if !checkIfStatusEffectIsPermanent("blindness"):
						if _thrownItem.piety.matchn("reverent"):
							_critter.statusEffects.blindness = 4
						elif _thrownItem.piety.matchn("formal"):
							_critter.statusEffects.blindness = 8
						elif _thrownItem.piety.matchn("blasphemous"):
							_critter.statusEffects.blindness = 27
						Globals.gameConsole.addLog("The {critterName} is blind!".format({ "critterName": _critter.critterName }))
						Globals.isItemIdentified(_thrownItem)
				"potion of paralysis":
					if _thrownItem.piety.matchn("reverent"):
						_critter.statusEffects.stun = 2
					elif _thrownItem.piety.matchn("formal"):
						_critter.statusEffects.stun = 4
					elif _thrownItem.piety.matchn("blasphemous"):
						_critter.statusEffects.stun = 8
					Globals.gameConsole.addLog("The {critterName} is stunned!".format({ "critterName": _critter.critterName }))
					Globals.isItemIdentified(_thrownItem)
		else:
			Globals.gameConsole.addLog("The {itemName} breaks!".format({ "itemName": _thrownItem.itemName }))
		if _thrownItem.amount > 1:
			_thrownItem.amount -= 1
		else:
			$"/root/World/Items/Items".removeItem(_thrownItem.id)
		
		var _projectile = load("res://Objects/Projectile/Projectile.tscn").instance()
		_projectile.create(_tiles, { "texture": _thrownItem.itemTexture })
		$"/root/World/Animations".add_child(_projectile)
		# warning-ignore:return_value_discarded
		$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).connect("playerAnimationDone", $"/root/World", "_onPlayerAnimationDone")
		$"/root/World/Animations".get_child($"/root/World/Animations".get_child_count() - 1).animateCycle()
	$"/root/World".closeMenu()

func useItem(_id):
	var _usedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _usedItem.type.matchn("corpse"):
		var _playerPosition = $"/root/World".level.getCritterTile(0)
		if $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].interactable == Globals.interactables.ALTAR:
			$"/root/World/Items/Items".removeItem(_usedItem)
			Globals.gameConsole.addLog("You offer the {itemName} to the gods.".format({ "itemName": _usedItem.itemName }))
			if randi() % 12 == 0:
				var _gift
				if randi() % 2 == 0:
					_gift = sacrificeGifts[justice.to_lower()].armor[randi() % sacrificeGifts[justice.to_lower()].armor.size()]
				else:
					_gift = sacrificeGifts[justice.to_lower()].weapons[randi() % sacrificeGifts[justice.to_lower()].weapons.size()]
				$"/root/World/Items/Items".createItem(_gift, _playerPosition, 1, false, { "piety": "Formal" })
				Globals.gameConsole.addLog("An item appears on the ground!")
			else:
				Globals.gameConsole.addLog("The gods seem unresponsive for now.")
		else:
			Globals.gameConsole.addLog("You need to be on an altar to use that.")
		$"/root/World".closeMenu(_additionalChoices)
	if _usedItem.type.matchn("potion"):
		if _usedItem.itemName.matchn("empty potion bottle"):
			Globals.gameConsole.addLog("You empty the {potionName} on the floor. Smart!".format({ "potionName": _usedItem.itemName }))
			$"/root/World".closeMenu(_additionalChoices)
			return
		if _usedItem.amount > 1:
			_usedItem.amount -= 1
		else:
			$"/root/World/Items/Items".removeItem(_usedItem.id)
		$"/root/World/Items/Items".createItem("empty potion bottle", null, 1, true)
		Globals.gameConsole.addLog("You empty the {potionName} on the floor.".format({ "potionName": _usedItem.itemName }))
		$"/root/World".closeMenu(_additionalChoices)
		return
	if _usedItem.type.matchn("tool"):
		match _usedItem.identifiedItemName.to_lower():
			"blindfold":
				if _usedItem.value.worn:
					_usedItem.value.worn = false
					statusEffects["blindness"] = 0
					itemsTurnedOn.erase(_usedItem.id)
					Globals.gameConsole.addLog("You take off the blindfold.")
				else:
					_usedItem.value.worn = true
					statusEffects["blindness"] = -1
					itemsTurnedOn.append(_usedItem.id)
					Globals.gameConsole.addLog("You wear the blindfold.")
			"candle":
				if !checkIfLightSourceIsTurnedOn() or itemsTurnedOn.has(_usedItem.id):
					if _usedItem.value.charges > 0:
						if _usedItem.value.turnedOn:
							_usedItem.value.turnedOn = false
							itemsTurnedOn.erase(_usedItem.id)
							Globals.gameConsole.addLog("You turn off the {itemName}.".format({ "itemName": _usedItem.itemName }))
						else:
							_usedItem.value.turnedOn = true
							itemsTurnedOn.append(_usedItem.id)
							Globals.gameConsole.addLog("You turn on the {itemName}.".format({ "itemName": _usedItem.itemName }))
					else:
						Globals.gameConsole.addLog("Your candle is spent.")
				else:
					Globals.gameConsole.addLog("You already have a lightsource on.")
			"oil lamp":
				if !checkIfLightSourceIsTurnedOn() or itemsTurnedOn.has(_usedItem.id):
					if _usedItem.value.charges > 0:
						if _usedItem.value.turnedOn:
							_usedItem.value.turnedOn = false
							itemsTurnedOn.erase(_usedItem.id)
							Globals.gameConsole.addLog("You turn off the {itemName}.".format({ "itemName": _usedItem.itemName }))
						else:
							_usedItem.value.turnedOn = true
							itemsTurnedOn.append(_usedItem.id)
							Globals.gameConsole.addLog("You turn on the {itemName}.".format({ "itemName": _usedItem.itemName }))
					else:
						Globals.gameConsole.addLog("Your lamp is spent.")
				else:
					Globals.gameConsole.addLog("You already have a lightsource on.")
			"magic lamp":
				if !checkIfLightSourceIsTurnedOn() or itemsTurnedOn.has(_usedItem.id):
					if _usedItem.value.turnedOn:
						_usedItem.value.turnedOn = false
						itemsTurnedOn.erase(_usedItem.id)
						Globals.gameConsole.addLog("You turn off the {itemName}.".format({ "itemName": _usedItem.itemName }))
					else:
						_usedItem.value.turnedOn = true
						itemsTurnedOn.append(_usedItem.id)
						Globals.gameConsole.addLog("You turn on the {itemName}.".format({ "itemName": _usedItem.itemName }))
				else:
					Globals.gameConsole.addLog("You already have a lightsource on.")
			"message in a bottle":
				var _messageInABottle = get_node("/root/World/Items/{id}".format({ "id": _id }))
				var _newItem = $"/root/World/Items/Items".getRandomItemByItemTypes({ "scroll": ["common", "uncommon", "rare"] }, true)
				$"/root/World/Items/Items".createItem(_newItem, null, 1, true)
				if _messageInABottle.amount > 1:
					_messageInABottle.amount -= 1
				else:
					$"/root/World/Critters/0/Inventory".inventory.erase(_id)
					get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
				Globals.gameConsole.addLog("You pull a {itemName} out of the bottle.".format({ "itemName": _newItem.itemName }))
			"pickaxe":
				Globals.gameConsole.addLog("Turn on automine from bottom right and walk towards a stone wall to use the pickaxe.")
			"ink bottle":
				Globals.gameConsole.addLog("Use a marker with ink and an empty scroll in inventory to write scrolls.")
			"marker":
				var _scrolls = []
				var _letters = {}
				var _ink = 0
				var _blankPaper = null
				for _item in $"/root/World/Critters/0".inventory.inventory:
					var _itemNode = get_node("/root/World/Items/{itemId}".format({ "itemId": _item }))
					if _itemNode.identifiedItemName.matchn("blank scroll"):
						_blankPaper = _itemNode
				if _blankPaper == null:
					Globals.gameConsole.addLog("You don't have a blank scroll.")
				for _rarity in $"/root/World/Items/Items".items.scroll:
					for _scroll in $"/root/World/Items/Items".items.scroll[_rarity]:
						if (
							GlobalItemInfo.globalItemInfo.has(_scroll.itemName) and
							GlobalItemInfo.globalItemInfo[_scroll.itemName].identified
						):
							_scrolls.append(_scroll.itemName)
							_letters[_scroll.itemName] = _scroll.value.letters
				for _item in $"/root/World/Critters/0".inventory.inventory:
					var _itemNode = get_node("/root/World/Items/{itemId}".format({ "itemId": _item }))
					if _itemNode.identifiedItemName.matchn("ink bottle"):
						_ink += _itemNode.value.ink
				$"/root/World/UI/UITheme/ListMenu".showListMenuList("Write what? ({ink} letters of ink)".format({ "ink": _ink }), _scrolls, _usedItem, false, { "ink": _ink, "letters": _letters, "blankPaper": _blankPaper })
				_additionalChoices = true
			"magic marker":
				var _scrolls = []
				var _blankPaper = null
				for _item in $"/root/World/Critters/0".inventory.inventory:
					var _itemNode = get_node("/root/World/Items/{itemId}".format({ "itemId": _item }))
					if _itemNode.identifiedItemName.matchn("blank scroll"):
						_blankPaper = _itemNode
				if _blankPaper == null:
					Globals.gameConsole.addLog("You don't have a blank scroll.")
				for _rarity in $"/root/World/Items/Items".items.scroll:
					for _scroll in $"/root/World/Items/Items".items.scroll[_rarity]:
						if (
							GlobalItemInfo.globalItemInfo.has(_scroll.itemName) and
							GlobalItemInfo.globalItemInfo[_scroll.itemName].identified
						):
							_scrolls.append(_scroll.itemName)
				$"/root/World/UI/UITheme/ListMenu".showListMenuList("Write what?", _scrolls, _usedItem, false, { "blankPaper": _blankPaper })
				_additionalChoices = true
			_:
				Globals.gameConsole.addLog("Thats not a tool...")
		Globals.isItemIdentified(_usedItem)
		checkAllIdentification(true, true)
		$"/root/World".closeMenu(_additionalChoices)

func dipItem(_id):
	var _dippedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _selectedItem
	if selectedItem != null:
		_selectedItem = get_node("/root/World/Items/{id}".format({ "id": selectedItem }))
	if !_dippedItem.type.matchn("potion"):
		$"/root/World/UI/UITheme/ItemManagement".hideItemManagementList()
		$"/root/World/UI/UITheme/ItemManagement".items = $"/root/World/Critters/0/Inventory".getItemsOfType(["potion"])
		$"/root/World/UI/UITheme/ItemManagement".showItemManagementList("Dip into what?")
		$"/root/World".currentGameState = $"/root/World".gameState.DIP
	elif _dippedItem.type.matchn("potion"):
		Globals.gameConsole.addLog("You dip the {itemName} into the potion.".format({ "itemName": _selectedItem.itemName }))
		match _dippedItem.identifiedItemName.to_lower():
			"water potion":
				if _dippedItem.piety.matchn("reverent"):
					$"/root/World/Items/Items".createItem(_selectedItem.identifiedItemName, Vector2(0, 0), 1, true, { "piety": "Reverent" })
					if _selectedItem.amount > 1:
						_selectedItem.amount -= 1
					else:
						$"/root/World/Items/Items".removeItem(_selectedItem.id)
					if _dippedItem.amount > 1:
						_dippedItem.amount -= 1
					else:
						$"/root/World/Items/Items".removeItem(_dippedItem)
					Globals.gameConsole.addLog("The {itemName} glows with a white light!".format({ "itemName": _selectedItem.itemName }))
					Globals.gameConsole.addLog("The {itemName} is consumed.".format({ "itemName": _dippedItem.itemName }))
				elif _dippedItem.piety.matchn("formal"):
					if _selectedItem.type.matchn("scroll"):
						$"/root/World/Items/Items".createItem("blank scroll", null, 1, true, { "piety": _selectedItem.piety })
						if _selectedItem.amount > 1:
							_selectedItem.amount -= 1
						else:
							$"/root/World/Items/Items".removeItem(_selectedItem.id)
						Globals.gameConsole.addLog("Ink fades from the {itemName}.".format({ "itemName": _selectedItem.itemName }))
					else:
						Globals.gameConsole.addLog("The {itemName} gets wet.".format({ "itemName": _selectedItem.itemName }))
				elif _dippedItem.piety.matchn("blasphemous"):
					$"/root/World/Items/Items".createItem(_selectedItem.identifiedItemName, Vector2(0, 0), 1, true, { "piety": "Blasphemous" })
					if _selectedItem.amount > 1:
						_selectedItem.amount -= 1
					else:
						$"/root/World/Items/Items".removeItem(_selectedItem)
					if _dippedItem.amount > 1:
						_dippedItem.amount -= 1
					else:
						$"/root/World/Items/Items".removeItem(_dippedItem)
					Globals.gameConsole.addLog("The {itemName} glows with a black light!".format({ "itemName": _selectedItem.itemName }))
					Globals.gameConsole.addLog("The {itemName} is consumed.".format({ "itemName": _dippedItem.itemName }))
			"soda bottle":
				Globals.gameConsole.addLog("The {itemName} looks sugary.".format({ "itemName": _selectedItem.itemName }))
			"potion of confusion":
				Globals.gameConsole.addLog("The {itemName} looks visibly confused!".format({ "itemName": _selectedItem.itemName }))
			"potion of toxix":
				Globals.gameConsole.addLog("The {itemName} looks slightly corroded.".format({ "itemName": _selectedItem.itemName }))
#			"potion of invisibility":
#				Globals.gameConsole.addLog("The {itemName} looks transparent.".format({ "itemName": _selectedItem.itemName }))
			_:
				Globals.gameConsole.addLog("Nothing happens.")
		selectedItem = null
		checkAllIdentification(true)
		$"/root/World".closeMenu()
		$"/root/World".processGameTurn()



########################
### Helper functions ###
########################

func dealWithTeleport(_critterId, _piety, _itemType = "scroll"):
	var _world = $"/root/World"
	var _critter = get_node("/root/World/Critters/{critterId}".format({ "critterId": _critterId }))
	if _piety.matchn("formal") or _piety.matchn("reverent") or _itemType.matchn("wand"):
		var _playerPosition = _world.level.getCritterTile(_critter.id)
		var _level = _world.level
		var _openTiles = _level.openTiles.duplicate(true)
		_openTiles.shuffle()
		for _openTile in _openTiles:
			var _randomTile = _openTiles[randi() % _openTiles.size()]
			if _level.isTileFreeOfCritters(_randomTile):
				_critter.moveCritter(_playerPosition, _randomTile, _critterId, _level)
				return true
			else:
				_openTiles.erase(_randomTile)
	elif _piety.matchn("blasphemous"):
		var _randomDungeonPart = _world.levels.keys()[randi() % _world.levels.keys().size()]
		var _randomLevel
		if _randomDungeonPart.matchn("firstlevel"):
			_randomLevel = _world.levels[_randomDungeonPart]
		else:
			_randomLevel = _world.levels[_randomDungeonPart][randi() % _world.levels[_randomDungeonPart].size()]
		var _openTiles = _randomLevel.openTiles.duplicate(true)
		_openTiles.shuffle()
		for _openTile in _openTiles:
			var _randomTile = _openTiles[randi() % _openTiles.size()]
			if _randomLevel.isTileFreeOfCritters(_randomTile):
				_world.goToLevel(_randomTile, _randomLevel)
				return true
			else:
				_openTiles.erase(_randomTile)
	return false

func dealWithScrollOfGenocide(_name, _piety):
	if _piety.matchn("reverent"):
		for _genocidableCritter in $"/root/World/Critters/Critters".critters[_name]:
			for _critter in $"/root/World/Critters".get_children():
				if _critter.name.matchn("Critters"):
					continue
				if _critter.critterName.matchn(_genocidableCritter.critterName):
					_critter.despawn(null, false, false)
			GlobalCritterInfo.globalCritterInfo[_genocidableCritter.critterName].population = 0
			Globals.gameConsole.addLog("{critter} has been wiped out.".format({ "critter": _genocidableCritter.critterName.capitalize() }))
			GlobalGameStats.gameStats["Species genocided"] += 1
	elif _piety.matchn("formal"):
		for _critter in $"/root/World/Critters".get_children():
			if _critter.name.matchn("Critters"):
				continue
			if _critter.critterName.matchn(_name):
				_critter.despawn(null, false, false)
		GlobalCritterInfo.globalCritterInfo[_name].population = 0
		Globals.gameConsole.addLog("{critter} has been wiped out.".format({ "critter": _name.capitalize() }))
		GlobalGameStats.gameStats["Species genocided"] += 1
	elif _piety.matchn("blasphemous"):
		var _level = $"/root/World".level
		for _populationCount in range(GlobalCritterInfo.globalCritterInfo[_name].population):
			if !$"/root/World/Critters/Critters".spawnCritter(_name):
				break
		Globals.gameConsole.addLog("RUMMMMMBLE!!!")
	$"/root/World".closeMenu()

func dealWithWandOfWishing(_name, _piety):
	if _piety.matchn("reverent"):
		$"/root/World/Items/Items".createItem(_name, null, 1, true)
		Globals.gameConsole.addLog("An item appears in your inventory.")
	elif _piety.matchn("formal"):
		$"/root/World/Items/Items".createItem(_name, $"/root/World".level.getCritterTile(0))
		Globals.gameConsole.addLog("An item appears at your feet.")
	elif _piety.matchn("blasphemous"):
		$"/root/World/Items/Items".createItem($"/root/World/Items/Items".getRandomItem(), $"/root/World".level.getCritterTile(0))
		Globals.gameConsole.addLog("An item appears at your feet... It doesn't seem to be what you wished for.")
	GlobalGameStats.gameStats["Items wished"] += 1
	$"/root/World".closeMenu()

func dealWithMarker(_scroll, _ink):
	if _ink.has("ink"):
		if _ink.ink < _ink.letters:
			Globals.gameConsole.addLog("You don't have enough ink to write that scroll.")
			return false
		elif _scroll.matchn("blank scroll"):
			Globals.gameConsole.addLog("You write a blank scroll... on the blank scroll. Wow!")
		else:
			for _item in $"/root/World/Critters/0".inventory.inventory:
				var _itemNode = get_node("/root/World/Items/{itemId}".format({ "itemId": _item }))
				if _itemNode.identifiedItemName.matchn("ink bottle"):
					if _itemNode.value.ink != 0 and _ink.letters != 0:
						if _ink.letters - _itemNode.value.ink <= 0:
							_itemNode.value.ink -= _ink.letters
							_ink.letters = 0
						elif _itemNode.value.ink - _ink.letters <= 0:
							_ink.letters -= _itemNode.value.ink
							_itemNode.value.ink = 0
						else:
							_ink.letters -= _itemNode.value.ink
							_itemNode.value.ink = 0
			$"/root/World/Items/Items".createItem(_scroll, null, 1, true, { "piety": get_node("/root/World/Items/{itemId}".format({ "itemId": _ink.blankPaper })).piety })
			Globals.gameConsole.addLog("You write {scroll} on a piece of blank paper.".format({ "scroll": _scroll }))
	else:
		$"/root/World/Items/Items".createItem(_scroll, null, 1, true, { "piety": get_node("/root/World/Items/{itemId}".format({ "itemId": _ink.blankPaper })).piety })
		Globals.gameConsole.addLog("You write {scroll} on a piece of blank paper.".format({ "scroll": _scroll }))
	if get_node("/root/World/Items/{itemId}".format({ "itemId": _ink.blankPaper })).amount > 1:
		get_node("/root/World/Items/{itemId}".format({ "itemId": _ink.blankPaper })).amount -= 1
	else:
		$"/root/World/Items/Items".removeItem(_ink.blankPaper)
	$"/root/World".closeMenu()
	return true
