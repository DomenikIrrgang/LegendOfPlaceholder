extends Panel

@export
var index: int

@onready
var stack_size: Label = $StackSize

@onready
var item_texture: TextureRect = $ItemTexture

var item: Item

@onready
var cooldown_bar: TextureProgressBar = $CooldownBar

@onready
var cooldown_text: Label = $CooldownText
var cooldown_scaling_factor: float = 10.0

func initialize(inventory: Inventory, _index: int):
	index = _index
	inventory.slot_changed.connect(on_slot_changed)
	update_slot(inventory.slots[index].item, inventory.slots[index].amount)
	cooldown_bar.max_value = 100.0 * cooldown_scaling_factor
	
func on_slot_changed(slot: int, item: Item, amount: int) -> void:
	if slot == index:
		update_slot(item, amount)
	
func _process(delta):
	update_cooldown()
		
func update_cooldown() -> void:
	if item != null and item.useable and  item.use_effect.has_cooldown() and item.use_effect.is_on_cooldown():
		cooldown_bar.value = item.use_effect.get_cooldown_progress() * cooldown_scaling_factor
		if item.use_effect.is_on_cooldown():
			cooldown_text.visible = true
			cooldown_bar.visible = true
		if item.use_effect.get_remaining_cooldown() < 1.0:
			cooldown_text.text = str(snapped(item.use_effect.get_remaining_cooldown(), 0.1))
		else:
			cooldown_text.text = str(floor(item.use_effect.get_remaining_cooldown()))
	else:
		cooldown_text.visible = false
		cooldown_bar.visible = false
		
func update_slot(_item: Item, amount: int) -> void:
	item = _item
	if item != null:
		if item.stackable:
			stack_size.text = str(amount)
			stack_size.visible = true
		else:
			stack_size.visible = false
		item_texture.texture = item.icon
		item_texture.visible = true
		if item.useable and item.use_effect.has_cooldown():
			cooldown_bar.visible = true
	else:
		item_texture.visible = false
		stack_size.visible = false
		cooldown_bar.visible = false
		
func select() -> void:
	item_texture.material.set_shader_parameter("grayscale", true)
	
func deselect() -> void:
	item_texture.material.set_shader_parameter("grayscale", false)
	

