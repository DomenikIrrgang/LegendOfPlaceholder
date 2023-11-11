extends Node2D

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	CutsceneManager.start_cutscene(load("res://Resources/Cutscenes/MegaslimeStart.tres"))	

func _input(event) -> void:
	if (event.is_action_released("pause")):
		get_tree().paused = true
		$UserInterface/PauseMenu.visible = true
