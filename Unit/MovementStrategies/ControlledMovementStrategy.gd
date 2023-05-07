class_name ControlledMovementStrategy
extends UnitMovementStrategy

func _init(_unit: Unit):
	super(_unit)
	
func calculateMovementVelocity() -> Vector2:
	return InputControlls.get_state().movement_direction.normalized()
