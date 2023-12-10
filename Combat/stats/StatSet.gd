class_name StatSet
extends Node

var stats = {}

var stat_modifiers: Array[StatModifier] = []

signal stat_changed(stat: Stat.Enum, new_value: int)

func set_stat(stat: Stat.Enum, value: int) -> void:
	stats[stat] = value
	stat_changed.emit(stat, get_stat(stat))

func get_stat(stat: Stat.Enum) -> int:
	if !stats.has(stat):
		return 0
	var value = stats[stat]
	for modifier in stat_modifiers:
		value += modifier.get_stat(stat, stats[stat])
	return value
	
func get_stats() -> Dictionary:
	return stats
	
func add_stat_modifier(stat_modifier: StatModifier) -> void:
	stat_modifiers.append(stat_modifier)
	stat_changed.emit(stat_modifier.stat, get_stat(stat_modifier.stat))
	
func remove_stat_modifier(stat_modifier: StatModifier) -> void:
	stat_modifiers.erase(stat_modifier)
	stat_changed.emit(stat_modifier.stat, get_stat(stat_modifier.stat))
	
func increase_stat(stat: Stat.Enum, value: int) -> void:
	set_stat(stat, get_stat(stat) + value)
	
func increase_by_stat_set(stat_set: StatSet) -> StatSet:
	for stat in stat_set.get_stats():
		set_stat(stat, get_stat(stat) + stat_set.get_stat(stat))
	return self
	
func subtract_stat_set(stat_set: StatSet) -> StatSet:
	var result = StatSet.new()
	for stat in get_stats():
		result.set_stat(stat, get_stat(stat))
	for stat in stat_set.get_stats():
		result.set_stat(stat, result.get_stat(stat) - stat_set.get_stat(stat))
	return result
	
func add_stat_set(stat_set: StatSet) -> StatSet:
	var result = StatSet.new()
	for stat in get_stats():
		result.set_stat(stat, get_stat(stat))
	for stat in stat_set.get_stats():
		result.set_stat(stat, result.get_stat(stat) + stat_set.get_stat(stat))
	return result
