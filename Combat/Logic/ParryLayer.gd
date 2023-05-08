class_name ParryLayer
extends LogicLayer

func on_ability_cast(combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	if combat_calculator.ability_parried(combat_logic_result.ability, combat_logic_result.source, combat_logic_result.target):
		combat_logic_result.hit_type = HitType.Enum.PARRIED
	return combat_logic_result
