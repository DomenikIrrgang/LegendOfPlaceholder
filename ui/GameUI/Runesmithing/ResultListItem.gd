extends PanelContainer

@onready
var icon: TextureRect = $MarginContainer/HBoxContainer/Icon

@onready
var item_label: Label = $MarginContainer/HBoxContainer/Item

# This is for tooltip
var item: Item

func set_ingridient(ingridient: Ingredient) -> void:
	item_label.text = (str(ingridient.amount) + "x " if ingridient.amount > 1 else "") + ingridient.item.alias
	icon.texture = ingridient.item.icon
	item = ingridient.item
