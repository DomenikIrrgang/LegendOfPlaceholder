extends PlayerState

func update(_delta: float) -> void:
	update_animation()
	if (InputControlls.get_directional_vector() == Vector2.ZERO):
		state_machine.transition_to("Idle")
		
func enter(_data := {}) -> void:
	player.movement_strategy = ControlledMovementStrategy.new(player)
	
func update_animation() -> void:
	match (player.direction):
		Player.Direction.LEFT:
			player.set_animation("Left")
		Player.Direction.RIGHT:
			player.set_animation("Right")
		Player.Direction.DOWN:
			player.set_animation("Down")
		Player.Direction.UP:
			player.set_animation("Up")
