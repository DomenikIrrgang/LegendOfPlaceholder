class_name FollowUnitCamera
extends CameraMovementStrategy

var unit: Unit

func _init(_unit: Unit) -> void:
	unit = _unit
	
func update(camera: Camera2D, _delta: float) -> void:
	camera.position = unit.position
