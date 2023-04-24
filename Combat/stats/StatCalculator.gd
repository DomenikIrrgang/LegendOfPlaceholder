class_name StatCalculator
extends Node

var unit: Unit

func _init(_unit: Unit) -> void:
	unit = _unit
	
func get_unit() -> Unit:
	return unit
	
func get_health() -> int:
	return unit.stats.get_stat(Stat.HEALTH) + unit.stats.get_stat(Stat.STAMINA) * 10

func get_mana() -> int:
	return unit.stats.get_stat(Stat.MANA) + unit.stats.get_stat(Stat.INTELLECT) * 10
	
func get_dodge_chance() -> float:
	return (unit.stats.get_stat(Stat.DODGE) + unit.stats.get_stat(Stat.DEFENSE) * 0.25 + unit.stats.get_stat(Stat.AGILITY) * 0.25) / 20.0
	
func get_parry_chance() -> float:
	return (unit.stats.get_stat(Stat.PARRY) + unit.stats.get_stat(Stat.DEFENSE) * 0.25) / 20.0

func get_critical_receive_chance() -> float:
	return unit.stats.get_stat(Stat.DEFENSE) / 20.0

func get_miss_chance() -> float:
	return unit.stats.get_stat(Stat.AVOIDANCE) / 20.0
	
func get_hit_chance() -> float:
	return (unit.stats.get_stat(Stat.HIT) + unit.stats.get_stat(Stat.INTELLECT) * 0.25) / 20.0

func get_haste() -> float:
	return unit.stats.get_stat(Stat.HASTE) + unit.stats.get_stat(Stat.AGILITY) / 20.0
	
func get_critical_chance() -> float:
	return (unit.stats.get_stat(Stat.CRIT) + unit.stats.get_stat(Stat.INTELLECT) * 0.25) / 20.0
	
func get_critical_effect() -> float:
	return (unit.stats.get_stat(Stat.CRITICAL_EFFECT) + unit.stats.get_stat(Stat.AGILITY) * 0.25) / 20.0
	
func get_spell_power(spell_school) -> int:
	return unit.stats.get_stat(Stat.SPELL_POWER) + unit.stats.get_stat(spell_school[0]) + unit.stats.get_stat(Stat.INTELLECT)
	
func get_attack_power() -> int:
	return unit.stats.get_stat(Stat.ATTACK_POWER) + unit.stats.get_stat(Stat.AGILITY)
	
func get_resistance(spell_school) -> float:
	return unit.stats.get_stat(spell_school[1]) + unit.stats.get_stat(Stat.STAMINA)
	
func get_expertise() -> float:
	return unit.stats.get_stat(Stat.EXPERTISE) / 20.0
	
func get_spell_reflect_chance() -> float:
	return unit.stats.get_stat(Stat.SPELL_REFLECT) / 20.0

func get_mastery() -> float:
	return unit.stats.get_stat(Stat.MASTERY)
	
func get_resource_reduction(resource_type: int) -> int:
	if(resource_type == ResourceType.Enum.HEALTH):
		return unit.stats.get_stat(Stat.RESOURCE_COST_HEALTH)
	elif(resource_type == ResourceType.Enum.MANA):
		return unit.stats.get_stat(Stat.RESOURCE_COST_MANA)
	elif(resource_type == ResourceType.Enum.RAGE):
		return unit.stats.get_stat(Stat.RESOURCE_COST_RAGE)
	elif(resource_type == ResourceType.Enum.ENERGY):
		return unit.stats.get_stat(Stat.RESOURCE_COST_ENERGY)
	return 0
