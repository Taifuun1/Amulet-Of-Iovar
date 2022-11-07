extends Control

var tooltipTexts = load("res://UI/Game Stats/GameStatsTooltipTexts.gd").new()

onready var statusEffectItem = preload("res://UI/Game Stats/Status Effect Item.tscn")

var attacks
var weight

#func _ready():
#	addStatusEffect("blindness")
#	addStatusEffect("fumbling")
#	addStatusEffect("hungry")
#	addStatusEffect("malnourished")
#	addStatusEffect("famished")
#	addStatusEffect("overEncumbured")
#	addStatusEffect("burdened")
#	addStatusEffect("flattened")
#	addStatusEffect("confusion")
#	addStatusEffect("displacement")



#################################
### Update player stats in UI ###
#################################

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
	justice = null,
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
	wisdom = null,
	goldPieces = null
}):
	if stats.critterName != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/NameContainer/Name.text = str(stats.critterName)
	if stats.race != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/RaceContainer/Race.text = str(stats.race)
	if stats.justice != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/JusticeContainer/Justice.text = str(stats.justice)
	if stats.dungeonLevel != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/DungeonLevelContainer/DungeonLevel.text = str(stats.dungeonLevel)
	if stats.level != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/LevelContainer/Level.text = str(stats.level)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/ExperienceContainer/Experience.text = str(stats.experiencePoints) + "/" + str(stats.experienceLevelGainAmount)
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/ExperienceContainer/Experience.set_tooltip("First value is your current exp, second value is next level\n" + str(stats.experiencePoints) + "/" + str(stats.experienceLevelGainAmount))
	if stats.strength != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/StrengthContainer/Strength.text = str(stats.strength)
	if stats.legerity != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/LegerityContainer/Legerity.text = str(stats.legerity)
	if stats.balance != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/BalanceContainer/Balance.text = str(stats.balance)
	if stats.belief != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/BeliefContainer/Belief.text = str(stats.belief)
	if stats.visage != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/VisageContainer/Visage.text = str(stats.visage)
	if stats.wisdom != null:
		$Background/GameStatsContainer/GameStatsColumns/DetailsContainer/WisdomContainer/Wisdom.text = str(stats.wisdom)
	
	if stats.maxhp != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/HPContainer/HPAmount.max_value = stats.maxhp
	if stats.hp != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/HPContainer/HP.text = str(stats.hp)
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/HPContainer/HPAmount.value = stats.hp
	if stats.maxmp != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/MPContainer/MPAmount.max_value = stats.maxmp
	if stats.mp != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/MPContainer/MP.text = str(stats.mp)
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/MPContainer/MPAmount.value = stats.mp
	if stats.ac != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/ACContainer/AC.text = str(stats.ac)
	if stats.attacks != null:
		var _attackString = "{damage}d{hits}+{bonusDmg}({ap})/{magicDmg}".format({
			"damage": str(stats.attacks.attack.dmg[0]) + "-" + str(stats.attacks.attack.dmg[1]),
			"hits": stats.attacks.hits,
			"bonusDmg": stats.attacks.bonusDmg,
			"ap": stats.attacks.attack.armorPen,
			"magicDmg": str(stats.attacks.attack.magicDmg.dmg[0]) + "-" + str(stats.attacks.attack.magicDmg.dmg[1])
		})
		attacks = stats.attacks
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/AttacksContainer/Attacks.text = str(_attackString)
	if stats.goldPieces != null:
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/GoldPiecesContainer/GoldPieces.text = str(stats.goldPieces)
	if stats.weight != null and stats.weightBounds != null:
		weight = stats.weight
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/WeightContainer/WeightBarContainer/Weigth.value = stats.weight
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/WeightContainer/WeightBarContainer/Weigth.min_value = stats.weightBounds.min
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/WeightContainer/WeightBarContainer/Weigth.max_value = stats.weightBounds.max
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/WeightContainer/WeightBarContainer/Weigth.set_tooltip("Current carried weight: " + str(stats.weight))
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/WeightContainer/WeightBarContainer/PreviousWeightBound.text = str(stats.weightBounds.min)
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/WeightContainer/WeightBarContainer/PreviousWeightBound.set_tooltip("Previous weight bound: " + str(stats.weightBounds.min))
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/WeightContainer/WeightBarContainer/NextWeightBound.text = str(stats.weightBounds.max)
		$Background/GameStatsContainer/GameStatsColumns/StatsContainer/WeightContainer/WeightBarContainer/NextWeightBound.set_tooltip("Next weight bound: " + str(stats.weightBounds.max))

func _on_Weigth_value_changed(value):
	var _min = $Background/GameStatsContainer/GameStatsColumns/StatsContainer/WeightContainer/WeightBarContainer/Weigth.min_value
	var _max = $Background/GameStatsContainer/GameStatsColumns/StatsContainer/WeightContainer/WeightBarContainer/Weigth.max_value
	var _r = range_lerp(value, _min, _max, 0, 1)
	var _g = range_lerp(value, _min, _max, 1, 0)
#	progress_bar.get("custom_styles/fg").set_bg_color(Color(red_amnt, green_amnt, 0.00, 1.00))
	$Background/GameStatsContainer/GameStatsColumns/StatsContainer/WeightContainer/WeightBarContainer/Weigth.tint_progress = Color(_r, _g, 0)

func isStatusEffectInGameStats(_statusEffect):
	for _node in $Background/GameStatsContainer/GameStatsColumns/StatusEffectsContainer.get_children():
		if _node.name.matchn(_statusEffect):
			return true
	return false

func addStatusEffect(_statusEffect):
	var _newStatusEffect = statusEffectItem.instance()
	_newStatusEffect.create(_statusEffect)
	$Background/GameStatsContainer/GameStatsColumns/StatusEffectsContainer.add_child(_newStatusEffect)

func removeStatusEffect(_statusEffect):
	get_node("Background/GameStatsContainer/GameStatsColumns/StatusEffectsContainer/{statusEffect}".format({ "statusEffect": _statusEffect })).queue_free()



########################
### Signal functions ###
########################

func _onMouseEnteredStat(_nodePath, _stat):
	var _tooltipDescription = tooltipTexts[_stat].description
	if _stat.matchn("attacks"):
		var _magicElement = ""
		if attacks.attack.magicDmg.element != null:
			_magicElement = attacks.attack.magicDmg.element
		_tooltipDescription = _tooltipDescription.format({
			"damage": str(attacks.attack.dmg[0]) + "-" + str(attacks.attack.dmg[1]),
			"hits": attacks.hits,
			"bonusDmg": attacks.bonusDmg,
			"ap": attacks.attack.armorPen,
			"magicDmg": str(attacks.attack.magicDmg.dmg[0]) + "-" + str(attacks.attack.magicDmg.dmg[1]),
			"magicElement": _magicElement
		})
	elif _stat.matchn("weight"):
		_tooltipDescription = _tooltipDescription.format({ "weight": weight })
	get_node("Background/GameStatsContainer/GameStatsColumns/{nodePath}/Tooltip/TooltipContainer".format({ "nodePath": _nodePath })).updateTooltip(tooltipTexts[_stat].title, _tooltipDescription)
	get_node("Background/GameStatsContainer/GameStatsColumns/{nodePath}/Tooltip/TooltipContainer".format({ "nodePath": _nodePath })).showTooltip()

func _onMouseExitedStat(_nodePath):
	get_node("Background/GameStatsContainer/GameStatsColumns/{nodePath}/Tooltip/TooltipContainer".format({ "nodePath": _nodePath })).hideTooltip()
