extends Control

var id

var selected = false
var equipmentTexture

func setValues(_item):
	id = _item.id
	
	$RuneItemArea/ItemContainer/Name.text = str(_item.itemName)
	if _item.notIdentified.alignment:
		$RuneItemArea/ItemContainer/Alignment.text = str(_item.alignment)
	else:
		$RuneItemArea/ItemContainer/Alignment.text = "Unknown"
	if _item.notIdentified.enchantment:
		$RuneItemArea/ItemContainer/Enchantment.text = str(_item.enchantment)
	else:
		$RuneItemArea/ItemContainer/Enchantment.text = "Unknown"
	
	equipmentTexture = _item.getTexture()

func _process(_delta):
	if selected:
		$"/root/World/UI/UITheme/Runes/DragSprite".global_position = lerp($"/root/World/UI/UITheme/Runes/DragSprite".global_position, get_global_mouse_position(), _delta * 25)
	if selected and Input.is_action_just_released("LEFT_CLICK"):
		if $"/root/World/UI/UITheme/Runes".hoveredEquipment != null:
			$"/root/World/UI/UITheme/Runes".setRunes(id)
		get_node("/root/World/UI/UITheme/Runes/DragSprite").texture = null
		selected = false

func _on_RuneItemArea_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("LEFT_CLICK") and get_node("/root/World/UI/UITheme/Runes/DragSprite").texture == null:
		get_node("/root/World/UI/UITheme/Runes/DragSprite").texture = equipmentTexture
		$"/root/World/UI/UITheme/Runes/DragSprite".global_position = get_global_mouse_position()
		selected = true
