class_name PauseMenu
extends Control

func _input(event) -> void:
	if (event.is_action_released("pause")):
		visible = false
		get_tree().paused = false
		accept_event()
