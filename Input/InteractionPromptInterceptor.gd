class_name InteractionPromptInterceptor
extends InputInterceptor

var disable_actions = {
	"Dash": false,
	"Attack": false,
	"Ability_One": false,
	"Ability_Two": false,
	"Ability_Three": false,
	"Ability_Four": false,
	"Use_Consumeable": false,
	"Interact": false,
}

func on_input(state: InputState) -> InputState:
	if InteractionManager.are_interactions_prompted():
		state.movement_direction = Vector2.ZERO
		for action in state.action_map:
			if disable_actions.has(action):
				state.action_map[action] = false
		state.action_map["ui_accept"] = Input.is_action_just_pressed("ui_accept")
	return state
