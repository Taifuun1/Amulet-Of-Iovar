extends HBoxContainer

func setValues(_item, _amount):
	$Item.text = _item
	if typeof(_amount) == TYPE_ARRAY:
		$Amount.text = str(_amount[0]) + " - " + str(_amount[1])
	else:
		$Amount.text = str(_amount)
