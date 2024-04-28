extends Node

var known_abilities: Array[Ability] = []

signal new_ability_learned(ability: Ability)
signal known_abilities_changed()

func _ready() -> void:
	SaveFileManager.game_state_loaded.connect(on_load)
	SaveFileManager.game_state_saving.connect(on_save)
	SaveFileManager.game_state_start_loading.connect(reset)
	SaveFileManager.game_state_start_unloading.connect(reset)
	
func reset() -> void:
	known_abilities = []
	known_abilities_changed.emit()
	
func on_save(game_state: Dictionary) -> void:
	game_state.known_abilities = []
	for ability in known_abilities:
		game_state.known_abilities.append(
			SaveFileManager.get_node_uid(ability)
		)
	
func on_load(game_state: Dictionary) -> void:
	for abiity in game_state.known_abilities:
		var ability_instance = SaveFileManager.get_resource_from_uid(abiity).instantiate()
		if not ability_known(ability_instance):
			learn_ability(ability_instance)
	for keybind in game_state.keybinds:
		if keybind != null:
			for ability in known_abilities:
				if SaveFileManager.get_node_uid(ability) == keybind.ability:
					if not Keybinds.is_ability_keybound(ability):
						Keybinds.keybind_ability(keybind.keybind, ability)
					else:
						Keybinds.swap_keybound_abilities(keybind.keybind, Keybinds.get_keybind_for_ability(ability))

func set_abilities(abilities: Array[Ability]) -> void:
	known_abilities = abilities

func get_all_abilities() -> Array[Ability]:
	return known_abilities
	
func get_abilities_by_spell_school(spell_school: SpellSchool.Enum) -> Array[Ability]:
	var result: Array[Ability]= []
	for ability in known_abilities:
		if ability.spell_school == spell_school:
			result.append(ability)
	return result
	
func learn_ability(ability: Ability) -> bool:
	if !ability_known(ability):
		known_abilities.append(ability)
		new_ability_learned.emit(ability)
		return true
	Error.send("Ability already known.")
	return false
	
func unlearn_ability(_ability: Ability) -> bool:
	if ability_known(_ability):
		for ability in known_abilities:
			if ability.get_alias() == _ability.get_alias():
				known_abilities.erase(ability)
				known_abilities_changed.emit()
				return true
	return false
	
func ability_known(_ability: Ability) -> bool:
	for ability in known_abilities:
		if ability.get_alias() == _ability.get_alias():
			return true
	return false
