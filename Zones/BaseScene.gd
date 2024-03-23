class_name BaseScene
extends Node2D

@export_file
var initial_scene: String

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if not SaveFileManager.save_file_exists():
		SaveFileManager.save_file_start_loading.emit()
		SaveFileManager.save_to_save_file()
	SaveFileManager.load_save_file()
	
func _input(event) -> void:
	if (event.is_action_released("pause")):
		get_tree().paused = true
		$UserInterface/PauseMenu.visible = true
