extends MarginContainer

var skillPoints = 21

func _ready():
	$VBoxContainer/HBoxContainer2/VBoxContainer/StrengthContainer/Strength.text = String(Globals.skillPoints.Strength)
	$VBoxContainer/HBoxContainer2/VBoxContainer/LegerityContainer/Legerity.text = String(Globals.skillPoints.Legerity)
	$VBoxContainer/HBoxContainer2/VBoxContainer/BalanceContainer/Balance.text = String(Globals.skillPoints.Balance)
	$VBoxContainer/HBoxContainer2/VBoxContainer/BeliefContainer/Belief.text = String(Globals.skillPoints.Belief)
	$VBoxContainer/HBoxContainer2/VBoxContainer/TrincinContainer/Trincin.text = String(Globals.skillPoints.Trincin)
	$VBoxContainer/HBoxContainer2/VBoxContainer/WisdomContainer/Wisdom.text = String(Globals.skillPoints.Wisdom)

func _on_Race_Changed(_race):
	Globals.race = _race

func _on_Role_Changed(_role):
	Globals.role = _role

func _on_Stats_Changed(_stat):
	if(skillPoints > 0 and Globals.skillPoints[_stat] < 10):
		Globals.skillPoints[_stat] += 1
		skillPoints -= 1
		get_node("VBoxContainer/HBoxContainer2/VBoxContainer/{stat}Container/{stat}".format({ "stat": _stat })).text = String(Globals.skillPoints[_stat])

func _on_Begin_pressed():
	get_tree().change_scene("res://path/to/scene.tscn")
