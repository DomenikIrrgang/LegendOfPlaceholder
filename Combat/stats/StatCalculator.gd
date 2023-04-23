class_name StatCalculator
extends Node

var stat_set: StatSet

func _init(stats: StatSet) -> void:
	stat_set = stats
	
func get_stat_set() -> StatSet:
	return stat_set
	
func get_health() -> int:
	return stat_set.get_stat(Stat.HEALTH) + stat_set.get_stat(Stat.STAMINA) * 10

func get_mana() -> int:
	return stat_set.get_stat(Stat.MANA) + stat_set.get_stat(Stat.INTELLECT) * 10
	
func get_dodge_chance() -> float:
	return (stat_set.get_stat(Stat.DODGE) + stat_set.get_stat(Stat.DEFENSE) * 0.25 + stat_set.get_stat(Stat.AGILITY) * 0.25) / 20.0
	
func get_parry_chance() -> float:
	return (stat_set.get_stat(Stat.PARRY) + stat_set.get_stat(Stat.DEFENSE) * 0.25) / 20.0

func get_critical_receive_chance() -> float:
	return stat_set.get_stat(Stat.DEFENSE) / 20.0

func get_miss_chance() -> float:
	return stat_set.get_stat(Stat.AVOIDANCE) / 20.0
	
func get_hit_chance() -> float:
	return (stat_set.get_stat(Stat.HIT) + stat_set.get_stat(Stat.INTELLECT) * 0.25) / 20.0

func get_haste() -> float:
	return stat_set.get_stat(Stat.HASTE) + stat_set.get_stat(Stat.AGILITY) / 20.0
	
func get_critical_chance() -> float:
	return (stat_set.get_stat(Stat.CRIT) + stat_set.get_stat(Stat.INTELLECT) * 0.25) / 20.0
	
func get_critical_effect() -> float:
	return (stat_set.get_stat(Stat.CRITICAL_EFFECT) + stat_set.get_stat(Stat.AGILITY) * 0.25) / 20.0
	
func get_spell_power(spell_school) -> int:
	return stat_set.get_stat(Stat.SPELL_POWER) + stat_set.get_stat(spell_school[0]) + stat_set.get_stat(Stat.INTELLECT)
	
func get_attack_power() -> int:
	return stat_set.get_stat(Stat.ATTACK_POWER) + stat_set.get_stat(Stat.AGILITY)
	
func get_resistance(spell_school) -> float:
	return stat_set.get_stat(spell_school[1]) + stat_set.get_stat(Stat.STAMINA)
	
func get_expertise() -> float:
	return stat_set.get_stat(Stat.EXPERTISE) / 20.0
	
func get_spell_reflect_chance() -> float:
	return stat_set.get_stat(Stat.SPELL_REFLECT) / 20.0

func get_mastery() -> float:
	return stat_set.get_stat(Stat.MASTERY)
	
func get_resource_reduction(resource_type: int) -> int:
	if(resource_type == ResourceType.HEALTH):
		return stat_set.get_stat(Stat.RESOURCE_COST_HEALTH)
	elif(resource_type == ResourceType.MANA):
		return stat_set.get_stat(Stat.RESOURCE_COST_MANA)
	elif(resource_type == ResourceType.RAGE):
		return stat_set.get_stat(Stat.RESOURCE_COST_RAGE)
	elif(resource_type == ResourceType.ENERGY):
		return stat_set.get_stat(Stat.RESOURCE_COST_ENERGY)
	return 0
