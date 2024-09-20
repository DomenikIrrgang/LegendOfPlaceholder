extends Button

func _ready() -> void:
	pressed.connect(on_pressed)
	RunesmithingManager.recipe_learned.connect(func(recipe: Recipe):
		visible = RunesmithingManager.get_recipes().size() > 0
	)
	visible = RunesmithingManager.get_recipes().size() > 0
	
func on_pressed() -> void:
	var recipe = Globals.get_tree().get_first_node_in_group("Recipelist").selected_recipe
	if recipe != null:
		RunesmithingManager.craft_recipe(recipe)
