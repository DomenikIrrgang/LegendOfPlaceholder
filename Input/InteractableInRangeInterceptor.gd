class_name InteractableInRangeInterceptor
extends InputInterceptor

var disable_actions = {
	"Attack": false,
}

func on_input(state: InputState) -> InputState:
	if Globals.get_player() != null and Globals.get_player().interaction.has_interactable_in_range():
		for action in state.action_map:
			if disable_actions.has(action):
				state.action_map[action] = false
	return state
