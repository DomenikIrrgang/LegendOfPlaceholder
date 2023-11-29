class_name StatusEffectBar
extends HBoxContainer

@export
var status_effect_type: StatusEffectType.Enum

@export
var duration_position: StatusEffectDurationPosition.Enum = StatusEffectDurationPosition.Enum.TOP

var time_passed: float = 1.0

var status_effect_display = load("res://ui/GameUI/StatusEffect/StatusEffectDisplay.tscn")

var unit: Unit

func initialize(_unit: Unit) -> void:
	if unit != null:
		unit.status_effect_applied.disconnect(sync_status_effects)
		unit.status_effect_removed.disconnect(sync_status_effects)
		unit.status_effect_refreshed.disconnect(sync_status_effects)
		unit.status_effect_dispelled.disconnect(sync_status_effects)
		unit.status_effect_stack_applied.disconnect(sync_status_effects)
		unit.status_effect_stack_removed.disconnect(sync_status_effects)
	unit = _unit
	unit.status_effect_applied.connect(sync_status_effects)
	unit.status_effect_removed.connect(sync_status_effects)
	unit.status_effect_refreshed.connect(sync_status_effects)
	unit.status_effect_dispelled.connect(sync_status_effects)
	unit.status_effect_dispelled.connect(sync_status_effects)
	unit.status_effect_dispelled.connect(sync_status_effects)
	unit.status_effect_stack_applied.connect(sync_status_effects)
	unit.status_effect_stack_removed.connect(sync_status_effects)
	
func sync_status_effects(status_effect: StatusEffect, stacks: int, source: Unit, target: Unit) -> void:
	for display in get_children():
		display.queue_free()
	for status_effect_application in unit.status_effects:
		if status_effect_type == status_effect_application.status_effect.type:
			var display = status_effect_display.instantiate()
			add_child(display)
			display.set_status_effect_application(status_effect_application, duration_position)
