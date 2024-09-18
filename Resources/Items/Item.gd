class_name Item
extends Resource

@export
var alias: String : get = get_alias

@export
var useable: bool : get = get_useable

@export
var use_effect: UseEffect : get = get_use_effect

@export_multiline
var use_description: String : get = get_use_description

@export
var limited: bool = false : get = get_limited

@export
var limit: int = 1 : get = get_limit

@export
var stackable: bool = false : get = get_stackable

@export
var stack_amount: int = 5 : get = get_stack_amount

@export_multiline
var description: String : get = get_description

@export
var icon: Texture

func get_alias() -> String:
	return alias
	
func get_description() -> String:
	return description
	
func get_use_description() -> String:
	return use_description
	
func get_use_effect() -> UseEffect:
	return use_effect
	
func get_useable() -> bool:
	return useable
	
func get_stackable() -> bool:
	return stackable
	
func get_stack_amount() -> int:
	return stack_amount
	
func get_limited() -> bool:
	return limited
	
func get_limit() -> int:
	return limit
