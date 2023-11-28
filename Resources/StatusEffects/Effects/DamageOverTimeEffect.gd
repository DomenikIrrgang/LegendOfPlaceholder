class_name DamageOverTimeEffect
extends StatusEffectScript

@export
var ability: PackedScene

@export
var tick_time: float = 3.0

var time_passed = {}

func on_status_effect_update(status_effect: StatusEffect, stacks: int, source: Unit, target: Unit, delta: float) -> void:
	if !time_passed.has(target.to_string()):
		time_passed[target.to_string()] = 0.0
	time_passed[target.to_string()] += delta
	if time_passed[target.to_string()] >= tick_time:
		on_tick(status_effect, stacks, source, target)
		time_passed[target.to_string()] = 0.0
		
func on_tick(status_effect: StatusEffect, stacks: int, source: Unit, target: Unit) -> void:
	var ability_instance = ability.instantiate()
	ability_instance.value = ability_instance.value * stacks
	target.combat_logic.cast_ability(source, target, ability_instance)
	ability_instance.queue_free()