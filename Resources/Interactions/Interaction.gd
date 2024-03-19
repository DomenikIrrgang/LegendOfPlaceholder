class_name Interaction
extends Resource

@export
var visible_conditions: Array[Condition] = []

@export
var useable_conditions: Array[Condition] = []

func start() -> void:
	pass

func get_icon() -> Texture:
	return load("res://assets/ui/items/fire_spelltome.png")
	
func get_alias() -> String:
	return "<InteractionType>"

func is_visible() -> bool:
	for condition in visible_conditions:
		if not condition.is_fulfilled():
			return false
	return true
	
func is_useable() -> bool:
	for condition in useable_conditions:
		if not condition.is_fulfilled():
			return false
	return true
