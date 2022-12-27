extends Player

var sacrificeGifts = load("res://Objects/Player/PlayerSacrificeGifts.gd")

######################
### Player actions ###
######################

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
			"scroll of identify":
				var _items = $"/root/World/Critters/0/Inventory".inventory.duplicate(true)
				if _items.empty():
					Globals.gameConsole.addLog("You hear strange whispers in your head. LLLLLL......")
				else:
					var _identifiableItemsInInventory = false
					if !_readItem.alignment.matchn("cursed"):
						if _readItem.alignment.matchn("blessed"):
							for _item in _items:
								var _itemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									GlobalItemInfo.globalItemInfo.has(_itemInInventory.identifiedItemName) and
									GlobalItemInfo.globalItemInfo[_itemInInventory.identifiedItemName].identified == false
								):
									_identifiableItemsInInventory = true
									_itemInInventory.identifyItem(true, true, true)
									Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _itemInInventory.identifiedItemName, "unidentifiedItemName": _itemInInventory.unidentifiedItemName }))
						else:
							while true:
								if _items.empty():
									break
								var _item = _items[randi() % _items.size()]
								var _randomItemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									GlobalItemInfo.globalItemInfo.has(_randomItemInInventory.identifiedItemName) and
									GlobalItemInfo.globalItemInfo[_randomItemInInventory.identifiedItemName].identified == false
								):
									_randomItemInInventory.identifyItem(true, true, true)
									Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _randomItemInInventory.identifiedItemName, "unidentifiedItemName": _randomItemInInventory.unidentifiedItemName }))
									_identifiableItemsInInventory = true
									break
								_items.erase(_item)
					if !_identifiableItemsInInventory:
						_items = $"/root/World/Critters/0/Inventory".inventory.duplicate(true)
						if _readItem.alignment.matchn("blessed"):
							for _item in _items:
								var _itemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									_itemInInventory.notIdentified.alignment or
									_itemInInventory.notIdentified.enchantment
								):
									_itemInInventory.identifyItem(true, true, true)
									Globals.gameConsole.addLog("You know more about {itemName}.".format({ "itemName": _itemInInventory.itemName }))
						else:
							while true:
								if _items.empty():
									Globals.gameConsole.addLog("You hear strange whispers in your head. LLLLLL......")
									break
								var _item = _items[randi() % _items.size()]
								var _randomItemInInventory = get_node("/root/World/Items/{id}".format({ "id": _item }))
								if (
									_randomItemInInventory.notIdentified.alignment or
									_randomItemInInventory.notIdentified.enchantment
								):
									_randomItemInInventory.identifyItem(true, true, true)
									Globals.gameConsole.addLog("You know more about {itemName}.".format({ "itemName": _randomItemInInventory.itemName }))
									break
								_items.erase(_item)
			"scroll of create food":
				var _playerPosition = $"/root/World".level.getCritterTile(0)
				if _readItem.alignment.matchn("blessed"):
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
				elif _readItem.alignment.matchn("uncursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["comestible"].keys()[randi() % $"/root/World/Items/Items".items["comestible"].keys().size()]
					var _item = $"/root/World/Items/Items".items["comestible"][_rarity][randi() % $"/root/World/Items/Items".items["comestible"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("{itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.alignment.matchn("cursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					newItem.createItem($"/root/World/Items/Items".getItemByName("orange"))
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("{itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
			"scroll of create potion":
				var _playerPosition = $"/root/World".level.getCritterTile(0)
				if _readItem.alignment.matchn("blessed"):
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
				elif _readItem.alignment.matchn("uncursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					var _rarity = $"/root/World/Items/Items".items["potion"].keys()[randi() % $"/root/World/Items/Items".items["potion"].keys().size()]
					var _item = $"/root/World/Items/Items".items["potion"][_rarity][randi() % $"/root/World/Items/Items".items["potion"][_rarity].size()]
					newItem.createItem(_item)
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("{itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.alignment.matchn("cursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					newItem.createItem($"/root/World/Items/Items".getItemByName("potion of toxix"))
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("{itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
			"scroll of summon critter":
				var _playerPosition = $"/root/World".level.getCritterTile(0)
				if _readItem.alignment.matchn("blessed"):
					var _critter = neutralCritters[randi() % neutralCritters.size()]
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
					if !_tiles.empty():
						for _tile in _tiles:
							Globals.gameConsole.addLog("A {critterName} appears beside you. It seems friendly.".format({ "critterName": $"/root/World/Critters/Critters".spawnCritter(_critter, _tile) }))
					else:
						Globals.gameConsole.addLog("Nothing happens...")
				elif _readItem.alignment.matchn("uncursed"):
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
					if !_tiles.empty():
						for _tile in _tiles:
							Globals.gameConsole.addLog("A {critterName} appears beside you!".format({ "critterName": $"/root/World/Critters/Critters".spawnRandomCritter(_tile) }))
					else:
						Globals.gameConsole.addLog("Nothing happens...")
				elif _readItem.alignment.matchn("cursed"):
					var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, false, true)
					if !_tiles.empty():
						for _tile in _tiles:
							$"/root/World/Critters/Critters".spawnRandomCritter(_tile)
						Globals.gameConsole.addLog("A bucketload of critters appear around you!")
					else:
						Globals.gameConsole.addLog("Nothing happens...")
			"scroll of genocide":
				var _aliveCritters = []
				if _readItem.alignment.matchn("blessed"):
					for _critterRace in $"/root/World/Critters/Critters".critters.keys():
						if !_critterRace.matchn("bosses"):
							for _critterName in $"/root/World/Critters/Critters".critters[_critterRace].critterTypes:
								if GlobalCritterInfo.globalCritterInfo[_critterName.critterName].population != 0:
									_aliveCritters.append(_critterRace)
									break
				elif _readItem.alignment.matchn("uncursed") or _readItem.alignment.matchn("cursed"):
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
				$"/root/World/UI/UITheme/ListMenu".showListMenuList("Genocide what?", _aliveCritters, _readItem)
				_additionalChoices = true
			"scroll of teleport":
				if dealWithTeleport(0, _readItem.alignment):
					Globals.gameConsole.addLog("Whoosh! You reappear somewhere!")
				else:
					Globals.gameConsole.addLog("It doesn't seem you have space to teleport...")
			"scroll of confusion":
				if statusEffects.confusion != -1:
					if _readItem.alignment.matchn("blessed"):
						statusEffects.confusion += 4
						Globals.gameConsole.addLog("You feel slightly disoriented.")
					elif _readItem.alignment.matchn("uncursed"):
						statusEffects.confusion += 10
						Globals.gameConsole.addLog("You feel confused.")
					elif _readItem.alignment.matchn("cursed"):
						statusEffects.confusion += 22
						Globals.gameConsole.addLog("The world spins!")
				else:
					Globals.gameConsole.addLog("You already feel confused enough!")
			_:
				Globals.gameConsole.addLog("Thats not a scroll...")
		Globals.isItemIdentified(_readItem)
		checkAllIdentification(true)
		if !_readItem.identifiedItemName.to_lower().matchn("blank scroll"):
			if _readItem.amount > 1:
				_readItem.amount -= 1
			else:
				$"/root/World/Items/Items".removeItem(_id)
	$"/root/World".closeMenu(_additionalChoices)

func quaffItem(_id):
	var _quaffedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _quaffedItem.type.matchn("potion"):
		Globals.gameConsole.addLog("You quaff a {itemName}.".format({ "itemName": _quaffedItem.itemName }))
		match _quaffedItem.identifiedItemName.to_lower():
			"water potion":
				if _quaffedItem.alignment.matchn("blessed"):
					Globals.gameConsole.addLog("This tastes fantastic!")
				if _quaffedItem.alignment.matchn("uncursed"):
					Globals.gameConsole.addLog("This tastes like water.")
				if _quaffedItem.alignment.matchn("cursed"):
					Globals.gameConsole.addLog("This doesn't taste very good. Ughhhh...")
			"soda bottle":
				if _quaffedItem.alignment.matchn("blessed"):
					Globals.gameConsole.addLog("Its orange juice! Its really good!")
				if _quaffedItem.alignment.matchn("uncursed"):
					Globals.gameConsole.addLog("Its apple juice. Tastes nice!")
				if _quaffedItem.alignment.matchn("cursed"):
					Globals.gameConsole.addLog("Its radish juice. Uggghh...")
			"potion of heal":
				var _amountToHeal = 0
				if _quaffedItem.alignment.matchn("blessed"):
					_amountToHeal = 6 + (level * 4)
					Globals.gameConsole.addLog("The {potion} heals you. That felt good!".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("uncursed"):
					_amountToHeal = 4 + (level * 3)
					Globals.gameConsole.addLog("The {potion} heals you.".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("cursed"):
					_amountToHeal = 2 + (level * 2)
					Globals.gameConsole.addLog("The {potion} heals you. That felt a little off.".format({ "potion": _quaffedItem.itemName }))
				if hp + _amountToHeal >= maxhp:
					if _quaffedItem.alignment.matchn("blessed"):
						maxhp = maxhp + 1
						Globals.gameConsole.addLog("You feel a little more vigorous.")
					hp = maxhp
				else:
					hp += _amountToHeal
			"potion of healaga":
				var _amountToHeal = 0
				if _quaffedItem.alignment.matchn("blessed"):
					_amountToHeal = 14 + (level * 8)
					Globals.gameConsole.addLog("The {potion} heals you alot. That felt good!".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("uncursed"):
					_amountToHeal = 9 + (level * 6)
					Globals.gameConsole.addLog("The {potion} heals you alot.".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("cursed"):
					_amountToHeal = 4 + (level * 4)
					Globals.gameConsole.addLog("The {potion} heals you alot. That felt a little off.".format({ "potion": _quaffedItem.itemName }))
				if hp + _amountToHeal >= maxhp:
					if _quaffedItem.alignment.matchn("blessed"):
						maxhp = maxhp + 2
						Globals.gameConsole.addLog("You feel a little more vigorous.")
					hp = maxhp
				else:
					hp += _amountToHeal
			"potion of toxix":
				if _quaffedItem.alignment.matchn("blessed"):
					statusEffects.toxix = 2
					Globals.gameConsole.addLog("The {potion} tastes slightly acidic. Bleagh!".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("uncursed"):
					statusEffects.toxix = 8
					hp -= 4
					Globals.gameConsole.addLog("The {potion} tastes bitter. Urgh!".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("cursed"):
					statusEffects.toxix = 16
					hp -= 4
					Globals.gameConsole.addLog("The {potion} burns your mouth. Uhhhh...".format({ "potion": _quaffedItem.itemName }))
					maxhp -= 1
					hp -= 1
					Globals.gameConsole.addLog("You feel a little less healthy.")
			"potion of sleep":
				if _quaffedItem.alignment.matchn("blessed"):
					statusEffects.sleep = 3
					Globals.gameConsole.addLog("The {potion} gives you sweet dreams.".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("uncursed"):
					statusEffects.sleep = 7
					Globals.gameConsole.addLog("The {potion} puts you asleep.".format({ "potion": _quaffedItem.itemName }))
				if _quaffedItem.alignment.matchn("cursed"):
					statusEffects.sleep = 13
					Globals.gameConsole.addLog("The {potion} knocks you out.".format({ "potion": _quaffedItem.itemName }))
			"potion of gain level":
				if _quaffedItem.alignment.matchn("blessed"):
					addExp(experienceNeededForLevelGainAmount)
					Globals.gameConsole.addLog("You gain a level! You feel like you gained extra experience.")
				if _quaffedItem.alignment.matchn("uncursed"):
					addExp(experienceNeededForLevelGainAmount - experiencePoints)
					Globals.gameConsole.addLog("You gain a level!")
				if _quaffedItem.alignment.matchn("cursed"):
					addExp(experienceNeededForPreviousLevelGainAmount - experiencePoints)
					Globals.gameConsole.addLog("You somehow feel less experienced.")
			"potion of hunger":
				if _quaffedItem.alignment.matchn("blessed"):
					calories += 300
					Globals.gameConsole.addLog("You feel nourished.")
				if _quaffedItem.alignment.matchn("uncursed"):
					calories += -450
					Globals.gameConsole.addLog("You feel malnourished.")
				if _quaffedItem.alignment.matchn("cursed"):
					calories += -1000
					Globals.gameConsole.addLog("You feel like you lost half your weight!")
			"potion of confusion":
				if statusEffects.confusion != -1:
					if _quaffedItem.alignment.matchn("blessed"):
						statusEffects.confusion = 4
						Globals.gameConsole.addLog("You feel slightly disoriented.")
					elif _quaffedItem.alignment.matchn("uncursed"):
						statusEffects.confusion += 10
						Globals.gameConsole.addLog("You feel confused.")
					elif _quaffedItem.alignment.matchn("cursed"):
						statusEffects.confusion += 22
						Globals.gameConsole.addLog("The world spins!")
				else:
					Globals.gameConsole.addLog("You already feel confused enough!")
			_:
				Globals.gameConsole.addLog("Thats not a potion...")
		Globals.isItemIdentified(_quaffedItem)
		checkAllIdentification(true)
		if _quaffedItem.amount > 1:
			_quaffedItem.amount -= 1
		else:
			$"/root/World/Items/Items".removeItem(_id)
	$"/root/World".closeMenu(_additionalChoices)

func consumeItem(_id):
	var _eatenItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	if _eatenItem.type.matchn("comestible"):
		if calories > 5000:
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
		Globals.gameConsole.addLog("You eat {comestible}.".format({ "comestible": _eatenItem.itemName }))
		if calories > 5000:
			Globals.gameConsole.addLog("You feel full.")
	$"/root/World".closeMenu()

func zapItem(_direction):
	var _playerPosition = $"/root/World".level.getCritterTile(0)
	var _zappedItem = get_node("/root/World/Items/{id}".format({ "id": selectedItem }))
	selectedItem = null
	var _additionalChoices = false
	if _zappedItem.type.matchn("wand"):
		Globals.gameConsole.addLog("You zap the {itemName}.".format({ "itemName": _zappedItem.itemName }))
		if _zappedItem.value.charges > 0:
			match _zappedItem.identifiedItemName.to_lower():
				"wand of light":
					if _zappedItem.alignment.matchn("blessed"):
						playerVisibility = {
							"distance": 10,
							"duration": 80
						}
						Globals.gameConsole.addLog("The light illuminates your surroundings brightly!")
					elif _zappedItem.alignment.matchn("uncursed"):
						playerVisibility = {
							"distance": 7,
							"duration": 35
						}
						Globals.gameConsole.addLog("The light illuminates your surroundings.")
					elif _zappedItem.alignment.matchn("cursed"):
						playerVisibility = {
							"distance": 4,
							"duration": 10
						}
						Globals.gameConsole.addLog("The light illuminates your surroundings dimly.")
					$"/root/World".drawLevel()
					Globals.isItemIdentified(_zappedItem)
				"wand of teleport":
					var _grid = $"/root/World".level.grid
					for i in range(1, _zappedItem.value.distance[_zappedItem.alignment]):
						if !Globals.isTileFree(_playerPosition + _direction * i, _grid) or _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].tile == Globals.tiles.DOOR_CLOSED:
							break
						if _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].critter != null:
							if _zappedItem.alignment.matchn("cursed"):
								Globals.gameConsole.addLog("The {critterName} vibrates... But nothing happens.".format({ "critterName": get_node("/root/World/Critters/{critterId}".format({ "critterId": _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].critter })).critterName }))
								break
							dealWithTeleport(_grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].critter, _zappedItem.alignment, _zappedItem.type)
							Globals.gameConsole.addLog("The {critterName} disappears!".format({ "critterName": get_node("/root/World/Critters/{critterId}".format({ "critterId": _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].critter })).critterName }))
							Globals.isItemIdentified(_zappedItem)
							break
				"wand of summon critter":
					if _zappedItem.alignment.matchn("blessed"):
						var _critter = neutralCritters[randi() % neutralCritters.size()]
						var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
						if !_tiles.empty():
							for _tile in _tiles:
								Globals.gameConsole.addLog("A {critterName} appears beside you. It seems friendly.".format({ "critterName": $"/root/World/Critters/Critters".spawnCritter(_critter, _tile) }))
						else:
							Globals.gameConsole.addLog("Nothing happens...")
					elif _zappedItem.alignment.matchn("uncursed"):
						var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, true, true)
						if !_tiles.empty():
							for _tile in _tiles:
								Globals.gameConsole.addLog("A {critterName} appears beside you!".format({ "critterName": $"/root/World/Critters/Critters".spawnRandomCritter(_tile) }))
						else:
							Globals.gameConsole.addLog("Nothing happens...")
					elif _zappedItem.alignment.matchn("cursed"):
						var _tiles = $"/root/World".level.checkAdjacentTilesForOpenSpace(_playerPosition, false, true)
						if !_tiles.empty():
							for _tile in _tiles:
								$"/root/World/Critters/Critters".spawnRandomCritter(_tile)
							Globals.gameConsole.addLog("A bucketload of critters appear around you!")
						else:
							Globals.gameConsole.addLog("Nothing happens...")
					Globals.isItemIdentified(_zappedItem)
				"wand of backwards magic sphere":
					if _zappedItem.alignment.matchn("blessed"):
						Globals.gameConsole.addLog("{itemName} somehow misses you!".format({ "itemName": _zappedItem.itemName }))
					elif _zappedItem.alignment.matchn("uncursed"):
						takeDamage(_zappedItem.value.dmg[_zappedItem.alignment], _playerPosition, "Wand of backwards magic sphere")
						Globals.gameConsole.addLog("{itemName} hits you!".format({ "itemName": _zappedItem.itemName }))
					elif _zappedItem.alignment.matchn("cursed"):
						takeDamage(_zappedItem.value.dmg[_zappedItem.alignment], _playerPosition, "Wand of backwards magic sphere")
						Globals.gameConsole.addLog("{itemName} knocks the wind out of you!".format({ "itemName": _zappedItem.itemName }))
					Globals.isItemIdentified(_zappedItem)
				"wand of item polymorph":
					var _grid = $"/root/World".level.grid
					for i in range(1, _zappedItem.value.distance[_zappedItem.alignment]):
						if !Globals.isTileFree(_playerPosition + _direction * i, _grid) or _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].tile == Globals.tiles.DOOR_CLOSED:
							break
						var _itemCount = 0
						if _zappedItem.alignment.matchn("blessed"):
							if _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].items.size() != 0:
								var _newItems = []
								var _newItemIds = []
								for _item in _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].items.duplicate(true):
									_newItems.append($"/root/World/Items/Items".getRandomItem())
									$"/root/World/Items/Items".removeItem(_item, _playerPosition + _direction * i)
									_itemCount += 1
								for _item in _newItems:
									$"/root/World/Items/Items".createItem(_item, _playerPosition + _direction * i)
									_newItemIds.append(Globals.itemId - 1)
								_grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].items = _newItemIds
								if _itemCount == 1:
									Globals.gameConsole.addLog("Item on the ground vibrates.")
									Globals.isItemIdentified(_zappedItem)
									continue
								Globals.gameConsole.addLog("Items on the ground vibrate.")
								Globals.isItemIdentified(_zappedItem)
						elif _zappedItem.alignment.matchn("uncursed"):
							if _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].items.size() != 0:
								var _newItems = []
								var _newItemIds = []
								for _item in _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].items.duplicate(true):
									if randi() % 2 == 0:
										_newItems.append($"/root/World/Items/Items".getRandomItem())
										$"/root/World/Items/Items".removeItem(_item, _playerPosition + _direction * i)
										_itemCount += 1
								for _item in _newItems:
									$"/root/World/Items/Items".createItem(_item, _playerPosition + _direction * i)
									_newItemIds.append(Globals.itemId - 1)
								_grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].items = _newItemIds
								if _itemCount > 0:
									Globals.gameConsole.addLog("Some items on the ground vibrate.")
									Globals.isItemIdentified(_zappedItem)
						elif _zappedItem.alignment.matchn("cursed"):
							if _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].items.size() != 0:
								var _newItems = []
								var _newItemIds = []
								for _item in _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].items.duplicate(true):
									if randi() % 4 == 0:
										_newItems.append($"/root/World/Items/Items".getRandomItem())
										$"/root/World/Items/Items".removeItem(_item, _playerPosition + _direction * i)
										_itemCount += 1
								for _item in _newItems:
									$"/root/World/Items/Items".createItem(_item, _playerPosition + _direction * i)
									_newItemIds.append(Globals.itemId - 1)
								_grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].items = _newItemIds
							if _itemCount > 0:
								Globals.gameConsole.addLog("A few items on the ground vibrate.")
								Globals.isItemIdentified(_zappedItem)
				"wand of wishing":
					Globals.isItemIdentified(_zappedItem)
					var _itemTypes = []
					for _type in $"/root/World/Items/Items".items:
						_itemTypes.append(_type)
					$"/root/World/UI/UITheme/ListMenu".showListMenuList("Wish for what item type?", _itemTypes, _zappedItem, true)
					_additionalChoices = true
				"wand of digging":
					var _level = $"/root/World".level
					var _isTileMined = false
					for i in range(1, _zappedItem.value.distance[_zappedItem.alignment]):
						var _tile = _playerPosition + _direction * i
						if _level.grid[_tile.x][_tile.y].tile == Globals.tiles.EMPTY or _level.grid[_tile.x][_tile.y].tile == Globals.tiles.WALL_CAVE:
							_level.grid[_tile.x][_tile.y].tile = Globals.tiles.FLOOR_CAVE
							_level.addPointToEnemyPathding(_tile)
							_level.addPointToPathPathding(_tile)
							_level.addPointToWeightedPathding(_tile)
							_isTileMined = true
						if _level.grid[_tile.x][_tile.y].tile == Globals.tiles.WALL_CAVE_DEEP:
							_level.grid[_tile.x][_tile.y].tile = Globals.tiles.FLOOR_CAVE_DEEP
							_level.addPointToEnemyPathding(_tile)
							_level.addPointToPathPathding(_tile)
							_level.addPointToWeightedPathding(_tile)
							_isTileMined = true
						if !Globals.isTileFree(_tile, _level.grid) or _level.grid[_tile.x][_tile.y].tile == Globals.tiles.DOOR_CLOSED:
							break
					if _isTileMined:
						$"/root/World".updateTiles()
						$"/root/World".drawLevel()
						Globals.gameConsole.addLog("The {itemName} bores through the wall!".format({ "itemName": _zappedItem.itemName }))
						Globals.isItemIdentified(_zappedItem)
				"wand of magic sphere", "wand of fleir", "wand of frost", "wand of thunder":
					var _grid = $"/root/World".level.grid
					for i in range(1, _zappedItem.value.distance[_zappedItem.alignment]):
						var _tile = _playerPosition + _direction * i
						if !Globals.isTileFree(_tile, _grid) or _grid[_tile.x][_tile.y].tile == Globals.tiles.DOOR_CLOSED:
							break
						if _grid[_tile.x][_tile.y].critter != null:
							var _critter = get_node("/root/World/Critters/{critterId}".format({ "critterId": _grid[_tile.x][_tile.y].critter }))
							_critter.takeDamage(_zappedItem.value.dmg[_zappedItem.alignment], _tile)
							Globals.isItemIdentified(_zappedItem)
				_:
					Globals.gameConsole.addLog("Thats not a wand...")
			_zappedItem.value.charges -= 1
			checkAllIdentification(true)
		else:
			Globals.gameConsole.addLog("The wand seems a little flaccid. There's no charges left.")
	$"/root/World".closeMenu(_additionalChoices)

