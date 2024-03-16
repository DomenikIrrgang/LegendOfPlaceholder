extends UnitState

func enter(_data := {}) -> void:
	update_animation()
	
func update(_delta: float) -> void:
	if (!unit.is_casting() and unit.movement_velocity != Vector2.ZERO):
		state_machine.transition_to("Moving")
	if (!unit.is_casting() and unit.movement_velocity == Vector2.ZERO):
		state_machine.transition_to("Idle")

func update_animation() -> void:
	unit.set_animation("Casting")
