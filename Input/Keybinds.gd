extends Node

var keybinds = {}

func _ready() -> void:
	keybind_ability("Dash", load("res://Combat/abilities/Dash.tscn").instantiate())
	keybind_ability("Attack", load("res://Combat/abilities/Attack.tscn").instantiate())
	keybind_ability("Ability_One", load("res://Combat/abilities/Mend.tscn").instantiate())
	keybind_ability("Ability_Two", load("res://Combat/abilities/ForceNova.tscn").instantiate())
	keybind_ability("Ability_Three", load("res://Combat/abilities/TimeStop.tscn").instantiate())
	keybind_ability("Ability_Four", load("res://Combat/abilities/Kick.tscn").instantiate())
	InputControlls.input_event.connect(on_input)
	
func on_input(state: InputState) -> void:
	for action in state.action_map:
		if keybinds.has(action) and state.action_map[action] == true:
			Globals.get_player().use_ability(Globals.get_player(), keybinds[action])

func keybind_ability(action_name: String, ability: Ability) -> void:
	keybinds[action_name] = ability
	
func get_ability_for_keybind(action_name: String) -> Ability:
	if keybinds.has(action_name):
		return keybinds[action_name]
	return null

func get_abilities() -> Array[Ability]:
	var result: Array[Ability] = []
	result.assign(keybinds.values())
	return result
