class_name TextTooltipComponent
extends MouseInside

@export
var text: String

@export
var text_node: Node

var tooltip = load("res://ui/GameUI/Tooltip/text_tooltip.tscn")
var tooltip_instance

func _on_mouse_in():
	if is_visible_in_tree():
		var _text = text_node.text if text_node != null else text
		if tooltip_instance == null:
			tooltip_instance = tooltip.instantiate()
			Globals.get_game_user_inteface().add_child(tooltip_instance)
		tooltip_instance.show_text(_text)
		tooltip_instance.visible = true

func _on_mouse_out():
	if tooltip_instance != null:
		tooltip_instance.queue_free()

func _on_visibility_changed():
	if tooltip_instance != null:
		tooltip_instance.visible = false
		tooltip_instance.queue_free()
