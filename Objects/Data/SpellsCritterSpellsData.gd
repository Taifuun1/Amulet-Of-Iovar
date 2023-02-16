
### Abilities

var gridMovement = {
	"name": "Grid movement",
	"distance": 0
}

var mining = {
	"name": "Mining",
	"distance": 0
}

var charge = {
	"name": "Charge",
	"distance": 5
}



### Self cast abilities

var sharpenSword = {
	"name": "Sharpen sword",
	"distance": 3,
	"mp": 7
}

var createShield = {
	"name": "Create shield",
	"distance": 4,
	"mp": 3
}

var displaceSelf = {
	"name": "Displace self",
	"distance": 2,
	"mp": 13
}



### Onhit abilities

var toxixSplash = {
	"name": "Toxix splash",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [2,5],
				"element": "toxix"
			}
		}
	]
}



### On attack abilities

var lifesteal = {
	"name": "Lifesteal",
	"attacks": [
		{
			"dmg": [3,6],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [0,0],
				"element": null
			}
		}
	],
	"distance": 0,
	"mp": 1
}

var ghostTouch = {
	"name": "Ghost touch",
	"attacks": [
		{
			"dmg": [2,2],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [0,0],
				"element": null
			}
		}
	],
	"distance": 0,
	"mp": 3
}

var selfdestruct = {
	"name": "Selfdestruct",
	"attacks": [
		{
			"dmg": [8,12],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [0,0],
				"element": null
			}
		}
	],
	"distance": 0,
	"mp": 4
}

var frostSelfdestruct = {
	"name": "Frost selfdestruct",
	"attacks": [
		{
			"dmg": [2,6],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [8,12],
				"element": "frost"
			}
		}
	],
	"distance": 0,
	"mp": 5
}

var thunderSelfdestruct = {
	"name": "Thunder selfdestruct",
	"attacks": [
		{
			"dmg": [3,3],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [13,17],
				"element": "thunder"
			}
		}
	],
	"distance": 0,
	"mp": 7
}



### Throwing abilities

var rockThrow = {
	"name": "Rock throw",
	"attacks": [
		{
			"dmg": [7,8],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [0,0],
				"element": null
			}
		}
	],
	"distance": 8,
	"mp": 9
}

var crackerThrow = {
	"name": "Cracker throw",
	"attacks": [
		{
			"dmg": [9,12],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [0,0],
				"element": null
			}
		}
	],
	"distance": 6,
	"mp": 8
}



### Fleir abilities

var fleirpoint = {
	"name": "Fleirpoint",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [2, 14],
				"element": "fleir"
			}
		}
	],
	"distance": 8,
	"mp": 12
}

var fleirnado = {
	"name": "Fleirnado",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [14, 22],
				"element": "fleir"
			}
		}
	],
	"distance": 5,
	"mp": 14
}

var fleirMiasma = {
	"name": "Fleir miasma",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [3, 3],
				"element": "fleir"
			}
		}
	],
	"distance": 5,
	"tiles": 5,
	"duration": 8,
	"mp": 2
}

var fleirBreath = {
	"name": "Fleir breath",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [18,28],
				"element": "fleir"
			}
		}
	],
	"distance": 12,
	"mp": 18
}



### Frost abilities

var frostpoint = {
	"name": "Frostpoint",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [6, 8],
				"element": "frost"
			}
		}
	],
	"distance": 7,
	"mp": 7
}

var frostBite = {
	"name": "Frost-bite",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [8, 17],
				"element": "frost"
			}
		}
	],
	"distance": 7,
	"mp": 9
}

var frostTouch = {
	"name": "Frost touch",
	"attacks": [
		{
			"dmg": [1,3],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [7, 15],
				"element": "frost"
			}
		}
	],
	"distance": 1,
	"mp": 6
}

var frostBreath = {
	"name": "Frost breath",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [13,15],
				"element": "frost"
			}
		}
	],
	"distance": 10,
	"mp": 18
}



### Thunder abilities

var thunderPoint = {
	"name": "Thunderpoint",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [11, 13],
				"element": "thunder"
			}
		}
	],
	"distance": 10,
	"mp": 8
}

var thundersplit = {
	"name": "Thundersplit",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [15, 17],
				"element": "thunder"
			}
		}
	],
	"distance": 8,
	"mp": 15
}

var thunderMiasma = {
	"name": "Thunder miasma",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [7, 7],
				"element": "Thunder"
			}
		}
	],
	"distance": 6,
	"tiles": 6,
	"duration": 5,
	"mp": 7
}

var thunderBreath = {
	"name": "Thunder breath",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [17,18],
				"element": "thunder"
			}
		}
	],
	"distance": 13,
	"mp": 18
}



### Toxix abilities

var poisonBite = {
	"name": "Poison bite",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [4, 5],
				"element": "toxix"
			}
		}
	],
	"distance": 7,
	"mp": 5
}

var toxixMiasma = {
	"name": "Toxix miasma",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [2, 2],
				"element": "toxix"
			}
		}
	],
	"distance": 8,
	"tiles": 10,
	"duration": 14,
	"mp": 4
}

var toxixBreath = {
	"name": "Toxix breath",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [2,6],
				"element": "toxix"
			}
		}
	],
	"distance": 6,
	"mp": 18
}



### Gleeie'er abilities

var gleeieerBreath = {
	"name": "Gleeie'er breath",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [16,18],
				"element": "gleeie'er"
			}
		}
	],
	"distance": 14,
	"mp": 18
}



### Other abilities

var summonCritter = {
	"name": "Summon critter",
	"distance": 4,
	"mp": 11
}

var summonCritters = {
	"name": "Summon critters",
	"distance": 4,
	"mp": 35
}

var dragonBreath = {
	"name": "Dragon breath",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [12,20],
				"element": "incineration"
			}
		}
	],
	"distance": 12,
	"mp": 18
}

var elderDragonBreath = {
	"name": "Elder dragon breath",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [15,32],
				"element": "incineration"
			}
		}
	],
	"distance": 16,
	"mp": 22
}

var voidBlast = {
	"name": "Void blast",
	"attacks": [
		{
			"dmg": [0,0],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [21,33],
				"element": "void"
			}
		}
	],
	"distance": 5,
	"mp": 86
}
