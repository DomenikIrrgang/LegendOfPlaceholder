extends Node

var calculator: CombatCalculator = CombatCalculator.new()

signal ability_failed_not_enough_resource(source: Unit, ability: Ability)
signal ability_failed_cannot_use(source: Unit, ability: Ability)
signal ability_result(result: AbilityCastResultEntry)

func use_ability(ability: Ability, source: Unit) -> void:
	if ability.can_use(source):
		if calculator.has_ability_resource(ability, source, source):
			increase_resource(source, ability.get_resource_type(), -calculator.get_ability_cost(ability, source, source))
			ability.use(source)
		else:
			ability_failed_not_enough_resource.emit(source, ability)
	else:
		ability_failed_cannot_use.emit(source, ability)

func cast_ability(ability: Ability, source: Unit, target: Unit):
	var results = []
	if (calculator.ability_castable(ability, source, target)):
			var result = AbilityCastResultEntry.new(source, target)
			if (calculator.ability_reflect(ability, result.source, result.target)):
				result.target = result.source
			result.hit_type = ability_hit(ability, result.source, result.target)
			if (result.hit_type == HitType.Enum.LANDED || result.hit_type == HitType.Enum.CRITICAL):
				result.ability_value = calculator.get_ability_value(ability, result.source, result.target)
				if (result.hit_type == HitType.Enum.CRITICAL):
					result.resist_amount = calculator.get_resist_amount(ability, result.source, result.target, result.value)		
					result.value = round(calculator.get_critical_amount(ability, result.source, result.target, result.ability_value)) - result.resist_amount
				else:
					result.resist_amount = calculator.get_resist_amount(ability, result.source, result.target, result.value)			
					result.value = round(result.ability_value - result.resist_amount)
				increase_resource(result.target, ResourceType.Enum.HEALTH, -result.value)
				ability.execute(result.source, result.target)
			ability_result.emit(result)
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
