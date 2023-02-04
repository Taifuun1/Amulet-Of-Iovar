extends Control

func _ready():
	name = "StartScreen"


func _on_Start_Button_pressed():
	if get_tree().change_scene("res://UI/Save Game Pick Screen/Save Game Pick Screen.tscn") != OK:
		push_error("Error changing to start screen.")

func _on_Games_Button_pressed():
	pass # Replace with function body.

func _on_Stats_Button_pressed():
	if get_tree().change_scene("res://UI/Stats Screen/Stats Screen.tscn") != OK:
		push_error("Error changing to start screen.")

func _on_Exit_Button_pressed():
	get_tree().quit()
