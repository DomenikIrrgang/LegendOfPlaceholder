extends Node

signal interaction_prompt_requested(unit_data: UnitData, interactions: Array[Interaction])
signal interaction_prompt_stopped()

var interaction_prompt_active = false

func prompt_interactions(unit_data: UnitData, interactions: Array[Interaction]) -> void:
	interaction_prompt_active = true
	var interactions_to_prompt = interactions.filter(func (interaction: Interaction): return interaction.is_visible())
	if interactions_to_prompt.size() > 1:
		interaction_prompt_requested.emit(
			unit_data,
			interactions_to_prompt
		)
	else:
		select_interaction(interactions_to_prompt[0])
	
func select_interaction(interaction: Interaction) -> void:
	if interaction.is_useable():
		interaction_prompt_stopped.emit()
		interaction_prompt_active = false	
		interaction.start()
	
func are_interactions_prompted() -> bool:
	return interaction_prompt_active
