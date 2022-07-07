extends Control

var id

var selected = false
var equipmentTexture

#func _ready():
#	var _catchWarning1 = connect("mouse_entered", self, "_mouse_over", [true])
#	var _catchWarning2 = connect("mouse_exited", self, "_mouse_over", [false])

func setValues(_item):
	id = _item.id
	$EquipmentItemArea/ItemContainer/Name.text = str(_item.itemName)
	$EquipmentItemArea/ItemContainer/Alignment.text = str(_item.alignment)
	$EquipmentItemArea/ItemContainer/Enchantment.text = str(_item.enchantment)
	equipmentTexture = _item.getTexture()

func _process(_delta):
	if selected:
		$"/root/World/UI/UITheme/Equipment/DragSprite".global_position = lerp($"/root/World/UI/UITheme/Equipment/DragSprite".global_position, get_global_mouse_position(), _delta * 25)
	if selected and Input.is_action_just_released("LEFT_CLICK"):
		if $"/root/World/UI/UITheme/Equipment".hoveredEquipment != null:
			$"/root/World/UI/UITheme/Equipment".setEquipment(id)
		get_node("/root/World/UI/UITheme/Equipment/DragSprite").texture = null
		selected = false

func _on_EquipmentItemArea_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("LEFT_CLICK") and get_node("/root/World/UI/UITheme/Equipment/DragSprite").texture == null:
		get_node("/root/World/UI/UITheme/Equipment/DragSprite").texture = equipmentTexture
		$"/root/World/UI/UITheme/Equipment/DragSprite".global_position = get_global_mouse_position()
		selected = true
