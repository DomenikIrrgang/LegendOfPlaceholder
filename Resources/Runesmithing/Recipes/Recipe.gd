class_name Recipe
extends Resource

@export
var name: String

@export
var level: int = 1

@export
var learning_conditions: Array[Condition] = []

@export_range(1, 100) # a difficulty of 1 means the recipe is easy, a difficulty of 100 is the hardest.
var difficulty: int = 10

@export
var conditions: Array[Condition] = []

func get_experience() -> int:
	return difficulty * level
