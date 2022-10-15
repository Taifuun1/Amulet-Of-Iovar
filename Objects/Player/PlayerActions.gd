extends Player



######################
### Player actions ###
######################

func readItem(_id):
	var _readItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _readItem.type.matchn("scroll"):
		Globals.gameConsole.addLog("You read a {itemName}.".format({ "itemName": _readItem.itemName }))
		if (
			GlobalItemInfo.globalItemInfo.has(_readItem.identifiedItemName) and
			GlobalItemInfo.globalItemInfo[_readItem.identifiedItemName].identified == false
		):
			GlobalItemInfo.globalItemInfo[_readItem.identifiedItemName].identified = true
			Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _readItem.identifiedItemName, "unidentifiedItemName": _readItem.unidentifiedItemName }))
		match _readItem.identifiedItemName.to_lower():
			"blank scroll":
				Globals.gameConsole.addLog("Its a blank scroll. Wow.")
			"official mail":
				Globals.gameConsole.addLog("Its a grocery list of milk, eggs and carrots. Riveting.")
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
									GlobalItemInfo.globalItemInfo[_itemInInventory.identifiedItemName].identified = true
									_itemInInventory.notIdentified.alignment = true
									_itemInInventory.notIdentified.enchantment = true
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
									GlobalItemInfo.globalItemInfo[_randomItemInInventory.identifiedItemName].identified = true
									_randomItemInInventory.notIdentified.alignment = true
									_randomItemInInventory.notIdentified.enchantment = true
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
									_itemInInventory.notIdentified.alignment = true
									_itemInInventory.notIdentified.enchantment = true
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
									_randomItemInInventory.notIdentified.alignment = true
									_randomItemInInventory.notIdentified.enchantment = true
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
					Globals.gameConsole.addLog("A {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.alignment.matchn("cursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					newItem.createItem($"/root/World/Items/Items".getItemByName("orange"))
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("An {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
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
					Globals.gameConsole.addLog("A {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
				elif _readItem.alignment.matchn("cursed"):
					var newItem = load("res://Objects/Item/Item.tscn").instance()
					newItem.createItem($"/root/World/Items/Items".getItemByName("potion of toxix"))
					$"/root/World/Items".add_child(newItem, true)
					$"/root/World".level.grid[_playerPosition.x][_playerPosition.y].items.append(newItem.id)
					Globals.gameConsole.addLog("An {itemName} appears at your feet.".format({ "itemName": newItem.itemName }))
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
						for _critterName in $"/root/World/Critters/Critters".critters[_critterRace].critterTypes:
							if GlobalCritterInfo.globalCritterInfo[_critterName.critterName].population != 0:
								_aliveCritters.append(_critterRace)
								break
				elif _readItem.alignment.matchn("uncursed") or _readItem.alignment.matchn("cursed"):
					for _critterName in GlobalCritterInfo.globalCritterInfo.keys():
						if GlobalCritterInfo.globalCritterInfo[_critterName].population != 0:
							_aliveCritters.append(_critterName)
				$"/root/World/UI/UITheme/ListMenu".showListMenuList("Genocide what?", _aliveCritters, _readItem.alignment)
				$"/root/World/UI/UITheme/ListMenu".show()
				_additionalChoices = true
			"scroll of teleport":
				if dealWithScrollOfTeleport(_readItem.alignment):
					Globals.gameConsole.addLog("Whoosh! You reappear somewhere!")
				else:
					Globals.gameConsole.addLog("It doesn't seem you have space to teleport...")
			_:
				Globals.gameConsole.addLog("Thats not a scroll...")
		checkAllItemsIdentification()
		if !_readItem.identifiedItemName.to_lower().matchn("blank scroll"):
			$"/root/World/Critters/0/Inventory".inventory.erase(_id)
			get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
	$"/root/World".closeMenu(_additionalChoices)

func dealWithScrollOfGenocide(_genocidableName, _alignment):
	if _alignment.matchn("blessed"):
		for _genocidableCritter in $"/root/World/Critters/Critters".critters[_genocidableName].critterTypes:
			for _critter in $"/root/World/Critters".get_children():
				if _critter.name == "Critters":
					continue
				if _critter.critterName == _genocidableCritter.critterName:
					_critter.despawn(null, false)
			GlobalCritterInfo.globalCritterInfo[_genocidableCritter.critterName].population = 0
			Globals.gameConsole.addLog("{critter} has been wiped out.".format({ "critter": _genocidableCritter.critterName.capitalize() }))
	if _alignment.matchn("uncursed"):
		for _critter in $"/root/World/Critters".get_children():
			if _critter.name == "Critters":
				continue
			if _critter.critterName == _genocidableName:
				_critter.despawn(null, false)
		GlobalCritterInfo.globalCritterInfo[_genocidableName].population = 0
		Globals.gameConsole.addLog("{critter} has been wiped out.".format({ "critter": _genocidableName.capitalize() }))
	if _alignment.matchn("cursed"):
		var _level = $"/root/World".level
		for _populationCount in range(GlobalCritterInfo.globalCritterInfo[_genocidableName].population):
			if !$"/root/World/Critters/Critters".spawnCritter(_genocidableName):
				break
		Globals.gameConsole.addLog("RUMMMMMBLE!!!")
	$"/root/World".closeMenu()

func dealWithScrollOfTeleport(_alignment):
	var _world = $"/root/World"
	if _alignment.matchn("uncursed") or _alignment.matchn("blessed"):
		var _playerPosition = _world.level.getCritterTile(0)
		var _level = _world.level
		var _openTiles = _level.openTiles.duplicate(true)
		for _openTile in _openTiles:
			var _randomTile = _openTiles[randi() % _openTiles.size()]
			if _level.isTileFreeOfCritters(_randomTile):
				$"/root/World/Critters/0".moveCritter(_playerPosition, _randomTile, 0, _level)
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

func quaffItem(_id):
	var _quaffedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _quaffedItem.type.matchn("potion"):
		Globals.gameConsole.addLog("You quaff a {itemName}.".format({ "itemName": _quaffedItem.itemName }))
		if (
			GlobalItemInfo.globalItemInfo.has(_quaffedItem.identifiedItemName) and
			GlobalItemInfo.globalItemInfo[_quaffedItem.identifiedItemName].identified == false
		):
			GlobalItemInfo.globalItemInfo[_quaffedItem.identifiedItemName].identified = true
			Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _quaffedItem.identifiedItemName, "unidentifiedItemName": _quaffedItem.unidentifiedItemName }))
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
					calories += 100
					Globals.gameConsole.addLog("You feel nourished.")
				if _quaffedItem.alignment.matchn("uncursed"):
					calories += -150
					Globals.gameConsole.addLog("You feel malnourished.")
				if _quaffedItem.alignment.matchn("cursed"):
					calories += -400
					Globals.gameConsole.addLog("You feel like you lost half your weight!")
			_:
				Globals.gameConsole.addLog("Thats not a potion...")
		checkAllItemsIdentification()
		$"/root/World/Critters/0/Inventory".inventory.erase(_id)
		get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
	$"/root/World".closeMenu(_additionalChoices)

