class_name InvertedMovementEffect
extends StatusEffectScript

func on_status_effect_applied(_status_effect: StatusEffect, _stacks: int, _source: Unit, target: Unit) -> void:
	target.movement_modifiers.append(InvertMovementModifier.new())
	
func on_status_effect_removed(_status_effect: StatusEffect, _stacks: int, _source: Unit, target: Unit) -> void:
	for i in range(target.movement_modifiers.size()):
		if target.movement_modifiers[i] is InvertMovementModifier:
			target.movement_modifiers.remove_at(i)
			break
