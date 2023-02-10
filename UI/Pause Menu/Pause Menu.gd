extends Panel

func _on_Continue_gui_input(event, _eventType):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
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
