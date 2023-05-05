class_name CustomCamera
extends Camera2D

var snap_time = 0.1
var current_snap_time = 0.1
var should_snap = false

@export
var targeted_node: Node2D

var movement_strategy: CameraMovementStrategy

func _ready() -> void:
	movement_strategy = FollowUnitCamera.new(targeted_node)

func _process(delta: float) -> void:
	movement_strategy.update(self, delta)
	if current_snap_time <= snap_time:
		current_snap_time += delta
	if should_snap and current_snap_time >= snap_time:
		should_snap = false
		position_smoothing_enabled = true

func reset() -> void:
	movement_strategy = FollowUnitCamera.new(targeted_node)
	position_smoothing_speed = 1.0
	
func snap() -> void:
	position_smoothing_enabled = false
	current_snap_time = 0.0
	should_snap = true
