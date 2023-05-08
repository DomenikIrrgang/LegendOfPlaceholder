class_name ResistLayer
extends LogicLayer

func on_ability_cast(combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	combat_logic_result.value -= combat_calculator.get_resist_amount(
		combat_logic_result.ability,
		combat_logic_result.source,
		combat_logic_result.target
	)
	return combat_logic_result
