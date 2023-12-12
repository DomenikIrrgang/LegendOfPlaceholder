class_name InvertMovementModifier
extends MovementModifier

func modify_movement_speed(unit: Unit, current_movement_velocity: Vector2) -> Vector2:
	return current_movement_velocity * Vector2(-1, -1)
