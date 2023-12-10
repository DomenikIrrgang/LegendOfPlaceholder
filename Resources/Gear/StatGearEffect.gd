class_name StatGearEffect
extends GearEffect

@export
var stats: Array[StatAssignment] = []

func on_gear_equipped(gear: Gear, target: Unit) -> void:
	for stat_assignment in stats:
		target.stats.increase_stat(stat_assignment.stat, stat_assignment.value)
	
func on_gear_unequipped(gear: Gear, target: Unit) -> void:
	for stat_assignment in stats:
		target.stats.increase_stat(stat_assignment.stat, -stat_assignment.value)
