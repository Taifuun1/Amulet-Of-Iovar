extends Node2D
class_name BaseCritter

var damageNumber = load("res://UI/Damage Number/Damage Number.tscn")

var id

var critterName
var critterClass
var race
var justice

var level
var hp
var mp
var basehp
var basemp
var maxhp
var maxmp
var shields
var ac
var attacks = [{
	"dmg": [0,0],
	"bonusDmg": {},
	"armorPen": 0,
	"magicDmg": {
		"dmg": [0,0],
		"element": null
	}
}]
var currentHit
var hits

var baseStats = {
	"strength": 0,
	"legerity": 0,
	"balance": 0,
	"belief": 0,
	"visage": 0,
	"wisdom": 0
}
var stats = {
	"strength": 0,
	"legerity": 0,
	"balance": 0,
	"belief": 0,
	"visage": 0,
	"wisdom": 0
}

var abilities
var resistances

var statusEffects = {
	"stun": 0,
	"confusion": 0,
	"fast digestion": 0,
	"slow digestion": 0,
	"regen": 0,
	"fumbling": 0,
	"sleep": 0,
	"blindness": 0,
#	"invisibility": 0,
	"seeing": 0,
	"toxix": 0,
	"backscattering": 0,
	"displacement": 0,
	"onFleir": 0
}
var statusStates = {
	"hunger": {
		"current": 0,
		"previous": 0
	},
	"weight": {
		"current": 0,
		"previous": 0
	}
}

var hpRegenTimer = 0
var mpRegenTimer = 0

func moveCritter(_moveFrom, _moveTo, _movingCritter, _level, _movedCritter = null):
	if _movedCritter == null:
		_level.grid[_moveFrom.x][_moveFrom.y].critter = null
		_level.grid[_moveTo.x][_moveTo.y].critter = _movingCritter
	else:
		_level.grid[_moveFrom.x][_moveFrom.y].critter = _movedCritter
		_level.grid[_moveTo.x][_moveTo.y].critter = _movingCritter



####################################
### Damage calculation function ###
####################################

func calculateDmg(_attack, _activeArmorSets = null):
	var damage = {
		"dmg": [0,0],
		"magicDmg": 0
	}
	
	if _attack.dmg != null:
		var _armorClassAfterArmorPen = (ac / 2) - _attack.armorPen
		if _armorClassAfterArmorPen < 0: _armorClassAfterArmorPen = 0
		
		var _floorDmg = int(_attack.dmg[0])
		var _dmgVariation = int(_attack.dmg[1] - _attack.dmg[0])
		
		var _totalBonusDamage = 0
		if _attack.bonusDmg != null:
			for _bonusDamage in _attack.bonusDmg.values():
				_totalBonusDamage += _bonusDamage
		
		var _baseDmg
		if _dmgVariation == 0:
			_baseDmg = _floorDmg
		else:
			_baseDmg = randi() % int(_dmgVariation) + _floorDmg
		damage.dmg = (_baseDmg + _totalBonusDamage) - _armorClassAfterArmorPen
	
	if typeof(_attack.magicDmg.dmg) == TYPE_ARRAY:
		var _magicFloorDmg = int(_attack.magicDmg.dmg[0])
		var _magicDmgVariation = int(_attack.magicDmg.dmg[1]) - _attack.magicDmg.dmg[0]
		var _magicDmg
		if _magicDmgVariation == 0:
			_magicDmg = _magicFloorDmg
		else:
			_magicDmg = randi() % int(_magicDmgVariation) + _magicFloorDmg
		if _activeArmorSets != null and _activeArmorSets.has(_attack.magicDmg.element) and _activeArmorSets[_attack.magicDmg.element]:
			_magicDmg += 3
		if _attack.magicDmg.element != null and resistances.has(_attack.magicDmg.element.to_lower()):
			_magicDmg /= 2
		damage.magicDmg = _magicDmg
	
	if damage.dmg < 0: damage.dmg = 0
	if damage.magicDmg < 0: damage.magicDmg = 0
	return damage



###############################
### Status effect functions ###
###############################

