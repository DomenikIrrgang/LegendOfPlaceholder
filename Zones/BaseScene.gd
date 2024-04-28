class_name BaseScene
extends Node2D

@export_file
var initial_scene: String

func _ready():
	SaveFileManager.load_game_state(SaveFileManager.loaded_game_state_index)
	if SaveFileManager.is_game_state_loaded():
		Globals.get_user_interface().visible = true
	
func _input(event) -> void:
	if (event.is_action_released("pause") and SaveFileManager.is_game_state_loaded()) and Globals.get_player().alive:
		get_tree().paused = true
		$UserInterface/PauseMenu.visible = true
