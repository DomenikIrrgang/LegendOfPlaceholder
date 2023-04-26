class_name FollowMovementStrategy
extends UnitMovementStrategy

var unit_to_follow: Unit

func _init(_unit: Unit, _unit_to_follow: Unit):
	super(_unit)
	unit_to_follow = _unit_to_follow
	
func calculateMovementVelocity() -> Vector2:
	var movement_velocity: Vector2
	if (get_distance_to_target() > 175 || get_distance_to_target() < 5):
		movement_velocity = Vector2(0, 0)
	else:
		var movement_direction = get_direction_to_target()
		movement_velocity = movement_direction
	return movement_velocity
	
func get_distance_to_target() -> float:
	return unit.global_position.distance_to(unit_to_follow.global_position)
	
func get_direction_to_target() -> Vector2:
	return (unit_to_follow.global_position - unit.global_position).normalized()
