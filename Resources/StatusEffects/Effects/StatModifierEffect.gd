class_name StatModifierEffect
extends StatusEffectScript

@export
var stats: Array[StatModifierAssignment] = []

var stat_modifiers: Array[StatModifier] = []

func on_status_effect_applied(_status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	for stat_assignment in stats:
		var stat_modifier = StatModifier.new(stat_assignment.stat, stat_assignment.value * stacks)
		target.stats.add_stat_modifier(stat_modifier)
		stat_modifiers.append(stat_modifier)
		
func on_status_effect_stack_applied(_status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	for i in stats.size():
		stat_modifiers[i].modifier += stacks * stats[i].value
		stat_modifiers[i].stat = stats[i].stat
		target.stats.remove_stat_modifier(stat_modifiers[i])
		target.stats.add_stat_modifier(stat_modifiers[i])
		
func on_status_effect_stack_removed(_status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	for i in stats.size():
		stat_modifiers[i].modifier -= stacks * stats[i].value
		stat_modifiers[i].stat *= stats[i].stat
	
func on_status_effect_removed(_status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	for stat_modifier in stat_modifiers:
		target.stats.remove_stat_modifier(stat_modifier)
		stat_modifiers.erase(stat_modifier)
		stat_modifier.queue_free()
