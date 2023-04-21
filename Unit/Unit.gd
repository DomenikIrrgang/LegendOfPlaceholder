class_name Unit
extends CharacterBody2D

@onready
var navigation_agent: NavigationAgent2D = $NavigationAgent

@onready
var model_animation: AnimationPlayer = $ModelAnimation

var tween: Tween

var pushback_velocity = Vector2(0, 0)
var movement_velocity = Vector2(0, 0)

var movement_speed = 30.0

func _ready() -> void:
	model_animation.play("Down")

func _process(_delta: float) -> void:
	var player = get_node("../Player")
	navigation_agent.target_position = player.position
	if (navigation_agent.distance_to_target() > 75 || navigation_agent.distance_to_target() < 0):
		navigation_agent.target_position = position
		movement_velocity = Vector2(0, 0)
	else:
		var movement_direction = position.direction_to(navigation_agent.get_next_path_position())
		movement_velocity = movement_speed * movement_direction
	
func _physics_process(_delta: float) -> void:
	velocity = movement_velocity + pushback_velocity
	move_and_slide()
	
func apply_pushback(direction: Vector2, pushback_strength: float, pushback_duration: float) -> void:
	tween = create_tween()
	tween.finished.connect(pushback_finished)
	pushback_velocity = direction.normalized() * pushback_strength
	tween.tween_property(self, "pushback_velocity", Vector2(0, 0), pushback_duration).set_ease(Tween.EASE_IN)
	tween.play()
		
func pushback_finished() -> void:
	print("pushback finished")
	
