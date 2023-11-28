class_name ImmuneLayer
extends LogicLayer

func on_ability_cast(_combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:	
	combat_logic_result.hit_type = HitType.Enum.IMMUNE
	combat_logic_result.ability_value = 0
	combat_logic_result.value = 0
	combat_logic_result.resist_amount = 0
	return combat_logic_result

func get_class_name() -> String:
	return "ImmuneLayer"
