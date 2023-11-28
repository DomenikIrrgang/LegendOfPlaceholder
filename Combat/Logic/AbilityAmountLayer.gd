class_name AbilityAmountLayer
extends LogicLayer

func on_ability_cast(combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	combat_logic_result.ability_value = combat_calculator.get_ability_value(
		combat_logic_result.ability,
		combat_logic_result.source,
		combat_logic_result.target
	)
	combat_logic_result.value = combat_logic_result.ability_value
	return combat_logic_result

func get_class_name() -> String:
	return "AbilityAmountLayer"
