extends Node

var learned_recipes: Array[Recipe] = []

var maximum_recipe_level_difference: int = 5

var max_level: int = 60
var level: int = 1
var experience: int = 0

signal experience_gained(amount: int)
signal experience_set(amount: int)
signal leveled_up(level: int)

signal recipe_learned(recipe: Recipe)
signal recipe_crafted(recipe: Recipe)

func _ready() -> void:
	SaveFileManager.game_state_loaded.connect(on_load)
	SaveFileManager.game_state_saving.connect(on_save)
	SaveFileManager.game_state_start_loading.connect(reset)
	SaveFileManager.game_state_start_unloading.connect(reset)
	
func reset() -> void:
	learned_recipes = []
	level = 1
	experience = 0
	
func on_save(game_state: Dictionary) -> void:
	var runesmithing: Dictionary = {}
	runesmithing.level = level
	runesmithing.experience = experience
	runesmithing.learned_recipes = []
	for recipe in learned_recipes:
		runesmithing.learned_recipes.append(
			SaveFileManager.get_resource_uid(recipe)
		)
	game_state.runesmithing = runesmithing
	
func on_load(game_state: Dictionary) -> void:
	if game_state.has("runesmithing"):
		level = game_state.runesmithing.level
		leveled_up.emit(level)
		experience = game_state.runesmithing.experience
		experience_set.emit(experience)
		for recipe_uid in game_state.runesmithing.learned_recipes:
			var recipe = SaveFileManager.get_resource_from_uid(recipe_uid)
			if not recipe_known(recipe):
				learn_recipe(recipe)
	
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
		
func imbue_gear(gear: GearInstance, rune_slot_index: int, rune: Rune) -> void:
	if gear.item.rune_slots[rune_slot_index].spell_school == rune.spell_school:
		gear.runes[rune_slot_index] = rune
		
func craft_recipe(recipe: Recipe) -> void:
	if can_craft_recipe(recipe):
		remove_ingridients_from_inventory(recipe)
		for result in recipe.results:
			result.receive()
		gain_experience(recipe.get_experience())
		recipe_crafted.emit(recipe)
		
func remove_ingridients_from_inventory(recipe: Recipe) -> void:
	for ingridient in recipe.ingredients:
		Globals.get_inventory().remove_item(ingridient.item, ingridient.amount)
		
func can_craft_recipe(recipe: Recipe) -> bool:
	return recipe_known(recipe) and can_receive_recipe_results(recipe) and has_materials(recipe) and fulfills_recipe_conditions(recipe)
	
func fulfills_recipe_conditions(recipe: Recipe) -> bool:
	var fulfills_conditions: bool = true
	for condition in recipe.conditions:
		if not condition.is_fulfilled():
			fulfills_conditions = false
			break
	return fulfills_conditions
	
func can_receive_recipe_results(recipe: Recipe) -> bool:
	var receivable: bool = true
	for result in recipe.results:
		if not result.can_receive():
			receivable = false
			break
	return receivable
	
func has_materials(recipe: Recipe) -> bool:
	var materials: bool = true
	for ingridient in recipe.ingredients:
		if not Globals.get_inventory().has_item_amount(ingridient.item, ingridient.amount):
			materials = false
			break
	return materials
		
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
	
func can_learn_recipe(recipe: Recipe) -> bool:
	return not recipe_known(recipe) and meets_learning_conditions(recipe)
	
func meets_learning_conditions(recipe: Recipe) -> bool:
	for condition in recipe.learning_conditions:
		if not condition.is_fulfilled():
			return false
	return true

func learn_recipe(recipe: Recipe) -> bool:
	if can_learn_recipe(recipe):
		learned_recipes.append(recipe)
		recipe_learned.emit(recipe)
		return true
	return false
	
func recipe_known(recipe: Recipe) -> bool:
	return learned_recipes.has(recipe)
