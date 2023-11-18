extends Node

var keybinds = {
	"Dash": use_ability(load("res://Combat/abilities/Dash.tscn").instantiate()),
	"Attack": use_ability(load("res://Combat/abilities/Attack.tscn").instantiate()),
	"Ability_One": use_ability(load("res://Combat/abilities/Mend.tscn").instantiate()),
	"Ability_Two": use_ability(load("res://Combat/abilities/ForceNova.tscn").instantiate()),
	"Ability_Three": use_ability(load("res://Combat/abilities/TimeStop.tscn").instantiate()),
	"Ability_Four": use_ability(load("res://Combat/abilities/Kick.tscn").instantiate()),
	"Toggle_Inventory": use_function(toggle_inventory),
	"Use_Consumeable": use_function(use_consumeable.bind(load("res://Resources/Items/HealingPotions/HealingPotion.tres")))
}

func _ready() -> void:
	InputControlls.input_event.connect(on_input)
	
func on_input(state: InputState) -> void:
	for action in state.action_map:
		if keybinds.has(action) and state.action_map[action] == true:
			keybinds[action].callback.call()

func keybind_ability(action_name: String, ability: Ability) -> void:
	keybinds[action_name] = ability
	
func use_ability(ability: Ability):
	return {
		"type": "Ability",
		"ability": ability,
		"callback": func():
			Globals.get_player().use_ability(Globals.get_player(), ability)
	}
	
func use_function(function: Callable):
	return {
		"type": "Callable",
		"callback": function
	}
	
func set_consumeable_item(item: Item) -> void:
	keybinds["Use_Consumeable"] = use_function(use_consumeable.bind(item))
		
func use_consumeable(item: Item) -> void:
	Globals.get_inventory().use_item(Globals.get_player(), item)
	
func toggle_inventory() -> void:
	Globals.get_game_user_inteface().get_node("Inventory").toggle()
	
func get_ability_for_keybind(action_name: String) -> Ability:
	if keybinds.has(action_name) and keybinds[action_name].type == "Ability":
		return keybinds[action_name].ability
	return null

func get_abilities() -> Array[Ability]:
	var result: Array[Ability] = []
	for keybind in keybinds.keys():
		if keybinds[keybind].type == "Ability":
			result.append(keybinds[keybind].ability)
	return result
