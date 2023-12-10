class_name InvertedControlledMovementStrategy
extends UnitMovementStrategy

var movement_strategy: UnitMovementStrategy

func _init(_unit: Unit, _movement_strategy: UnitMovementStrategy):
	super(_unit)
	movement_strategy = _movement_strategy
	
func calculateMovementVelocity() -> Vector2:
	return movement_strategy.calculateMovementVelocity() * Vector2(-1, -1)
