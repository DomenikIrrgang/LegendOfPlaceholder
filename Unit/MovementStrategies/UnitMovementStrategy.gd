class_name UnitMovementStrategy
extends Node

var unit: Unit

func _init(_unit: Unit):
	unit = _unit

func calculateMovementVelocity() -> Vector2:
	return Vector2(0, 0)
