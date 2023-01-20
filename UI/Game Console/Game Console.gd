extends Control

var consoleLog = []

func create():
	createLabel("Welcome to Amulet of Iovar!")

func addLog(_log, _critterName = null):
	if _critterName != null:
		createRichTextLabelExtended(_critterName, _log)
		return
	createLabel(_log)

func createLabel(_text):
	var label = Label.new()
	label.text = _text
	label.set_autowrap(true)
	$Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.add_child(label)
	consoleLog.append(_text)
	updateGameConsole()

func createRichTextLabelExtended(_critterName, _text):
	var _richTextLabelExtended = load("res://UI/RichTextLabel Extended/RichTextLabel Extended.tscn").instance()
	$Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.add_child(_richTextLabelExtended)
	_richTextLabelExtended.createRichTextLabelForGameConsole(_critterName, _text)
	consoleLog.append("{critterName}: {_text}".format({ "critterName": _critterName, "text": _text }))
	updateGameConsole()

func updateGameConsole():
	if $Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.get_child_count() >= 31:
		$Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.remove_child($Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.get_child(0))
		consoleLog.pop_front()
	
	# Wait a frame for Godot to realize the new label
	yield(get_tree().create_timer(.01), "timeout")
	$Background/GameConsoleContainer/GameConsoleScrollContainer.scroll_vertical = $Background/GameConsoleContainer/GameConsoleScrollContainer.get_v_scrollbar().max_value

func getGameConsoleSaveData():
	return consoleLog
