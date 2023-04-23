extends Node

const CombatCalculator = preload("res://src/combat/CombatCalculator.gd")
const AbilityCastResult = preload("res://src/combat/AbilityCastResult.gd")
const AbilityCastFailedMissingResource = preload("res://src/combat/AbilityCastFailedMissingResource.gd")
const AbilityCastResultEntry = preload("res://src/combat/AbilityCastResultEntry.gd")
const CombatResult = preload("res://src/combat/CombatResult.gd")
const ResourceUpdate = preload("res://src/combat/ResourceUpdate.gd")
const AbilityCastStart = preload("res://src/combat/AbilityCastStart.gd")

var player_group
var enemy_group
var calculator

var actions = []
var round_counter = 1

signal round_over(new_round_count)

func _init(param_player_group, param_enemy_group, param_calculator = CombatCalculator.new()):
	player_group = param_player_group
	enemy_group = param_enemy_group
	calculator = param_calculator
	reset()
	
func add_combat_action(ability, source, target):
	actions.append({ "ability": ability, "source": source, "target": target})
	
func calculate_round() -> Array:
	var results = []
	while (actions.size() > 0):
		results += calculate_step()
	return results
	
func calculate_step() -> Array:
	var action = get_fastest_combat_action()
	actions.remove(actions.find(action))
	if (actions.size() <= 0):
		round_counter += 1
		emit_signal("round_over", round_counter)
	return cast_ability(action.ability, action.source, action.target)
		
func cast_ability(ability, source, target):
	var results = []
	results.append(CombatResult.new(CombatResultType.ABILITY_CAST_START, [ AbilityCastStart.new(source, target, ability) ]))
	if (calculator.ability_castable(ability, source, target)):
		if (calculator.has_ability_resource(ability, source, target)):
			results.append(CombatResult.new(CombatResultType.RESOURCE_UPDATE, [ reduce_resource(source, ability.get_resource_type(), calculator.get_ability_cost(ability, source, target)) ]))
			var ability_results = []
			var resource_results = []
			for unit in get_ability_targets(ability, source, target):
				var result = AbilityCastResultEntry.new(source, unit)
				if (calculator.ability_reflect(ability, result.source, result.target)):
					result.target = result.source
				result.hit_type = ability_hit(ability, result.source, result.target)
				if (result.hit_type == HitType.LANDED || result.hit_type == HitType.CRITICAL):
					result.ability_value = calculator.get_ability_value(ability, result.source, result.target, result.hit_type == HitType.CRITICAL)
					if (result.hit_type == HitType.CRITICAL):
						result.resist_amount = calculator.get_resist_amount(ability, result.source, result.target, result.value)		
						result.value = round((result.ability_value) * (ability.get_critical_effect() + source.stat_calculator.get_critical_effect()) - result.resist_amount)
					else:
						result.resist_amount = calculator.get_resist_amount(ability, result.source, result.target, result.value)			
						result.value = round(result.ability_value - result.resist_amount)
					ability_results.append(result)
					resource_results.append(reduce_resource(result.target, ResourceType.HEALTH, result.value))
					ability.execute(self, result.source, result.target)
				else:
					ability_results.append(result)
			results.append(CombatResult.new(CombatResultType.ABILITY_CAST_RESULT, [ AbilityCastResult.new(ability, ability_results) ]))
			results.append(CombatResult.new(CombatResultType.RESOURCE_UPDATE, resource_results))
		else:
			results.append(CombatResult.new(CombatResultType.ABILITY_CAST_FAILED_RESOURCE_MISSING, [ AbilityCastFailedMissingResource.new(ability, source) ]))			
	return results
	
func reduce_resource(unit, type, value) -> ResourceUpdate:
	unit.reduce_resource(type, value)
	return ResourceUpdate.new(unit.clone(), type, value)
	
func ability_hit(ability, source, target):
	if (!calculator.ability_hit(ability, source, target)):
		return HitType.MISSED
	if (calculator.ability_dodge(ability, source, target)):
		return HitType.DODGED
	if (calculator.ability_parry(ability, source, target)):
		return HitType.PARRIED
	if (calculator.ability_crit(ability, source, target)):
		return HitType.CRITICAL
	return HitType.LANDED
		
	
func get_fastest_combat_action():
	var result = actions[0];
	for action in actions:
		if (action.source.stat_calculator.get_haste() > result.source.stat_calculator.get_haste()):
			result = action
	return result;
	
func get_ability_targets(ability, source, target):
	if (ability.get_target_type() == TargetType.SINGLE):
		return [ target ]
	if (ability.get_target_type() == TargetType.GROUP):
		return get_units_group(target)
	if (ability.get_target_type() == TargetType.AOE):
		return player_group + enemy_group
	return []
		
func get_units_group(unit):
	if (player_group.has(unit)):
		return player_group
	else:
		return enemy_group
	
func reset():
	for unit in player_group:
		unit.reset()
	for unit in enemy_group:
		unit.reset()
	round_counter = 1
	actions = []
