class_name Dash
extends Ability

func use(unit: Unit) -> void:
	unit.movement_state.transition_to("Dash")
