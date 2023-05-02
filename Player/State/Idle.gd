extends PlayerState

func update(_delta: float) -> void:
	if (player.movement_velocity != Vector2.ZERO):
		state_machine.transition_to("Run")

func enter(_data := {}) -> void:
	player.movement_strategy = ControlledMovementStrategy.new(player)
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
