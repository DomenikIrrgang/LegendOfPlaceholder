extends Node

var active_bonuses: Array[SetBonus] = []

func _ready() -> void:
	SaveFileManager.game_state_start_loading.connect(reset)
	SaveFileManager.game_state_saving.connect(on_save)
	SaveFileManager.game_state_loaded.connect(on_load)
	
func reset() -> void:
	for slot in Gear.Slot.values():
		Globals.get_player().unequip_gear_in_slot(slot)
	
func on_save(game_state: Dictionary) -> void:
	game_state.gear = Gear.Slot.values().map(func(value: int):
		return {
			slot = Gear.Slot.keys()[value],
			gear = SaveFileManager.get_resource_uid(Globals.get_player().gear_slots[value]) if Globals.get_player().gear_slots[value] != null else null
		}
	)
	
func on_load(game_state: Dictionary) -> void:
	Globals.get_player().equipped_gear.connect(on_gear_changed)
	Globals.get_player().unequipped_gear.connect(on_gear_changed)
	for equiped_gear in game_state.gear:
		if equiped_gear.gear != null:
			Globals.get_player().equip_gear_in_slot(
				Gear.Slot[equiped_gear.slot],
				SaveFileManager.get_resource_from_uid(equiped_gear.gear)
			)

func on_gear_changed(gear: Gear) -> void:
	if gear != null and gear.gear_set != null:
		var gear_set = gear.gear_set
		for bonus in gear_set.set_bonuses:
			if gear_set.is_bonus_completed(bonus) and not active_bonuses.has(bonus):
				active_bonuses.append(bonus)
				bonus.on_bonus_active(gear, Globals.get_player())
			if not gear_set.is_bonus_completed(bonus) and active_bonuses.has(bonus):
				active_bonuses.erase(bonus)
				bonus.on_bonus_inactive(gear, Globals.get_player())
