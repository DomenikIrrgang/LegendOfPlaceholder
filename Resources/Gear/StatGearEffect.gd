class_name StatGearEffect
extends GearEffect

@export
var stats: Array[StatAssignment] = []

func on_gear_equipped(_gear: Gear, target: Unit) -> void:
	for stat_assignment in stats:
		target.stats.increase_stat(stat_assignment.stat, stat_assignment.value)
	
func on_gear_unequipped(_gear: Gear, target: Unit) -> void:
	for stat_assignment in stats:
		target.stats.increase_stat(stat_assignment.stat, -stat_assignment.value)
