extends Panel

func create(_itemName, _itemData):
	if typeof(_itemData) != TYPE_DICTIONARY:
		set_custom_minimum_size(Vector2(920, 24))
		$ItemContainer/LabelContainer/Name.text = _itemName
		$ItemContainer/LabelContainer/Count.text = str(_itemData)
		return
	if typeof(_itemData) == TYPE_DICTIONARY and _itemData.has("description") and _itemData.knowledge:
		$ItemContainer/LabelContainer/Name.text = _itemName
		$ItemContainer/Description.text = _itemData.description
		$ItemContainer/Description.show()
	else:
		$ItemContainer/LabelContainer/Name.text = "?"
		$ItemContainer/Description.show()
