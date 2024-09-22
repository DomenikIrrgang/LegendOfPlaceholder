class_name ItemInstance
extends Node

var item: Item : set = set_item

func get_save_data() -> Dictionary:
	return {}
	
func load_save_data(save_data: Dictionary) -> void:
	pass

func set_item(_item: Item) -> void:
	item = _item
