extends PanelContainer

@onready
var ingridient_name_labeL: Label = $MarginContainer/Left/Label

@onready
var amount_label: Label = $MarginContainer/Right/AmountLabel

@onready
var ingridient_icon: TextureRect = $MarginContainer/Left/Icon

@onready
var taint: ColorRect = $Taint

var ingridient: Ingredient

# This is for the tooltip
var item: Item

func _ready() -> void:
	Globals.get_inventory().inventory_changed.connect(on_inventory_changed)
	
func on_inventory_changed(_item: Item, amount: int) -> void:
	if item == _item:
		amount_label.text = str(Globals.get_inventory().get_item_amount(ingridient.item)) + "/" + str(ingridient.amount)
		taint.visible = Globals.get_inventory().get_item_amount(ingridient.item) < ingridient.amount

func set_ingridient(_ingridient: Ingredient) -> void:
	ingridient = _ingridient
	item = ingridient.item
	ingridient_icon.texture = ingridient.item.icon
	ingridient_name_labeL.text = ingridient.item.alias
	amount_label.text = str(Globals.get_inventory().get_item_amount(ingridient.item)) + "/" + str(ingridient.amount)
	taint.visible = Globals.get_inventory().get_item_amount(ingridient.item) < ingridient.amount
