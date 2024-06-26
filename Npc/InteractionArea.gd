class_name Interactable
extends Area2D

func interact() -> void:
	InteractionManager.prompt_interactions(owner.unit_data, get_interactions())
	
func get_interactions() -> Array[Interaction]:
	return owner.unit_data.interactions
	
func get_unit_data() -> UnitData:
	return owner.unit_data
	
func is_interactable() -> bool:
	return InteractionManager.get_interactions_to_prompt(get_interactions()).size() > 0
	
