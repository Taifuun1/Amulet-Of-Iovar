extends Control

func _ready():
	addResistance("MR")
	addResistance("SR")
	addResistance("CC")

func updateStats(stats = {
	maxhp = null,
	hp = null,
	maxmp = null,
	mp = null,
	level = null,
	critterName = null,
	race = null,
	alignment = null,
	ac = null,
	attacks = null,
	currentHit = null,
	hits = null,
	dungeonLevel = null
}):
	if stats.maxhp != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/HPContainer/HPAmount.max_value = stats.maxhp
	if stats.hp != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/HPContainer/HP.text = str(stats.hp)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/HPContainer/HPAmount.value = stats.hp
	if stats.maxmp != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/MPContainer/MPAmount.max_value = stats.maxmp
	if stats.mp != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/MPContainer/MP.text = str(stats.mp)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/MPContainer/MPAmount.value = stats.mp
	if stats.level != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/LevelContainer/Level.text = str(stats.level)
	if stats.critterName != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/CritterNameContainer/CritterName.text = str(stats.critterName)
	if stats.race != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/RaceContainer/Race.text = str(stats.race)
	if stats.alignment != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/AlignmentContainer/Alignment.text = str(stats.alignment)
	if stats.ac != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/ACContainer/AC.text = str(stats.ac)
#	if stats.alignment != null:
#		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/AlignmentContainer/Alignment.text = str(stats.alignment)
#	if stats.alignment != null:
#		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/AlignmentContainer/Alignment.text = str(stats.alignment)
	if stats.dungeonLevel != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/DungeonLevelContainer/DungeonLevel.text = str(stats.dungeonLevel)

func addResistance(_resistance):
#	var label = RichTextLabel.new()
	var label = Label.new()
	label.text = _resistance
#	label.syntax_highlighting(true)
	label.add_color_override("font_color", Color8(0,128,0))
#	label.add_color_override("background_color", Color8(0,255,0))
#	syntax_highlighting [default: false]set_syntax_coloring(value) setteris_syntax_coloring_enabled() getter

#	label.set("custom_colors/background_color",Color8(0,0,255))
	
#	my_style.set_bg_color(Color(0,1,1,1))
#	label.set_bg_color(Color8(0,255,0))
	$Background/GameStatsContainer/GameStatsColumns/ResistancesContainer.add_child(label)
	
	# Set the "normal" style to be your newly created style.
#	set("custom_styles/normal", my_style)
