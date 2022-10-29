
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
	"distance": 3
}

var createShield = {
	"name": "Create shield",
	"distance": 4
}

var displaceSelf = {
	"name": "Displace self",
	"distance": 2
}



### Throwing abilities

var rockThrow = {
	"name": "Rock throw",
	"attacks": [
		{
			"dmg": [6,8],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": 0,
				"element": null
			}
		}
	],
	"distance": 8
}

var crackerThrow = {
	"name": "Cracker throw",
	"attacks": [
		{
			"dmg": [8,11],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": 0,
				"element": null
			}
		}
	],
	"distance": 6
}



### Fleir abilities

var fleirpoint = {
	"name": "Fleirpoint",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [2, 18],
				"element": "fleir"
			}
		}
	],
	"distance": 8
}

var fleirnado = {
	"name": "Fleirnado",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [8, 15],
				"element": "fleir"
			}
		}
	],
	"distance": 5
}

var fleirMiasma = {
	"name": "Fleir miasma",
	"attacks": [
		{
			"dmg": null,
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
	"duration": 3
}

var fleirBreath = {
	"name": "Fleir breath",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [15,28],
				"element": "fleir"
			}
		}
	],
	"distance": 12
}



### Frost abilities

var frostpoint = {
	"name": "Frostpoint",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [6, 8],
				"element": "frost"
			}
		}
	],
	"distance": 7
}

var frostBite = {
	"name": "Frost-bite",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [4, 12],
				"element": "frost"
			}
		}
	],
	"distance": 7
}

var frostTouch = {
	"name": "Frost touch",
	"attacks": [
		{
			"dmg": [1,3],
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [3, 13],
				"element": "frost"
			}
		}
	],
	"distance": 1
}

var frostBreath = {
	"name": "Frost breath",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [11,13],
				"element": "frost"
			}
		}
	],
	"distance": 10
}



### Thunder abilities

var thunderpoint = {
	"name": "Thunderpoint",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [10, 13],
				"element": "thunder"
			}
		}
	],
	"distance": 10
}

var thundersplit = {
	"name": "Thundersplit",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [14, 16],
				"element": "thunder"
			}
		}
	],
	"distance": 8
}

var thunderBreath = {
	"name": "Thunder breath",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [14,15],
				"element": "thunder"
			}
		}
	],
	"distance": 13
}



### Toxix abilities

var poisonBite = {
	"name": "Poison bite",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [4, 5],
				"element": "toxix"
			}
		}
	],
	"distance": 7
}

var toxixBreath = {
	"name": "Toxix breath",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [2,6],
				"element": "toxix"
			}
		}
	],
	"distance": 6
}



### Gleeie'er abilities

var gleeieerBreath = {
	"name": "Gleeie'er breath",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [12,14],
				"element": "gleeie'er"
			}
		}
	],
	"distance": 14
}



### Other abilities

var summonCritter = {
	"name": "Summon critter",
	"distance": 3
}

var summonCritters = {
	"name": "Summon critters",
	"distance": 4
}

var dragonBreath = {
	"name": "Dragon breath",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [12,23],
				"element": "incineration"
			}
		}
	],
	"distance": 12,
}

var elderDragonBreath = {
	"name": "Elder dragon breath",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [22,48],
				"element": "incineration"
			}
		}
	],
	"distance": 16,
}

var voidBlast = {
	"name": "Void blast",
	"attacks": [
		{
			"dmg": null,
			"bonusDmg": {},
			"armorPen": 0,
			"magicDmg": {
				"dmg": [64,148],
				"element": "Void"
			}
		}
	],
	"distance": 6
}
