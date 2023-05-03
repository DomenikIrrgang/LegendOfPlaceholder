class_name MoveCameraAction
extends CutsceneAction

@export
var target_position: Vector2

func get_camera_action_type() -> String:
	return "MoveCameraAction"
