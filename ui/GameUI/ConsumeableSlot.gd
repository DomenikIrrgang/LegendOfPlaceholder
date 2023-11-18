extends Control

@export
var item: Item

@onready
var icon: TextureRect = $Icon

@onready
var amount: Label = $Amount

func _ready():
	Globals.get_inventory().received_item.connect(inventory_slot_changed)
	Globals.get_inventory().removed_item.connect(inventory_slot_changed)
	gui_input.connect(on_input)
	if item != null:
		update_item(item)
	else:
		icon.texture = null
		
func update_item(_item: Item) -> void:
	item = _item
	icon.texture = item.icon
	amount.text = str(Globals.get_inventory().get_item_amount(item))
	
func inventory_slot_changed(_item: Item, amount: int) -> void:
	if item == _item:
		update_item(item)
		
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
	
