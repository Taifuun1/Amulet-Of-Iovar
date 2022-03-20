extends Area2D

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var id = get_node("..").getId()
		get_node("../../../")._on_Item_Management_List_Clicked(id)
