extends MarginContainer

var statsData = load("res://Objects/Miscellaneous/StatsData.gd").new()

var statsList = load("res://UI/Stats/Stats List.tscn")

func fillStatsList():
#	var dir = Directory.new()
#	dir.remove("user://lifetimeStats.json")
#	dir.remove("user://items.json")
#	dir.remove("user://critters.json")
	
	var _lifetimeList = statsList.instance()
	_lifetimeList.create("Lifetime stats", $"/root/World/Save".loadDataLifeTimeStats("lifetimeStats", statsData.lifetimeStats))
	$VBoxContainer/ScrollContainer/VBoxContainer.add_child(_lifetimeList)
	
	var _itemList = statsList.instance()
	_itemList.create("Item knowledge", $"/root/World/Save".loadDataLifeTimeStats("items", statsData.items))
	$VBoxContainer/ScrollContainer/VBoxContainer.add_child(_itemList)
	
	var _critterList = statsList.instance()
	_critterList.create("Critter knowledge", $"/root/World/Save".loadDataLifeTimeStats("critters", statsData.critters))
	$VBoxContainer/ScrollContainer/VBoxContainer.add_child(_critterList)
