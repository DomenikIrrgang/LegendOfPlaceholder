class_name Interactable
extends Area2D

func interact() -> void:
	InteractionManager.prompt_interactions(owner.unit_data, owner.unit_data.interactions)
