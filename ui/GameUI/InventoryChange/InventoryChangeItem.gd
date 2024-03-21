class_name InventoryChangeItem
extends PanelContainer

@onready
var icon: TextureRect = $MarginContainer/HBoxContainer/Icon

@onready
var label: Label = $MarginContainer/HBoxContainer/Text

func set_change(item: Item, amount: int) -> void:
	icon.texture = item.icon
	label.text = (str(amount) + "x " if amount > 1 else "") + item.alias
	var timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(on_timer_completed)
	timer.one_shot = true
	timer.start(3.0)
	
func on_timer_completed() -> void:
	queue_free()
