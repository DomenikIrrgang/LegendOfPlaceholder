class_name ResourceCostLayer
extends LogicLayer

func on_ability_cast(combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	combat_logic_result.resource_type = combat_logic_result.ability.get_resource_type()
	combat_logic_result.resource_cost = combat_calculator.get_ability_cost(
		combat_logic_result.ability,
		combat_logic_result.source,
		combat_logic_result.target
	)
	return combat_logic_result

func get_class_name() -> String:
	return "ResourceCostLayer"
