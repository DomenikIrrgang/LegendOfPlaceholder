class_name ChangeDialogAction
extends DialogAction

@export
var dialog: Dialog

func start() -> void:
	DialogManager.change_dialog(dialog)
