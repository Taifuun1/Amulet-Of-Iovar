extends Control

var id

var selected = false
var equipmentTexture

func setValues(_item):
	id = _item.id
	
	$ItemContainer/Name.text = str(_item.itemName)
	if _item.notIdentified.piety:
		$ItemContainer/Piety.text = str(_item.piety)
	else:
		$ItemContainer/Piety.text = "?"
	if _item.notIdentified.enchantment:
		$ItemContainer/Enchantment.text = str(_item.enchantment)
	else:
		$ItemContainer/Enchantment.text = "?"
	
	equipmentTexture = _item.getTexture()

func _process(_delta):
	if selected:
		$"/root/World/UI/UITheme/Runes/DragSprite".global_position = lerp($"/root/World/UI/UITheme/Runes/DragSprite".global_position, get_global_mouse_position(), _delta * 25)
	if selected and Input.is_action_just_released("LEFT_CLICK"):
		if $"/root/World/UI/UITheme/Runes".hoveredEquipment != null:
			$"/root/World/UI/UITheme/Runes".setRunes(id)
		get_node("/root/World/UI/UITheme/Runes/DragSprite").texture = null
		selected = false
		get_tree().get_root().set_input_as_handled()

func _on_RuneItem_gui_input(_event):
	if Input.is_action_pressed("LEFT_CLICK") and get_node("/root/World/UI/UITheme/Runes/DragSprite").texture == null:
		get_node("/root/World/UI/UITheme/Runes/DragSprite").texture = equipmentTexture
		$"/root/World/UI/UITheme/Runes/DragSprite".global_position = get_global_mouse_position()
		selected = true
		accept_event()
