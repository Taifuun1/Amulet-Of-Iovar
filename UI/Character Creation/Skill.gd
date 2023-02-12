extends VBoxContainer

func setValues(_skill, _level, _skillcap):
	$SkillTitle.text = str(_skill.capitalize())
	$LevelContainer/Level.text = str(_level)
	$SkillcapContainer/Skillcap.text = str(_skillcap)
	
