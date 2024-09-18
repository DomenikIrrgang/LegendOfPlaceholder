extends PanelContainer

@onready
var name_label: Label = $MarginContainer/VBoxContainer/Name/MarginContainer/Level

@onready
var level_label: Label = $MarginContainer/VBoxContainer/Level/MarginContainer/Level

@onready
var difficulty_label: Label = $MarginContainer/VBoxContainer/Difficulty/MarginContainer/Level

func _ready() -> void:
	Globals.get_tree().get_first_node_in_group("Recipelist").recipe_selected.connect(on_recipe_selected)
	
func on_recipe_selected(recipe: Recipe) -> void:
	name_label.text = "Name: " + recipe.name
	level_label.text = "Level: " + str(recipe.level)
	difficulty_label.text = "Difficulty: " + str(recipe.difficulty)
