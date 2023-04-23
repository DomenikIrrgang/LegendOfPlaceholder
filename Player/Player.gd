class_name Player
extends Unit

@export_global_file
var weapon_path: String
var weapon: Weapon

func _ready() -> void:
	super()
	init_weapon()
	movement_speed = 50.0
	pass
	
func init_weapon() -> void:
	var weapon_scene: PackedScene = load(weapon_path)
	weapon = weapon_scene.instantiate()
	add_child(weapon)

func attack() -> AnimationPlayer:
	return weapon.attack(self)
