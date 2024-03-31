class_name PathMovementStrategy
extends UnitMovementStrategy

var path: Array[Vector2]
var current_index: int = 0

func _init(_unit: Unit, _path: Array[Vector2]):
	super(_unit)
	path = _path
	
func calculateMovementVelocity() -> Vector2:
	if current_index >= path.size() - 1 and unit.global_position == path[current_index]:
		return Vector2(0, 0)
	if unit.global_position == path[current_index]:
		current_index += 1
	var direction = (path[current_index] - unit.global_position).normalized()
	var distance =  unit.global_position.distance_to(path[current_index])
	var direction_distance = direction.length()
	var position = unit.global_position
	if direction_distance > distance:
		unit.global_position = path[current_index]
		return Vector2(0, 0)
	else:
		return direction
