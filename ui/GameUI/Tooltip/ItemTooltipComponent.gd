class_name ItemTooltipComponent
extends MouseInside

@export
var item_node: Node

var tooltip = load("res://ui/GameUI/Tooltip/ItemTooltip.tscn")
var tooltip_instance

func _ready() -> void:
	owner.focus_entered.connect(on_focus_entered)
	owner.focus_exited.connect(on_focus_exited)
	
func on_focus_entered() -> void:
	var item_instance = item_node.item_instance
	if item_instance != null:
		if tooltip_instance == null:
			tooltip_instance = tooltip.instantiate()
			Globals.get_game_user_inteface().add_child(tooltip_instance)
		#tooltip_instance.position_mode = tooltip_instance.PositionMode.NODE
		tooltip_instance.show_item(item_instance)
		tooltip_instance.attach_to_node(owner)
		#tooltip_instance.global_position = owner.global_position + Vector2(0, owner.size.y)
		#tooltip_instance.reset_size()
		tooltip_instance.visible = false
		
func on_focus_exited() -> void:
	if tooltip_instance != null:
		tooltip_instance.queue_free()

func _on_mouse_in():
	if owner.mouse_filter != Control.MouseFilter.MOUSE_FILTER_IGNORE and item_node and item_node.is_visible_in_tree() and not owner.has_focus():
		var item_instance = item_node.item_instance
		if item_instance != null:
			if tooltip_instance == null:
				tooltip_instance = tooltip.instantiate()
				Globals.get_game_user_inteface().add_child(tooltip_instance)
			tooltip_instance.show_item(item_instance)
			tooltip_instance.visible = false

func _on_mouse_out():
	if tooltip_instance != null and not owner.has_focus():
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
