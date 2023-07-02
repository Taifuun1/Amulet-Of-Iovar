extends Panel

onready var defaultKeybinds = preload("res://Objects/Text/DefaultKeybinds.gd").new().defaultKeybinds

var changedAction = null
var changedActionKeybind = null
var shiftClick = ""

func _ready():
	var directory = Directory.new()
	if not directory.dir_exists("user://Keybinds"):
		$"/root/World/Save".saveData("Keybinds", "Keybinds", defaultKeybinds)
	setKeybinds($"/root/World/Save".loadData("Keybinds", "Keybinds"))

func setKeybind(_scancode, _action, _modifiers = []):
	var scancodeString = str(OS.get_scancode_string(_scancode))
	var newInput = InputEventKey.new()
	newInput.set_scancode(_scancode)
	for _modifier in _modifiers:
		if !_modifier.empty():
			newInput[_modifier] = true
			scancodeString = _modifier.capitalize() + " + " + scancodeString
	InputMap.action_add_event(_action, newInput)
	get_node("ControlsMenuScroll/ControlsMenuList/Item{actionName}/ItemButton".format({ "actionName": _action })).text = scancodeString

func setKeybinds(_keybindData):
	for _keybind in _keybindData:
		if typeof(_keybindData[_keybind]) == TYPE_DICTIONARY:
			setKeybind(_keybindData[_keybind].scancode, _keybind, _keybindData[_keybind].modifiers)
		elif typeof(_keybindData[_keybind]) == TYPE_ARRAY:
			for _keybindIteration in _keybindData[_keybind]:
				if typeof(_keybindIteration) == TYPE_DICTIONARY:
					pass
				else:
					setKeybind(_keybindIteration, _keybind)
		else:
			setKeybind(_keybindData[_keybind], _keybind)
	$"/root/World/Save".saveData("Keybinds", "Keybinds", _keybindData)

func resetControlsVariables():
	changedAction = null
	changedActionKeybind = null
	shiftClick = ""

func _reset_Keybinds(_event):
	if _event is InputEventMouseButton and _event.pressed and _event.button_index == BUTTON_LEFT:
		setKeybinds(defaultKeybinds)

func _on_Continue_gui_input(_event, _eventType):
	if _event is InputEventMouseButton and _event.pressed and _event.button_index == BUTTON_LEFT:
		match _eventType.to_lower():
			"continue":
				$"/root/World".resetToDefaulGameState()
				$"/root/World/UI/UITheme/PauseMenu".hide()
			"back":
				$PauseMenuList.show()
				$ControlsMenuScroll.hide()
			"controls":
				$PauseMenuList.hide()
				$ControlsMenuScroll.show()
			"codex":
				pass
			"save and exit":
				$"/root/World/UI/UITheme/PauseMenu".hide()
				$"/root/World".saveGameInThread()

func _On_Control_Change_Click(_event, _action):
	if changedAction == null and _event is InputEventMouseButton and _event.pressed and _event.button_index == BUTTON_LEFT:
		changedAction = _action
		changedActionKeybind = get_node("ControlsMenuScroll/ControlsMenuList/Item{actionName}/ItemButton".format({ "actionName": _action })).text
		get_node("ControlsMenuScroll/ControlsMenuList/Item{actionName}/ItemButton".format({ "actionName": _action })).text = "Click keybind"

func _input(_event):
	if Input.is_action_pressed("BACK"):
		if changedAction != null and $"/root/World".currentGameState == $"/root/World".gameState.PAUSED:
			get_node("ControlsMenuScroll/ControlsMenuList/Item{actionName}/ItemButton".format({ "actionName": changedAction })).text = str(changedActionKeybind)
		resetControlsVariables()
	elif (
		changedAction != null and
		_event is InputEventKey and
		!_event.echo and
		!Input.is_mouse_button_pressed(1) and
		!Input.is_mouse_button_pressed(2)
	):
		if _event.scancode == 16777237:
			shiftClick = "shift"
		else:
			if changedAction == "BACK":
				for _event in InputMap.get_action_list("BACK"):
					if !_event is InputEventMouse:
						InputMap.action_erase_event("BACK", _event)
			else:
				InputMap.action_erase_events(changedAction)
			setKeybind(_event.scancode, changedAction, [shiftClick])
			resetControlsVariables()
