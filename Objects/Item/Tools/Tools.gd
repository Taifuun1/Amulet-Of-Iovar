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
			"stackable": false
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
			"stackable": true
		},
		{
			"itemName": "Blindfold",
			"unidentifiedItemName": "Blindfold",
			"texture": load("res://Assets/Tools/Blindfold.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Blindfold.png"),
			"type": "Tool",
			"category": null,
			"weight": 10,
			"value": {
				"worn": null
			},
			"enchantable": false,
			"stackable": true
		},
		{
			"itemName": "Candle",
			"unidentifiedItemName": "Candle",
			"texture": load("res://Assets/Tools/Candle.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Candle.png"),
			"type": "Tool",
			"category": null,
			"weight": 1,
			"value": {
				"turnedOn": null,
				"charges": [150, 100],
				"value": 3
			},
			"enchantable": false,
			"stackable": false
		},
		{
			"itemName": "Credit card",
			"unidentifiedItemName": "Credit card",
			"texture": load("res://Assets/Tools/CreditCard.png"),
			"unidentifiedTexture": load("res://Assets/Tools/CreditCard.png"),
			"type": "Tool",
			"category": null,
			"weight": 2,
			"value": null,
			"enchantable": false,
			"stackable": true
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
			"stackable": false
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
#			"enchantable": true
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
			"stackable": false
		},
		{
			"itemName": "Pickaxe",
			"unidentifiedItemName": "Pickaxe",
			"texture": load("res://Assets/Tools/Pickaxe.png"),
			"unidentifiedTexture": load("res://Assets/Tools/Pickaxe.png"),
			"type": "Tool",
			"category": null,
			"weight": 100,
			"value": null,
			"enchantable": false,
			"stackable": false
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
			"stackable": true
		},
		{
			"itemName": "Ink bottle",
			"unidentifiedItemName": "Ink bottle",
			"texture": load("res://Assets/Tools/InkBottle.png"),
			"unidentifiedTexture": load("res://Assets/Tools/InkBottle.png"),
			"type": "Tool",
			"category": null,
			"weight": 10,
			"value": {
				"ink": [0, 31]
			},
			"enchantable": false,
			"stackable": false
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
			"stackable": true
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
			"stackable": true
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
			"weight": 25,
			"value": null,
			"points": 500,
			"enchantable": false,
			"stackable": false
		},
		{
			"itemName": "Bag of weight",
			"unidentifiedItemName": "Bag",
			"texture": load("res://Assets/Tools/BagOfWeight.png"),
			"unidentifiedTexture": load("res://Assets/Tools/BagLeather.png"),
			"type": "Tool",
			"category": "Container",
			"weight": 250,
			"value": {
				"binds": "Inventory"
			},
			"enchantable": false,
			"stackable": false
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
			"stackable": false
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
			"stackable": true
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
			"stackable": true
		}
	]
}
