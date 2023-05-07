class_name PlayerControlInputInterceptor
extends InputInterceptor

func on_input(state: InputState) -> InputState:
	state.movement_direction = get_directional_vector()
	for action in InputMap.get_actions():
		if state.action_map.has(action):
			state.action_map[action] = Input.is_action_just_pressed(action)
	return state

func get_directional_vector() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
