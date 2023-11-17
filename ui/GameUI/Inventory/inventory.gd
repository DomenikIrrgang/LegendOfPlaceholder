class_name InventoryWindow
extends PanelContainer

@export
var title: String

@onready
var title_label: Label = $MarginContainer/Content/TitleBar/Title/Text

@onready
var slots: GridContainer = $MarginContainer/Content/Slots

var slot = load("res://ui/GameUI/Inventory/InventorySlot.tscn")

var inventory: Inventory

var selected_item: int = -1

func _ready() -> void:
	title_label.text = title
	
func initialize(_inventory: Inventory) -> void:
	inventory = _inventory
	for i in inventory.get_size():
		var new_slot = slot.instantiate()
		slots.add_child(new_slot)
		new_slot.initialize(inventory, i)
		new_slot.gui_input.connect(on_slot_input.bind(i))
		
func on_slot_input(event: InputEvent, slot: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		if selected_item == -1:
			pick_item(slot)
		else:
			drop_item(slot)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_RIGHT and event.is_pressed():
		if inventory.slots[slot].item.useable:
			inventory.slots[slot].item.use_effect.use(Globals.get_player())			

func pick_item(slot: int) -> void:
	if selected_item == -1 and inventory.slots[slot].item != null:
		selected_item = slot
		slots.get_child(slot).select()

func drop_item(slot: int) -> void:
	if selected_item != -1:
		inventory.swap_slots(selected_item, slot)
		clear_selection()
		
func clear_selection() -> void:
	slots.get_child(selected_item).deselect()	
	selected_item = -1
	
