extends Control

var consoleLog = []

func create():
	createLabel("Welcome to Amulet of Iovar!")

func addLog(_log):
	createLabel(_log)

func createLabel(_text):
	var label = Label.new()
	label.text = _text
	label.set_autowrap(true)
	$Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.add_child(label)
	if $Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.get_child_count() >= 30:
		$Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.remove_child($Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.get_child(0))
	# Wait a frame for Godot to realize the new label
	yield(get_tree().create_timer(.01), "timeout")
	$Background/GameConsoleContainer/GameConsoleScrollContainer.scroll_vertical = $Background/GameConsoleContainer/GameConsoleScrollContainer.get_v_scrollbar().max_value

func createRichLabel(_text):
	var richLabel = RichTextLabel.new()
	richLabel.bbcode_enabled(true)
	richLabel.append_bbcode(_text)
	$Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.add_child(richLabel)
	updateGameConsole()

func updateGameConsole():
	if $Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.get_child_count() >= 30:
		$Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.remove_child($Background/GameConsoleContainer/GameConsoleScrollContainer/GameConsoleScroll.get_child(0))
	# Wait a frame for Godot to realize the new label
	yield(get_tree().create_timer(.01), "timeout")
	$Background/GameConsoleContainer/GameConsoleScrollContainer.scroll_vertical = $Background/GameConsoleContainer/GameConsoleScrollContainer.get_v_scrollbar().max_value

func getGameConsoleSaveData():
	var _consoleLogs = {}
	for _consoleLog in consoleLog.size():
		_consoleLogs[_consoleLog] = consoleLog[_consoleLog]
	return _consoleLogs