func useItem(_id):
	var _usedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _usedItem.type.matchn("corpse"):
		var _playerPosition = $"/root/World".level.getCritterTile(0)
		if $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].interactable == Globals.interactables.ALTAR:
			$"/root/World/Items/Items".removeItem(_usedItem)
			Globals.gameConsole.addLog("You offer the {itemName} to the gods.".format({ "itemName": _usedItem.itemName }))
			if $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items != null:
				var _alignedItem = get_node("/root/World/Items/{id}".format({ "id": $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items[randi() % $"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.size()] }))
				if randi() % 2 == 0:
					_alignedItem.alignment = "Blessed"
					Globals.gameConsole.addLog("{itemname} glows white.".format({ "itemName": _alignedItem.itemName }))
				else:
					_alignedItem.alignment = "Cursed"
					Globals.gameConsole.addLog("{itemname} glows black.".format({ "itemName": _alignedItem.itemName }))
			if randi() % 8 == 0:
				var _gift
				if randi() % 2 == 0:
					_gift = sacrificeGifts[justice].armor[randi() % sacrificeGifts[justice].armor.size()]
				else:
					_gift = sacrificeGifts[justice].weapons[randi() % sacrificeGifts[justice].weapons.size()]
				$"/root/World/Items/Items".createItem(_gift, _playerPosition, 1, false, { "alignment": "Uncursed" })
				Globals.gameConsole.addLog("An item appears on the ground!")
			else:
				Globals.gameConsole.addLog("The gods seem unresponsive for now.")
	if _usedItem.type.matchn("tool"):
		match _usedItem.identifiedItemName.to_lower():
			"blindfold":
				if _usedItem.value.worn:
					_usedItem.value.worn = false
					statusEffects["blindness"] = 0
					itemsTurnedOn.erase(_usedItem)
					Globals.gameConsole.addLog("You take off the blindfold.")
				else:
					_usedItem.value.worn = true
					statusEffects["blindness"] = -1
					itemsTurnedOn.append(_usedItem)
					Globals.gameConsole.addLog("You wear the blindfold.")
			"candle":
				if !checkIfLightSourceIsTurnedOn() or itemsTurnedOn.has(_usedItem):
					if _usedItem.value.charges > 0:
						if _usedItem.value.turnedOn:
							_usedItem.value.turnedOn = false
							itemsTurnedOn.erase(_usedItem)
							Globals.gameConsole.addLog("You turn off the {itemName}.".format({ "itemName": _usedItem.itemName }))
						else:
							_usedItem.value.turnedOn = true
							itemsTurnedOn.append(_usedItem)
							Globals.gameConsole.addLog("You turn on the {itemName}.".format({ "itemName": _usedItem.itemName }))
					else:
						Globals.gameConsole.addLog("Your candle is spent.")
				else:
					Globals.gameConsole.addLog("You already have a lightsource on.")
			"oil lamp":
				if !checkIfLightSourceIsTurnedOn() or itemsTurnedOn.has(_usedItem):
					if _usedItem.value.charges > 0:
						if _usedItem.value.turnedOn:
							_usedItem.value.turnedOn = false
							itemsTurnedOn.erase(_usedItem)
							Globals.gameConsole.addLog("You turn off the {itemName}.".format({ "itemName": _usedItem.itemName }))
						else:
							_usedItem.value.turnedOn = true
							itemsTurnedOn.append(_usedItem)
							Globals.gameConsole.addLog("You turn on the {itemName}.".format({ "itemName": _usedItem.itemName }))
					else:
						Globals.gameConsole.addLog("Your lamp is spent.")
				else:
					Globals.gameConsole.addLog("You already have a lightsource on.")
			"magic lamp":
				if !checkIfLightSourceIsTurnedOn() or itemsTurnedOn.has(_usedItem):
					if _usedItem.value.turnedOn:
						_usedItem.value.turnedOn = false
						itemsTurnedOn.erase(_usedItem)
						Globals.gameConsole.addLog("You turn off the {itemName}.".format({ "itemName": _usedItem.itemName }))
					else:
						_usedItem.value.turnedOn = true
						itemsTurnedOn.append(_usedItem)
						Globals.gameConsole.addLog("You turn on the {itemName}.".format({ "itemName": _usedItem.itemName }))
				else:
					Globals.gameConsole.addLog("You already have a lightsource on.")
			"message in a bottle":
				var _messageInABottle = get_node("/root/World/Items/{id}".format({ "id": _id }))
				var _newItem = $"/root/World/Items/Items".getRandomItemByItemTypes(["scroll"], true)
				$"/root/World/Items/Items".createItem(_newItem, null, 1, true)
				if _messageInABottle.amount > 1:
					_messageInABottle.amount -= 1
				else:
					$"/root/World/Critters/0/Inventory".inventory.erase(_id)
					get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
				Globals.gameConsole.addLog("You pull a {itemName} out of the bottle.".format({ "itemName": _newItem.itemName }))
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
					Globals.gameConsole.addLog("You dont have a blank scroll.")
					continue
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
					Globals.gameConsole.addLog("You dont have a blank paper.")
					continue
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
	var _additionalChoices = false
	if !_dippedItem.type.matchn("potion"):
		$"/root/World/UI/UITheme/ItemManagement".hideItemManagementList()
		$"/root/World/UI/UITheme/ItemManagement".items = $"/root/World/Critters/0/Inventory".getItemsOfType(["potion"])
		$"/root/World/UI/UITheme/ItemManagement".showItemManagementList("Dip into what?", true)
		$"/root/World".currentGameState = $"/root/World".gameState.DIP
	elif _dippedItem.type.matchn("potion"):
		match _dippedItem.identifiedItemName.to_lower():
			"water potion":
				if _dippedItem.alignment.matchn("blessed"):
					_selectedItem.alignment = "blessed"
					Globals.gameConsole.addLog("The {itemName} glows with a white light!".format({ "itemName": _selectedItem.itemName }))
				elif _dippedItem.alignment.matchn("uncursed"):
					if _selectedItem.type.matchn("scroll"):
						$"/root/World/Items/Items".createItem("blank scroll", null, _selectedItem.amount, true)
						$"/root/World/Items/Items".removeItem(selectedItem)
						Globals.gameConsole.addLog("Ink fades from the {itemName}.".format({ "itemName": _selectedItem.itemName }))
					else:
						Globals.gameConsole.addLog("The {itemName} gets wet.".format({ "itemName": _selectedItem.itemName }))
				elif _dippedItem.alignment.matchn("cursed"):
					_selectedItem.alignment = "cursed"
					Globals.gameConsole.addLog("The {itemName} glows with a black light!".format({ "itemName": _selectedItem.itemName }))
				Globals.gameConsole.addLog("The {itemName} is consumed.".format({ "itemName": _dippedItem.itemName }))
			"soda bottle":
				Globals.gameConsole.addLog("The {itemName} is soaked with sugar.".format({ "itemName": _selectedItem.itemName }))
			"potion of confusion":
				Globals.gameConsole.addLog("The {itemName} looks visibly confused!".format({ "itemName": _selectedItem.itemName }))
			"potion of toxix":
				Globals.gameConsole.addLog("The {itemName} looks slightly corroded.".format({ "itemName": _selectedItem.itemName }))
#			"potion of invisibility":
#				Globals.gameConsole.addLog("The {itemName} looks transparent.".format({ "itemName": _selectedItem.itemName }))
			_:
				Globals.gameConsole.addLog("You soak the {itemName} into the potion. Nothing happens.".format({ "itemName": _selectedItem.itemName }))
		selectedItem = null
		checkAllIdentification(true)
		$"/root/World/Items/Items".removeItem(_id)
		$"/root/World".closeMenu(_additionalChoices)
		$"/root/World".processGameTurn()



########################
### Helper functions ###
########################

func dealWithTeleport(_critterId, _alignment, _itemType = "scroll"):
	var _world = $"/root/World"
	var _critter = get_node("/root/World/Critters/{critterId}".format({ "critterId": _critterId }))
	if _alignment.matchn("uncursed") or _alignment.matchn("blessed") or _itemType.matchn("wand"):
		var _playerPosition = _world.level.getCritterTile(_critter)
		var _level = _world.level
		var _openTiles = _level.openTiles.duplicate(true)
		for _openTile in _openTiles:
			var _randomTile = _openTiles[randi() % _openTiles.size()]
			if _level.isTileFreeOfCritters(_randomTile):
				_critter.moveCritter(_playerPosition, _randomTile, _critterId, _level)
				return true
			else:
				_openTiles.erase(_randomTile)
	elif _alignment.matchn("cursed"):
		var _randomDungeonPart = _world.levels.keys()[randi() % _world.levels.keys().size()]
		var _randomLevel
		if _randomDungeonPart.matchn("firstlevel"):
			_randomLevel = _world.levels[_randomDungeonPart]
		else:
			_randomLevel = _world.levels[_randomDungeonPart][randi() % _world.levels[_randomDungeonPart].size()]
		var _openTiles = _randomLevel.openTiles.duplicate(true)
		for _openTile in _openTiles:
			var _randomTile = _openTiles[randi() % _openTiles.size()]
			if _randomLevel.isTileFreeOfCritters(_randomTile):
				_world.goToLevel(_randomTile, _randomLevel)
				return true
			else:
				_openTiles.erase(_randomTile)
	return false

func dealWithScrollOfGenocide(_name, _alignment):
	if _alignment.matchn("blessed"):
		for _genocidableCritter in $"/root/World/Critters/Critters".critters[_name].critterTypes:
			for _critter in $"/root/World/Critters".get_children():
				if _critter.name.matchn("Critters"):
					continue
				if _critter.critterName.matchn(_genocidableCritter.critterName):
					_critter.despawn(null, false)
			GlobalCritterInfo.globalCritterInfo[_genocidableCritter.critterName].population = 0
			Globals.gameConsole.addLog("{critter} has been wiped out.".format({ "critter": _genocidableCritter.critterName.capitalize() }))
			GlobalGameStats.gameStats["Species genocided"] += 1
	elif _alignment.matchn("uncursed"):
		for _critter in $"/root/World/Critters".get_children():
			if _critter.name.matchn("Critters"):
				continue
			if _critter.critterName.matchn(_name):
				_critter.despawn(null, false)
		GlobalCritterInfo.globalCritterInfo[_name].population = 0
		Globals.gameConsole.addLog("{critter} has been wiped out.".format({ "critter": _name.capitalize() }))
		GlobalGameStats.gameStats["Species genocided"] += 1
	elif _alignment.matchn("cursed"):
		var _level = $"/root/World".level
		for _populationCount in range(GlobalCritterInfo.globalCritterInfo[_name].population):
			if !$"/root/World/Critters/Critters".spawnCritter(_name):
				break
		Globals.gameConsole.addLog("RUMMMMMBLE!!!")
	$"/root/World".closeMenu()

func dealWithWandOfWishing(_name, _alignment):
	if _alignment.matchn("blessed"):
		$"/root/World/Items/Items".createItem(_name, null, 1, true)
		Globals.gameConsole.addLog("An item appears in your inventory.")
	elif _alignment.matchn("cursed"):
		$"/root/World/Items/Items".createItem($"/root/World/Items/Items".getRandomItem(), $"/root/World".level.getCritterTile(0))
		Globals.gameConsole.addLog("An item appears at your feet... It doesn't seem to be what you wished for.")
	else:
		$"/root/World/Items/Items".createItem(_name, $"/root/World".level.getCritterTile(0))
		Globals.gameConsole.addLog("An item appears at your feet.")
	GlobalGameStats.gameStats["Items wished"] += 1
	$"/root/World".closeMenu()

func dealWithMarker(_scroll, _ink):
	if _ink.has("ink"):
		if _ink.ink < _ink.letters:
			Globals.gameConsole.addLog("You dont have enough ink to write that scroll.")
			return false
		elif _scroll.matchn("blank scroll"):
			Globals.gameConsole.addLog("You write a blank scroll... on the blank scroll.")
			$"/root/World/Items/Items".createItem(_scroll, null, 1, true)
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
			$"/root/World/Items/Items".createItem(_scroll, null, 1, true)
			Globals.gameConsole.addLog("You write {scroll} on a piece of blank paper.".format({ "scroll": _scroll }))
	else:
		$"/root/World/Items/Items".createItem(_scroll, null, 1, true)
		Globals.gameConsole.addLog("You write {scroll} on a piece of blank paper.".format({ "scroll": _scroll }))
	if get_node("/root/World/Items/{itemId}".format({ "itemId": _ink.blankPaper })).amount > 1:
		get_node("/root/World/Items/{itemId}".format({ "itemId": _ink.blankPaper })).amount -= 1
	else:
		$"/root/World/Items/Items".removeItem(_ink.blankPaper)
	$"/root/World".closeMenu()
	return true
