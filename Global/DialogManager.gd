extends Control

var DialogScene = preload("res://Ui/Dialog/Dialog.tscn")

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
	
func on_dialog_step_finished(dialog_step: DialogStep, choice: DialogChoice) -> void:
	if choice != null:
		if choice.action is ChangeDialogAction:
			change_dialog(choice.action.dialog)
			return
	if not is_dialog_over():
		continue_dialog()
	else:
		stop_dialog()
		
func is_dialog_over() -> bool:
	var new_dialog_step_index = current_dialog.steps.find(current_dialog_step) + 1
	return new_dialog_step_index > current_dialog.steps.size() - 1
	
func get_next_dialog_step() -> DialogStep:
	return current_dialog.steps[current_dialog.steps.find(current_dialog_step) + 1]
		
func continue_dialog() -> void:
	current_dialog_step = get_next_dialog_step()
	current_dialog_scene.show_dialog_step(current_dialog_step)
		
func stop_dialog() -> void:
	current_dialog_scene.queue_free()
	current_dialog = null
	current_dialog_step = null
	Globals.start_enemies()
		
func change_dialog(dialog: Dialog) -> void:
	current_dialog = dialog
	current_dialog_step = dialog.steps[0]
	current_dialog_scene.show_dialog_step(current_dialog_step)

func has_active_dialog() -> bool:
	return current_dialog != null
