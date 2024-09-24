extends Node

signal interaction_prompt_requested(unit_data: UnitData, interactions: Array[Interaction])
signal interaction_prompt_stopped()

var interaction_prompt_active = false

func prompt_interactions(unit_data: UnitData, interactions: Array[Interaction]) -> void:
	var interactions_to_prompt = get_interactions_to_prompt(interactions)
	if interactions_to_prompt.size() > 1:
		interaction_prompt_active = true
		#interaction_prompt_requested.emit(
		#	unit_data,
		#	interactions_to_prompt
		#)
		var selection_list: Array[SelectionListEntryData] = []
		for interaction in interactions:
			if interaction.is_visible():
				selection_list.append(SelectionListEntryData.new(
					interaction.get_icon(),
					interaction.get_alias(),
					interaction
				))
		SelectionListManager.prompt_selection(
			unit_data.alias,
			selection_list
		)
		SelectionListManager.selection_made.connect(on_selection_made)
	elif interactions_to_prompt.size() == 1:
		interaction_prompt_active = true
		select_interaction(interactions_to_prompt[0])
		
func on_selection_made(selection: SelectionListEntryData) -> void:
	SelectionListManager.selection_made.disconnect(on_selection_made)
	select_interaction(selection.data)
		
func get_interactions_to_prompt(interactions: Array[Interaction]) -> Array[Interaction]:
	return interactions.filter(func (interaction: Interaction): return interaction.is_visible())
	
func select_interaction(interaction: Interaction) -> void:
	interaction_prompt_active = false
	if interaction.is_useable():
		interaction_prompt_stopped.emit()
		interaction.start()
	
func are_interactions_prompted() -> bool:
	return interaction_prompt_active
