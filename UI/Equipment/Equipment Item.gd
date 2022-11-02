extends Control

var item

var selected = false
var equipmentTexture

func setValues(_item):
	item = _item
	
	$ItemContainer/Name.text = str(_item.itemName)
	if _item.notIdentified.alignment:
		$ItemContainer/Alignment.text = str(_item.alignment)
	else:
		$ItemContainer/Alignment.text = "Unknown"
	if _item.notIdentified.enchantment:
		$ItemContainer/Enchantment.text = str(_item.enchantment)
	else:
		$ItemContainer/Enchantment.text = "Unknown"
	
	equipmentTexture = _item.getTexture()

func updateValues(_itemName):#, _alignment, _enchantment):
	$ItemContainer/Name.text = str(_itemName)
#	if _data.notIdentified.alignment:
#		$ItemContainer/Alignment.text = str(_data.alignment)
#	else:
#		$ItemContainer/Alignment.text = "Unknown"
#	if _data.notIdentified.enchantment:
#		$ItemContainer/Enchantment.text = str(_data.enchantment)
#	else:
#		$ItemContainer/Enchantment.text = "Unknown"

func _process(_delta):
	if selected:
		$"/root/World/UI/UITheme/Equipment/DragSprite".global_position = lerp($"/root/World/UI/UITheme/Equipment/DragSprite".global_position, get_global_mouse_position(), _delta * 25)
	if selected and Input.is_action_just_released("LEFT_CLICK"):
		if $"/root/World/UI/UITheme/Equipment".hoveredEquipment != null:
			$"/root/World/UI/UITheme/Equipment".setEquipment(item.id)
		get_node("/root/World/UI/UITheme/Equipment/DragSprite").texture = null
		selected = false
		get_tree().get_root().set_input_as_handled()

func _on_EquipmentItemArea_input_event(_event):
	if Input.is_action_pressed("LEFT_CLICK") and get_node("/root/World/UI/UITheme/Equipment/DragSprite").texture == null:
		get_node("/root/World/UI/UITheme/Equipment/DragSprite").texture = equipmentTexture
		$"/root/World/UI/UITheme/Equipment/DragSprite".global_position = get_global_mouse_position()
		selected = true
