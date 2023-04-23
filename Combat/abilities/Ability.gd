class_name Ability
extends Node

@export
var alias: String

@export
var tooltip: String

@export
var cooldown: float
var remaining_cooldown: float

@export
var spell_school: SpellSchool.Enum

@export
var target_type: TargetType.Enum

@export
var resource_cost: int

@export
var resource_type: ResourceType.Enum

@export
var crittable: bool

@export
var critical_chance: float

@export
var critical_effect: float

@export
var missable: bool

@export
var miss_chance: float

@export
var dodgeable: bool

@export
var parriable: bool

@export
var resistable: bool

@export
var reflectable: bool

func _init() -> void:
	remaining_cooldown = 0.0
	
func get_cool_down() -> float:
	return cooldown
	
func set_remaining_cool_down(new_remaining_cool_down: float) -> void:
	remaining_cooldown = new_remaining_cool_down

func get_remaining_cool_down() -> float:
	return remaining_cooldown
	
func get_alias() -> String:
	return alias
	
func reset() -> void:
	remaining_cooldown = 0
	
func get_tooltip() -> String:
	return tooltip
	
func get_spell_school() -> SpellSchool.Enum:
	return spell_school
	
func can_crit() -> bool:
	return crittable
	
func get_critical_chance() -> float:
	return critical_chance
	
func get_critical_effect() -> float:
	return critical_effect
	
func get_miss_chance() -> float:
	return miss_chance
	
func can_miss() -> bool:
	return missable
	
func can_be_dodged() -> bool:
	return dodgeable
	
func can_be_parried() -> bool:
	return parriable
	
func can_be_reflected() -> bool:
	return reflectable
	
func can_be_resisted() -> bool:
	return resistable
	
func get_resource_type() -> int:
	return resource_type

func get_resource_cost() -> int:
	return resource_cost
	
func get_target_type() -> int:
	return target_type
	
func get_value(source, target) -> int:
	assert(false, "Function not implemented yet!")
	return 0
	
func get_scaling_factor(source, target) -> float:
	assert(false, "Function not implemented yet!")
	return 0.0

func get_animation() -> void:
	assert(false, "Function not implemented yet!")
	
func execute(combat, source, target) -> void:
	assert(false, "Function not implemented yet!")
