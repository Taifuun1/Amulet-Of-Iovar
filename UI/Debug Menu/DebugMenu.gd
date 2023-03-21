extends Control

func showMenu():
	show()
	$DebugMenuPopup.show()

func _on_Go_pressed():
	$"/root/World".__debug__go_to_level(int($DebugMenuPopup/DebugMenuContainer/LineEdit.text))

func _on_Hide_pressed():
	hide()
	$DebugMenuPopup.hide()
