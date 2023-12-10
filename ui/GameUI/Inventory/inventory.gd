class_name InventoryWindow
extends PanelContainer

static var Events = {
	Opened = "InventoryWindowOpened",
	Closed = "InventoryWindowClosed"
}

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
	Globals.get_drag_and_drop().on_stop_dragging.connect(clear_selection)
	
func toggle() -> void:
	if visible:
		close()
	else:
		open()
	
func open() -> void:
	visible = true
	EventBus.emit_event(InventoryWindow.Events.Opened, {
		"Window" = self
	})
	
func close() -> void:
	visible = false
	if selected_item != -1:
		Globals.get_drag_and_drop().stop_dragging()
	EventBus.emit_event(InventoryWindow.Events.Closed, {
		"Window" = self
	})	
	
func initialize(_inventory: Inventory) -> void:
	inventory = _inventory
	for i in inventory.get_size():
		var new_slot = slot.instantiate()
		slots.add_child(new_slot)
		new_slot.initialize(inventory, i)
		new_slot.gui_input.connect(on_slot_input.bind(i))
		
func on_slot_input(event: InputEvent, _slot: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		if Globals.get_drag_and_drop().is_dragging() == false:
			pick_item(_slot)
		else:
			drop_item(_slot)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_RIGHT and event.is_pressed():
		if inventory.slots[_slot].item is Gear:
			var gear = inventory.slots[_slot].item
			var equiped_gear = Globals.get_player().gear_slots[gear.slot]
			if equiped_gear != null:
				inventory.change_slot(_slot, equiped_gear, 1)
			else:
				inventory.change_slot(_slot, null, 0)
			Globals.get_player().equip_gear_in_slot(gear.slot, gear)
		else:
			inventory.use_slot(Globals.get_player(), _slot)

func pick_item(_slot: int) -> void:
	if Globals.get_drag_and_drop().is_dragging() == false and inventory.slots[_slot].item != null:
		slots.get_child(_slot).select()
		selected_item = _slot
		Globals.get_drag_and_drop().start_dragging({
			"inventory": inventory,
			"inventory_slot": inventory.slots[_slot],
		}, inventory.slots[_slot].item.icon)

func drop_item(_slot: int) -> void:
	if Globals.get_drag_and_drop().is_dragging():
		if Globals.get_drag_and_drop().data.has("inventory"):
			var previous_inventory: Inventory = Globals.get_drag_and_drop().data.inventory
			var inventory_slot: InventorySlot = Globals.get_drag_and_drop().data.inventory_slot
			if inventory.slots[_slot].item != null:
				var item: Item = inventory.slots[_slot].item
				var amount: int = inventory.slots[_slot].amount
				if item == inventory_slot.item and item.stackable and amount + inventory_slot.amount <= item.stack_amount:
					inventory.change_slot(_slot, inventory_slot.item, inventory_slot.amount + amount)
					previous_inventory.change_slot(inventory_slot.index, null, 0)
				else:
					inventory.change_slot(_slot, inventory_slot.item, inventory_slot.amount)
					previous_inventory.change_slot(inventory_slot.index, item, amount)
			else:
				inventory.change_slot(_slot, inventory_slot.item, inventory_slot.amount)
				previous_inventory.change_slot(inventory_slot.index, null, 0)
			Globals.get_drag_and_drop().stop_dragging()
		if Globals.get_drag_and_drop().data.has("gear"):
			var gear = Globals.get_drag_and_drop().data.gear
			if inventory.slots[_slot].item == null:
				Globals.get_player().unequip_gear_in_slot(gear.slot)
				inventory.change_slot(_slot, gear, 1)
			else:
				var inventory_gear = inventory.slots[_slot].item
				if inventory_gear is Gear and inventory_gear.slot == gear.slot:
					Globals.get_player().equip_gear_in_slot(gear.slot, inventory_gear)
					inventory.change_slot(_slot, gear, 1)
			Globals.get_drag_and_drop().stop_dragging()
		
func clear_selection() -> void:
	if selected_item != -1:
		slots.get_child(selected_item).deselect()	
		selected_item = -1
	
