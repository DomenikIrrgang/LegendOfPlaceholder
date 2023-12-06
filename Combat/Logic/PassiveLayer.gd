class_name AbilityCastableLayer
extends LogicLayer

func on_ability_cast(_combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	if !combat_logic_result.ability.ability_types.has(Ability.Type.CASTABLE):
		combat_logic_result.type = ResultType.Enum.CANNOT_CAST
	return combat_logic_result

func get_class_name() -> String:
	return "AbilityCastableLayer"
