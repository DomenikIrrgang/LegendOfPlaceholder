class_name Player
extends Unit

@export
var weapon_path: String

var weapon: Weapon

# Dash
var dash_charges: float = 0.0
var max_dash_charges: int = 3
var dash_charge_regeneration_rate: float = 0.4

signal dash_charges_changed(dash_charges: float, dash_charge_change: float)

# Experience
var experience: int = 0

signal experience_changed(change: int)

func _ready() -> void:
	super()
	init_weapon()
	base_movement_speed = 50.0
	pass
	
func _process(delta: float) -> void:
	super(delta)
	update_dash_charges(delta)
	
func update_dash_charges(delta: float) -> void:
	change_dash_charges(delta * dash_charge_regeneration_rate)
	
func change_dash_charges(change: float) -> float:
	var old_value = dash_charges
	dash_charges = dash_charges + change
	if (dash_charges < 0):
		dash_charges = 0
	if (dash_charges > max_dash_charges):
		dash_charges = max_dash_charges
	var dash_charges_change = dash_charges - old_value
	if (dash_charges_change != 0):
		dash_charges_changed.emit(dash_charges, dash_charges_change)
	return dash_charges_change
	
func gain_experience(amount: int) -> void:
	if (level < max_level):
		experience += amount
		print("total experience ", experience)
		print("current experience ", current_experience())
		print("experience needed for next level ", experience_needed_for_next_level())
		print("experience missing to level up ", experience_needed_for_next_level() - current_experience())
		while (experience_needed_for_next_level() - current_experience() <= 0):
			set_level(level + 1)
		experience_changed.emit(amount)
	
func current_experience() -> int:
	return experience - experience_needed_for_level(level - 1)
	
func experience_needed_for_next_level() -> int:
	return experience_needed_for_level(level) - experience_needed_for_level(level - 1)
	
func experience_needed_for_level(_level: int) -> int:
	return _level * _level * 100
	
func init_weapon() -> void:
	var weapon_scene: PackedScene = load(weapon_path)
	weapon = weapon_scene.instantiate()
	add_child(weapon)

func attack() -> AnimationPlayer:
	return weapon.attack(self)
