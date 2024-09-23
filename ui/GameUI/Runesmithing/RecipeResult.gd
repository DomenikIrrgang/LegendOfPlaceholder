extends PanelContainer

@onready
var result_list: VBoxContainer = $MarginContainer/VBoxContainer/ResultList

var ResultListItem = preload("res://ui/GameUI/Runesmithing/ResultListItem.tscn")

func _ready() -> void:
	Globals.get_tree().get_first_node_in_group("Recipelist").recipe_selected.connect(on_recipe_selected)
	
func on_recipe_selected(recipe: Recipe) -> void:
	Globals.free_children(result_list)
	if recipe is CraftingRecipe:
		for ingridient in recipe.results:
			var result_list_item = ResultListItem.instantiate()
			result_list.add_child(result_list_item)
			result_list_item.set_ingridient(ingridient)
	if recipe is RuneRecipe:
		var result_list_item = ResultListItem.instantiate()
		result_list.add_child(result_list_item)
		result_list_item.set_ingridient(recipe.gear_ingridient)
