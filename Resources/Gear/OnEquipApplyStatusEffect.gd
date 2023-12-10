class_name OnEquipApplyStatusEffect
extends OnEquipEffect

@export
var status_effects: Array[StatusEffect] = []

func on_gear_equipped(gear: Gear, target: Unit) -> void:
	for status_effect in status_effects:
		target.apply_status_effect(status_effect, target, 1)
	
func on_gear_unequipped(gear: Gear, target: Unit) -> void:
	for status_effect in status_effects:
		target.remove_status_effect(status_effect, target)
