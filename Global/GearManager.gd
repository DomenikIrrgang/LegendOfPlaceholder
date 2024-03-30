extends Node

var active_bonuses: Array[SetBonus] = []

func _ready() -> void:
	SaveFileManager.save_file_start_loading.connect(reset)
	SaveFileManager.save_file_saving.connect(on_save)
	SaveFileManager.save_file_loaded.connect(on_load)
	Globals.get_player().gear_slot_changed.connect(on_gear_changed)
	
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

func on_gear_changed(slot: Gear.Slot, gear: Gear) -> void:
	if gear != null and gear.gear_set != null:
		var gear_set = gear.gear_set
		for bonus in gear_set.set_bonuses:
			print(gear_set.set_bonuses)
			print(type_string(typeof(bonus)))
			print(type_string(typeof(gear_set)))
			print(type_string(typeof(gear_set.set_bonuses)))
			print(type_string(typeof(gear_set.set_bonuses[0])))
			print(gear_set.alias)
			print(gear_set.set_bonuses)
			print(gear_set.set_bonuses[0])
			print(gear_set.set_bonuses[0].get_class())
			print(gear_set.set_bonuses[0].get_script().resource_path)
			var resource_test = preload("res://Resources/Gear/RunesmithSet/TwoPiece.tres")
			print(resource_test.required_pieces)
			print(gear_set.set_bonuses[0].get_script().resource_path.get_file())
			print(gear_set.set_bonuses[0].required_pieces)
			if gear_set.is_bonus_completed(bonus) and not active_bonuses.has(bonus):
				active_bonuses.append(bonus)
				bonus.on_bonus_active(gear, Globals.get_player())
			if not gear_set.is_bonus_completed(bonus) and active_bonuses.has(bonus):
				active_bonuses.erase(bonus)
				bonus.on_bonus_inactive(gear, Globals.get_player())
