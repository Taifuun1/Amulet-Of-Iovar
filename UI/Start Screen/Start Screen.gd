extends Control

func _ready():
	name = "StartScreen"
	# warning-ignore:return_value_discarded
	$StartContainer/Button.connect("pressed", $"/root/World", "_on_Game_Start")

func setLoadingText(_text):
	$DancingDragonsContainer/LoadingText.text = _text

func _on_Start_Button_pressed():
	$DancingDragonsPlayer.play("Dancing Dragons")
	$DancingDragonsContainer.show()
	$StartContainer.hide()
