class_name CriticialHitLayer
extends LogicLayer

func on_ability_cast(combat_calculator: CombatCalculator, combat_logic_result: CombatLogicResult) -> CombatLogicResult:
	if combat_logic_result.hit_type == HitType.Enum.LANDED:
		if combat_calculator.ability_crit(combat_logic_result.ability, combat_logic_result.source, combat_logic_result.target):
			combat_logic_result.hit_type = HitType.Enum.CRITICAL
	return combat_logic_result

func get_class_name() -> String:
	return "CritLayer"
