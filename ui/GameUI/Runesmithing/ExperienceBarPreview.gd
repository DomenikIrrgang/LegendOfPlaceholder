extends TextureProgressBar

func _ready() -> void:
	RunesmithingManager.experience_gained.connect(on_experience_gained)
	Globals.get_tree().get_first_node_in_group("Recipelist").recipe_selected.connect(on_recipe_selected)
	RunesmithingManager.experience_set.connect(func(amount: int):
		max_value = RunesmithingManager.get_experience_needed_for_level(RunesmithingManager.level)
		value = amount
	)
	RunesmithingManager.recipe_crafted.connect(on_recipe_crafted)
	update_experience_amount()
	
func on_recipe_crafted(recipe: Recipe) -> void:
	value = RunesmithingManager.experience + recipe.get_experience()
	
func on_recipe_selected(recipe: Recipe) -> void:
	var old_value = value
	var preview_value = recipe.get_experience()
	var old_experience =  RunesmithingManager.experience
	var total_xp = RunesmithingManager.get_experience_needed_for_level(RunesmithingManager.level)
	value = RunesmithingManager.experience + recipe.get_experience()

func update_experience_amount() -> void:
	max_value = RunesmithingManager.get_experience_needed_for_level(RunesmithingManager.level)
	value = RunesmithingManager.experience
	
func on_experience_gained(amount: int) -> void:
	update_experience_amount()
