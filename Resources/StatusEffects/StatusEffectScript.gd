class_name StatusEffectScript
extends Resource

func on_status_effect_applied(status_effect: StatusEffect, _source: Unit, _target: Unit) -> void:
	if _source is Player:
		_source.stats.increase_stat(Stat.Enum.STAMINA, 4000)
	
func on_status_effect_dispelled(status_effect: StatusEffect, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_removed(status_effect: StatusEffect, _source: Unit, _target: Unit) -> void:
	pass
	
func on_status_effect_update(status_effect: StatusEffect, _source: Unit, _target: Unit, delta: float) -> void:
	pass
