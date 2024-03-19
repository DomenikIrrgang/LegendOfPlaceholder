class_name StartDialog
extends Interaction

@export
var dialog: Dialog

func start() -> void:
	DialogManager.show_dialog(dialog)

func get_alias() -> String:
	return "Talk"
