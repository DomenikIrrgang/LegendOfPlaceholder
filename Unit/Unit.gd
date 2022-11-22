extends CharacterBody2D

@onready
var navigation_agent: NavigationAgent2D = $NavigationAgent

@onready
var model_animation: AnimationPlayer = $ModelAnimation

func _ready() -> void:
	model_animation.play("Down")

func _process(_delta: float) -> void:
	var player = get_node("../Player")
	navigation_agent.target_location = player.position
	if (navigation_agent.distance_to_target() > 75):
		navigation_agent.target_location = position
	
func _physics_process(_delta: float) -> void:
	var move_direction = position.direction_to(navigation_agent.get_next_location())
	velocity = 20.0 * move_direction
	if (navigation_agent.distance_to_target() > 20):
		move_and_slide()
	
	
