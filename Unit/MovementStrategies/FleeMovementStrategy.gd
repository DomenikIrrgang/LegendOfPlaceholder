class_name EscapeMovementStrategy
extends UnitMovementStrategy

var unit_to_follow: Unit

func _init(unit: Unit, unit_to_follow: Unit):
	super(unit)
	self.unit_to_follow = unit_to_follow
	
func calculateMovementVelocity() -> Vector2:
	var movement_velocity: Vector2
	var movement_direction = get_direction_to_target()
	if (get_distance_to_target() > 80):
		movement_velocity = unit.movement_speed * movement_direction
	elif (get_distance_to_target() > 78):
		movement_velocity = Vector2.ZERO
	else:
		movement_velocity = unit.movement_speed * movement_direction * -1
	return movement_velocity
	
func get_distance_to_target() -> float:
	return unit.global_position.distance_to(unit_to_follow.global_position)
	
func get_direction_to_target() -> Vector2:
	return (unit_to_follow.global_position - unit.global_position).normalized()
