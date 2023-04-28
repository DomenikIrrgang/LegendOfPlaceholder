extends Node

var keybinds = {}

func _ready() -> void:
	keybind_ability("Dash", load("res://Combat/abilities/Dash.tscn").instantiate())
	keybind_ability("Attack", load("res://Combat/abilities/Attack.tscn").instantiate())
	
func _input(event: InputEvent) -> void:
	if event.is_action_type():
		for action_name in keybinds:
			if Input.is_action_just_pressed(action_name):
				CombatLogic.use_ability(keybinds[action_name], (get_tree().get_first_node_in_group("player")))

func keybind_ability(action_name: String, ability: Ability) -> void:
	keybinds[action_name] = ability
	
func get_ability_for_keybind(action_name: String) -> Ability:
	if keybinds.has(action_name):
		return keybinds[action_name]
	return null
