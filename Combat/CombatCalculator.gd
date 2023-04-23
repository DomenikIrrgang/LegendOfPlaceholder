class_name CombatCalculator

func get_ability_value(ability, source, target, critical):
	var ability_value = ability.get_value(source, target)
	var scaling_value = ability.get_scaling_factor(source, target)
	if ability.get_spell_school() != SpellSchool.Enum.PHYSICAL:
		scaling_value *= source.stat_calculator.get_spell_power(ability.get_spell_school())
	else:
		scaling_value *= source.stat_calculator.get_attack_power()
	return ability_value + scaling_value

func get_resist_amount(ability, source, target, value):
	if (ability.can_be_resisted()):
		return target.stat_calculator.get_resistance(ability.get_spell_school())  * random_value(0.8, 1.0)
	return 0
	
func get_critical_amount(ability, source, target, value):
	return value * 1.5 * (source.stat_calculator.get_critical_effect() / 100.0)

func get_ability_cost(ability, source, target):
	return ability.get_resource_cost() - source.stat_calculator.get_resource_reduction(ability.get_resource_type())
	
func ability_hit(ability, source, target):
	if (ability.can_miss()):
		return !random_chance(5.0 + target.stat_calculator.get_miss_chance() - source.stat_calculator.get_hit_chance())
	return false
	
func ability_dodge(ability, source, target):
	if (ability.can_be_dodged()):
		return random_chance(target.stat_calculator.get_dodge_chance() - source.stat_calculator.get_expertise())
	return false
	
func ability_parry(ability, source, target):
	if (ability.can_be_parried()):
		return random_chance(target.stat_calculator.get_parry_chance() - source.stat_calculator.get_expertise())
	return false
	
func ability_crit(ability, source, target):
	if (ability.can_crit()):
		return random_chance(5.0 + target.stat_calculator.get_critical_chance() - source.stat_calculator.get_critical_receive_chance())
	return false
	
func ability_reflect(ability, source, target):
	if (ability.can_be_reflected()):
		return random_chance(target.stat_calculator.get_spell_reflect_chance())
	return false
	
func ability_castable(ability, source, target):
	return true
	
func has_ability_resource(ability, source, target):
	return source.has_resouce_amount(ability.get_resource_type(), get_ability_cost(ability, source, target))
	
func random_chance(chance: float):
	return (randf() * 100.0) <= chance

# min and max have to be between 0.0 and 1.0	
func random_value(minimum: float, maximum: float):
	return randf() * (maximum - minimum) + minimum
