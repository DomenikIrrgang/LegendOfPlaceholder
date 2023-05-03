class_name ShowDialogAction
extends CutsceneAction

@export
var dialog: Dialog

func get_camera_action_type() -> String:
	return "ShowDialogAction"
