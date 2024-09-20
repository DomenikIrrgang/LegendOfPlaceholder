class_name Ingredient
extends Resource

@export
var item: Item

@export
var amount: int = 1

func receive() -> void:
	Globals.get_inventory().add_item(item, amount)
	
func can_receive() -> bool:
	return Globals.get_inventory().can_receive_item(item, amount)
