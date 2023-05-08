class_name StartCastLayer
extends LogicLayer

func on_ability_cast(combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	if combat_calculator.get_cast_time(combat_logic_result.ability, combat_logic_result.source) > 0.0 and not combat_logic_result.source.is_cast_finished():
		combat_logic_result.type = ResultType.Enum.START_CAST
	return combat_logic_result
