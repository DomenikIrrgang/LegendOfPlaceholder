class_name ResourceCheckLayer
extends LogicLayer

func on_ability_cast(_combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	if not combat_logic_result.source.has_resource_amount(combat_logic_result.resource_type, combat_logic_result.resource_cost):
		combat_logic_result.type = ResultType.Enum.NOT_ENOUGH_RESOURCES
	return combat_logic_result
