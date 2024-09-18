class_name RunesmithingInputInterceptor
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
	if Globals.get_scene_tree().get_first_node_in_group("Runesmithing") != null and Globals.get_scene_tree().get_first_node_in_group("Runesmithing").visible:
		state.movement_direction = Vector2.ZERO
		for action in state.action_map:
			if disable_actions.has(action):
				state.action_map[action] = false
		state.action_map["ui_accept"] = Input.is_action_just_pressed("ui_accept")
	return state
