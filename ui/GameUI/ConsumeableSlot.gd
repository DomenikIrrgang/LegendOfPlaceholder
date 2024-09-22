extends Control

@export
var item_instance: ItemInstance

@onready
var icon: TextureRect = $Icon

@onready
var amount: Label = $Amount

@onready
var cooldown_bar: TextureProgressBar = $CooldownBar

@onready
var cooldown_text: Label = $CooldownText
var cooldown_scaling_factor: float = 10.0

@onready
var highlight: TextureRect = $Highlight

func _ready():
	Globals.get_inventory().received_item.connect(inventory_changed)
	Globals.get_inventory().removed_item.connect(inventory_changed)
	Globals.get_inventory().slot_changed.connect(inventory_slot_changed)
	Globals.get_drag_and_drop().on_start_dragging.connect(on_start_dragging)
	Globals.get_drag_and_drop().on_stop_dragging.connect(on_stop_dragging)
	gui_input.connect(on_input)
	update_item(item_instance)
		
		
func on_start_dragging() -> void:
	var drag_and_drop = Globals.get_drag_and_drop()
	if drag_and_drop.data.has("inventory"):
		var _item = drag_and_drop.data.inventory_slot.item_instance.item
		if _item.useable:
			highlight.visible = true
					
func on_stop_dragging() -> void:
	highlight.visible = false
		
func update_item(_item: ItemInstance) -> void:
	if _item != null:
		item_instance = _item
		icon.texture = item_instance.item.icon
		amount.text = str(Globals.get_inventory().get_item_amount(item_instance.item))
		cooldown_text.visible = false
		cooldown_bar.visible = false
	else:
		icon.texture = null
		amount.text = ""
	
func inventory_changed(_item: ItemInstance, _amount: int) -> void:
	update_item(item_instance)
	
func inventory_slot_changed(_slot: int, _item: ItemInstance, _amount: int) -> void:
	update_item(item_instance)
		
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
		
func on_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		if Globals.get_drag_and_drop().is_dragging() == true:
			var drag_and_drop = Globals.get_drag_and_drop()
			if drag_and_drop.data.has("inventory"):
				var _item_instance = drag_and_drop.data.inventory_slot.item_instance
				if _item_instance.item.useable:
					Keybinds.set_consumeable_item(_item_instance.item)
					update_item(_item_instance)
					Globals.get_drag_and_drop().stop_dragging()
	
