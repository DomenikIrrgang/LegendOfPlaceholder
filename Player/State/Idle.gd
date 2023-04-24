extends PlayerState

func update(_delta: float) -> void:
	if (InputControlls.get_directional_vector() != Vector2.ZERO):
		state_machine.transition_to("Run")
	if (Input.is_action_just_pressed("Attack")):
		state_machine.transition_to("Attack")

func enter(_data := {}) -> void:
	player.movement_strategy = UnitMovementStrategy.new(player)
	update_animation()

func update_animation() -> void:
	match (player.direction):
		Unit.Direction.LEFT:
			player.set_animation("Idle_Left")
		Unit.Direction.RIGHT:
			player.set_animation("Idle_Right")
		Unit.Direction.DOWN:
			player.set_animation("Idle_Down")
		Unit.Direction.UP:
			player.set_animation("Idle_Up")
