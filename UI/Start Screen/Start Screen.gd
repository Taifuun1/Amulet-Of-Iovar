extends Control

func _ready():
	name = "StartScreen"
	$UI/StartContainer/Button.connect("pressed", $"/root/World", "_on_Game_Start")

func _on_Start_Button_pressed():
	$DancingDragonsPlayer.play("Dancing Dragons")
	$UI/DancingDragonsContainer.show()
	$UI/StartContainer.hide()