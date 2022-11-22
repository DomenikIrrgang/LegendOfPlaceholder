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
var model_animation: AnimationPlayer = $Animations

@onready
var weapon_animation: AnimationPlayer = $WeaponAnimation

@onready
var weapon: Sprite2D = $Weapon

func _ready() -> void:
	weapon_animation.animation_finished.connect(on_weapon_animation_finished)
	
func _physics_process(_delta: float) -> void:
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
	move_and_slide()

func attack() -> AnimationPlayer:
	weapon.visible = true
	match (direction):
		Direction.LEFT:
			weapon_animation.play("Attack_Left")
			model_animation.play("Attack_Left")
			weapon.position.x = -10
			weapon.position.y = 3
		Direction.DOWN:
			weapon_animation.play("Attack_Down")
			model_animation.play("Attack_Down")
			weapon.position.x = 0
			weapon.position.y = 10
		Direction.RIGHT:
			weapon_animation.play("Attack_Right")
			model_animation.play("Attack_Right")
			weapon.position.x = 10
			weapon.position.y = 0
		Direction.UP:
			weapon_animation.play("Attack_Up")
			model_animation.play("Attack_Up")
			weapon.position.x = 0
			weapon.position.y = -10
	return weapon_animation
	
func on_weapon_animation_finished(_animation_name: String) -> void:
	weapon.visible = false
	
func set_animation(animation_name: String) -> void:
	model_animation.play(animation_name)
	
func get_directional_vector() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
