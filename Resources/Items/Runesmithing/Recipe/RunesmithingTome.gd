class_name RunesmithingTome
extends Item

@export
var recipe: Recipe

func get_alias() -> String:
	return "Runesmithing: " + recipe.name
	
func get_use_description() -> String:
	return "Teaches you the runesmithing recipe " + recipe.name + "."
	
func get_use_effect() -> UseEffect:
	if use_effect == null:
		var recipe_effect = RecipeEffect.new()
		var cooldown_group = CooldownGroup.new()
		cooldown_group.alias = "RunesmithingTome"
		cooldown_group.cooldown = 3
		recipe_effect.recipe = recipe
		recipe_effect.cooldown_group = cooldown_group
		return recipe_effect
	return use_effect

func get_useable() -> bool:
	return true
	
func get_stackable() -> bool:
	return false
	
func get_stack_amount() -> int:
	return 1
	
func get_limited() -> bool:
	return true
