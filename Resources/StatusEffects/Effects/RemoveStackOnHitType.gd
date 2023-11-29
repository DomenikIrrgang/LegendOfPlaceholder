class_name RemoveStackOnAbilityResult
extends StatusEffectScript

@export
var hit_type: HitType.Enum

func on_status_effect_applied(status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	target.combat_logic_result.connect(on_combat_logic_result.bind(status_effect, target))
	
func on_status_effect_removed(status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	target.combat_logic_result.disconnect(on_combat_logic_result)
	
func on_combat_logic_result(combat_result: CombatLogicResult, status_effect: StatusEffect, target: Unit) -> void:
	if combat_result.hit_type == hit_type and combat_result.source == target:
		target.remove_status_effect_stack(status_effect, 1)
