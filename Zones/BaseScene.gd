class_name BaseScene
extends Node2D

@export_file
var initial_scene: String

func _ready():
	SaveFileManager.load_game_state(SaveFileManager.loaded_game_state_index)
	
func _input(event) -> void:
	if (event.is_action_released("pause")):
		get_tree().paused = true
		$UserInterface/PauseMenu.visible = true
