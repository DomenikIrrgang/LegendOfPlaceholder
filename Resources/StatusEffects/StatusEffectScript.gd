class_name StatusEffectScript
extends Resource

func on_status_effect_applied(status_effect: StatusEffect, stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_stack_applied(status_effect: StatusEffect, stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_stack_removed(status_effect: StatusEffect, stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_dispelled(status_effect: StatusEffect, stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_removed(status_effect: StatusEffect, stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_expired(status_effect: StatusEffect, stacks: int, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_update(status_effect: StatusEffect, stacks: int, _source: Unit, _target: Unit, delta: float) -> void:
	pass
	
func on_status_effect_refreshed(status_effect: StatusEffect, stacks: int, _source: Unit, _target: Unit) -> void:
	pass
