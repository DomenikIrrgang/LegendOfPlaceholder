class_name CooldownLayer
extends LogicLayer

func on_ability_cast(_combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	if not combat_logic_result.ability.can_use(combat_logic_result.source):
		combat_logic_result.type = ResultType.Enum.NOT_READY
	return combat_logic_result
