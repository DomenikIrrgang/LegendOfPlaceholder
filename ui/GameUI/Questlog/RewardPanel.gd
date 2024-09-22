extends Panel

var item: Item
var item_instance: ItemInstance

@onready
var icon: TextureRect = $ItemTexture

@onready
var amount_label: Label = $Amount

func set_reward(_item: Item, amount: int) -> void:
	item = _item
	item_instance = Globals.new_item_instance(item)
	icon.texture = item.icon
	amount_label.text = str(amount) if amount > 1 else ""