func consumeItem(_id):
	var _eatenItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	if _eatenItem.type.matchn("comestible"):
		calories += _eatenItem.value
		checkAllItemsIdentification()
		$"/root/World/Critters/0/Inventory".inventory.erase(_id)
		get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
		Globals.gameConsole.addLog("You eat the {comestible}.".format({ "comestible": _eatenItem.itemName }))
	$"/root/World".closeMenu()

func zapItem(_id):
	var _zappedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _zappedItem.type.matchn("wand"):
		Globals.gameConsole.addLog("You zap the {itemName}.".format({ "itemName": _zappedItem.itemName }))
		if (
			GlobalItemInfo.globalItemInfo.has(_zappedItem.identifiedItemName) and
			GlobalItemInfo.globalItemInfo[_zappedItem.identifiedItemName].identified == false
		):
			GlobalItemInfo.globalItemInfo[_zappedItem.identifiedItemName].identified = true
			Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _zappedItem.identifiedItemName, "unidentifiedItemName": _zappedItem.unidentifiedItemName }))
		if _zappedItem.value.charges > 0:
			match _zappedItem.identifiedItemName.to_lower():
				"wand of summon critter":
					var _playerPosition = $"/root/World".level.getCritterTile(0)
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
				"wand of backwards magic sphere":
					var _playerPosition = $"/root/World".level.getCritterTile(0)
					if _zappedItem.alignment.matchn("blessed"):
						Globals.gameConsole.addLog("{itemName} somehow misses you!".format({ "itemName": _zappedItem.itemName }))
					elif _zappedItem.alignment.matchn("uncursed"):
						takeDamage([8], "Wand of backwards magic sphere", _playerPosition)
						Globals.gameConsole.addLog("{itemName} hits you!".format({ "itemName": _zappedItem.itemName }))
					elif _zappedItem.alignment.matchn("cursed"):
						takeDamage([18], "Wand of backwards magic sphere", _playerPosition)
						Globals.gameConsole.addLog("{itemName} knocks the wind out of you!".format({ "itemName": _zappedItem.itemName }))
				_:
					Globals.gameConsole.addLog("Thats not a wand...")
			_zappedItem.value.charges -= 1
			checkAllItemsIdentification()
		else:
			Globals.gameConsole.addLog("The wand seems a little flaccid. There's no charges left.")
	$"/root/World".closeMenu()

func useItem(_id):
	var _usedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _additionalChoices = false
	if _usedItem.type.matchn("tool"):
		if (
			GlobalItemInfo.globalItemInfo.has(_usedItem.identifiedItemName) and
			GlobalItemInfo.globalItemInfo[_usedItem.identifiedItemName].identified == false
		):
			GlobalItemInfo.globalItemInfo[_usedItem.identifiedItemName].identified = true
			Globals.gameConsole.addLog("{unidentifiedItemName} is a {identifiedItemName}!".format({ "identifiedItemName": _usedItem.identifiedItemName, "unidentifiedItemName": _usedItem.unidentifiedItemName }))
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
				var _newItem = $"/root/World/Items/Items".getRandomItem("scroll")
				$"/root/World/Items/Items".createItem(_newItem, null, 1, true)
				$"/root/World/Critters/0/Inventory".inventory.erase(_id)
				get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
				Globals.gameConsole.addLog("You pull a {itemName} out of the bottle.".format({ "itemName": _newItem.itemName }))
			_:
				Globals.gameConsole.addLog("Thats not a tool...")
		checkAllItemsIdentification()
	$"/root/World".closeMenu()
