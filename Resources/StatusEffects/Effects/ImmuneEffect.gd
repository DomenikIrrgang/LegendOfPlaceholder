class_name ImmuneEffect
extends StatusEffectScript

func on_status_effect_applied(_status_effect: StatusEffect, _stacks: int, _source: Unit, target: Unit) -> void:
	target.combat_logic.add_calculate_logic_layer(ImmuneLayer.new())
	
func on_status_effect_removed(_status_effect: StatusEffect, _stacks: int, _source: Unit, target: Unit) -> void:
	target.combat_logic.remove_calculate_logic_layer(ImmuneLayer.new())
