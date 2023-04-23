class_name Player
extends Unit

@export_global_file
var weapon_path: String
var weapon: Weapon

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var direction: int = Direction.DOWN

func _ready() -> void:
	super()
	init_weapon()
	movement_speed = 50.0
	pass
	
func init_weapon() -> void:
	var weapon_scene: PackedScene = load(weapon_path)
	weapon = weapon_scene.instantiate()
	add_child(weapon)
	
func _process(_delta) -> void:
	super(_delta)
	if (movement_velocity.y != 0):
		if (movement_velocity.y > 0):
			direction = Direction.DOWN
		else:
			direction = Direction.UP
	if (movement_velocity.x != 0):
		if (movement_velocity.x > 0):
			direction = Direction.RIGHT
		else:
			direction = Direction.LEFT

func attack() -> AnimationPlayer:
	return weapon.attack(self)
	
func set_animation(animation_name: String) -> void:
	model_animation.play(animation_name)
