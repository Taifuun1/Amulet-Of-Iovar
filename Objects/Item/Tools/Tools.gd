var tools = {
	"common": [
		{
			"itemName": "Leather bag",
			"unidentifiedItemName": "Bag",
			"texture": load("res://Assets/Tools/BagLeather.png"),
			"unidentifiedTexture": load("res://Assets/Tools/BagLeather.png"),
			"type": "Tool",
			"category": "Container",
			"weight": 25,
			"value": null,
			"enchantable": false,
			"stackable": false,
			"rarity": "Common",
			"identified": false
		},
		{
			"itemName": "Lockpick",
			"unidentifiedItemName": "Lockpick",
			"texture": load("res://Assets/Tools/Lockpick.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Lockpick.png"),
			"type": "Tool",
			"category": null,
			"weight": 5,
			"value": null,
			"enchantable": false,
			"stackable": true,
			"rarity": "Common",
			"identified": false
		},
		{
			"itemName": "Blindfold",
			"unidentifiedItemName": "Blindfold",
			"texture": load("res://Assets/Tools/Blindfold.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Blindfold.png"),
			"type": "Tool",
			"category": null,
			"weight": 5,
			"value": {
				"worn": null
			},
			"enchantable": false,
			"stackable": true,
			"rarity": "Common",
			"identified": false
		},
		{
			"itemName": "Candle",
			"unidentifiedItemName": "Candle",
			"texture": load("res://Assets/Tools/Candle.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Candle.png"),
			"type": "Tool",
			"category": null,
			"weight": 5,
			"value": {
				"turnedOn": null,
				"charges": [150, 100],
				"value": 3
			},
			"enchantable": false,
			"stackable": false,
			"rarity": "Common",
			"identified": false
		},
		{
			"itemName": "Credit card",
			"unidentifiedItemName": "Credit card",
			"texture": load("res://Assets/Tools/CreditCard.png"),
			"unidentifiedTexture": load("res://Assets/Tools/CreditCard.png"),
			"type": "Tool",
			"category": null,
			"weight": 5,
			"value": null,
			"enchantable": false,
			"stackable": true,
			"rarity": "Common",
			"identified": false
		},
		{
			"itemName": "Shovel",
			"unidentifiedItemName": "Shovel",
			"texture": load("res://Assets/Tools/Shovel.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Shovel.png"),
			"type": "Tool",
			"category": null,
			"weight": 50,
			"value": null,
			"enchantable": false,
			"stackable": false,
			"rarity": "Common",
			"identified": false
		}
#		{
#			"itemName": "Fancy whistle",
#			"unidentifiedItemName": "Whistle",
#			"texture": load("res://Assets/Tools/WhistleFancy.png"),
#			"unidentifiedTexture": load("res://Assets/Tools/WhistleFancy.png"),
#			"type": "Tool",
#			"category": null,
#			"weight": 5,
#			"value": null,
#			"enchantable": true,
#			"stackable": false,
#			"rarity": "Common"
#		}
	],
	"uncommon": [
		{
			"itemName": "Oil lamp",
			"unidentifiedItemName": "Lamp",
			"texture": load("res://Assets/Tools/LampOil.png"),
			"unidentifiedTexture": load("res://Assets/Tools/LampOil.png"),
			"type": "Tool",
			"category": null,
			"weight": 25,
			"value": {
				"turnedOn": null,
				"charges": [500, 750],
				"value": 5
			},
			"enchantable": false,
			"stackable": false,
			"rarity": "Common",
			"identified": false
		},
		{
			"itemName": "Pickaxe",
			"unidentifiedItemName": "Pickaxe",
			"texture": load("res://Assets/Tools/Pickaxe.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Pickaxe.png"),
			"type": "Tool",
			"category": null,
			"weight": 50,
			"value": null,
			"enchantable": false,
			"stackable": false,
			"rarity": "Uncommon",
			"identified": false
		},
		{
			"itemName": "Marker",
			"unidentifiedItemName": "Marker",
			"texture": load("res://Assets/Tools/Marker.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Marker.png"),
			"type": "Tool",
			"category": null,
			"weight": 5,
			"value": null,
			"enchantable": false,
			"stackable": true,
			"rarity": "Uncommon",
			"identified": false
		},
		{
			"itemName": "Ink bottle",
			"unidentifiedItemName": "Ink bottle",
			"texture": load("res://Assets/Tools/InkBottle.png"),
			"unidentifiedTexture": load("res://Assets/Tools/InkBottle.png"),
			"type": "Tool",
			"category": null,
			"weight": 5,
			"value": {
				"ink": [0, 31]
			},
			"enchantable": false,
			"stackable": false,
			"rarity": "Uncommon",
			"identified": false
		},
		{
			"itemName": "Key",
			"unidentifiedItemName": "Key",
			"texture": load("res://Assets/Tools/Key.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Key.png"),
			"type": "Tool",
			"category": null,
			"weight": 5,
			"value": null,
			"enchantable": false,
			"stackable": true,
			"rarity": "Uncommon",
			"identified": false
		},
		{
			"itemName": "Message in a bottle",
			"unidentifiedItemName": "Message in a bottle",
			"texture": load("res://Assets/Tools/MessageInABottle.png"),
			"unidentifiedTexture": load("res://Assets/Tools/MessageInABottle.png"),
			"type": "Tool",
			"category": null,
			"weight": 25,
			"value": null,
			"enchantable": false,
			"stackable": true,
			"rarity": "Uncommon",
			"identified": false
		}
	],
	"rare": [
		{
			"itemName": "Bag of holding",
			"unidentifiedItemName": "Bag",
			"texture": load("res://Assets/Tools/BagOfHolding.png"),
			"unidentifiedTexture": load("res://Assets/Tools/BagLeather.png"),
			"type": "Tool",
			"category": "Container",
			"weight": 10,
			"value": null,
			"points": 500,
			"enchantable": false,
			"stackable": false,
			"rarity": "Rare",
			"identified": false
		},
		{
			"itemName": "Bag of weight",
			"unidentifiedItemName": "Bag",
			"texture": load("res://Assets/Tools/BagOfWeight.png"),
			"unidentifiedTexture": load("res://Assets/Tools/BagLeather.png"),
			"type": "Tool",
			"category": "Container",
			"weight": 150,
			"value": {
				"binds": "Inventory"
			},
			"enchantable": false,
			"stackable": false,
			"rarity": "Rare",
			"identified": false
		},
		{
			"itemName": "Magic lamp",
			"unidentifiedItemName": "Lamp",
			"texture": load("res://Assets/Tools/LampMagic.png"),
			"unidentifiedTexture": load("res://Assets/Tools/LampOil.png"),
			"type": "Tool",
			"category": null,
			"weight": 25,
			"value": {
				"turnedOn": null,
				"charges": -1,
				"value": 7
			},
			"points": 250,
			"enchantable": false,
			"stackable": false,
			"rarity": "Rare",
			"identified": false
		},
		{
			"itemName": "Tome of Knowledge",
			"unidentifiedItemName": "Heavy tome",
			"texture": load("res://Assets/Tools/TomeOfKnowledge.png"),
			"unidentifiedTexture": load("res://Assets/Tools/TomeOfKnowledge.png"),
			"type": "Tool",
			"category": null,
			"weight": 25,
			"value": null,
			"points": 250,
			"enchantable": false,
			"stackable": true,
			"rarity": "Rare",
			"identified": false
		},
		{
			"itemName": "Magic marker",
			"unidentifiedItemName": "Marker",
			"texture": load("res://Assets/Tools/MarkerMagic.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Marker.png"),
			"type": "Tool",
			"category": null,
			"weight": 5,
			"value": null,
			"enchantable": false,
			"stackable": true,
			"rarity": "Rare",
			"identified": false
		},
		{
			"itemName": "Magic key",
			"unidentifiedItemName": "Key",
			"texture": load("res://Assets/Tools/KeyMagic.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Key.png"),
			"type": "Tool",
			"category": null,
			"weight": 5,
			"value": null,
			"enchantable": false,
			"stackable": true,
			"rarity": "Rare",
			"identified": false
		}
	]
}
