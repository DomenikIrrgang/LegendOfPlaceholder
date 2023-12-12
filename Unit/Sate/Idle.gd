extends UnitState

func enter(_data := {}) -> void:
	update_animation()
	
func update(_delta: float) -> void:
	if (unit.movement_velocity != Vector2.ZERO):
		state_machine.transition_to("Moving")
	if unit.is_casting():
		state_machine.transition_to("Casting")

func update_animation() -> void:
	match (unit.direction):
		Unit.Direction.LEFT:
			unit.set_animation("UnitAnimations/Idle_Left")
		Unit.Direction.RIGHT:
			unit.set_animation("UnitAnimations/Idle_Right")
		Unit.Direction.DOWN:
			unit.set_animation("UnitAnimations/Idle_Down")
		Unit.Direction.UP:
			unit.set_animation("UnitAnimations/Idle_Up")
