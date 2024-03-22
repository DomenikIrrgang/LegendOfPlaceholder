extends Node

var known_abilities: Array[Ability] = []

signal new_ability_learned(ability: Ability)
signal known_abilities_changed()

func _ready() -> void:
	SaveFileManager.save_file_loaded.connect(on_load)
	SaveFileManager.save_file_saving.connect(on_save)
	SaveFileManager.save_file_start_loading.connect(reset)
	
func reset() -> void:
	known_abilities = []
	var attack = load("res://Combat/abilities/Attack.tscn").instantiate()
	var dash = load("res://Combat/abilities/Dash.tscn").instantiate()
	learn_ability(attack)
	learn_ability(dash)
	Keybinds.keybind_ability("Attack", attack)
	Keybinds.keybind_ability("Dash", dash)	
	known_abilities_changed.emit()
	
func on_save(save_file: Dictionary) -> void:
	pass
	
func on_load(save_file: Dictionary) -> void:
	pass

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
	
func ability_known(_ability: Ability) -> bool:
	for ability in known_abilities:
		if ability.get_alias() == _ability.get_alias():
			return true
	return false
