extends Node

signal keybind_changed(action_name: String, ability: Ability)

var keybinds = {
	"Toggle_Questlog": use_function(toggle_questlog),
	"Toggle_Inventory": use_function(toggle_inventory),
	"Toggle_CharacterSheet": use_function(toggle_character_sheet),
	"Toggle_Spellbook": use_function(toggle_spellbook),
	"Use_Consumeable": use_function(use_consumeable.bind(load("res://Resources/Items/HealingPotions/HealingPotion.tres"))),
	"Interact": use_function(interact)
}

var ability_keybinds = ["Ability_One", "Ability_Two", "Ability_Three", "Ability_Four", "Attack", "Dash"]

func _ready() -> void:
	InputControlls.input_event.connect(on_input)
	Spellbook.new_ability_learned.connect(on_new_ability_learned)
	Spellbook.known_abilities_changed.connect(on_known_abilities_changed)
	SaveFileManager.save_file_saving.connect(on_save)
	SaveFileManager.save_file_start_loading.connect(reset)
	
func on_save(save_file: Dictionary) -> void:
	save_file.keybinds = ability_keybinds.map(func(keybind: String):
		if keybinds.has(keybind):
			return {
				"keybind": keybind,
				"ability": SaveFileManager.get_node_uid(keybinds[keybind].ability)
			}
	)
	
func reset() -> void:
	for keybind in ability_keybinds:
		keybinds.erase(keybind)
		keybind_changed.emit(keybind, null)
		
func  on_known_abilities_changed() -> void:
	for ability_keybind in ability_keybinds:
		if keybinds.has(ability_keybind) and not Spellbook.ability_known(keybinds[ability_keybind].ability):
			keybinds.erase(ability_keybind)
			keybind_changed.emit(ability_keybind, null)
	
func on_new_ability_learned(ability: Ability) -> void:
	if not is_ability_keybound(ability):
		for ability_keybind in ability_keybinds:
			if not keybinds.has(ability_keybind):
				keybind_ability(ability_keybind, ability)
				break
			
func is_ability_keybound(ability: Ability) -> bool:
	for ability_keybind in ability_keybinds:
		if keybinds.has(ability_keybind) and keybinds[ability_keybind].ability == ability:
			return true
	return false
	
func get_keybind_for_ability(ability: Ability) -> String:
	for ability_keybind in ability_keybinds:
		if keybinds.has(ability_keybind) and keybinds[ability_keybind].ability == ability:
			return ability_keybind
	return ""
	
func init_ability(action_name: String, ability: Ability) -> void:
	Spellbook.learn_ability(ability)
	keybind_ability(action_name, ability)
	
func interact() -> void:
	if Globals.get_player().interaction.has_interactable_in_range():
		Globals.get_player().interaction.closest_interactable.interact()
	
func on_input(state: InputState) -> void:
	for action in state.action_map:
		if keybinds.has(action) and state.action_map[action] == true:
			keybinds[action].callback.call()

func keybind_ability(action_name: String, ability: Ability) -> void:
	if keybinds.has(action_name):
		keybinds[action_name].ability.on_unassign(Globals.get_player())		
	keybinds[action_name] = use_ability(ability)
	ability.on_assign(Globals.get_player())
	keybind_changed.emit(action_name, ability)
	
func swap_keybound_abilities(action_name_one: String, action_name_two: String) -> void:
	var tmp
	if keybinds.has(action_name_one):
		tmp = keybinds[action_name_one]
	if keybinds.has(action_name_two):
		keybinds[action_name_one] = keybinds[action_name_two]
		keybind_changed.emit(action_name_one, keybinds[action_name_one].ability)
	else:
		keybinds.erase(action_name_one)
		keybind_changed.emit(action_name_one, null)
	if tmp != null:
		keybinds[action_name_two] = tmp
		keybind_changed.emit(action_name_two, keybinds[action_name_two].ability)
	else:
		keybinds.erase(action_name_two)
		keybind_changed.emit(action_name_two, null)
	
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
	Globals.get_scene_tree().get_first_node_in_group("Inventory").toggle()
	
func toggle_questlog() -> void:
	Globals.get_scene_tree().get_first_node_in_group("Questlog").toggle()

func toggle_character_sheet() -> void:
	Globals.get_scene_tree().get_first_node_in_group("CharacterSheet").toggle()
	
func toggle_spellbook() -> void:
	Globals.get_scene_tree().get_first_node_in_group("Spellbook").toggle()
	
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
