var weapons = {
	"common": [
		{
			"itemName": "Chipped sword",
			"unidentifiedItemName": "Chipped sword",
			"texture": load("res://Assets/Weapons/SwordChippedSword.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/SwordChippedSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 20,
			"value": {
				"dmg": [2,4],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Dull two-hander",
			"unidentifiedItemName": "Dull two-handed sword",
			"texture": load("res://Assets/Weapons/TwohanderDullTwohander.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/TwohanderDullTwohander.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"weight": 30,
			"value": {
				"dmg": [4,7],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Cut dagger",
			"unidentifiedItemName": "Cut dagger",
			"texture": load("res://Assets/Weapons/DaggerCutDagger.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/DaggerCutDagger.png"),
			"type": "Weapon",
			"category": "Dagger",
			"weight": 15,
			"value": {
				"dmg": [1,3],
				"d": 2,
				"bonusDmg": {
					"baseWeapon": 1
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Worn mace",
			"unidentifiedItemName": "Worn mace",
			"texture": load("res://Assets/Weapons/MaceWornMace.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/MaceWornMace.png"),
			"type": "Weapon",
			"category": "Mace",
			"weight": 20,
			"value": {
				"dmg": [3,5],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 1,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Rigid flail",
			"unidentifiedItemName": "Rigid flail",
			"texture": load("res://Assets/Weapons/FlailRigidFlail.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/FlailRigidFlail.png"),
			"type": "Weapon",
			"category": "Flail",
			"weight": 25,
			"value": {
				"dmg": [1,3],
				"d": 3,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		}
	],
	"uncommon": [
		{
			"itemName": "Orc dagger",
			"unidentifiedItemName": "Dark dagger",
			"texture": load("res://Assets/Weapons/DaggerOrcDagger.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/DaggerOrcDagger.png"),
			"type": "Weapon",
			"category": "Dagger",
			"weight": 15,
			"value": {
				"dmg": [2,4],
				"d": 2,
				"bonusDmg": {
					"baseWeapon": 1
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Sharp flail",
			"unidentifiedItemName": "Sharp flail",
			"texture": load("res://Assets/Weapons/FlailSharpFlail.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/FlailSharpFlail.png"),
			"type": "Weapon",
			"category": "Flail",
			"weight": 20,
			"value": {
				"dmg": [2,4],
				"d": 3,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Dwarvish laysword",
			"unidentifiedItemName": "Dwarvish laysword",
			"texture": load("res://Assets/Weapons/SwordDwarvishLaysword.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/SwordDwarvishLaysword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 20,
			"value": {
				"dmg": [5,8],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 2
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false,
		},
		{
			"itemName": "Orcish sword",
			"unidentifiedItemName": "Dark sword",
			"texture": load("res://Assets/Weapons/SwordOrcSword.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/SwordOrcSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 20,
			"value": {
				"dmg": [5,7],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 1
				},
				"armorPen": 1,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Elvish sword",
			"unidentifiedItemName": "Elvish sword",
			"texture": load("res://Assets/Weapons/SwordElvishSword.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/SwordElvishSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 20,
			"value": {
				"dmg": [5,7],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 1
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [1,1],
					"element": "Gleeie'er"
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Orcish two-hander",
			"unidentifiedItemName": "Black two-hander",
			"texture": load("res://Assets/Weapons/TwohanderOrcTwohander.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/TwohanderOrcTwohander.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"weight": 30,
			"value": {
				"dmg": [5,10],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 2
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		}
	],
	"rare": [
		{
			"itemName": "Glowing dagger",
			"unidentifiedItemName": "Glowing dagger",
			"texture": load("res://Assets/Weapons/DaggerGlowingDagger.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/DaggerGlowingDagger.png"),
			"type": "Weapon",
			"category": "Dagger",
			"weight": 15,
			"value": {
				"dmg": [2,5],
				"d": 2,
				"bonusDmg": {
					"baseWeapon": 1
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [2,2],
					"element": "Thunder"
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Dwarvish dagger",
			"unidentifiedItemName": "Blueish dagger",
			"texture": load("res://Assets/Weapons/DaggerDwarvishDagger.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/DaggerDwarvishDagger.png"),
			"type": "Weapon",
			"category": "Dagger",
			"weight": 15,
			"value": {
				"dmg": [5,5],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 1
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Elvish flail",
			"unidentifiedItemName": "Greenish flail",
			"texture": load("res://Assets/Weapons/FlailElvishFlail.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/FlailElvishFlail.png"),
			"type": "Weapon",
			"category": "Flail",
			"weight": 20,
			"value": {
				"dmg": [2,3],
				"d": 3,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [1,1],
					"element": "Gleeie'er"
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Morning star",
			"unidentifiedItemName": "Morning star",
			"texture": load("res://Assets/Weapons/MaceMorningStar.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/MaceMorningStar.png"),
			"type": "Weapon",
			"category": "Mace",
			"weight": 25,
			"value": {
				"dmg": [7,10],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 3,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Adorned sword",
			"unidentifiedItemName": "Adorned sword",
			"texture": load("res://Assets/Weapons/SwordAdornedSword.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/SwordAdornedSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 20,
			"value": {
				"dmg": [7,10],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 1
				},
				"armorPen": 1,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"points": 250,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Justice'eer sword",
			"unidentifiedItemName": "Justice'eer sword",
			"texture": load("res://Assets/Weapons/SwordJustice'eerSword.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/SwordJustice'eerSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 20,
			"value": {
				"dmg": [8,14],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false,
		},
		{
			"itemName": "Mithril two-hander",
			"unidentifiedItemName": "Mithril two-hander",
			"texture": load("res://Assets/Weapons/TwohanderMithrilTwohander.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/TwohanderMithrilTwohander.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"weight": 30,
			"value": {
				"dmg": [8,14],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 3
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"enchantable": true,
			"stackable": false
		}
	],
	"legendary": [
		{
			"itemName": "Krakag Orraig",
			"unidentifiedItemName": "Krakag Orraig",
			"texture": load("res://Assets/Weapons/DaggerKrakagOrraig.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/DaggerKrakagOrraig.png"),
			"type": "Weapon",
			"category": "Dagger",
			"weight": 15,
			"value": {
				"dmg": [5,7],
				"d": 2,
				"bonusDmg": {},
				"armorPen": 1,
				"magicDmg": {
					"dmg": [5,6],
					"element": "Toxix"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Dagger of Elbier",
			"unidentifiedItemName": "Dagger of Elbier",
			"texture": load("res://Assets/Weapons/DaggerOfElbier.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/DaggerOfElbier.png"),
			"type": "Weapon",
			"category": "Dagger",
			"weight": 15,
			"value": {
				"dmg": [5,7],
				"d": 2,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [3,3],
					"element": "Thunder"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Crustel flail",
			"unidentifiedItemName": "Crustel flail",
			"texture": load("res://Assets/Weapons/FlailCrustelFlail.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/FlailCrustelFlail.png"),
			"type": "Weapon",
			"category": "Flail",
			"weight": 20,
			"value": {
				"dmg": [5,7],
				"d": 4,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [5, 7],
					"element": "Gleeie'er"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Loperiels Destiny",
			"unidentifiedItemName": "Loperiels Destiny",
			"texture": load("res://Assets/Weapons/FlailLoperielsDestiny.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/FlailLoperielsDestiny.png"),
			"type": "Weapon",
			"category": "Flail",
			"weight": 20,
			"value": {
				"dmg": [3,6],
				"d": 4,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [2,4],
					"element": "Toxix"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Star Love",
			"unidentifiedItemName": "Star Love",
			"texture": load("res://Assets/Weapons/FlailStarLove.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/FlailStarLove.png"),
			"type": "Weapon",
			"category": "Flail",
			"weight": 20,
			"value": {
				"dmg": [4,6],
				"d": 4,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [1,4],
					"element": "Frost"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Dumpel Pompel",
			"unidentifiedItemName": "Dumpel Pompel",
			"texture": load("res://Assets/Weapons/MaceDumpelPompel.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/MaceDumpelPompel.png"),
			"type": "Weapon",
			"category": "Mace",
			"weight": 25,
			"value": {
				"dmg": [9,12],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 6,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Final Dawn",
			"unidentifiedItemName": "Final Dawn",
			"texture": load("res://Assets/Weapons/MaceFinalDawn.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/MaceFinalDawn.png"),
			"type": "Weapon",
			"category": "Mace",
			"weight": 25,
			"value": {
				"dmg": [6,9],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 5,
				"magicDmg": {
					"dmg": [8,12],
					"element": "Fleir"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Titan Slayer",
			"unidentifiedItemName": "Titan Slayer",
			"texture": load("res://Assets/Weapons/MaceTitanSlayer.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/MaceTitanSlayer.png"),
			"type": "Weapon",
			"category": "Mace",
			"weight": 25,
			"value": {
				"dmg": [8,14],
				"d": 1,
				"bonusDmg": {
					"giants": 6
				},
				"armorPen": 5,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Fleirflare",
			"unidentifiedItemName": "Fleirflare",
			"texture": load("res://Assets/Weapons/SwordFleirflare.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/SwordFleirflare.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 20,
			"value": {
				"dmg": [6,9],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [6,8],
					"element": "Fleir"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Frostfury",
			"unidentifiedItemName": "Frostfury",
			"texture": load("res://Assets/Weapons/SwordFrostfury.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/SwordFrostfury.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 20,
			"value": {
				"dmg": [6,9],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [6,8],
					"element": "Frost"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Thunderstruck",
			"unidentifiedItemName": "Thunderstruck",
			"texture": load("res://Assets/Weapons/SwordThunderstruck.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/SwordThunderstruck.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 20,
			"value": {
				"dmg": [6,9],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [6,8],
					"element": "Thunder"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Stormbringer",
			"unidentifiedItemName": "Stormbringer",
			"texture": load("res://Assets/Weapons/SwordStormbringer.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/SwordStormbringer.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 20,
			"value": {
				"dmg": [5,8],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [5,7],
					"element": "Gleeie'er"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Vorpal sword",
			"unidentifiedItemName": "Vorpal sword",
			"texture": load("res://Assets/Weapons/SwordVorpalSword.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/SwordVorpalSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 40,
			"value": {
				"dmg": [15,20],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 3,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Dragonslayer",
			"unidentifiedItemName": "Dragonslayer",
			"texture": load("res://Assets/Weapons/TwohanderDragonslayer.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/TwohanderDragonslayer.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"weight": 75,
			"value": {
				"dmg": [18,27],
				"d": 1,
				"bonusDmg": {
					"dragons": 6
				},
				"armorPen": 5,
				"magicDmg": {
					"dmg": [0,0],
					"element": null
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Brittleleaf",
			"unidentifiedItemName": "Brittleleaf",
			"texture": load("res://Assets/Weapons/TwohanderBrittleLeaf.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/TwohanderBrittleLeaf.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"weight": 50,
			"value": {
				"dmg": [6,9],
				"d": 2,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [3,8],
					"element": "Gleeie'er"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		},
		{
			"itemName": "Icesplitter",
			"unidentifiedItemName": "Icesplitter",
			"texture": load("res://Assets/Weapons/TwohanderIcesplitter.png"),
			"unidentifiedTexture": load("res://Assets/Weapons/TwohanderIcesplitter.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"weight": 50,
			"value": {
				"dmg": [12,15],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": [5,6],
					"element": "Frost"
				}
			},
			"points": 500,
			"enchantable": true,
			"stackable": false
		}
	]
}
