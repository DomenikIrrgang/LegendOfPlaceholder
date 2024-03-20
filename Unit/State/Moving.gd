extends UnitState

func update(_delta: float) -> void:
	update_animation()
	if (unit.movement_velocity == Vector2.ZERO):
		state_machine.transition_to("Idle")
	if unit.is_casting():
		state_machine.transition_to("Casting")
	
func update_animation() -> void:
	match (unit.direction):
		Player.Direction.LEFT:
			unit.set_animation("Moving_Left")
		Player.Direction.RIGHT:
			unit.set_animation("Moving_Right")
		Player.Direction.DOWN:
			unit.set_animation("Moving_Down")
		Player.Direction.UP:
			unit.set_animation("Moving_Up")
