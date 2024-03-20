extends UnitState

func enter(_data := {}) -> void:
	super()
	update_animation()
	
func update(_delta: float) -> void:
	if (unit.movement_velocity != Vector2.ZERO):
		state_machine.transition_to("Moving")
	if unit.is_casting():
		state_machine.transition_to("Casting")

func update_animation() -> void:
	var set_animation = false
	match (unit.direction):
		Unit.Direction.LEFT:
			set_animation = unit.set_animation("UnitAnimations/Idle_Left")
		Unit.Direction.RIGHT:
			set_animation = unit.set_animation("UnitAnimations/Idle_Right")
		Unit.Direction.DOWN:
			set_animation = unit.set_animation("UnitAnimations/Idle_Down")
		Unit.Direction.UP:
			set_animation = unit.set_animation("UnitAnimations/Idle_Up")
	if set_animation == false:
		unit.set_animation("Idle")
	
