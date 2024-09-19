class_name RunesmithingInteraction
extends Interaction

func start() -> void:
	Globals.get_tree().get_first_node_in_group("Runesmithing").visible = true
