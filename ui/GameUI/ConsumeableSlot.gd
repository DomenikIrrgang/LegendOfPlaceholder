extends Control

@export
var item: Item

@onready
var icon: TextureRect = $Icon

@onready
var amount: Label = $Amount

@onready
var cooldown_bar: TextureProgressBar = $CooldownBar

@onready
var cooldown_text: Label = $CooldownText
var cooldown_scaling_factor: float = 10.0

func _ready():
	Globals.get_inventory().received_item.connect(inventory_changed)
	Globals.get_inventory().removed_item.connect(inventory_changed)
	Globals.get_inventory().slot_changed.connect(inventory_slot_changed)
	gui_input.connect(on_input)
	if item != null:
		update_item(item)
	else:
		icon.texture = null
		
func update_item(_item: Item) -> void:
	print("updating")
	item = _item
	icon.texture = item.icon
	amount.text = str(Globals.get_inventory().get_item_amount(item))
	cooldown_text.visible = false
	cooldown_bar.visible = false
	
func inventory_changed(_item: Item, amount: int) -> void:
	update_item(item)
	
func inventory_slot_changed(slot: int, _item: Item, amount: int) -> void:
	update_item(item)
		
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
		
func on_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		if Globals.get_drag_and_drop().is_dragging() == true:
			var drag_and_drop = Globals.get_drag_and_drop()
			if drag_and_drop.data.has("inventory"):
				var item = drag_and_drop.data.inventory_slot.item
				if item.useable:
					Keybinds.set_consumeable_item(item)
					update_item(item)
					Globals.get_drag_and_drop().stop_dragging()
	
