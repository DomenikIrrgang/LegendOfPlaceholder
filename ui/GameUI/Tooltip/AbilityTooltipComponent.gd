class_name AbilityTooltipComponent
extends MouseInside

@export
var ability_node: Node

var tooltip = load("res://ui/GameUI/Tooltip/ability_tooltip.tscn")
var tooltip_instance

func _on_mouse_in():
	var ability = ability_node.ability
	if ability != null:
		if tooltip_instance == null:
			tooltip_instance = tooltip.instantiate()
			add_child(tooltip_instance)
		tooltip_instance.show_ability(ability)
		tooltip_instance.visible = true

func _on_mouse_out():
	if tooltip_instance != null:
		tooltip_instance.visible = false
		tooltip_instance.queue_free()
