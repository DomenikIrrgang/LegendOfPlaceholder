class_name UnitMovementStrategy
extends Node

var unit: Unit
var enabled: bool = true

func _init(_unit: Unit):
	unit = _unit
	
func get_movement_velocity() -> Vector2:
	if enabled:
		return calculateMovementVelocity()
	else:
		return Vector2.ZERO

func calculateMovementVelocity() -> Vector2:
	return Vector2(0, 0)
