class_name ShowDialogAction
extends CutsceneAction

@export
var dialog: Dialog

func start() -> void:
	DialogManager.dialog_finished.connect(on_dialog_finished)
	DialogManager.show_dialog(dialog, false)

func on_dialog_finished(_dialog: Dialog) -> void:
	cutscene_action_finished.emit(self)
