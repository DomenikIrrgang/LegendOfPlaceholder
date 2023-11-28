class_name StatusEffectTooltip
extends PanelContainer

@onready
var alias: Label = $MarginContainer/Content/TopLine/StatusEffectName/Label

@onready
var type: Label = $MarginContainer/Content/TopLine/Type/Label

@onready
var description: Label = $MarginContainer/Content/Description/Text/Label

func _process(_delta: float):
	visible = !Globals.get_drag_and_drop().is_dragging()
	global_position = get_viewport().get_mouse_position()
	if global_position.x >= get_viewport().size.x / 2:
		global_position.x -= size.x - 1
	else:
		global_position.x += 1
	if global_position.y >= get_viewport().size.y / 2:
		global_position.y -= size.y - 1
	else:
		global_position.y += 1


func show_status_effect(status_effect: StatusEffect) -> void:
	alias.text = status_effect.alias
	type.text = StatusEffectType.Enum.keys()[status_effect.type].capitalize()
	description.text = status_effect.description
	
