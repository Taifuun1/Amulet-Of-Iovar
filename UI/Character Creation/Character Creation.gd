extends Control

func _on_Classes_Pick_input(_event, _className):
	if Input.is_action_pressed("LEFT_CLICK"):
		if StartingData.selectedClass != null and !StartingData.selectedClass.match(_className):
			var panelStylebox = get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": StartingData.selectedClass })).get_stylebox("panel").duplicate()
			panelStylebox.set_border_color(Color("0b103b"))
			get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": StartingData.selectedClass })).add_stylebox_override("panel", panelStylebox)
		StartingData.selectedClass = _className
		var panelStylebox = get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": _className })).get_stylebox("panel").duplicate()
		panelStylebox.set_border_color(Color("3b4284"))
		get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": _className })).add_stylebox_override("panel", panelStylebox)
		$CharacterCreationContainer/CenterContainer/VBoxContainer/StartButton.disabled = false

func _on_Classes_Pick_mouse_entered(_className):
	if StartingData.selectedClass != null and _className.matchn(StartingData.selectedClass):
		var panelStylebox = get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": _className })).get_stylebox("panel").duplicate()
		panelStylebox.set_border_color(Color("3b4284"))
		get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": _className })).add_stylebox_override("panel", panelStylebox)
	else:
		var panelStylebox = get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": _className })).get_stylebox("panel").duplicate()
		panelStylebox.set_border_color(Color("181e57"))
		get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": _className })).add_stylebox_override("panel", panelStylebox)

func _on_Classes_Pick_mouse_exited(_className):
	if StartingData.selectedClass != null and _className.matchn(StartingData.selectedClass):
		var panelStylebox = get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": _className })).get_stylebox("panel").duplicate()
		panelStylebox.set_border_color(Color("3b4284"))
		get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": _className })).add_stylebox_override("panel", panelStylebox)
	else:
		var panelStylebox = get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": _className })).get_stylebox("panel").duplicate()
		panelStylebox.set_border_color(Color("0b103b"))
		get_node("CharacterCreationContainer/ClassesContainer/{className}".format({ "className": _className })).add_stylebox_override("panel", panelStylebox)

func _on_Start_Button_pressed():
	$CharacterCreationContainer/CenterContainer/VBoxContainer/StartButton.disabled = true
	if get_tree().change_scene("res://Objects/World/World.tscn") != OK:
		push_error("Error changing to character world.")

func _on_Back_Button_pressed():
	StartingData.selectedClass = null
	if get_tree().change_scene("res://UI/Save Game Pick Screen/Save Game Pick Screen.tscn") != OK:
		push_error("Error changing to character creation screen.")
