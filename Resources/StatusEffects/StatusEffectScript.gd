class_name StatusEffectScript
extends Resource

func on_status_effect_applied(_status_effect: StatusEffect, _stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_stack_applied(_status_effect: StatusEffect, _stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_stack_removed(_status_effect: StatusEffect, _stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_dispelled(_status_effect: StatusEffect, _stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_removed(_status_effect: StatusEffect, _stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_expired(_status_effect: StatusEffect, _stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_update(_status_effect: StatusEffect, _stacks: int, _source: Unit, _target: Unit, _delta: float) -> void:
	pass
	
func on_status_effect_refreshed(_status_effect: StatusEffect, _stacks: int, _source: Unit, _target: Unit) -> void:
	pass
