class_name PassiveLayer
extends LogicLayer

func on_ability_cast(_combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	if combat_logic_result.ability.ability_type == Ability.Type.PASSIVE:
		combat_logic_result.type = ResultType.Enum.CANNOT_CAST
	return combat_logic_result

func get_class_name() -> String:
	return "PassiveLayer"
