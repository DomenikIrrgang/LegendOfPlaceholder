class_name Ability
extends Node

@export
var alias: String = ""

@export
var tooltip: String = ""

enum Type {
	TARGETED,
	NOT_TARGETED
}

@export
var ability_type: Ability.Type = Type.TARGETED

@export
var cooldown: float = 0.0
var remaining_cooldown: float = 0

@export
var cast_time: float = 0.0

@export
var interuptable: bool = false

@export
var value: int = 0

@export
var scaling_factor: float = 0.1

@export
var spell_school: SpellSchool.Enum = SpellSchool.Enum.PHYSICAL

@export
var target_type: TargetType.Enum = TargetType.Enum.SINGLE

@export
var resource_cost: int = 0

@export
var resource_type: ResourceType.Enum = ResourceType.Enum.MANA

@export
var crittable: bool = true

@export
var critical_chance: float = 0.0

@export
var critical_effect: float = 0.0

@export
var missable: bool = false

@export
var miss_chance: float = 0.0

@export
var dodgeable: bool = false

@export
var parriable: bool = false

@export
var resistable: bool = false

@export
var reflectable: bool = false

@export
var icon: Texture

# Charges
@export
var max_charges: int = 1
var charges: float = 1.0

signal charges_changed(current_charges: int, change: int)
signal remaining_cooldown_changed(remaining_cooldown: float, cooldown: float)
signal used(ability: Ability)

func _init() -> void:
	remaining_cooldown = 0.0
		
func get_cooldown() -> float:
	return cooldown
	
func get_alias() -> String:
	return alias
	
func reset() -> void:
	remaining_cooldown = 0
	charges = max_charges
	
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
	
func execute(_source: Unit, _target: Unit) -> void:
	pass
	
func get_value(_source: Unit, _target: Unit) -> int:
	return value
	
func get_scaling_factor(_source: Unit, _target: Unit) -> float:
	return scaling_factor
	
func can_use(_source: Unit) -> bool:
	return get_charges() >= 1
	
func can_cast(_source: Unit, _target: Unit) -> bool:
	return true
	
func get_cast_time() -> float:
	return cast_time
	
func is_interuptable() -> bool:
	return interuptable

func use(_source: Unit, _target: Unit) -> void:
	if get_charges() == get_max_charges():
		set_remaining_cooldown(get_cooldown())
	gain_charges(-1)
	used.emit(self)
	
func get_charges() -> int:
	return charges
	
func get_max_charges() -> int:
	return max_charges
	
func gain_charges(change: int) -> void:
	charges += change
	charges_changed.emit(charges, change)
	
func set_remaining_cooldown(_remaining_cooldown) -> void:
	remaining_cooldown = _remaining_cooldown
	remaining_cooldown_changed.emit(remaining_cooldown, cooldown)
	
func get_remaining_cooldown() -> float:
	return remaining_cooldown
	
func get_cooldown_progress() -> float:
	return get_remaining_cooldown() * 100.0 / get_cooldown()
	
func update(delta: float) -> void:
	if remaining_cooldown > 0.0:
		set_remaining_cooldown(get_remaining_cooldown() - delta)
	else:
		if get_charges() < get_max_charges():
			gain_charges(1)
			if get_charges() == get_max_charges():
				set_remaining_cooldown(0.0)				
			else:
				set_remaining_cooldown(cooldown)
		else:
			if remaining_cooldown < 0.0:
				set_remaining_cooldown(0.0)
