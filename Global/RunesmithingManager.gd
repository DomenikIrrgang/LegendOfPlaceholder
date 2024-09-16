extends Node

var learned_recipes: Array[Recipe] = []

var maximum_recipe_level_difference: int = 5

var max_level: int = 60
var level: int = 1
var experience: int = 0

signal experience_gained(amount: int)
signal leveled_up(level: int)

signal recipe_learned(recipe: Recipe)
signal recipe_crafted(recipe: Recipe)

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
		
func craft_recipe(recipe: Recipe) -> void:
	if can_craft_recipe(recipe):
		for result in recipe.results:
			result.receive()
		gain_experience(recipe.get_experience())
		
func can_craft_recipe(recipe: Recipe) -> bool:
	var can_receive_results: bool = true
	for result in recipe.results:
		if not result.can_receive():
			can_receive_results = false
	return recipe_known(recipe) && can_receive_results
		
func level_up() -> void:
	experience = 0
	level += 1
	leveled_up.emit(level)
	
func get_experience_needed_for_level(level: int) -> int:
	return (level + 1) * (level + 1) * 10

func get_experience_needed_for_level_up(level: int) -> int:
	return get_experience_needed_for_level(level) - experience
	
func get_recipes() -> Array[Recipe]:
	return learned_recipes

func learn_recipe(recipe: Recipe) -> bool:
	if not recipe_known(recipe):
		learned_recipes.append(recipe)
		recipe_learned.emit(recipe)
		return true
	return false
	
func recipe_known(recipe: Recipe) -> bool:
	return learned_recipes.has(recipe)
