class_name ControlledMovementStrategy
extends UnitMovementStrategy

func _init(_unit: Unit):
	super(_unit)
	
func calculateMovementVelocity() -> Vector2:
	var movement_velocity: Vector2
	var direction = InputControlls.get_directional_vector().normalized()
	movement_velocity = direction
	return movement_velocity
