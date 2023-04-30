class_name StatCalculator
extends Node

var unit: Unit

func _init(_unit: Unit) -> void:
	unit = _unit
	
func get_unit() -> Unit:
	return unit
	
func get_health() -> int:
	return unit.stats.get_stat(Stat.Enum.HEALTH) + unit.stats.get_stat(Stat.Enum.STAMINA) * 10

func get_mana() -> int:
	return unit.stats.get_stat(Stat.Enum.MANA) + unit.stats.get_stat(Stat.Enum.INTELLECT) * 10
	
func get_dodge_chance() -> float:
	return (unit.stats.get_stat(Stat.Enum.DODGE) + unit.stats.get_stat(Stat.Enum.DEFENSE) * 0.25 + unit.stats.get_stat(Stat.Enum.AGILITY) * 0.25) / 20.0
	
func get_parry_chance() -> float:
	return (unit.stats.get_stat(Stat.Enum.PARRY) + unit.stats.get_stat(Stat.Enum.DEFENSE) * 0.25) / 20.0

func get_critical_receive_chance() -> float:
	return unit.stats.get_stat(Stat.Enum.DEFENSE) / 20.0

func get_miss_chance() -> float:
	return unit.stats.get_stat(Stat.Enum.AVOIDANCE) / 20.0
	
func get_hit_chance() -> float:
	return (unit.stats.get_stat(Stat.Enum.HIT) + unit.stats.get_stat(Stat.Enum.INTELLECT) * 0.25) / 20.0

func get_haste() -> float:
	var haste_percentage = unit.stats.get_stat(Stat.Enum.HASTE) * 0.001
	var agility_percentage = unit.stats.get_stat(Stat.Enum.AGILITY) * 0.0001
	return haste_percentage + agility_percentage
	
func get_critical_chance() -> float:
	return (unit.stats.get_stat(Stat.Enum.CRIT) + unit.stats.get_stat(Stat.Enum.INTELLECT) * 0.25) / 20.0
	
func get_critical_effect() -> float:
	return (unit.stats.get_stat(Stat.Enum.CRITICAL_EFFECT) + unit.stats.get_stat(Stat.Enum.AGILITY) * 0.25) / 20.0
	
func get_spell_power(spell_school: SpellSchool.Enum) -> int:
	return unit.stats.get_stat(Stat.Enum.SPELL_POWER) + unit.stats.get_stat(SpellSchool.SPELLPOWER[spell_school]) + unit.stats.get_stat(Stat.Enum.INTELLECT)
	
func get_attack_power() -> int:
	return unit.stats.get_stat(Stat.Enum.ATTACK_POWER) + unit.stats.get_stat(Stat.Enum.AGILITY)
	
func get_resistance(spell_school) -> float:
	return unit.stats.get_stat(SpellSchool.RESISTANCE[spell_school]) + unit.stats.get_stat(Stat.Enum.STAMINA)
	
func get_expertise() -> float:
	return unit.stats.get_stat(Stat.Enum.EXPERTISE) / 20.0
	
func get_spell_reflect_chance() -> float:
	return unit.stats.get_stat(Stat.Enum.SPELL_REFLECT) / 20.0

func get_mastery() -> float:
	return unit.stats.get_stat(Stat.Enum.MASTERY)
	
func get_resource_reduction(resource_type: int) -> int:
	if(resource_type == ResourceType.Enum.HEALTH):
		return unit.stats.get_stat(Stat.Enum.RESOURCE_COST_HEALTH)
	elif(resource_type == ResourceType.Enum.MANA):
		return unit.stats.get_stat(Stat.Enum.RESOURCE_COST_MANA)
	elif(resource_type == ResourceType.Enum.RAGE):
		return unit.stats.get_stat(Stat.Enum.RESOURCE_COST_RAGE)
	elif(resource_type == ResourceType.Enum.ENERGY):
		return unit.stats.get_stat(Stat.Enum.RESOURCE_COST_ENERGY)
	return 0
