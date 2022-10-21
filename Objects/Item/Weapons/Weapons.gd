var weapons = {
	"common": [
		{
			"itemName": "Chipped sword",
			"unidentifiedItemName": "Chipped sword",
			"texture": load("res://Assets/Weapons/SwordChippedSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordChippedSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 50,
			"value": {
				"dmg": [2,4],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Common",
			"identified": false
		},
		{
			"itemName": "Dull two-hander",
			"unidentifiedItemName": "Dull two-handed sword",
			"texture": load("res://Assets/Weapons/TwohanderDullTwohander.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/TwohanderDullTwohander.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"weight": 50,
			"value": {
				"dmg": [4,7],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Common",
			"identified": false
		},
		{
			"itemName": "Cut dagger",
			"unidentifiedItemName": "Cut dagger",
			"texture": load("res://Assets/Weapons/DaggerCutDagger.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/DaggerCutDagger.png"),
			"type": "Weapon",
			"category": "Dagger",
			"weight": 50,
			"value": {
				"dmg": [1,3],
				"d": 2,
				"bonusDmg": {
					"baseWeapon": 1
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Common",
			"identified": false
		},
		{
			"itemName": "Worn mace",
			"unidentifiedItemName": "Worn mace",
			"texture": load("res://Assets/Weapons/MaceWornMace.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/MaceWornMace.png"),
			"type": "Weapon",
			"category": "Mace",
			"weight": 50,
			"value": {
				"dmg": [3,5],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 1,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Common",
			"identified": false
		},
		{
			"itemName": "Rigid flail",
			"unidentifiedItemName": "Rigid flail",
			"texture": load("res://Assets/Weapons/FlailRigidFlail.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/FlailRigidFlail.png"),
			"type": "Weapon",
			"category": "Flail",
			"weight": 50,
			"value": {
				"dmg": [1,3],
				"d": 3,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Common",
			"identified": false
		}
	],
	"uncommon": [
		{
			"itemName": "Orc dagger",
			"unidentifiedItemName": "Dark dagger",
			"texture": load("res://Assets/Weapons/DaggerOrcDagger.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/DaggerOrcDagger.png"),
			"type": "Weapon",
			"category": "Dagger",
			"weight": 50,
			"value": {
				"dmg": [3,5],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 1
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Uncommon",
			"identified": false
		},
		{
			"itemName": "Sharp flail",
			"unidentifiedItemName": "Sharp flail",
			"texture": load("res://Assets/Weapons/FlailSharpFlail.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/FlailSharpFlail.png"),
			"type": "Weapon",
			"category": "Flail",
			"weight": 50,
			"value": {
				"dmg": [2,4],
				"d": 3,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Uncommon",
			"identified": false
		},
		{
			"itemName": "Dwarvish laysword",
			"unidentifiedItemName": "Dwarvish laysword",
			"texture": load("res://Assets/Weapons/SwordDwarvishLaysword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordDwarvishLaysword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 50,
			"value": {
				"dmg": [5,8],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 2
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Uncommon",
			"identified": false
		},
		{
			"itemName": "Orcish sword",
			"unidentifiedItemName": "Dark sword",
			"texture": load("res://Assets/Weapons/SwordOrcSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordOrcSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 50,
			"value": {
				"dmg": [5,7],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 1
				},
				"armorPen": 1,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Uncommon",
			"identified": false
		},
		{
			"itemName": "Elvish sword",
			"unidentifiedItemName": "Elvish sword",
			"texture": load("res://Assets/Weapons/SwordElvishSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordElvishSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 50,
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Uncommon",
			"identified": false
		}
	],
	"rare": [
		{
			"itemName": "Glowing dagger",
			"unidentifiedItemName": "Glowing dagger",
			"texture": load("res://Assets/Weapons/DaggerGlowingDagger.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/DaggerGlowingDagger.png"),
			"type": "Weapon",
			"category": "Dagger",
			"weight": 50,
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Rare",
			"identified": false
		},
		{
			"itemName": "Morning star",
			"unidentifiedItemName": "Morning star",
			"texture": load("res://Assets/Weapons/MaceMorningStar.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/MaceMorningStar.png"),
			"type": "Weapon",
			"category": "Mace",
			"weight": 50,
			"value": {
				"dmg": [7,10],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 3,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Rare",
			"identified": false
		},
		{
			"itemName": "Adorned sword",
			"unidentifiedItemName": "Adorned sword",
			"texture": load("res://Assets/Weapons/SwordAdornedSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordAdornedSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 50,
			"value": {
				"dmg": [7,10],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 1
				},
				"armorPen": 1,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Rare",
			"identified": false
		},
		{
			"itemName": "Mithril two-hander",
			"unidentifiedItemName": "Mithril two-hander",
			"texture": load("res://Assets/Weapons/TwohanderMithrilTwohander.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/TwohanderMithrilTwohander.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"weight": 50,
			"value": {
				"dmg": [8,14],
				"d": 1,
				"bonusDmg": {
					"baseWeapon": 3
				},
				"armorPen": 0,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Rare",
			"identified": false
		}
	],
	"legendary": [
		{
			"itemName": "Krakag Orraig",
			"unidentifiedItemName": "Krakag Orraig",
			"texture": load("res://Assets/Weapons/DaggerKrakagOrraig.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/DaggerKrakagOrraig.png"),
			"type": "Weapon",
			"category": "Dagger",
			"weight": 50,
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Dagger of Elbier",
			"unidentifiedItemName": "Dagger of Elbier",
			"texture": load("res://Assets/Weapons/DaggerOfElbier.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/DaggerOfElbier.png"),
			"type": "Weapon",
			"category": "Dagger",
			"weight": 50,
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Crustel flail",
			"unidentifiedItemName": "Crustel flail",
			"texture": load("res://Assets/Weapons/FlailCrustelFlail.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/FlailCrustelFlail.png"),
			"type": "Weapon",
			"category": "Flail",
			"weight": 50,
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Loperiels Destiny",
			"unidentifiedItemName": "Loperiels Destiny",
			"texture": load("res://Assets/Weapons/FlailLoperielsDestiny.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/FlailLoperielsDestiny.png"),
			"type": "Weapon",
			"category": "Flail",
			"weight": 50,
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Dumpel Pompel",
			"unidentifiedItemName": "Dumpel Pompel",
			"texture": load("res://Assets/Weapons/MaceDumpelPompel.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/MaceDumpelPompel.png"),
			"type": "Weapon",
			"category": "Mace",
			"weight": 50,
			"value": {
				"dmg": [9,12],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 6,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Final Dawn",
			"unidentifiedItemName": "Final Dawn",
			"texture": load("res://Assets/Weapons/MaceFinalDawn.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/MaceFinalDawn.png"),
			"type": "Weapon",
			"category": "Mace",
			"weight": 50,
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Titan Slayer",
			"unidentifiedItemName": "Titan Slayer",
			"texture": load("res://Assets/Weapons/MaceTitanSlayer.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/MaceTitanSlayer.png"),
			"type": "Weapon",
			"category": "Mace",
			"weight": 50,
			"value": {
				"dmg": [8,14],
				"d": 1,
				"bonusDmg": {
					"giants": 5
				},
				"armorPen": 5,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Fleirflare",
			"unidentifiedItemName": "Fleirflare",
			"texture": load("res://Assets/Weapons/SwordFleirflare.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordFleirflare.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 50,
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Frostfury",
			"unidentifiedItemName": "Frostfury",
			"texture": load("res://Assets/Weapons/SwordFrostfury.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordFrostfury.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 50,
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Justice'eer sword",
			"unidentifiedItemName": "Justice'eer sword",
			"texture": load("res://Assets/Weapons/SwordJustice'eerSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordJustice'eerSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 50,
			"value": {
				"dmg": [8,14],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 0,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Stormbringer",
			"unidentifiedItemName": "Stormbringer",
			"texture": load("res://Assets/Weapons/SwordStormbringer.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordStormbringer.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 50,
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Vorpal sword",
			"unidentifiedItemName": "Vorpal sword",
			"texture": load("res://Assets/Weapons/SwordVorpalSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordVorpalSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"weight": 50,
			"value": {
				"dmg": [13,18],
				"d": 1,
				"bonusDmg": {},
				"armorPen": 3,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Giantslayer",
			"unidentifiedItemName": "Giantslayer",
			"texture": load("res://Assets/Weapons/TwohanderGiantslayer.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/TwohanderGiantslayer.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"weight": 50,
			"value": {
				"dmg": [18,26],
				"d": 1,
				"bonusDmg": {
					"giants": 5
				},
				"armorPen": 3,
				"magicDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Brittleleaf",
			"unidentifiedItemName": "Brittleleaf",
			"texture": load("res://Assets/Weapons/TwohanderBrittleLeaf.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/TwohanderBrittleLeaf.png"),
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		},
		{
			"itemName": "Icesplitter",
			"unidentifiedItemName": "Icesplitter",
			"texture": load("res://Assets/Weapons/TwohanderIcesplitter.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/TwohanderIcesplitter.png"),
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
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary",
			"identified": false
		}
	]
}
