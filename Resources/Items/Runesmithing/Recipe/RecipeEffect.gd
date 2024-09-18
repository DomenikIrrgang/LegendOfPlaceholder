class_name RecipeEffect
extends UseEffect

@export
var recipe: Recipe

func on_use(_source: Unit) -> bool:
	return RunesmithingManager.learn_recipe(recipe)

func get_conditions() -> Array[Condition]:
	return recipe.learning_conditions
