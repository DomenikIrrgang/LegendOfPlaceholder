class_name CustomCamera
extends Camera2D

@export
var targeted_node: Node2D

var movement_strategy: CameraMovementStrategy

func _ready() -> void:
	movement_strategy = FollowUnitCamera.new(targeted_node)

func _process(delta: float) -> void:
	movement_strategy.update(self, delta)

func reset() -> void:
	movement_strategy = FollowUnitCamera.new(targeted_node)
