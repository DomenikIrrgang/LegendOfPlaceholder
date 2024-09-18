extends PanelContainer

@onready
var material_list: VBoxContainer = $MarginContainer/VBoxContainer/MaterialList

var MaterialListItem = preload("res://ui/GameUI/Runesmithing/MaterialListItem.tscn")

func _ready() -> void:
	Globals.get_tree().get_first_node_in_group("Recipelist").recipe_selected.connect(on_recipe_selected)
	
func on_recipe_selected(recipe: Recipe) -> void:
	Globals.free_children(material_list)
	for ingridient in recipe.ingredients:
		var list_item = MaterialListItem.instantiate()
		material_list.add_child(list_item)
		list_item.set_ingridient(ingridient)
