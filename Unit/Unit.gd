class_name Unit
extends CharacterBody2D

@export
var alias: String

@onready
var model: Sprite2D = $Model

@onready
var model_animation: AnimationPlayer = $ModelAnimation

# UI
@onready
var health_bar
var HealthBar = preload("res://ui/unit/UnitHpBar.tscn")

# Movement
var pushback_velocity = Vector2(0, 0)
var movement_velocity = Vector2(0, 0)
var movement_speed = 30.0
var movement_strategy: UnitMovementStrategy = UnitMovementStrategy.new(self)

var mass: float = 50.0

# Health
var max_health: int = 1000
var health: int = 1000

signal health_changed(new_value: int, change: int)

# Direction
enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var direction: int = Direction.DOWN

signal direction_changed(direction: int)

func _ready() -> void:
	#movement_strategy = FollowMovementStrategy.new(self, get_node("../Player"))
	health_bar = HealthBar.instantiate()
	health_bar.position.y = -15
	add_child(health_bar)
	health_bar.initialize(self)
	model_animation.play("Down")

func _process(_delta: float) -> void:
	movement_velocity = movement_strategy.calculateMovementVelocity()
	update_direction()
	change_health(1)
	
func _physics_process(delta: float) -> void:
	velocity = movement_velocity + pushback_velocity * delta
	move_and_slide()
	
func update_direction() -> void:
	var original_direction = direction
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
	if (original_direction != direction):
		direction_changed.emit(direction)
	
func set_animation(animation_name: String) -> void:
	model_animation.play(animation_name)
	
func apply_pushback(pushback_direction: Vector2, pushback_strength: float, pushback_duration: float) -> void:
	var tween = create_tween()
	pushback_velocity = pushback_direction.normalized() * (pushback_strength * 700) * (100.0 / mass)
	tween.tween_property(self, "pushback_velocity", Vector2(0, 0), pushback_duration).set_ease(Tween.EASE_IN)
	tween.play()
	
func change_health(change: int) -> int:
	var old_value = health
	health = health + change
	if (health < 0):
		health = 0
	if (health > max_health):
		health = max_health
	var health_change = health - old_value
	emit_signal("health_changed", health, health_change)
	return health_change
