class_name GearInstance
extends ItemInstance

var rune_slots: Array[RuneSlot] = []

func get_save_data() -> Dictionary:
	return {
		"rune_slots": null
	}
	
func load_save_data(save_data: Dictionary) -> void:
	pass
