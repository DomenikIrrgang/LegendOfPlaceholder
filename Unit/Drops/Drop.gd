extends Node2D

var item: Item
var amount: int

@onready
var icon: TextureRect = $PanelContainer/MarginContainer/HBoxContainer/Icon

@onready
var alias: Label = $PanelContainer/MarginContainer/HBoxContainer/Name

@onready
var amount_label: Label = $PanelContainer/MarginContainer/HBoxContainer/Amount

func set_item(_item: Item, _amount: int) -> void:
	item = _item
	amount = _amount
	icon.texture = item.icon
	alias.text = item.alias
	if amount > 1:
		amount_label.text = "x" + str(amount)
		amount_label.visible = true
	else:
		amount_label.visible = false

func _on_pickup_area_body_entered(body):
	if body == Globals.get_player():
		var success = Globals.get_inventory().add_item(item, amount)
		if success:
			queue_free()
