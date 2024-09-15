class_name Recipe
extends Resource

@export
var name: String

@export
var conditions: Array[Condition] = []

@export
var ingredients: Array[Ingredient] = []

@export
var results: Array[Ingredient] = []
