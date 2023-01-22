extends Panel

func _on_Continue_gui_input(_event, _eventType):
	if Input.is_action_pressed("LEFT_CLICK"):
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
