extends Control

var DialogScene = preload("res://Ui/Dialog.tscn")

var current_dialog: Dialog
var current_dialog_step: DialogStep
var current_dialog_scene

func show_dialog(dialog: Dialog) -> void:
	var user_interface = Globals.get_user_interface()
	current_dialog_scene = DialogScene.instantiate()
	Globals.get_user_interface().add_child(current_dialog_scene)
	current_dialog_scene.dialog_step_finished.connect(on_dialog_step_finished)
	current_dialog = dialog
	current_dialog_step = dialog.steps[0]
	current_dialog_scene.show_dialog_step(current_dialog_step)
	Globals.pause_enemies()
	
func on_dialog_step_finished(dialog_step: DialogStep) -> void:
	var new_dialog_step_index = current_dialog.steps.find(dialog_step) + 1
	if new_dialog_step_index <= current_dialog.steps.size() - 1:
		current_dialog_step = current_dialog.steps[new_dialog_step_index]
		current_dialog_scene.show_dialog_step(current_dialog_step)
	else:
		current_dialog_scene.queue_free()
		current_dialog = null
		current_dialog_step = null
		Globals.start_enemies()

func has_active_dialog() -> bool:
	return current_dialog != null
