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
	experiencePoints = null,
	experienceLevelGainAmount = null,
	critterName = null,
	race = null,
	alignment = null,
	ac = null,
	attacks = null,
	currentHit = null,
	hits = null,
	dungeonLevel = null,
	weight = null,
	weightBounds = null,
	strength = null,
	legerity = null,
	balance = null,
	belief = null,
	visage = null,
	wisdom = null
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
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/LevelContainer/Level.set_tooltip(str(stats.level))
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/ExperienceContainer/Experience.text = str(stats.experiencePoints) + "/" + str(stats.experienceLevelGainAmount)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/ExperienceContainer/Experience.set_tooltip("First value is your current exp, second value is next level\n" + str(stats.experiencePoints) + "/" + str(stats.experienceLevelGainAmount))
	if stats.critterName != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/NameContainer/Name.text = str(stats.critterName)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/NameContainer/Name.set_tooltip(str(stats.critterName))
	if stats.race != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/RaceContainer/Race.text = str(stats.race)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/RaceContainer/Race.set_tooltip(str(stats.race))
	if stats.alignment != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/AlignmentContainer/Alignment.text = str(stats.alignment)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/AlignmentContainer/Alignment.set_tooltip(str(stats.alignment))
	if stats.ac != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/ACContainer/AC.text = str(stats.ac)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/ACContainer/AC.set_tooltip(str(stats.ac))
#	if stats.alignment != null:
#		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/AlignmentContainer/Alignment.text = str(stats.alignment)
#	if stats.alignment != null:
#		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/AlignmentContainer/Alignment.text = str(stats.alignment)
	if stats.dungeonLevel != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/DungeonLevelContainer/DungeonLevel.text = str(stats.dungeonLevel)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/DungeonLevelContainer/DungeonLevel.set_tooltip(str(stats.dungeonLevel))
	if stats.weight != null and stats.weightBounds != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/WeightContainer/Weigth.value = stats.weight
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/WeightContainer/Weigth.min_value = stats.weightBounds.min
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/WeightContainer/Weigth.max_value = stats.weightBounds.max
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/WeightContainer/Weigth.set_tooltip("Current carried weight: " + str(stats.weight))
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/WeightContainer/PreviousWeightBound.text = str(stats.weightBounds.min)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/WeightContainer/PreviousWeightBound.set_tooltip("Previous weight bound: " + str(stats.weightBounds.min))
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/WeightContainer/NextWeightBound.text = str(stats.weightBounds.max)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/WeightContainer/NextWeightBound.set_tooltip("Next weight bound: " + str(stats.weightBounds.max))
	if stats.strength != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/StrengthContainer/Strength.text = str(stats.strength)
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/StrengthContainer/Strength.set_tooltip(str(stats.strength))
	if stats.legerity != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/LegerityContainer/Legerity.text = str(stats.legerity)
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/LegerityContainer/Legerity.set_tooltip(str(stats.legerity))
	if stats.balance != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/BalanceContainer/Balance.text = str(stats.balance)
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/BalanceContainer/Balance.set_tooltip(str(stats.balance))
	if stats.belief != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/BeliefContainer/Belief.text = str(stats.belief)
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/BeliefContainer/Belief.set_tooltip(str(stats.belief))
	if stats.visage != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/VisageContainer/Visage.text = str(stats.visage)
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/VisageContainer/Visage.set_tooltip(str(stats.visage))
	if stats.wisdom != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/WisdomContainer/Wisdom.text = str(stats.wisdom)
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/WisdomContainer/Wisdom.set_tooltip(str(stats.wisdom))

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
