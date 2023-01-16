extends Control

var statsList = load("res://UI/Stats/Stats List.tscn")


func _ready():
	var _lifetimeList = statsList.instance()
	
	var _lifeTimeStats = GlobalSave.saveAndloadLifeTimeStats("LifeTimeStats")
	_lifetimeList.create("Lifetime stats", _lifeTimeStats)
	$StatsContainer/VBoxContainer/ScrollContainer/VBoxContainer.add_child(_lifetimeList)
	
	var _itemList = statsList.instance()
	_itemList.create("Item knowledge", GlobalSave.saveAndloadLifeTimeStats("Items"))
	$StatsContainer/VBoxContainer/ScrollContainer/VBoxContainer.add_child(_itemList)
	
	var _critterList = statsList.instance()
	_critterList.create("Critter knowledge", GlobalSave.saveAndloadLifeTimeStats("Critters"))
	$StatsContainer/VBoxContainer/ScrollContainer/VBoxContainer.add_child(_critterList)



func _on_Back_Button_pressed():
	if get_tree().change_scene("res://UI/Start Screen/Start Screen.tscn") != OK:
		push_error("Error changing to start screen.")
