extends PlayerState

func update(_delta: float) -> void:
	if (not Input.is_action_pressed("right") && not Input.is_action_pressed("left") &&
		not Input.is_action_pressed("up") && not Input.is_action_pressed("down")):
		state_machine.transition_to("Idle")
	if (Input.is_action_just_pressed("Attack")):
		state_machine.transition_to("Attack")
	if (Input.is_action_just_pressed("Dash")):
		state_machine.transition_to("Dash")

func physics_update(_delta: float) -> void:
	var direction = player.get_directional_vector().normalized()
	player.movement_velocity = direction * player.movement_speed
	update_animation()
	
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
