class_name BaseScene
extends Node2D

@export_file
var initial_scene: String

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if SaveFileManager.save_file_exists():
		SaveFileManager.load_save_file()
	else:
		SaveFileManager.save_file_start_loading.emit()
		SceneSwitcher.load_scene(initial_scene, Vector2(0, 0))
	
func _input(event) -> void:
	if (event.is_action_released("pause")):
		get_tree().paused = true
		$UserInterface/PauseMenu.visible = true
