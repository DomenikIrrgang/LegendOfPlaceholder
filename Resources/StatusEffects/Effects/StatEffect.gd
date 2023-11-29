class_name StatStatusEffect
extends StatusEffectScript

@export
var stats: Array[StatAssignment] = []

func on_status_effect_applied(status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	for stat_assignment in stats:
		target.stats.increase_stat(stat_assignment.stat, stacks * stat_assignment.value)
		
func on_status_effect_stack_applied(status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	for stat_assignment in stats:
		target.stats.increase_stat(stat_assignment.stat, stacks * stat_assignment.value)
		
func on_status_effect_stack_removed(status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	for stat_assignment in stats:
		target.stats.increase_stat(stat_assignment.stat, stacks * -stat_assignment.value)
	
func on_status_effect_removed(status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	for stat_assignment in stats:
		target.stats.increase_stat(stat_assignment.stat, stacks * -stat_assignment.value)
