extends CenterContainer


func _on_SplashScreen_timeout():
	if get_tree().change_scene("res://UI/Start Screen/Start Screen.tscn") != OK:
		push_error("Error changing to start screen.")
