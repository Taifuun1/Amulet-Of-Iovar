var weapons = {
	"common": [
		{
			"itemName": "Chipped sword",
			"unidentifiedItemName": "Chipped sword",
			"texture": load("res://Assets/Weapons/SwordChippedSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordChippedSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"value": {
				"dmg": [2,4],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Common"
		},
		{
			"itemName": "Dull two-hander",
			"unidentifiedItemName": "Dull two-handed sword",
			"texture": load("res://Assets/Weapons/TwohandedSwordDullTwohander.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/TwohandedSwordDullTwohander.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"value": {
				"dmg": [4,7],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Common"
		},
		{
			"itemName": "Cut dagger",
			"unidentifiedItemName": "Cut dagger",
			"texture": load("res://Assets/Weapons/DaggerCutDagger.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/DaggerCutDagger.png"),
			"type": "Weapon",
			"category": "Dagger",
			"value": {
				"dmg": [1,3],
				"d": 2,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Common"
		},
		{
			"itemName": "Worn mace",
			"unidentifiedItemName": "Worn mace",
			"texture": load("res://Assets/Weapons/MaceWornMace.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/MaceWornMace.png"),
			"type": "Weapon",
			"category": "Mace",
			"value": {
				"dmg": [2,4],
				"d": 1,
				"bonusDmg": {
					"dmg": 1,
					"element": "Toxix"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Common"
		},
		{
			"itemName": "Rigid flail",
			"unidentifiedItemName": "Rigid flail",
			"texture": load("res://Assets/Weapons/FlailRigidFlail.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/FlailRigidFlail.png"),
			"type": "Weapon",
			"category": "Flail",
			"value": {
				"dmg": [1,2],
				"d": 3,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Common"
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
			"value": {
				"dmg": [3,5],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Uncommon"
		},
		{
			"itemName": "Sharp Flail",
			"unidentifiedItemName": "Sharp Flail",
			"texture": load("res://Assets/Weapons/FlailSharpFlail.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/FlailSharpFlail.png"),
			"type": "Weapon",
			"category": "Flail",
			"value": {
				"dmg": [7,10],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Uncommon"
		},
		{
			"itemName": "Dwarvish laysword",
			"unidentifiedItemName": "Dwarvish laysword",
			"texture": load("res://Assets/Weapons/SwordDwarvishLaysword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordDwarvishLaysword.png"),
			"type": "Weapon",
			"category": "Sword",
			"value": {
				"dmg": [4,6],
				"d": 2,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Uncommon"
		},
		{
			"itemName": "Orcish sword",
			"unidentifiedItemName": "Dark sword",
			"texture": load("res://Assets/Weapons/SwordOrcSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordOrcSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"value": {
				"dmg": [4,6],
				"d": 2,
				"bonusDmg": {
					"dmg": 1,
					"element": "Toxix"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Uncommon"
		},
		{
			"itemName": "Elvish sword",
			"unidentifiedItemName": "Elvish sword",
			"texture": load("res://Assets/Weapons/SwordElvishSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordElvishSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"value": {
				"dmg": [4,6],
				"d": 2,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Uncommon"
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
			"value": {
				"dmg": [2,4],
				"d": 2,
				"bonusDmg": {
					"dmg": 2,
					"element": "Thunder"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Rare"
		},
		{
			"itemName": "Morning star",
			"unidentifiedItemName": "Morning star",
			"texture": load("res://Assets/Weapons/MaceMorningStar.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/MaceMorningStar.png"),
			"type": "Weapon",
			"category": "Mace",
			"value": {
				"dmg": [6,8],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Rare"
		},
		{
			"itemName": "Adorned sword",
			"unidentifiedItemName": "Adorned sword",
			"texture": load("res://Assets/Weapons/SwordAdornedSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordAdornedSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"value": {
				"dmg": [7,10],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Rare"
		},
		{
			"itemName": "Mithril two-hander",
			"unidentifiedItemName": "Mithril two-hander",
			"texture": load("res://Assets/Weapons/TwohandedSwordMithrilTwohander.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/TwohandedSwordMithrilTwohander.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"value": {
				"dmg": [8,14],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Rare"
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
			"value": {
				"dmg": [5,7],
				"d": 2,
				"bonusDmg": {
					"dmg": 5,
					"element": "Toxix"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Dagger of Elbier",
			"unidentifiedItemName": "Dagger of Elbier",
			"texture": load("res://Assets/Weapons/DaggerOfElbier.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/DaggerOfElbier.png"),
			"type": "Weapon",
			"category": "Dagger",
			"value": {
				"dmg": [5,7],
				"d": 2,
				"bonusDmg": {
					"dmg": 3,
					"element": "Thunder"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Crustel Flail",
			"unidentifiedItemName": "Crustel Flail",
			"texture": load("res://Assets/Weapons/FlailCrustelFlail.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/FlailCrustelFlail.png"),
			"type": "Weapon",
			"category": "Flail",
			"value": {
				"dmg": [5,7],
				"d": 4,
				"bonusDmg": {
					"dmg": 5,
					"element": "Gleeie'er"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Loperiels Destiny",
			"unidentifiedItemName": "Loperiels Destiny",
			"texture": load("res://Assets/Weapons/FlailLoperielsDestiny.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/FlailLoperielsDestiny.png"),
			"type": "Weapon",
			"category": "Flail",
			"value": {
				"dmg": [3,6],
				"d": 4,
				"bonusDmg": {
					"dmg": 2,
					"element": "Toxix"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Dumpel Pompel",
			"unidentifiedItemName": "Dumpel Pompel",
			"texture": load("res://Assets/Weapons/MaceDumpelPompel.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/MaceDumpelPompel.png"),
			"type": "Weapon",
			"category": "Mace",
			"value": {
				"dmg": [8,10],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Final Dawn",
			"unidentifiedItemName": "Final Dawn",
			"texture": load("res://Assets/Weapons/MaceFinalDawn.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/MaceFinalDawn.png"),
			"type": "Weapon",
			"category": "Mace",
			"value": {
				"dmg": [6,8],
				"d": 1,
				"bonusDmg": {
					"dmg": 8,
					"element": "Fleir"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Titan Slayer",
			"unidentifiedItemName": "Titan Slayer",
			"texture": load("res://Assets/Weapons/MaceTitanSlayer.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/MaceTitanSlayer.png"),
			"type": "Weapon",
			"category": "Mace",
			"value": {
				"dmg": [8,14],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Fleirflare",
			"unidentifiedItemName": "Fleirflare",
			"texture": load("res://Assets/Weapons/SwordFleirflare.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordFleirflare.png"),
			"type": "Weapon",
			"category": "Sword",
			"value": {
				"dmg": [6,8],
				"d": 1,
				"bonusDmg": {
					"dmg": 6,
					"element": "Fleir"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Frostfury",
			"unidentifiedItemName": "Frostfury",
			"texture": load("res://Assets/Weapons/SwordFrostfury.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordFrostfury.png"),
			"type": "Weapon",
			"category": "Sword",
			"value": {
				"dmg": [6,8],
				"d": 1,
				"bonusDmg": {
					"dmg": 6,
					"element": "Frost"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Justice'eer Sword",
			"unidentifiedItemName": "Justice'eer Sword",
			"texture": load("res://Assets/Weapons/SwordJustice'eerSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordJustice'eerSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"value": {
				"dmg": [8,14],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Stormbringer",
			"unidentifiedItemName": "Stormbringer",
			"texture": load("res://Assets/Weapons/SwordStormbringer.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordStormbringer.png"),
			"type": "Weapon",
			"category": "Sword",
			"value": {
				"dmg": [5,7],
				"d": 1,
				"bonusDmg": {
					"dmg": 5,
					"element": "Gleeie'er"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Vorpal Sword",
			"unidentifiedItemName": "Vorpal Sword",
			"texture": load("res://Assets/Weapons/SwordVorpalSword.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/SwordVorpalSword.png"),
			"type": "Weapon",
			"category": "Sword",
			"value": {
				"dmg": [13,17],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Giantslayer",
			"unidentifiedItemName": "Giantslayer",
			"texture": load("res://Assets/Weapons/TwohandedGiantslayer.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/TwohandedGiantslayer.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"value": {
				"dmg": [18,22],
				"d": 1,
				"bonusDmg": {
					"dmg": 0,
					"element": null
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "BrittleLeaf",
			"unidentifiedItemName": "BrittleLeaf",
			"texture": load("res://Assets/Weapons/TwohandedSwordBrittleLeaf.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/TwohandedSwordBrittleLeaf.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"value": {
				"dmg": [6,8],
				"d": 2,
				"bonusDmg": {
					"dmg": 3,
					"element": "Gleeie'er"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		},
		{
			"itemName": "Icesplitter",
			"unidentifiedItemName": "Icesplitter",
			"texture": load("res://Assets/Weapons/TwohandedSwordIcesplitter.png"),
			"unIdentifiedTexture": load("res://Assets/Weapons/TwohandedSwordIcesplitter.png"),
			"type": "Weapon",
			"category": "Two-hander",
			"value": {
				"dmg": [12,15],
				"d": 1,
				"bonusDmg": {
					"dmg": 6,
					"element": "Frost"
				}
			},
			"enchantment": true,
			"stackable": false,
			"rarity": "Legendary"
		}
	]
}
