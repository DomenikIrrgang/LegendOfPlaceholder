class_name KeepVelocityMovementStrategy
extends UnitMovementStrategy

func _init(_unit: Unit):
	super(_unit)
	
func calculateMovementVelocity() -> Vector2:
	return unit.movement_velocity
