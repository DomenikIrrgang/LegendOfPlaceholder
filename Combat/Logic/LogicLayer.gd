class_name LogicLayer
extends Node

func on_ability_cast(_combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:
	return combat_logic_result
