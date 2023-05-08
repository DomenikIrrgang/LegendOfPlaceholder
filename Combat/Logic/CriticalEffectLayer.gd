class_name CriticalEffectLayer
extends LogicLayer

func on_ability_cast(combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	if combat_logic_result.hit_type == HitType.Enum.CRITICAL:
		combat_logic_result.value *= combat_calculator.get_critical_effect(
			combat_logic_result.ability,
			combat_logic_result.source,
			combat_logic_result.target
		)
	return combat_logic_result
