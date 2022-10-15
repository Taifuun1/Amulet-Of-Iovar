extends Node2D
class_name BaseCritter

var damageNumber = load("res://UI/Damage Number/Damage Number.tscn")

var id

var critterName
var race
var critterClass
var alignment

var level
var hp
var mp
var basehp
var basemp
var maxhp
var maxmp
var ac
var attacks
var currentHit
var hits

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
	"hungerification": 0,
	"slow digestion": 0,
	"regen": 0,
	"fumbling": 0,
	"sleep": 0,
	"blindness": 0,
	"invisibility": 0,
	"seeing": 0,
	"hunger": 0
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
### Damage calculation functions ###
####################################

func calculateDmg(_attack):
	var damage = {
		"dmg": 0,
		"magicDmg": 0
	}
	
	if _attack.dmg != null:
		var _armorClassAfterArmorPen = ac - _attack.armorPen
		if _armorClassAfterArmorPen < 0: _armorClassAfterArmorPen = 0
		
		var _floorDmg = int(_attack.dmg[0])
		var _dmgVariation = int(_attack.dmg[1]) - _attack.dmg[0]
		
		var _totalBonusDamage = 0
		if _attack.bonusDmg != null:
			for _bonusDamage in _attack.bonusDmg:
				_totalBonusDamage += _bonusDamage
		
		var _baseDmg
		if _dmgVariation == 0:
			_baseDmg = _floorDmg
		else:
			_baseDmg = randi() % int(_dmgVariation) + _floorDmg
		damage.dmg = (_baseDmg + _totalBonusDamage) - _armorClassAfterArmorPen
	
	var _magicDmg = _attack.magicDmg.dmg
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
	for _status in statusEffects.keys():
		if statusEffects[_status] > 0:
			statusEffects[_status] -= 1
	
	if hpRegenTimer >= 20 - ( stats.legerity / 2 ):
		if hp < maxhp:
			if checkIfStatusEffectIsInEffect("regen"):
				hp += 3
			else:
				hp += 1
		hpRegenTimer = 0
	else:
		hpRegenTimer += 1
	
	if mpRegenTimer >= 20 - ( stats.belief / 2 ):
		if mp < maxmp:
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
