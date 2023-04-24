class_name StatSet
extends Node

var stats = {}

signal stat_changed(stat: int, new_value: int)

func set_stat(stat: int, value: int) -> void:
	stats[stat] = value
	stat_changed.emit(stat, value)

func get_stat(stat: int) -> int:
	if !stats.has(stat):
		return 0
	return stats[stat]
	
func get_stats() -> Dictionary:
	return stats
	
func increase_stat(stat: int, value: int) -> void:
	set_stat(stat, get_stat(stat) + value)
	
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
