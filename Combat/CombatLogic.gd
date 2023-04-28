extends Node

var calculator: CombatCalculator = CombatCalculator.new()

func use_ability(ability: Ability, source: Unit) -> void:
	if ability.can_use(source) and calculator.has_ability_resource(ability, source, source):
		increase_resource(source, ability.get_resource_type(), -calculator.get_ability_cost(ability, source, source))
		ability.use(source)

func cast_ability(ability: Ability, source: Unit, target: Unit):
	var results = []
	results.append(CombatResult.new(CombatResultType.Enum.ABILITY_CAST_START, [ AbilityCastStart.new(source, target, ability) ]))
	if (calculator.ability_castable(ability, source, target)):
		if (calculator.has_ability_resource(ability, source, target)):
			#if (ability.get_resource_type() != ResourceType.Enum.FREE and calculator.get_ability_cost(ability, source, target) > 0):
			#	results.append(CombatResult.new(CombatResultType.Enum.RESOURCE_UPDATE, [ increase_resource(source, ability.get_resource_type(), -calculator.get_ability_cost(ability, source, target)) ]))
			var ability_results = []
			var resource_results = []
			var result = AbilityCastResultEntry.new(source, target)
			if (calculator.ability_reflect(ability, result.source, result.target)):
				result.target = result.source
			result.hit_type = ability_hit(ability, result.source, result.target)
			if (result.hit_type == HitType.Enum.LANDED || result.hit_type == HitType.Enum.CRITICAL):
				result.ability_value = calculator.get_ability_value(ability, result.source, result.target)
				if (result.hit_type == HitType.Enum.CRITICAL):
					result.resist_amount = calculator.get_resist_amount(ability, result.source, result.target, result.value)		
					result.value = round((result.ability_value) * (ability.get_critical_effect() + source.stat_calculator.get_critical_effect()) - result.resist_amount)
				else:
					result.resist_amount = calculator.get_resist_amount(ability, result.source, result.target, result.value)			
					result.value = round(result.ability_value - result.resist_amount)
				ability_results.append(result)
				resource_results.append(increase_resource(result.target, ResourceType.Enum.HEALTH, -result.value))
				ability.execute(result.source, result.target)
			else:
				ability_results.append(result)
			results.append(CombatResult.new(CombatResultType.Enum.ABILITY_CAST_RESULT, [ AbilityCastResult.new(ability, ability_results) ]))
			results.append(CombatResult.new(CombatResultType.Enum.RESOURCE_UPDATE, resource_results))
		else:
			results.append(CombatResult.new(CombatResultType.Enum.ABILITY_CAST_FAILED_RESOURCE_MISSING, [ AbilityCastFailedMissingResource.new(source, ability) ]))			
	return results
	
func increase_resource(unit: Unit, type: ResourceType.Enum, value: int) -> ResourceUpdate:
	unit.increase_resource_value(type, value)
	return ResourceUpdate.new(unit, type, value)
	
func ability_hit(ability: Ability, source: Unit, target: Unit):
	if (calculator.ability_missed(ability, source, target)):
		return HitType.Enum.MISSED
	if (calculator.ability_dodged(ability, source, target)):
		return HitType.Enum.DODGED
	if (calculator.ability_parried(ability, source, target)):
		return HitType.Enum.PARRIED
	if (calculator.ability_crit(ability, source, target)):
		return HitType.Enum.CRITICAL
	return HitType.Enum.LANDED
