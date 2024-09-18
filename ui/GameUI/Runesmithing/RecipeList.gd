extends VBoxContainer

signal recipe_selected(recipe: Recipe)

var selected_recipe: Recipe = null

func _ready() -> void:
	for recipe in RunesmithingManager.get_recipes():
		add_recipe(recipe)
	RunesmithingManager.recipe_learned.connect(add_recipe)
	visibility_changed.connect(on_visibility_changed)
	
func on_visibility_changed() -> void:
	if visible and get_child_count() > 0:
		get_children()[0].grab_focus()
		
				
func add_recipe(recipe: Recipe) -> void:
	var list_entry = Button.new()
	list_entry.text = recipe.name
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
	if visible:
		get_children()[get_children().size() - 1].grab_focus()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
