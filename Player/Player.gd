class_name Player
extends Unit

@export
var weapon_path: String

var weapon: Weapon

# Dash
var dash_charges: float = 0.0
var max_dash_charges: int = 3
var dash_charge_regeneration_rate: float = 0.4

# UI
var DashMeter = preload("res://ui/unit/DashMeter.tscn")
var dash_meter

signal dash_charges_changed(dash_charges: float, dash_charge_change: float)

func _ready() -> void:
	super()
	init_weapon()
	movement_speed = 50.0
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
	
func init_weapon() -> void:
	var weapon_scene: PackedScene = load(weapon_path)
	weapon = weapon_scene.instantiate()
	add_child(weapon)

func attack() -> AnimationPlayer:
	return weapon.attack(self)
