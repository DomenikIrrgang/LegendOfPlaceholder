class_name CombatLogic

var calculator: CombatCalculator

func _init(_calculator: CombatCalculator = CombatCalculator.new()):
	calculator = _calculator
		
func cast_ability(ability: Ability, source: Unit, target: Unit):
	var results = []
	results.append(CombatResult.new(CombatResultType.Enum.ABILITY_CAST_START, [ AbilityCastStart.new(source, target, ability) ]))
	if (calculator.ability_castable(ability, source, target)):
		if (calculator.has_ability_resource(ability, source, target)):
			results.append(CombatResult.new(CombatResultType.Enum.RESOURCE_UPDATE, [ reduce_resource(source, ability.get_resource_type(), calculator.get_ability_cost(ability, source, target)) ]))
			var ability_results = []
			var resource_results = []
			var result = AbilityCastResultEntry.new(source, target)
			if (calculator.ability_reflect(ability, result.source, result.target)):
				result.target = result.source
			result.hit_type = ability_hit(ability, result.source, result.target)
			if (result.hit_type == HitType.Enum.LANDED || result.hit_type == HitType.Enum.CRITICAL):
				result.ability_value = calculator.get_ability_value(ability, result.source, result.target, result.hit_type == HitType.Enum.CRITICAL)
				if (result.hit_type == HitType.Enum.CRITICAL):
					result.resist_amount = calculator.get_resist_amount(ability, result.source, result.target, result.value)		
					result.value = round((result.ability_value) * (ability.get_critical_effect() + source.stat_calculator.get_critical_effect()) - result.resist_amount)
				else:
					result.resist_amount = calculator.get_resist_amount(ability, result.source, result.target, result.value)			
					result.value = round(result.ability_value - result.resist_amount)
				ability_results.append(result)
				resource_results.append(reduce_resource(result.target, ResourceType.Enum.HEALTH, result.value))
				ability.execute(self, result.source, result.target)
			else:
				ability_results.append(result)
			results.append(CombatResult.new(CombatResultType.Enum.ABILITY_CAST_RESULT, [ AbilityCastResult.new(ability, ability_results) ]))
			results.append(CombatResult.new(CombatResultType.Enum.RESOURCE_UPDATE, resource_results))
		else:
			results.append(CombatResult.new(CombatResultType.Enum.ABILITY_CAST_FAILED_RESOURCE_MISSING, [ AbilityCastFailedMissingResource.new(source, ability) ]))			
	return results
	
func reduce_resource(unit: Unit, type: int, value: int) -> ResourceUpdate:
	unit.reduce_resource(type, value)
	return ResourceUpdate.new(unit, type, value)
	
func ability_hit(ability: Ability, source: Unit, target: Unit):
	if (!calculator.ability_hit(ability, source, target)):
		return HitType.Enum.MISSED
	if (calculator.ability_dodge(ability, source, target)):
		return HitType.Enum.DODGED
	if (calculator.ability_parry(ability, source, target)):
		return HitType.Enum.PARRIED
	if (calculator.ability_crit(ability, source, target)):
		return HitType.Enum.CRITICAL
	return HitType.Enum.LANDED
