extends Control

var className

func _ready():
	name = "StartScreen"

func setLoadingText(_text):
	$DancingDragonsContainer/LoadingText.text = _text


func _on_Start_Game_pressed():
	# warning-ignore:return_value_discarded
#	$CharacterCreationContainer/Button.connect("pressed", $"/root/World", "_on_Game_Start", [className])
	$DancingDragonsPlayer.play("Dancing Dragons")
	$DancingDragonsContainer.show()
	$CharacterCreationContainer.hide()
	$"/root/World"._on_Game_Start(className)

func _on_Classes_Pick_input_event(_viewport, _event, _shape_idx, _className):
	if Input.is_action_pressed("LEFT_CLICK"):
		className = _className
		$CharacterCreationContainer/Button.disabled = false



func _on_Start_Button_pressed():
	$CharacterCreationContainer.show()
	$StartContainer.hide()

func _on_Stats_Button_pressed():
	$StatsContainer.fillStatsList()
	$StatsContainer.show()
	$StartContainer.hide()

func _on_Back_Button_pressed():
	$StatsContainer.hide()
	$StartContainer.show()

func _on_Exit_Button_pressed():
	get_tree().quit()
