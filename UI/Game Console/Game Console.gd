extends MarginContainer

var consoleLog = []

func addLog(_log):
	consoleLog.append(_log)
	var label = Label.instance()
	label.text = "LMAAOOOOOOO"
	$GameConsoleScrollContainer/GameConsoleScroll.add_child(label)
