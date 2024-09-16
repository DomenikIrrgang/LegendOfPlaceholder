extends Node

var learned_recipes: Array[Recipe] = []

var max_level: int = 60
var level: int = 1
var experience: int = 0

signal experience_gained(amount: int)
signal leveled_up(level: int)

func _ready() -> void:
	pass
	
func gain_experience(amount: int) -> void:
	if level < max_level:
		var remaining_amount: int = amount
		var xp_needed_for_level_up: int = get_experience_needed_for_level_up(level)
		while (xp_needed_for_level_up <= remaining_amount):
			level_up()
			remaining_amount -= xp_needed_for_level_up
			xp_needed_for_level_up = get_experience_needed_for_level_up(level)
		experience += remaining_amount
		experience_gained.emit(amount)
		
func level_up() -> void:
	experience = 0
	level += 1
	leveled_up.emit(level)
	
func get_experience_needed_for_level(level: int) -> int:
	return level * level * 10

func get_experience_needed_for_level_up(level: int) -> int:
	return get_experience_needed_for_level(level) - experience
	
