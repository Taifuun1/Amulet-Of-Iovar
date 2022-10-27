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
				$"/root/World/UI/UITheme/ListMenu".show()
				_additionalChoices = true
			"scroll of teleport":
				if dealWithTeleport(0, _readItem.alignment):
					Globals.gameConsole.addLog("Whoosh! You reappear somewhere!")
				else:
					Globals.gameConsole.addLog("It doesn't seem you have space to teleport...")
			"scroll of confusion":
				if statusEffects.confusion != -1:
					if _readItem.alignment.matchn("blessed"):
						statusEffects.confusion = 4
						Globals.gameConsole.addLog("You feel slightly disoriented.")
					elif _readItem.alignment.matchn("blessed"):
						statusEffects.confusion = 10
						Globals.gameConsole.addLog("You feel confused.")
					elif _readItem.alignment.matchn("blessed"):
						statusEffects.confusion = 22
						Globals.gameConsole.addLog("The world spins!")
				else:
					Globals.gameConsole.addLog("You already feel confused enough!")
			_:
				Globals.gameConsole.addLog("Thats not a scroll...")
		checkAllItemsIdentification()
		if !_readItem.identifiedItemName.to_lower().matchn("blank scroll"):
			$"/root/World/Critters/0/Inventory".inventory.erase(_id)
			get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
	$"/root/World".closeMenu(_additionalChoices)

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
						statusEffects.confusion = 10
						Globals.gameConsole.addLog("You feel confused.")
					elif _quaffedItem.alignment.matchn("cursed"):
						statusEffects.confusion = 22
						Globals.gameConsole.addLog("The world spins!")
				else:
					Globals.gameConsole.addLog("You already feel confused enough!")
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

func zapItem(_direction):
	var _playerPosition = $"/root/World".level.getCritterTile(0)
	var _zappedItem = get_node("/root/World/Items/{id}".format({ "id": selectedItem }))
	selectedItem = null
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
				"wand of light":
					if _zappedItem.alignment.matchn("blessed"):
						playerVisibility = {
							"distance": 10,
							"duration": 20
						}
						Globals.gameConsole.addLog("The light illuminates your surroundings brightly!")
					elif _zappedItem.alignment.matchn("uncursed"):
						playerVisibility = {
							"distance": 7,
							"duration": 15
						}
						Globals.gameConsole.addLog("The light illuminates your surroundings.")
					elif _zappedItem.alignment.matchn("cursed"):
						playerVisibility = {
							"distance": 4,
							"duration": 10
						}
						Globals.gameConsole.addLog("The light illuminates your surroundings dimly.")
					$"/root/World".drawLevel()
				"wand of teleport":
					var _grid = $"/root/World".level.grid
#					if _zappedItem.alignment.matchn("blessed"):
					for i in range(1, 7):
						if !Globals.isTileFree(_playerPosition + _direction * i, _grid) or _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].tile == Globals.tiles.DOOR_CLOSED:
							break
						if _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].critter != null:
							dealWithTeleport(_grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].critter, _zappedItem.alignment, _zappedItem.type)
							Globals.gameConsole.addLog("The {critterName} disappears!".format({ "critterName": get_node("/root/World/Critters/{critterId}".format({ "critterId": _grid[(_playerPosition + _direction * i).x][(_playerPosition + _direction * i).y].critter })).critterName }))
							break
#					elif _zappedItem.alignment.matchn("uncursed"):
#						dealWithTeleport(_zappedItem.id, _zappedItem.alignment, _zappedItem.type)
#						Globals.gameConsole.addLog("The light illuminates your surroundings.")
#					elif _zappedItem.alignment.matchn("cursed"):
#						dealWithTeleport(_zappedItem.id, _zappedItem.alignment, _zappedItem.type)
#						Globals.gameConsole.addLog("The light illuminates your surroundings dimly.")
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
				"wand of backwards magic sphere":
					if _zappedItem.alignment.matchn("blessed"):
						Globals.gameConsole.addLog("{itemName} somehow misses you!".format({ "itemName": _zappedItem.itemName }))
					elif _zappedItem.alignment.matchn("uncursed"):
						takeDamage([
							{
								"dmg": [8,12],
								"bonusDmg": {},
								"armorPen": 0,
								"magicDmg": {
									"dmg": 0,
									"element": null
								}
							}
						], "Wand of backwards magic sphere", _playerPosition)
						Globals.gameConsole.addLog("{itemName} hits you!".format({ "itemName": _zappedItem.itemName }))
					elif _zappedItem.alignment.matchn("cursed"):
						takeDamage([
							{
								"dmg": [18,22],
								"bonusDmg": {},
								"armorPen": 0,
								"magicDmg": {
									"dmg": 0,
									"element": null
								}
							}
						], "Wand of backwards magic sphere", _playerPosition)
						Globals.gameConsole.addLog("{itemName} knocks the wind out of you!".format({ "itemName": _zappedItem.itemName }))
				"wand of item polymorph":
					var _grid = $"/root/World".level.grid
					for i in range(1, 6):
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
									continue
								Globals.gameConsole.addLog("Items on the ground vibrate.")
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
				"wand of wishing":
					var _itemTypes = []
