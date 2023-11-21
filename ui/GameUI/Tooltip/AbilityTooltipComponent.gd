class_name AbilityTooltipComponent
extends MouseInside

@export
var ability_node: Node

var tooltip = load("res://ui/GameUI/Tooltip/ability_tooltip.tscn")
var tooltip_instance

func _on_mouse_in():
	if ability_node == null:
		ability_node = get_parent()
	if ability_node and ability_node.is_visible_in_tree():
		var ability = ability_node.ability
		if tooltip_instance == null:
			tooltip_instance = tooltip.instantiate()
			Globals.get_game_user_inteface().add_child(tooltip_instance)
		tooltip_instance.show_ability(ability)
		tooltip_instance.visible = false

func _on_mouse_out():
	if tooltip_instance != null:
		tooltip_instance.visible = false
		tooltip_instance.queue_free()

func _on_visibility_changed():
	if tooltip_instance != null:
		tooltip_instance.visible = false
		tooltip_instance.queue_free()
