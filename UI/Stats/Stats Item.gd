extends VBoxContainer

func create(_itemName, _itemData):
	$LabelContainer/Name.text = _itemName
	if typeof(_itemData) != TYPE_DICTIONARY:
		$LabelContainer/Count.text = str(_itemData)
	if typeof(_itemData) == TYPE_DICTIONARY and _itemData.has("description") and _itemData.knowledge:
		$Description.text = _itemData.description
		$Description.show()
