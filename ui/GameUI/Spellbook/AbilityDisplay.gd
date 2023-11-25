class_name AbilityDisplay
extends HBoxContainer

@onready
var icon: TextureRect = $Control/Icon

@onready
var alias: Label = $Alias

var ability: Ability

func set_ability(_ability: Ability) -> void:
	ability = _ability
	icon.texture = ability.icon
	alias.text = ability.get_alias()


func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		if Globals.get_drag_and_drop().is_dragging() and Globals.get_drag_and_drop().data.has("ability") and Globals.get_drag_and_drop().data.ability == ability:
			Globals.get_drag_and_drop().stop_dragging()
		else:
			Globals.get_drag_and_drop().stop_dragging()
			Globals.get_drag_and_drop().start_dragging({
					"ability": ability,
					"slot": null
				}, ability.icon)
