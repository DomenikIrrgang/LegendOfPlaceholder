extends VBoxContainer

signal recipe_selected(recipe: Recipe)

var selected_recipe: Recipe = null

func _ready() -> void:
	RunesmithingManager.recipe_learned.connect(add_recipe)
	visibility_changed.connect(on_visibility_changed)
	
func on_visibility_changed() -> void:
	if is_visible_in_tree():
		%NoRecipes.visible = RunesmithingManager.get_recipes().size() == 0
		for recipe in RunesmithingManager.get_recipes():
			add_recipe(recipe)
		if RunesmithingManager.get_recipes().size() >= 1:
			%RecipeDetails.visible = true
			get_children()[0].grab_focus()
		else:
			%RecipeDetails.visible = false
			%CloseButton.grab_focus()
	else:
		Globals.free_children(self)
				
func add_recipe(recipe: Recipe) -> void:
	if is_visible_in_tree():
		var list_entry = Button.new()
		list_entry.text = recipe.name
		if recipe is CraftingRecipe:
			list_entry.icon = recipe.results[0].item.icon
		list_entry.alignment = HORIZONTAL_ALIGNMENT_LEFT
		list_entry.focus_entered.connect(func():
			selected_recipe = recipe
			recipe_selected.emit(recipe)
		)
		list_entry.pressed.connect(func():
			RunesmithingManager.craft_recipe(recipe)
		)
		list_entry.button_mask = 0
		add_child(list_entry)
		var child_count =  get_child_count() 
		if get_child_count() == 1:
			%RecipeDetails.visible = true
			%NoRecipes.visible = false
