class_name InvertedMovementEffect
extends StatusEffectScript

func on_status_effect_applied(_status_effect: StatusEffect, _stacks: int, _source: Unit, target: Unit) -> void:
	target.running_movement_strategy = InvertedControlledMovementStrategy.new(target, target.running_movement_strategy)
	target.movement_strategy = target.running_movement_strategy
	
func on_status_effect_removed(_status_effect: StatusEffect, _stacks: int, _source: Unit, target: Unit) -> void:
	target.running_movement_strategy = target.running_movement_strategy.movement_strategy
