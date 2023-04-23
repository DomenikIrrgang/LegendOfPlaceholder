class_name ControlledMovementStrategy
extends UnitMovementStrategy

func _init(_unit: Unit):
	super(_unit)
	
func calculateMovementVelocity() -> Vector2:
	var movement_velocity: Vector2
	var direction = get_directional_vector().normalized()
	movement_velocity = direction * unit.movement_speed
	return movement_velocity
	
func get_directional_vector() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
