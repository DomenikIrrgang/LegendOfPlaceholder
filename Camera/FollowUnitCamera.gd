class_name FollowUnitCamera
extends CameraMovementStrategy

var unit: Unit

var max_distance_to_unit: float = 1.0
var speed: float = 0.2

func _init(_unit: Unit) -> void:
	unit = _unit
	
func update(camera: Camera2D, _delta: float) -> void:
	if (unit != null):
		var direction_to_unit = camera.global_position.direction_to(unit.global_position).normalized()
		var distance_to_unit = camera.global_position.distance_to(unit.global_position)
		if distance_to_unit >= max_distance_to_unit:
			camera.global_position += direction_to_unit * ((distance_to_unit / (20 * max_distance_to_unit)) * speed)
