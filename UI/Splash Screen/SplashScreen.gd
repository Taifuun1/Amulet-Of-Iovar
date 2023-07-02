extends CenterContainer

func _ready():
	OS.center_window()


func _on_SplashScreen_timeout():
	if get_tree().change_scene("res://UI/Start Screen/StartScreen.tscn") != OK:
		push_error("Error changing to start screen.")
