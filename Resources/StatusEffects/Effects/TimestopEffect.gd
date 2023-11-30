class_name TimestopEffect
extends StatusEffectScript

func on_status_effect_applied(_status_effect: StatusEffect, _stacks: int, _source: Unit, target: Unit) -> void:
	target.freeze()
	
func on_status_effect_removed(_status_effect: StatusEffect, _stacks: int, _source: Unit, target: Unit) -> void:
	target.unfreeze()
