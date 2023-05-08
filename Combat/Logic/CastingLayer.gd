class_name CastingLayer
extends LogicLayer

func on_ability_cast(_combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	if combat_logic_result.source.is_casting() and not combat_logic_result.source.is_cast_finished():
		combat_logic_result.type = ResultType.Enum.ALREADY_CASTING
	return combat_logic_result
