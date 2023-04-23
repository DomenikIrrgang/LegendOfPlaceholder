class_name Unit
extends CharacterBody2D

@export
var alias: String

@onready
var model: Sprite2D = $Model

@onready
var model_animation: AnimationPlayer = $ModelAnimation

@onready
var user_interface: CanvasLayer = $UserInterface

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
var max_health = 1000
var health = 1000

signal health_changed(new_value: int, change: int)

func _init() -> void:
	alias = "Suu"

func _ready() -> void:
	movement_strategy = EscapeMovementStrategy.new(self, get_node("../Player"))
	health_bar = HealthBar.instantiate()
	health_bar.position.y = -15
	add_child(health_bar)
	health_bar.initialize(self)
	model_animation.play("Down")

func _process(_delta: float) -> void:
	movement_velocity = movement_strategy.calculateMovementVelocity()
	change_health(1)
	
func _physics_process(delta: float) -> void:
	velocity = movement_velocity + pushback_velocity * delta
	move_and_slide()
	
func apply_pushback(direction: Vector2, pushback_strength: float, pushback_duration: float) -> void:
	var tween = create_tween()
	pushback_velocity = direction.normalized() * (pushback_strength * 700) * (100.0 / mass)
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
