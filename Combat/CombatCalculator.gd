class_name CombatCalculator

func get_ability_value(ability: Ability, source: Unit, target: Unit):
	var ability_value = ability.get_value(source, target)
	var scaling_value = ability.get_scaling_factor(source, target)
	if ability.get_spell_school() != SpellSchool.Enum.PHYSICAL:
		scaling_value *= source.stat_calculator.get_spell_power(ability.get_spell_school())
	else:
		scaling_value *= source.stat_calculator.get_attack_power()
	return ability_value + scaling_value

func get_resist_amount(ability: Ability, _source: Unit, target: Unit) -> float:
	if (ability.can_be_resisted()):
		return target.stat_calculator.get_resistance(ability.get_spell_school()) * random_value(0.8, 1.0)
	return 0
	
func get_critical_effect(ability: Ability, source: Unit, _target: Unit) -> float:
	if ability.can_crit():
		return ability.get_critical_effect() + (source.stat_calculator.get_critical_effect())
	else:
		return 1.5

func get_ability_cost(ability: Ability, source: Unit, _target: Unit) -> int:
	return ability.get_resource_cost() - source.stat_calculator.get_resource_reduction(ability.get_resource_type())
	
func ability_missed(ability: Ability, source: Unit, target: Unit) -> bool:
	if (ability.can_miss()):
		return random_chance(target.stat_calculator.get_miss_chance() + ability.get_miss_chance() - source.stat_calculator.get_hit_chance())
	return false
	
func ability_dodged(ability: Ability, source: Unit, target: Unit) -> bool:
	if (ability.can_be_dodged()):
		return random_chance(target.stat_calculator.get_dodge_chance() - source.stat_calculator.get_expertise())
	return false
	
func ability_parried(ability: Ability, source: Unit, target: Unit) -> bool:
	if (ability.can_be_parried()):
		return random_chance(target.stat_calculator.get_parry_chance() - source.stat_calculator.get_expertise())
	return false
	
func ability_crit(ability: Ability, source: Unit, target: Unit) -> bool:
	if (ability.can_crit()):
		return random_chance(source.stat_calculator.get_critical_chance() + ability.get_critical_chance() - target.stat_calculator.get_critical_receive_chance())
	return false
	
func ability_reflect(ability: Ability, _source: Unit, target: Unit) -> bool:
	if (ability.can_be_reflected()):
		return random_chance(target.stat_calculator.get_spell_reflect_chance())
	return false
	
func ability_castable(ability: Ability, source: Unit, target: Unit) -> bool:
	return ability.can_cast(source, target)
	
func has_ability_resource(ability: Ability, source: Unit, target: Unit) -> bool:
	return ability.get_resource_type() == ResourceType.Enum.FREE or source.has_resource_amount(ability.get_resource_type(), get_ability_cost(ability, source, target))

func get_cast_time(ability: Ability, source: Unit) -> float:
	var haste_percentage = source.stat_calculator.get_haste()
	return ability.get_cast_time() * (1.0 - haste_percentage)

func random_chance(chance: float) -> bool:
	return (randf() * 100.0) <= chance

# min and max have to be between 0.0 and 1.0	
func random_value(minimum: float, maximum: float) -> float:
	return randf() * (maximum - minimum) + minimum