func processCritterEffects():
	if abilities != null:
		for _ability in abilities:
			match _ability.abilityName:
				"reflection":
					statusEffects.backscattering = -1
	
	for _status in statusEffects.keys():
		if statusEffects[_status] > 0 or statusEffects[_status] == -1:
			if _status.matchn("toxix"):
				var _toxixDmg = 1
				hp -= _toxixDmg
				Globals.gameConsole.addLog("{critterName} takes {dmg} toxix damage.".format({ "critterName": critterName, "dmg": _toxixDmg }))
			elif _status.matchn("onfleir"):
				var _fleirDmg = 2
				hp -= _fleirDmg
				Globals.gameConsole.addLog("{critterName} takes {dmg} fleir damage.".format({ "critterName": critterName, "dmg": _fleirDmg }))
			elif _status.matchn("confusion") or _status.matchn("fumbling"):
				if stats.balance > 30:
					if statusEffects[_status] - 3 < 0:
						statusEffects[_status] = 0
					else:
						statusEffects[_status] -= 3
				elif stats.balance > 15:
					if statusEffects[_status] - 2 < 0:
						statusEffects[_status] = 0
					else:
						statusEffects[_status] -= 2
				else:
					statusEffects[_status] -= 1
			elif _status.matchn("stun"):
				if stats.legerity > 27:
					if statusEffects[_status] - 2 < 0:
						statusEffects[_status] = 0
					else:
						statusEffects[_status] -= 2
				else:
					statusEffects[_status] -= 1
			elif _status.matchn("blindness"):
				if stats.belief > 32:
					if statusEffects[_status] - 3 < 0:
						statusEffects[_status] = 0
					else:
						statusEffects[_status] -= 3
				elif stats.belief > 18:
					if statusEffects[_status] - 2 < 0:
						statusEffects[_status] = 0
					else:
						statusEffects[_status] -= 2
				else:
					statusEffects[_status] -= 11
#			elif _status.matchn("invisibility"):
#				if stats.visage > 32:
#					if statusEffects[_status] - 3 < 0:
#						statusEffects[_status] = 0
#					else:
#						statusEffects[_status] -= 3
#				elif stats.visage > 18:
#					if statusEffects[_status] - 2 < 0:
#						statusEffects[_status] = 0
#					else:
#						statusEffects[_status] -= 2
#				else:
#					statusEffects[_status] -= 1
			else:
				statusEffects[_status] -= 1
	
	if hpRegenTimer >= 20 - ( (stats.legerity / 3) + (stats.strength / 3) ):
		if hp < maxhp:
			if checkIfStatusEffectIsInEffect("regen"):
				if hp + 3 > maxhp:
					hp = maxhp
				else:
					hp += 3
			if (stats.legerity / 3) + (stats.strength / 3) >= 20:
				if hp + 8 > maxhp:
					hp = maxhp
				else:
					hp += 8
			elif (stats.legerity / 3) + (stats.strength / 3) >= 15:
				if hp + 5 > maxhp:
					hp = maxhp
				else:
					hp += 5
			elif (stats.legerity / 3) + (stats.strength / 3) >= 10:
				if hp + 3 > maxhp:
					hp = maxhp
				else:
					hp += 3
			elif (stats.legerity / 3) + (stats.strength / 3) >= 5:
				if hp + 2 > maxhp:
					hp = maxhp
				else:
					hp += 2
			else:
				if hp + 1 > maxhp:
					hp = maxhp
				else:
					hp += 1
		hpRegenTimer = 0
	else:
		hpRegenTimer += 1
	
	if mpRegenTimer >= 20 - ( stats.belief / 2 ):
		if mp < maxmp:
			if stats.belief / 2 >= 20:
				if mp + 8 > maxmp:
					mp = maxmp
				else:
					mp += 8
			elif stats.belief / 2 >= 15:
				if mp + 5 > maxmp:
					mp = maxmp
				else:
					mp += 5
			elif stats.belief / 2 >= 10:
				if mp + 3 > maxmp:
					mp = maxmp
				else:
					mp += 3
			elif stats.belief / 2 >= 5:
				if mp + 2 > maxmp:
					mp = maxmp
				else:
					mp += 2
			else:
				if mp + 1 > maxmp:
					mp = maxmp
				else:
					mp += 1
		mpRegenTimer = 0
	else:
		mpRegenTimer += 1

func checkIfStatusEffectIsPermanent(_statusEffect):
	if statusEffects[_statusEffect] == -1:
		return true
	return false

func checkIfStatusEffectIsInEffect(_statusEffect):
	if statusEffects[_statusEffect] > 0 or statusEffects[_statusEffect] == -1:
		return true
	return false

func getBaseCritterSaveData():
	return {
		id = id,
		critterName = critterName,
		critterClass = critterClass,
		race = race,
		justice = justice,
		level = level,
		hp = hp,
		mp = mp,
		basehp = basehp,
		basemp = basemp,
		maxhp = maxhp,
		maxmp = maxmp,
		shields = shields,
		ac = ac,
		attacks = attacks,
		currentHit = currentHit,
		hits = hits,
		baseStats = baseStats,
		stats = stats,
		abilities = abilities,
		resistances = resistances,
		statusEffects = statusEffects,
		statusStates = statusStates,
		hpRegenTimer = hpRegenTimer,
		mpRegenTimer = mpRegenTimer
	}
