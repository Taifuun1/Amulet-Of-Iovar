extends VBoxContainer

func setValues(_skill, _level, _skillcap):
	$Skill.text = str(_skill.capitalize())
	$HBoxContainer/Level.text = str(_level)
	$HBoxContainer2/Skillcap.text = str(_skillcap)
	
