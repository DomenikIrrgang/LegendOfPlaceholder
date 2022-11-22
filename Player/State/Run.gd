extends PlayerState

func handle_input(_event: InputEvent) -> void:
	if (not Input.is_action_pressed("right") && not Input.is_action_pressed("left") &&
		not Input.is_action_pressed("up") && not Input.is_action_pressed("down")):
		state_machine.transition_to("Idle")
	if (Input.is_action_just_pressed("Attack")):
		state_machine.transition_to("Attack")
	if (Input.is_action_just_pressed("Dash")):
		state_machine.transition_to("Dash")

func update(_delta: float) -> void:
	var direction = player.get_directional_vector().normalized()
	player.velocity = direction * player.speed
	update_animation()
	
func update_animation() -> void:
	match (player.get_direction()):
		"LEFT":
			player.set_animation("Left")
		"RIGHT":
			player.set_animation("Right")
		"DOWN":
			player.set_animation("Down")
		"UP":
			player.set_animation("Up")
