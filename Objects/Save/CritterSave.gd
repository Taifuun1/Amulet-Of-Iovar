
### Critter metadata

var critterType

### Basecritter

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
	"displacement": 0
}

var statusStates = {
	"hunger": 0,
	"weight": 0
}

var hpRegenTimer = 0
var mpRegenTimer = 0

### Critter

var levelId
var aI
var weight
var expDropAmount
var drops
var abilityHits
var currentCritterAbilityHit
var activationDistance = null

### Player critter

var playerClass

var playerVisibility = {
	"distance": -1,
	"duration": -1
}

var experiencePoints = 0
var experienceNeededForPreviousLevelGainAmount = 0
var experienceNeededForLevelGainAmount = 20

var hpIncrease = 0
var mpIncrease = 0
var strengthIncrease = 0
var legerityIncrease = 0
var balanceIncrease = 0
var beliefIncrease = 0
var visageIncrease = 0
var wisdomIncrease = 0

var calories
var previousCalories

var goldPieces

var maxCarryWeight = {
	"overEncumbured": 0,
	"burdened": 1,
	"flattened": 2
}
var carryWeightBounds = {
	"min": 0,
	"max": 1
}

var turnsUntilAction = 0

var selectedItem = null
var itemsTurnedOn = []

var skills = {
	"sword": {
		"experience": 0,
		"level": 0,
		"skillCap": 0
	},
	"two-hander": {
		"experience": 0,
		"level": 0,
		"skillCap": 0
	},
	"dagger": {
		"experience": 0,
		"level": 0,
		"skillCap": 0
	},
	"mace": {
		"experience": 0,
		"level": 0,
		"skillCap": 0
	},
	"flail": {
		"experience": 0,
		"level": 0,
		"skillCap": 0
	}
}

var neutralCritters = ["Sugar ant", "Shopkeeper"]
