class_name DynamicIngridient
extends Ingredient

var item_instance: ItemInstance

func get_possible_ingriedients_from_inventory() -> Array[ItemInstance]:
	return Globals.get_inventory().get_all_items()
