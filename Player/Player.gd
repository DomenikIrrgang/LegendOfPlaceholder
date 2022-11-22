class_name Player
extends CharacterBody2D

@export
var speed: float = 50

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var direction: int = Direction.DOWN

@onready
var model_animations: AnimationPlayer = $Animations

@onready
var weapon_animation: AnimationPlayer = $WeaponAnimation

@onready
var weapon: Sprite2D = $Weapon

func _ready() -> void:
	weapon_animation.animation_finished.connect(on_weapon_animation_finished)
	
func _process(_delta: float) -> void:
	if (velocity.y != 0):
		if (velocity.y > 0):
			direction = Direction.DOWN
		else:
			direction = Direction.UP
	if (velocity.x != 0):
		if (velocity.x > 0):
			direction = Direction.RIGHT
		else:
			direction = Direction.LEFT
			
func _physics_process(_delta: float) -> void:
	move_and_slide()

func attack() -> AnimationPlayer:
	weapon.visible = true
	match (direction):
		Direction.LEFT:
			weapon_animation.play("Attack_Left")
	return weapon_animation
	
func on_weapon_animation_finished(_animation_name: String) -> void:
	weapon.visible = false
	
func set_animation(animation_name: String) -> void:
	model_animations.play(animation_name)
	
func get_directional_vector() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
