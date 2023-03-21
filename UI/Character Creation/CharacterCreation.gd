extends Control

onready var playableClasses = preload("res://Objects/Player/PlayableClasses.gd").new()

func _on_Classes_Pick_input(_event, _className):
	if Input.is_action_pressed("LEFT_CLICK"):
		if StartingData.selectedClass != null and !StartingData.selectedClass.match(_className):
			var panelStylebox = get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": StartingData.selectedClass })).get_stylebox("panel").duplicate()
			panelStylebox.set_border_color(Color("0b103b"))
			get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": StartingData.selectedClass })).add_stylebox_override("panel", panelStylebox)
		StartingData.selectedClass = _className
		var panelStylebox = get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": _className })).get_stylebox("panel").duplicate()
		panelStylebox.set_border_color(Color("3b4284"))
		get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": _className })).add_stylebox_override("panel", panelStylebox)
		$CharacterCreationContainer/CenterContainer/VBoxContainer/StartButton.disabled = false
		
		var _classData = playableClasses[(StartingData.selectedClass[0].to_lower() + StartingData.selectedClass.substr(1,-1)).replace(" ", "")]
		
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/BaseStatsContainer/HpContainer/DataText.text = str(_classData.hp)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/BaseStatsContainer/MpContainer/DataText.text = str(_classData.mp)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/BaseStatsContainer/StrengthContainer/DataText.text = str(_classData.stats.strength)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/BaseStatsContainer/LegerityContainer/DataText.text = str(_classData.stats.legerity)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/BaseStatsContainer/BalanceContainer/DataText.text = str(_classData.stats.balance)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/BaseStatsContainer/BeliefContainer/DataText.text = str(_classData.stats.belief)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/BaseStatsContainer/VisageContainer/DataText.text = str(_classData.stats.visage)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/BaseStatsContainer/WisdomContainer/DataText.text = str(_classData.stats.wisdom)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/StatsIncreaseContainer/HpContainer/DataText.text = str(_classData.hpIncrease)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/StatsIncreaseContainer/MpContainer/DataText.text = str(_classData.mpIncrease)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/StatsIncreaseContainer/StrengthContainer/DataText.text = str(_classData.strengthIncrease)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/StatsIncreaseContainer/LegerityContainer/DataText.text = str(_classData.legerityIncrease)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/StatsIncreaseContainer/BalanceContainer/DataText.text = str(_classData.balanceIncrease)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/StatsIncreaseContainer/BeliefContainer/DataText.text = str(_classData.beliefIncrease)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/StatsIncreaseContainer/VisageContainer/DataText.text = str(_classData.visageIncrease)
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/StatsContainer/StatsIncreaseContainer/WisdomContainer/DataText.text = str(_classData.wisdomIncrease)
		
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/RaceContainer/PanelContainer/ClassDataContainer/DataText.text = _classData.race
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/JusticeContainer/PanelContainer/ClassDataContainer/DataText.text = _classData.justice
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/SkillContainer/PanelContainer/ClassDataContainer/DataText.text = _classData.skill
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/QuoteContainer/PanelContainer/ClassDataContainer/DataText.text = _classData.quote
		var _resistances = ""
		var _resistancesArray = _classData.resistances.duplicate(true)
		while true:
			var _resistance = _resistancesArray.pop_front()
			if _resistance == null:
				_resistances.erase(_resistances.length() - 2, 2)
				break
			_resistances += "%s, " % _resistance.capitalize()
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/ResistancesContainer/PanelContainer/ClassDataContainer/DataText.text = _resistances
		var _neutralClasses = ""
		var _neutralClassesArray = _classData.neutralClasses.duplicate(true)
		while true:
			var _neutralClass = _neutralClassesArray.pop_front()
			if _neutralClass == null:
				_neutralClasses.erase(_neutralClasses.length() - 2, 2)
				break
			_neutralClasses += "%s, " % _neutralClass.capitalize()
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/NeutralClassesContainer/PanelContainer/ClassDataContainer/DataText.text = _neutralClasses
		$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/GoldPiecesContainer/PanelContainer/ClassDataContainer/DataText.text = str(_classData.goldPieces)
		
		for _node in $CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/ClassDataListsContainer/ClassDataListsContainer/ClassDataListsContainer/StartingItemsContainer/StartingItemsScroll/StartingItemsList.get_children():
			_node.queue_free()
		for _node in $CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/ClassDataListsContainer/ClassDataListsContainer/ClassDataListsContainer/SkillsContainer/SkillsScroll/SkillsList.get_children():
			_node.queue_free()
		for _item in _classData.items:
			var _listItem = load("res://UI/Character Creation/StartingItem.tscn").instance()
			_listItem.setValues(_item, _classData.items[_item])
			$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/ClassDataListsContainer/ClassDataListsContainer/ClassDataListsContainer/StartingItemsContainer/StartingItemsScroll/StartingItemsList.add_child(_listItem)
		
		for _skill in _classData.skills:
			var _listItem = load("res://UI/Character Creation/Skill.tscn").instance()
			_listItem.setValues(_skill, _classData.skills[_skill].level, _classData.skills[_skill].skillcap)
			$CharacterCreationContainer/ClassesContentContainer/VBoxContainer/Panel/VBoxContainer/VBoxContainer/ClassDataListsContainer/ClassDataListsContainer/ClassDataListsContainer/SkillsContainer/SkillsScroll/SkillsList.add_child(_listItem)

func _on_Classes_Pick_mouse_entered(_className):
	if StartingData.selectedClass != null and _className.matchn(StartingData.selectedClass):
		var panelStylebox = get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": _className })).get_stylebox("panel").duplicate()
		panelStylebox.set_border_color(Color("3b4284"))
		get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": _className })).add_stylebox_override("panel", panelStylebox)
	else:
		var panelStylebox = get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": _className })).get_stylebox("panel").duplicate()
		panelStylebox.set_border_color(Color("181e57"))
		get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": _className })).add_stylebox_override("panel", panelStylebox)

func _on_Classes_Pick_mouse_exited(_className):
	if StartingData.selectedClass != null and _className.matchn(StartingData.selectedClass):
		var panelStylebox = get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": _className })).get_stylebox("panel").duplicate()
		panelStylebox.set_border_color(Color("3b4284"))
		get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": _className })).add_stylebox_override("panel", panelStylebox)
	else:
		var panelStylebox = get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": _className })).get_stylebox("panel").duplicate()
		panelStylebox.set_border_color(Color("0b103b"))
		get_node("CharacterCreationContainer/ClassesContentContainer/ClassesContainer/{className}".format({ "className": _className })).add_stylebox_override("panel", panelStylebox)

func _on_Start_Button_pressed():
	$CharacterCreationContainer/CenterContainer/VBoxContainer/StartButton.disabled = true
	if get_tree().change_scene("res://Objects/World/World.tscn") != OK:
		push_error("Error changing to character world.")

func _on_Back_Button_pressed():
	StartingData.selectedClass = null
	if get_tree().change_scene("res://UI/Save Game Pick Screen/SaveGamePickScreen.tscn") != OK:
		push_error("Error changing to character creation screen.")
