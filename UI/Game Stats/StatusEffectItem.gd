extends Control

var statusEffectsData = load("res://Objects/Data/StatusEffectsData.gd").new().statusEffectsData

func create(_statusEffect):
	name = str(_statusEffect)
	$StatusEffectContainer/StatusEffectText.append_bbcode("[center][color=%s]%s[/color][/center]" % [statusEffectsData[_statusEffect].color, statusEffectsData[_statusEffect].label.to_upper()])
#	$Background.color = Color(statusEffects[_statusEffect].color).darkened(0.5)
#	$Background.color = Color(statusEffects[_statusEffect].color).lightened(0.5)
#	$Background.color = Color(statusEffects[_statusEffect].color).contrasted()
#	$Background.color = Color(statusEffectsData.statusEffectsData[_statusEffect].color).inverted()
#	$StatusEffectContainer/StatusEffectText.append_color([color=<code/name>]{text}[/color])
	$StatusEffectContainer/StatusEffectIcon.texture = statusEffectsData[_statusEffect].texture
	$Tooltip/TooltipContainer.updateTooltip(_statusEffect.capitalize(), statusEffectsData[_statusEffect].description, statusEffectsData[_statusEffect].texture)



########################
### Signal functions ###
########################

func _on_Status_Effect_mouse_entered():
	$Tooltip/TooltipContainer.showTooltip()

func _on_Status_Effect_mouse_exited():
	$Tooltip/TooltipContainer.hideTooltip()
