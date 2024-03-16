class_name Interactable
extends Area2D

func _ready() -> void:
	connect("area_entered", on_area_entered)
	
func on_area_entered(area: PlayerInteractionArea) -> void:
	pass
	
func interact() -> void:
	print("interacted with ", owner)
	for interaction in owner.unit_data.interactions:
		interaction.type.start()
