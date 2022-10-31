extends Control

var statsItem = load("res://UI/Stats/Stats Item.tscn")

func create(_title, _items):
	name = "%sList" % _title
	$Label.text = _title
	
	for _item in _items:
		var newItem = statsItem.instance()
		newItem.create(_item, _items[_item])
		$StatsList.add_child(newItem)
