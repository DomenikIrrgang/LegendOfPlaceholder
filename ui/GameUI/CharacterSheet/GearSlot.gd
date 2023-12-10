extends CenterContainer

@export
var slot: Gear.Slot

@export
var gear: Gear

@onready
var icon: TextureRect = $Icon

@onready
var highlight: NinePatchRect = $Highlight

@onready
var slot_tooltip: Control = $TextTooltipCompnent

var text: String = ""
var item: Item

func _ready() -> void:
	Globals.get_player().gear_slot_changed.connect(on_gear_slot_changed)
	Globals.get_drag_and_drop().on_start_dragging.connect(on_start_dragging)
	Globals.get_drag_and_drop().on_stop_dragging.connect(on_stop_dragging)
	on_gear_slot_changed(slot, Globals.get_player().gear_slots[slot])
	gui_input.connect(on_gear_slot_input)
	
func on_start_dragging() -> void:
	var drag_and_drop = Globals.get_drag_and_drop()
	if drag_and_drop.data.has("inventory") and drag_and_drop.data.inventory_slot.item is Gear and drag_and_drop.data.inventory_slot.item.slot == slot:
		highlight.visible = true
					
func on_stop_dragging() -> void:
	highlight.visible = false

func on_gear_slot_changed(_slot: Gear.Slot, _gear: Gear) -> void:
	if slot == _slot:
		gear = _gear
		item = _gear
		if gear != null:
			icon.texture = _gear.icon
			text = ""
			slot_tooltip.visible = false
		else:
			icon.texture = null
			text = Gear.Slot.keys()[slot].capitalize()
			slot_tooltip.visible = true

func on_gear_slot_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		if Globals.get_drag_and_drop().is_dragging() == false:
			pick_gear()
		else:
			equip_gear()
			
func pick_gear() -> void:
	var drag_and_drop = Globals.get_drag_and_drop()
	if Globals.get_player().gear_slots[slot] != null:
		var gear = Globals.get_player().gear_slots[slot]
		Globals.get_drag_and_drop().start_dragging({
			"gear": gear,
		}, gear.icon)
	
func equip_gear() -> void:
	var drag_and_drop = Globals.get_drag_and_drop()
	if drag_and_drop.data.has("inventory"):
		var inventory = drag_and_drop.data.inventory
		var inventory_slot = drag_and_drop.data.inventory_slot
		var item = inventory_slot.item
		if item is Gear and item.slot == slot:
			var previous_gear: Gear = null
			if Globals.get_player().gear_slots[slot] != null:
				previous_gear = Globals.get_player().gear_slots[slot]
			Globals.get_player().equip_gear_in_slot(slot, item)
			inventory.change_slot(inventory_slot.index, previous_gear, 1)
	drag_and_drop.stop_dragging()
