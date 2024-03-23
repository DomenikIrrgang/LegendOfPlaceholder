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
	if !unit.status_effect_applied.is_connected(sync_status_effects):
		unit.status_effect_applied.connect(sync_status_effects)
		unit.status_effect_removed.connect(sync_status_effects)
		unit.status_effect_refreshed.connect(sync_status_effects)
		unit.status_effect_dispelled.connect(sync_status_effects)
		unit.status_effect_stack_applied.connect(sync_status_effects)
		unit.status_effect_stack_removed.connect(sync_status_effects)
	sync_status_effects(null, 0, null, null)
	
func sync_status_effects(_status_effect: StatusEffect, _stacks: int, _source: Unit, _target: Unit) -> void:
	var status_effect_count = get_status_effect_type_count(unit, status_effect_type)
	if get_children().size() < status_effect_count:
		for i in range(get_children().size(), status_effect_count):
			var display = status_effect_display.instantiate()
			add_child(display)
	if get_children().size() > status_effect_count:
		for i in range(status_effect_count, get_children().size()):
			get_children()[i].queue_free()
	var index = 0
	var status_effect_index = 0
	while index < status_effect_count:
		if unit.status_effects[status_effect_index].status_effect.type == status_effect_type:
			get_children()[index].set_status_effect_application(unit.status_effects[status_effect_index], duration_position)
			index += 1
		status_effect_index += 1
		
func get_status_effect_type_count(_unit: Unit, type: StatusEffectType.Enum) -> int:
	var count = 0
	for status_effect_application in _unit.status_effects:
		if status_effect_application.status_effect.type == type:
			count +=1
	return count
