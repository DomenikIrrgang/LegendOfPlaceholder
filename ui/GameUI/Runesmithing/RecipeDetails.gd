extends PanelContainer

@onready
var name_label: Label = $MarginContainer/VBoxContainer/Name/MarginContainer/Level

@onready
var level_label: Label = $MarginContainer/VBoxContainer/Level/MarginContainer/Level

@onready
var difficulty_label: Label = $MarginContainer/VBoxContainer/Difficulty/MarginContainer/Level

@onready
var condition_list: VBoxContainer = $MarginContainer/VBoxContainer/Conditions/MarginContainer/VBoxContainer/ConditionList

@onready
var rune_slot: PanelContainer = $MarginContainer/VBoxContainer/RuneSlot

@onready
var rune_slot_label: Label = $MarginContainer/VBoxContainer/RuneSlot/MarginContainer/Level

@onready
var conditions_label: Label = $MarginContainer/VBoxContainer/Conditions/MarginContainer/VBoxContainer/Conditions

var ConditionListItem = preload("res://ui/GameUI/Runesmithing/ConditionListItem.tscn")

func _ready() -> void:
	Globals.get_tree().get_first_node_in_group("Recipelist").recipe_selected.connect(on_recipe_selected)
	
func on_recipe_selected(recipe: Recipe) -> void:
	name_label.text = "Name: " + recipe.name
	level_label.text = "Level: " + str(recipe.level)
	difficulty_label.text = "Difficulty: " + str(recipe.difficulty)
	rune_slot.visible = recipe is RuneRecipe
	if recipe is RuneRecipe:
		rune_slot_label.text = "Rune Slot: " + SpellSchool.Enum.keys()[recipe.rune.spell_school].capitalize()
	Globals.free_children(condition_list)
	if recipe.conditions.size() > 0:
		conditions_label.text = "Conditions:"
		for condition in recipe.conditions:
			var condition_list_item = ConditionListItem.instantiate()
			condition_list.add_child(condition_list_item)
			condition_list_item.set_condition(condition)
	else:
		conditions_label.text = "Conditions: None"
