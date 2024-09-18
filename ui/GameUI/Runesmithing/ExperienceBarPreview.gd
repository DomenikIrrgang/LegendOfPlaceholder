extends TextureProgressBar

func _ready() -> void:
	RunesmithingManager.experience_gained.connect(on_experience_gained)
	Globals.get_tree().get_first_node_in_group("Recipelist").recipe_selected.connect(on_recipe_selected)
	RunesmithingManager.recipe_crafted.connect(on_recipe_crafted)
	update_experience_amount()
	
func on_recipe_crafted(recipe: Recipe) -> void:
	value = RunesmithingManager.experience + recipe.get_experience()
	
func on_recipe_selected(recipe: Recipe) -> void:
	value = RunesmithingManager.experience + recipe.get_experience()

func update_experience_amount() -> void:
	value = RunesmithingManager.experience
	max_value = RunesmithingManager.get_experience_needed_for_level(RunesmithingManager.level)
	
func on_experience_gained(amount: int) -> void:
	update_experience_amount()
