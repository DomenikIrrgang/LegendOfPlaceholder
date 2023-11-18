class_name CutsceneInputInterceptor
extends InputInterceptor

var disable_actions = {
	"Dash": false,
	"Attack": false,
	"Ability_One": false,
	"Ability_Two": false,
	"Ability_Three": false,
	"Ability_Four": false,
	"Toggle_Inventory": false,
	"Use_Consumeable": false,
}

func on_input(state: InputState) -> InputState:
	if CutsceneManager.has_active_cutscene():
		state.movement_direction = Vector2.ZERO
		for action in state.action_map:
			if disable_actions.has(action):
				state.action_map[action] = false
	return state
