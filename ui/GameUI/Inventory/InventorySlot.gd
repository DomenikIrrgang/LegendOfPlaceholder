extends Panel

@export
var index: int

@onready
var stack_size: Label = $StackSize

@onready
var item_texture: TextureRect = $ItemTexture

@onready
var cooldown_bar: TextureProgressBar = $CooldownBar
var cooldown_scaling_factor: float = 10.0

func initialize(inventory: Inventory, _index: int):
	index = _index
	inventory.slot_changed.connect(on_slot_changed)
	update_slot(inventory.slots[index].item, inventory.slots[index].amount)
	
func on_slot_changed(slot: int, item: Item, amount: int) -> void:
	if slot == index:
		update_slot(item, amount)
		
func update_slot(item: Item, amount: int) -> void:
	if item != null:
		if item.stackable:
			stack_size.text = str(amount)
			stack_size.visible = true
		else:
			stack_size.visible = false
		item_texture.texture = item.icon
		item_texture.visible = true
	else:
		item_texture.visible = false
		stack_size.visible = false
		
func select() -> void:
	item_texture.material.set_shader_parameter("grayscale", true)
	
func deselect() -> void:
	item_texture.material.set_shader_parameter("grayscale", false)	
