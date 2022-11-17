extends Control

var className

func setLoadingText(_text):
	$DancingDragonsContainer/LoadingText.call_deferred("text", _text)


func startDancingDragons():
	# warning-ignore:return_value_discarded
#	$CharacterCreationContainer/Button.connect("pressed", $"/root/World", "_on_Game_Start", [className])
	$DancingDragonsPlayer.call_deferred("play", "Dancing Dragons")
	$DancingDragonsContainer.call_deferred("show")
#	$"/root/World"._on_Game_Start(className)
