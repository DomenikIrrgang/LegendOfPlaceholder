extends Node

var known_abilites: Array[Ability] = []

signal new_ability_learned(ability: Ability)

func set_abilities(abilities: Array[Ability]) -> void:
	known_abilites = abilities

func get_all_abilities() -> Array[Ability]:
	return known_abilites
	
func get_abilities_by_spell_school(spell_school: SpellSchool.Enum) -> Array[Ability]:
	var result: Array[Ability]= []
	for ability in known_abilites:
		if ability.spell_school == spell_school:
			result.append(ability)
	return result
	
func learn_ability(ability: Ability) -> bool:
	if !ability_known(ability):
		known_abilites.append(ability)
		new_ability_learned.emit(ability)
		return true
	Error.send("Ability already known.")
	return false
	
func ability_known(_ability: Ability) -> bool:
	for ability in known_abilites:
		if ability.get_alias() == _ability.get_alias():
			return true
	return false
