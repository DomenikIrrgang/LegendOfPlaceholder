class_name FailureLayer
extends LogicLayer

func on_ability_cast(_combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	if combat_logic_result.type != ResultType.Enum.SUCCESS:
		combat_logic_result.ability_value = 0
		combat_logic_result.value = 0
		combat_logic_result.resist_amount = 0
	return combat_logic_result

func get_class_name() -> String:
	return "FailureLayer"
