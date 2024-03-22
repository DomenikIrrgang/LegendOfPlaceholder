extends Node

func _ready() -> void:
	SaveFileManager.save_file_start_loading.connect(reset)
	SaveFileManager.save_file_saving.connect(on_save)
	SaveFileManager.save_file_loaded.connect(on_load)
	
func reset() -> void:
	for slot in Gear.Slot.values():
		Globals.get_player().unequip_gear_in_slot(slot)
	
func on_save(save_file: Dictionary) -> void:
	save_file.gear = Gear.Slot.values().map(func(value: int):
		return {
			slot = Gear.Slot.keys()[value],
			gear = SaveFileManager.get_resource_uid(Globals.get_player().gear_slots[value]) if Globals.get_player().gear_slots[value] != null else null
		}
	)
	
func on_load(save_file: Dictionary) -> void:
	for equiped_gear in save_file.gear:
		if equiped_gear.gear != null:
			Globals.get_player().equip_gear_in_slot(
				Gear.Slot[equiped_gear.slot],
				SaveFileManager.get_resource_from_uid(equiped_gear.gear)
			)