#					if _readItem.alignment.matchn("blessed"):
					for _type in $"/root/World/Items/Items".items:
						_itemTypes.append(_type)
#					elif _readItem.alignment.matchn("uncursed") or _readItem.alignment.matchn("cursed"):
#						for _critterName in GlobalCritterInfo.globalCritterInfo.keys():
#							if GlobalCritterInfo.globalCritterInfo[_critterName].population != 0:
#								_aliveCritters.append(_critterName)
					$"/root/World/UI/UITheme/ListMenu".showListMenuList("Wish for what item type?", _itemTypes, _zappedItem, true)
					$"/root/World/UI/UITheme/ListMenu".show()
					_additionalChoices = true
				_:
					Globals.gameConsole.addLog("Thats not a wand...")
			_zappedItem.value.charges -= 1
			checkAllItemsIdentification()
		else:
			Globals.gameConsole.addLog("The wand seems a little flaccid. There's no charges left.")
	$"/root/World".closeMenu(_additionalChoices)

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
				var _newItem = $"/root/World/Items/Items".getRandomItemByItemTypes(["scroll"], true)
				$"/root/World/Items/Items".createItem(_newItem, null, 1, true)
				$"/root/World/Critters/0/Inventory".inventory.erase(_id)
				get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
				Globals.gameConsole.addLog("You pull a {itemName} out of the bottle.".format({ "itemName": _newItem.itemName }))
			_:
				Globals.gameConsole.addLog("Thats not a tool...")
		checkAllItemsIdentification()
		$"/root/World".closeMenu()

func dipItem(_id):
	var _dippedItem = get_node("/root/World/Items/{id}".format({ "id": _id }))
	var _selectedItem
	if selectedItem != null:
		_selectedItem = get_node("/root/World/Items/{id}".format({ "id": selectedItem }))
	var _additionalChoices = false
	if !_dippedItem.type.matchn("potion"):
		$"/root/World/UI/UITheme/ItemManagement".hideItemManagementList()
		$"/root/World/UI/UITheme/ItemManagement".items = $"/root/World/Critters/0/Inventory".getItemsOfType(["potion"])
		$"/root/World/UI/UITheme/ItemManagement".showItemManagementList(true)
		$"/root/World".currentGameState = $"/root/World".gameState.DIP
	elif _dippedItem.type.matchn("potion"):
		match _dippedItem.identifiedItemName.to_lower():
			"water potion":
				if _dippedItem.alignment.matchn("blessed"):
					_selectedItem.alignment = "blessed"
					Globals.gameConsole.addLog("The {itemName} glows with a white light!".format({ "itemName": _selectedItem.itemName }))
				elif _dippedItem.alignment.matchn("uncursed"):
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
			"potion of invisibility":
				Globals.gameConsole.addLog("The {itemName} looks transparent.".format({ "itemName": _selectedItem.itemName }))
			_:
				Globals.gameConsole.addLog("You soak the {itemName} into the potion. Nothing happens.".format({ "itemName": _selectedItem.itemName }))
		selectedItem = null
		checkAllItemsIdentification()
		$"/root/World/Critters/0/Inventory".inventory.erase(_id)
		get_node("/root/World/Items/{id}".format({ "id": _id })).queue_free()
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
				if _critter.critterName == _genocidableCritter.critterName:
					_critter.despawn(null, false)
			GlobalCritterInfo.globalCritterInfo[_genocidableCritter.critterName].population = 0
			Globals.gameConsole.addLog("{critter} has been wiped out.".format({ "critter": _genocidableCritter.critterName.capitalize() }))
	if _alignment.matchn("uncursed"):
		for _critter in $"/root/World/Critters".get_children():
			if _critter.name.matchn("Critters"):
				continue
			if _critter.critterName.matchn(_name):
				_critter.despawn(null, false)
		GlobalCritterInfo.globalCritterInfo[_name].population = 0
		Globals.gameConsole.addLog("{critter} has been wiped out.".format({ "critter": _name.capitalize() }))
	if _alignment.matchn("cursed"):
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
		Globals.gameConsole.addLog("An item appears at your feet.")
	else:
		$"/root/World/Items/Items".createItem(_name, $"/root/World".level.getCritterTile(0))
		Globals.gameConsole.addLog("An item appears at your feet... It doesn't seem to be what you wished for.")
	$"/root/World".closeMenu()
