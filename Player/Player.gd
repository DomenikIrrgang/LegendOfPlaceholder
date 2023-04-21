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

@onready
var weapon_animation: AnimationPlayer = $WeaponAnimation

func _ready() -> void:
	var weapon_scene: PackedScene = load(weapon_path)
	weapon = weapon_scene.instantiate()
	add_child(weapon)
	pass
	
func _process(delta) -> void:
	pass
	
func _physics_process(_delta: float) -> void:
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
	move_and_slide()

func attack() -> AnimationPlayer:
	return weapon.attack(self)
	
func set_animation(animation_name: String) -> void:
	model_animation.play(animation_name)
	
func get_directional_vector() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
