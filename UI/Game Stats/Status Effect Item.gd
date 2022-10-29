extends Control

var statusEffectsData = load("res://Objects/Miscellaneous/StatusEffectsData.gd").new()

func create(_statusEffect):
	name = str(_statusEffect)
	$StatusEffectContainer/StatusEffectText.append_bbcode("[center][color=%s]%s[/color][/center]" % [statusEffectsData.statusEffectsData[_statusEffect].color, statusEffectsData.statusEffectsData[_statusEffect].label.to_upper()])
	$StatusEffectContainer.hint_tooltip = statusEffectsData.statusEffectsData[_statusEffect].description
#	$Background.color = Color(statusEffects[_statusEffect].color).darkened(0.5)
#	$Background.color = Color(statusEffects[_statusEffect].color).lightened(0.5)
#	$Background.color = Color(statusEffects[_statusEffect].color).contrasted()
	$Background.color = Color(statusEffectsData.statusEffectsData[_statusEffect].color).inverted()
#	$StatusEffectContainer/StatusEffectText.append_color([color=<code/name>]{text}[/color])
	$StatusEffectContainer/StatusEffectIcon.texture = statusEffectsData.statusEffectsData[_statusEffect].texture
