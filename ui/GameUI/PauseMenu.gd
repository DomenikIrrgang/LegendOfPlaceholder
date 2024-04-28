class_name PauseMenu
extends Control

func _input(event) -> void:
	if (event.is_action_released("pause") and Globals.get_player().alive):
		visible = false
		get_tree().paused = false
		accept_event()
