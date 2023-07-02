extends Control

onready var dialogMenuDialogs = preload("res://Objects/Text/DialogMenuDialogs.gd").new()

func create():
	name = "DialogMenu"
	hide()

func setText(_dialogEvent):
	var _dialog = dialogMenuDialogs.dialogMenuDialogs[_dialogEvent]
	$DialogContainer/Title.clear()
	$DialogContainer/Title.append_bbcode(_dialog.title)
	$DialogContainer/ScrollContainer/Text.clear()
	$DialogContainer/ScrollContainer/Text.append_bbcode(_dialog.text)
	$"/root/World".currentGameState = $"/root/World".gameState.OUT_OF_PLAYERS_HANDS
	show()

func _on_Accept_Button_pressed():
	$"/root/World".currentGameState = $"/root/World".gameState.GAME
	hide()
