class_name RunesmithingCraftObjective
extends QuestObjective

@export
var recipe: Recipe

@export
var amount: int = 1
var progress: int = 0

func init() -> void:
	RunesmithingManager.recipe_crafted.connect(on_recipe_crafted)
	
func reset() -> void:
	progress = 0
	RunesmithingManager.recipe_crafted.disconnect(on_recipe_crafted)

func on_recipe_crafted(_recipe: Recipe) -> void:
	if recipe == _recipe:
		progress += 1
		objective_progress_changed.emit(self)
		
func is_completed() -> bool:
	return progress >= amount
	
func get_progess_string() -> String:
	return str(min(progress, amount)) + "/" + str(amount) + " " + recipe.name + " crafted"
