extends Control

var tooltipTexts = load("res://UI/Game Stats/GameStatsTooltipTexts.gd").new()

var attacks
var magicAttacks
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
	magicAttacks = null,
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
		$GameStatsContainer/DetailsContainer/NameContainer/Name.text = str(stats.critterName)
	if stats.race != null:
		$GameStatsContainer/DetailsContainer/RaceContainer/Race.text = str(stats.race)
	if stats.justice != null:
		$GameStatsContainer/DetailsContainer/JusticeContainer/Justice.text = str(stats.justice)
	if GlobalGameStats.gameStats["Turn count"] != null:
		$GameStatsContainer/DetailsContainer/TurnCountContainer/TurnCount.text = str(GlobalGameStats.gameStats["Turn count"])
	if stats.dungeonLevel != null:
		$GameStatsContainer/DetailsContainer/DungeonLevelContainer/DungeonLevel.text = str(stats.dungeonLevel)
	if stats.strength != null:
		$GameStatsContainer/DetailsContainer/StrengthContainer/Strength.text = str(int(stats.strength))
	if stats.legerity != null:
		$GameStatsContainer/DetailsContainer/LegerityContainer/Legerity.text = str(int(stats.legerity))
	if stats.balance != null:
		$GameStatsContainer/DetailsContainer/BalanceContainer/Balance.text = str(int(stats.balance))
	if stats.belief != null:
		$GameStatsContainer/DetailsContainer/BeliefContainer/Belief.text = str(int(stats.belief))
	if stats.visage != null:
		$GameStatsContainer/DetailsContainer/VisageContainer/Visage.text = str(int(stats.visage))
	if stats.wisdom != null:
		$GameStatsContainer/DetailsContainer/WisdomContainer/Wisdom.text = str(int(stats.wisdom))
	
	if stats.maxhp != null:
		$GameStatsContainer/StatsContainer/HPContainer/HPAmount.max_value = stats.maxhp
	if stats.hp != null:
		$GameStatsContainer/StatsContainer/HPContainer/HP.text = str(stats.hp)
		$GameStatsContainer/StatsContainer/HPContainer/HPAmount.value = stats.hp
	if stats.maxmp != null:
		$GameStatsContainer/StatsContainer/MPContainer/MPAmount.max_value = stats.maxmp
	if stats.mp != null:
		$GameStatsContainer/StatsContainer/MPContainer/MP.text = str(stats.mp)
		$GameStatsContainer/StatsContainer/MPContainer/MPAmount.value = stats.mp
	if stats.ac != null:
		$GameStatsContainer/StatsContainer/ACContainer/AC.text = str(stats.ac)
	if stats.attacks != null:
		var _attackString = "{damage}d{hits}+{bonusDmg}({ap})/{magicDmg}".format({
			"damage": str(stats.attacks.attack.dmg[0]) + "-" + str(stats.attacks.attack.dmg[1]),
			"hits": stats.attacks.hits,
			"bonusDmg": stats.attacks.bonusDmg,
			"ap": stats.attacks.attack.armorPen,
			"magicDmg": str(stats.attacks.attack.magicDmg.dmg[0]) + "-" + str(stats.attacks.attack.magicDmg.dmg[1])
		})
		attacks = stats.attacks
		$GameStatsContainer/StatsContainer/AttacksContainer/Attacks.text = str(_attackString)
	if stats.magicAttacks != null:
		var _attackString = "{damage}d{hits}+{bonusDmg}({ap})/{magicDmg}".format({
			"damage": str(stats.magicAttacks.attack.dmg[0]) + "-" + str(stats.magicAttacks.attack.dmg[1]),
			"hits": stats.magicAttacks.hits,
			"bonusDmg": stats.magicAttacks.bonusDmg,
			"ap": stats.magicAttacks.attack.armorPen,
			"magicDmg": str(stats.magicAttacks.attack.magicDmg.dmg[0]) + "-" + str(stats.magicAttacks.attack.magicDmg.dmg[1])
		})
		magicAttacks = stats.magicAttacks
		$GameStatsContainer/StatsContainer/MagicAttacksContainer/MagicAttacks.text = str(_attackString)
	if stats.level != null:
		$GameStatsContainer/StatsContainer/LevelContainer/Level.text = str(stats.level)
		$GameStatsContainer/StatsContainer/ExperienceContainer/Experience.text = str(stats.experiencePoints) + "/" + str(stats.experienceLevelGainAmount)
	if stats.goldPieces != null:
		$GameStatsContainer/StatsContainer/GoldPiecesContainer/GoldPieces.text = str(stats.goldPieces)
	if stats.weight != null and stats.weightBounds != null:
		weight = stats.weight
		$GameStatsContainer/StatsContainer/WeightContainer/WeightBarContainer/Weigth.min_value = stats.weightBounds.min
		$GameStatsContainer/StatsContainer/WeightContainer/WeightBarContainer/Weigth.max_value = stats.weightBounds.max
		$GameStatsContainer/StatsContainer/WeightContainer/WeightBarContainer/Weigth.value = 0
		$GameStatsContainer/StatsContainer/WeightContainer/WeightBarContainer/Weigth.value = stats.weight
		$GameStatsContainer/StatsContainer/WeightContainer/WeightBarContainer/PreviousWeightBound.text = str(stats.weightBounds.min)
		$GameStatsContainer/StatsContainer/WeightContainer/WeightBarContainer/NextWeightBound.text = str(stats.weightBounds.max)

