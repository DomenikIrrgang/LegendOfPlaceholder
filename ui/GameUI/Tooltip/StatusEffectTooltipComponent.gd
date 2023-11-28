class_name StatusEffectTooltipComponent
extends MouseInside

@export
var status_effect_node: Node

var tooltip = load("res://ui/GameUI/Tooltip/StatusEffectTooltip.tscn")
var tooltip_instance

func _on_mouse_in():
	if status_effect_node == null:
		status_effect_node = get_parent()
	if status_effect_node and status_effect_node.is_visible_in_tree():
		var status_effect = status_effect_node.status_effect
		if tooltip_instance == null:
			tooltip_instance = tooltip.instantiate()
			Globals.get_game_user_inteface().add_child(tooltip_instance)
		tooltip_instance.show_status_effect(status_effect)
		tooltip_instance.visible = false

func _on_mouse_out():
	if tooltip_instance != null:
		tooltip_instance.visible = false
		tooltip_instance.queue_free()

func _on_visibility_changed():
	if tooltip_instance != null:
		tooltip_instance.visible = false
		tooltip_instance.queue_free()

func _notification(what):
	if (what == NOTIFICATION_PREDELETE):
		if tooltip_instance != null:
			tooltip_instance.visible = false
			tooltip_instance.queue_free()
