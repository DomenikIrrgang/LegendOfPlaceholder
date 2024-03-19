extends Panel

var item: Item

@onready
var icon: TextureRect = $ItemTexture

@onready
var amount_label: Label = $Amount

func set_reward(_item: Item, amount: int) -> void:
	item = _item
	icon.texture = item.icon
	amount_label.text = str(amount) if amount > 1 else ""
