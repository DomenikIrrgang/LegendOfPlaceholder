extends Control

var DialogScene = preload("res://ui/Dialog/Dialog.tscn")

var current_dialog: Dialog
var current_dialog_step: DialogStep
var current_dialog_scene

var world_paused: bool = false

signal dialog_started(dialog: Dialog)
signal dialog_finished(dialog: Dialog)

func _ready() -> void:
	dialog_started.connect(on_dialog_started)
	dialog_finished.connect(on_dialog_finished)

func show_dialog(dialog: Dialog) -> void:
	current_dialog_scene = DialogScene.instantiate()
	Globals.get_dialogs_node().add_child(current_dialog_scene)
	current_dialog = dialog
	dialog_started.emit(current_dialog)
	run_dialog_step(dialog.steps[0])

func run_dialog_step(dialog_step: DialogStep) -> void:
	current_dialog_step = dialog_step
	current_dialog_scene.show_dialog_step(current_dialog_step)
	current_dialog_step.dialog_step_finished.connect(on_dialog_step_finished)
	current_dialog_step.start()
	
func _process(delta) -> void:
	if has_active_dialog():
		current_dialog_step.update(delta)
	
func on_dialog_step_finished(_dialog_step: DialogStep) -> void:
	current_dialog_step.dialog_step_finished.disconnect(on_dialog_step_finished)
	if not is_dialog_over():
		run_dialog_step(get_next_dialog_step())
	else:
		dialog_finished.emit(current_dialog)
		
func is_dialog_over() -> bool:
	var new_dialog_step_index = current_dialog.steps.find(current_dialog_step) + 1
	return new_dialog_step_index > current_dialog.steps.size() - 1
	
func get_next_dialog_step() -> DialogStep:
	return current_dialog.steps[current_dialog.steps.find(current_dialog_step) + 1]
	
func on_dialog_started(_dialog: Dialog) -> void:
	if not CutsceneManager.has_active_cutscene():
		Globals.pause_units()
		
func on_dialog_finished(_dialog: Dialog) -> void:
	current_dialog_scene.queue_free()
	current_dialog = null
	current_dialog_step = null
	if not CutsceneManager.has_active_cutscene():
		Globals.start_units()
		
func change_dialog(dialog: Dialog) -> void:
	current_dialog = dialog
	current_dialog_step = dialog.steps[0]
	current_dialog_scene.show_dialog_step(current_dialog_step)

func has_active_dialog() -> bool:
	return current_dialog != null
