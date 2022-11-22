extends PlayerState

func update(_delta: float) -> void:
	if (Input.is_action_pressed("right") ||	Input.is_action_pressed("left") ||
		Input.is_action_pressed("up") || Input.is_action_pressed("down")):
		state_machine.transition_to("Run")
	if (Input.is_action_just_pressed("Attack")):
		state_machine.transition_to("Attack")

func enter(_data := {}) -> void:
	player.velocity = Vector2.ZERO
	update_animation()

func update_animation() -> void:
	match (player.direction):
		Player.Direction.LEFT:
			player.set_animation("Idle_Left")
		Player.Direction.RIGHT:
			player.set_animation("Idle_Right")
		Player.Direction.DOWN:
			player.set_animation("Idle_Down")
		Player.Direction.UP:
			player.set_animation("Idle_Up")
