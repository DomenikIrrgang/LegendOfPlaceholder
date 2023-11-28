class_name StatusEffectBar
extends HBoxContainer

@export
var status_effect_type: StatusEffectType.Enum

var time_passed: float = 1.0

var status_effect_display = load("res://ui/GameUI/StatusEffect/StatusEffectDisplay.tscn")

var unit: Unit

func initialize(_unit: Unit) -> void:
	unit = _unit
	unit.status_effect_applied.connect(sync_status_effects)
	unit.status_effect_removed.connect(sync_status_effects)
	unit.status_effect_refreshed.connect(sync_status_effects)
	unit.status_effect_dispelled.connect(sync_status_effects)
	
func sync_status_effects(status_effect: StatusEffect, stacks: int, source: Unit, target: Unit) -> void:
	for display in get_children():
		display.queue_free()
	for status_effect_application in unit.status_effects:
		if status_effect_type == status_effect_application.status_effect.type:
			var display = status_effect_display.instantiate()
			add_child(display)
			display.set_status_effect_application(status_effect_application)
