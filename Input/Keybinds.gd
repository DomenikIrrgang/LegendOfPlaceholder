extends Node

var keybinds = {}

func _ready() -> void:
	keybind_ability("Dash", load("res://Combat/abilities/Dash.tscn").instantiate())
	keybind_ability("Attack", load("res://Combat/abilities/Attack.tscn").instantiate())
	keybind_ability("Ability_One", load("res://Combat/abilities/Mend.tscn").instantiate())
	keybind_ability("Ability_Two", load("res://Combat/abilities/ForceNova.tscn").instantiate())
	keybind_ability("Ability_Three", load("res://Combat/abilities/TimeStop.tscn").instantiate())
	
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

func get_abilities() -> Array[Ability]:
	var result: Array[Ability]
	result.assign(keybinds.values())
	return result