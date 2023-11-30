class_name CooldownReductionOnHitType
extends StatusEffectScript

@export
var hit_type: HitType.Enum

@export
var amount: float

func on_status_effect_applied(status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	target.combat_logic_result.connect(on_combat_logic_result.bind(target))
	
func on_status_effect_removed(status_effect: StatusEffect, stacks: int, _source: Unit, target: Unit) -> void:
	target.combat_logic_result.disconnect(on_combat_logic_result)
	
func on_combat_logic_result(combat_result: CombatLogicResult, unit: Unit) -> void:
	if combat_result.hit_type == hit_type and combat_result.source == unit:
		for ability in unit.get_abilities():
			ability.update(amount)

