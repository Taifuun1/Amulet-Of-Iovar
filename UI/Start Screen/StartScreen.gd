extends Control

func _ready():
	name = "StartScreen"


func _on_Start_Button_pressed():
	if get_tree().change_scene("res://UI/Save Game Pick Screen/SaveGamePickScreen.tscn") != OK:
		push_error("Error changing to start screen.")

func _on_Games_Button_pressed():
	if get_tree().change_scene("res://UI/Games Screen/GamesScreen.tscn") != OK:
		push_error("Error changing to start screen.")

func _on_Stats_Button_pressed():
	if get_tree().change_scene("res://UI/Stats Screen/StatsScreen.tscn") != OK:
		push_error("Error changing to start screen.")

func _on_Exit_Button_pressed():
	get_tree().quit()

func _on_ReportBug_pressed():
	return OS.shell_open("https://github.com/Taifuun1/Amulet-Of-Iovar/issues")
