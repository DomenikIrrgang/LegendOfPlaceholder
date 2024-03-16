class_name StartDialog
extends InteractionType

@export
var dialog: Dialog

func start() -> void:
	DialogManager.show_dialog(dialog)