func _on_Weigth_value_changed(value):
	var _min = $GameStatsContainer/StatsContainer/WeightContainer/WeightBarContainer/Weigth.min_value
	var _max = $GameStatsContainer/StatsContainer/WeightContainer/WeightBarContainer/Weigth.max_value
	var _r = range_lerp(value, _min, _max, 0, 1)
	var _g = range_lerp(value, _min, _max, 1, 0)
#	progress_bar.get("custom_styles/fg").set_bg_color(Color(red_amnt, green_amnt, 0.00, 1.00))
	$GameStatsContainer/StatsContainer/WeightContainer/WeightBarContainer/Weigth.tint_progress = Color(_r, _g, 0)

func isStatusEffectInGameStats(_statusEffect):
	for _node in $GameStatsContainer/EffectsAndIconsContainer/StatusEffectsContainer.get_children():
		if _node.name.matchn(_statusEffect):
			return true
	return false

func addStatusEffect(_statusEffect):
	var _newStatusEffect = load("res://UI/Game Stats/Status Effect Item.tscn").instance()
	_newStatusEffect.create(_statusEffect)
	$GameStatsContainer/EffectsAndIconsContainer/StatusEffectsContainer.add_child(_newStatusEffect)

func removeStatusEffect(_statusEffect):
	get_node("GameStatsContainer/EffectsAndIconsContainer/StatusEffectsContainer/{statusEffect}".format({ "statusEffect": _statusEffect })).queue_free()



########################
### Signal functions ###
########################

func _onMouseEnteredStat(_nodePath, _stat):
	var _tooltipDescription
	if tooltipTexts[_stat].has("description"):
		_tooltipDescription = tooltipTexts[_stat].description
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
	elif _stat.matchn("magicAttacks"):
		var _magicElement = ""
		if magicAttacks.attack.magicDmg.element != null:
			_magicElement = magicAttacks.attack.magicDmg.element
		_tooltipDescription = _tooltipDescription.format({
			"damage": str(magicAttacks.attack.dmg[0]) + "-" + str(magicAttacks.attack.dmg[1]),
			"hits": magicAttacks.hits,
			"bonusDmg": magicAttacks.bonusDmg,
			"ap": magicAttacks.attack.armorPen,
			"magicDmg": str(magicAttacks.attack.magicDmg.dmg[0]) + "-" + str(magicAttacks.attack.magicDmg.dmg[1]),
			"magicElement": _magicElement
		})
	elif _stat.matchn("weight"):
		_tooltipDescription = _tooltipDescription.format({ "weight": weight })
	if tooltipTexts[_stat].has("description"):
		get_node("GameStatsContainer/{nodePath}/Tooltip/TooltipContainer".format({ "nodePath": _nodePath })).updateTooltip(tooltipTexts[_stat].title, _tooltipDescription)
	else:
		get_node("GameStatsContainer/{nodePath}/Tooltip/TooltipContainer".format({ "nodePath": _nodePath })).updateTooltip(tooltipTexts[_stat].title, tooltipTexts[_stat].sprite)
	get_node("GameStatsContainer/{nodePath}/Tooltip/TooltipContainer".format({ "nodePath": _nodePath })).showTooltip()

func _onMouseExitedStat(_nodePath):
	get_node("GameStatsContainer/{nodePath}/Tooltip/TooltipContainer".format({ "nodePath": _nodePath })).hideTooltip()


func _onIconClicked(event, _icon):
	if (
		event is InputEventMouseButton and
		event.pressed and
		event.button_index == BUTTON_LEFT and
		$"/root/World".inGame
	):
		match _icon:
			"inventory":
				$"/root/World".openMenu("inventory")
			"equipment":
				$"/root/World".openMenu("equipment")
			"read":
				$"/root/World".openMenu("read")
			"quaff":
				$"/root/World".openMenu("quaff")
			"consume":
				$"/root/World".openMenu("consume")
			"zap":
				$"/root/World".openMenu("zap")
			"use":
				$"/root/World".openMenu("use")
			"runes":
				$"/root/World".openMenu("runes")
			"loot":
				$"/root/World".openMenu("loot", $"/root/World".level.getCritterTile(0))
			"dip":
				$"/root/World".openMenu("dip")
			"autoMine":
				pass
			"attackNeutral":
				pass
