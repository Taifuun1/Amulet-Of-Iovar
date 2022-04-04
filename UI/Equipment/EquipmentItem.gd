extends Control

var id

var mouseOver = false
var selected = false
var equipmentTexture

func _ready():
	var _catchWarning1 = connect("mouse_entered", self, "_mouse_over", [true])
	var _catchWarning2 = connect("mouse_exited", self, "_mouse_over", [false])
#	$DragItemSprite.hide()

func setValues(_item):
	id = _item.id
	$EquipmentItemArea/ItemContainer/Name.text = str(_item.itemName)
	$EquipmentItemArea/ItemContainer/Alignment.text = str(_item.alignment)
	$EquipmentItemArea/ItemContainer/Enchantment.text = str(_item.enchantment)
	equipmentTexture = _item.getTexture()

func _process(_delta):
	if selected:
		$"/root/World/UI/Equipment/DragSprite".global_position = lerp($"/root/World/UI/Equipment/DragSprite".global_position, get_global_mouse_position(), _delta * 25)
	if selected and Input.is_action_just_released("LEFT_CLICK"):
		if $"/root/World/UI/Equipment".hoveredEquipment != null:
			$"/root/World/UI/Equipment".setEquipment(id)
		get_node("/root/World/UI/Equipment/DragSprite").texture = null
		selected = false
#	if mouseOver and Input.is_mouse_button_pressed(1):
#	if mouseOver and (Input.is_action_pressed("LEFT_CLICK") or InputEvent):
#		print("HELLO 1")
#		$DragItemSprite.show()
#		$DragItemSprite.global_position = get_global_mouse_position()
#	elif mouseOver and Input.is_action_just_released("LEFT_CLICK"):
#		print("HELLO 2")
#		$DragItemSprite.hide()

#func _input(event):
#	if selected:
#		$DragItemSprite.show()
#		$DragItemSprite.global_position = get_global_mouse_position()
#	else:
#		$DragItemSprite.hide()
#	if mouseOver and Input.is_mouse_button_pressed(1):
#	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and mouseOver:
#		$DragItemSprite.show()
#		$DragItemSprite.global_position = get_global_mouse_position()
#	elif mouseOver and event.button_index == BUTTON_LEFT and Input.is_action_just_released("LEFT_CLICK"):
#		print("HELLO 2")
#		$DragItemSprite.hide()
		
#	if mouseOver and (Input.is_action_pressed("LEFT_CLICK") or InputEvent):
#		print("HELLO 1")
#		$DragItemSprite.show()
#		$DragItemSprite.global_position = get_global_mouse_position()
#	elif mouseOver and Input.is_action_just_released("LEFT_CLICK"):
#		print("HELLO 2")
#		$DragItemSprite.hide()

#func _unhandled_input(event):
#	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT and mouseOver:
#		get_tree().set_input_as_handled() # Mark the current input event as "handled"
#		print("YO")
#		clicked()

#func _mouse_over(_mouseOver):
#	mouseOver = _mouseOver

func _on_EquipmentItemArea_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("LEFT_CLICK") and get_node("/root/World/UI/Equipment/DragSprite").texture == null:
		get_node("/root/World/UI/Equipment/DragSprite").texture = equipmentTexture
		$"/root/World/UI/Equipment/DragSprite".global_position = get_global_mouse_position()
		selected = true
