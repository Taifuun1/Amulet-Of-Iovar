extends Control

func _on_Button_pressed():
	$"/root/World"._debug__go_to_level(int($DebugMenuContainer/LineEdit.text))
