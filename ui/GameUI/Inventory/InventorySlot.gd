extends Panel

@export
var index: int

@onready
var stack_size: Label = $StackSize

@onready
var item_texture: TextureRect = $ItemTexture

var item_instance: ItemInstance

@onready
var cooldown_bar: TextureProgressBar = $CooldownBar

@onready
var cooldown_text: Label = $CooldownText
var cooldown_scaling_factor: float = 10.0

func initialize(inventory: Inventory, _index: int):
	index = _index
	inventory.slot_changed.connect(on_slot_changed)
	update_slot(inventory.slots[index].item_instance, inventory.slots[index].amount)
	cooldown_bar.max_value = 100.0 * cooldown_scaling_factor
	
func on_slot_changed(slot: int, _item: ItemInstance, _amount: int) -> void:
	if slot == index:
		update_slot(_item, _amount)
	
func _process(_delta: float) -> void:
	update_cooldown()
		
func update_cooldown() -> void:
	if item_instance != null and item_instance.item.useable and  item_instance.item.use_effect.has_cooldown() and item_instance.item.use_effect.is_on_cooldown():
		cooldown_bar.value = item_instance.item.use_effect.get_cooldown_progress() * cooldown_scaling_factor
		if item_instance.item.use_effect.is_on_cooldown():
			cooldown_text.visible = true
			cooldown_bar.visible = true
		if item_instance.item.use_effect.get_remaining_cooldown() < 1.0:
			cooldown_text.text = str(snapped(item_instance.item.use_effect.get_remaining_cooldown(), 0.1))
		else:
			cooldown_text.text = str(floor(item_instance.item.use_effect.get_remaining_cooldown()))
	else:
		cooldown_text.visible = false
		cooldown_bar.visible = false
		
func update_slot(_item_instance: ItemInstance, amount: int) -> void:
	item_instance = _item_instance
	if item_instance != null:
		if item_instance.item.stackable:
			stack_size.text = str(amount)
			stack_size.visible = true
		else:
			stack_size.visible = false
		item_texture.texture = item_instance.item.icon
		item_texture.visible = true
		if item_instance.item.useable and item_instance.item.use_effect.has_cooldown():
			cooldown_bar.visible = true
	else:
		item_texture.visible = false
		stack_size.visible = false
		cooldown_bar.visible = false
		
func select() -> void:
	item_texture.material.set_shader_parameter("grayscale", true)
	
func deselect() -> void:
	item_texture.material.set_shader_parameter("grayscale", false)
	
