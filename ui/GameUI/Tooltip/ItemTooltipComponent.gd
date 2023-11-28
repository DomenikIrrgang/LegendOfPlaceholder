class_name ItemTooltipComponent
extends MouseInside

@export
var item_node: Node

var tooltip = load("res://ui/GameUI/Tooltip/ItemTooltip.tscn")
var tooltip_instance

func _on_mouse_in():
	if item_node and item_node.is_visible_in_tree():
		var item = item_node.item
		if item != null:
			if tooltip_instance == null:
				tooltip_instance = tooltip.instantiate()
				Globals.get_game_user_inteface().add_child(tooltip_instance)
			tooltip_instance.show_item(item)
			tooltip_instance.visible = false

func _on_mouse_out():
	if tooltip_instance != null:
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
