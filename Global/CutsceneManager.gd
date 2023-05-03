extends Node


signal cutscene_started(cutscene: Cutscene)
signal cutscene_step_started(cutscene: Cutscene, cutscene_step: CutsceneStep)
signal cutscene_step_finished(cutscene: Cutscene, cutscene_step: CutsceneStep)
signal cutscene_finished(cutscene: Cutscene)

var cutscene_action_map = {
	MoveCameraAction = on_move_camera_action,
	ShowDialogAction = on_show_dialog_action,
}

var current_cutscene: Cutscene
var current_cutscene_step: CutsceneStep

func _ready() -> void:
	cutscene_started.connect(on_cutscene_started)
	cutscene_finished.connect(on_cutscene_finished)
	cutscene_step_finished.connect(on_cutscene_step_finished)

func start_cutscene(cutscene: Cutscene) -> void:
	current_cutscene = cutscene
	current_cutscene_step = cutscene.steps[0]
	cutscene_started.emit(current_cutscene)
	run_cutscene_step(current_cutscene_step)
	
func run_cutscene_step(cutscene_step: CutsceneStep) -> void:
	for cutscene_action in cutscene_step.actions:
		if cutscene_action_map.has(cutscene_action.get_camera_action_type()):
			cutscene_action_map[cutscene_action.get_camera_action_type()].call(cutscene_action)
		else:
			print_debug("No defined action for CutsceneActionType: ", cutscene_action.get_camera_action_type())
	cutscene_step_finished.emit(current_cutscene, cutscene_step)
	
func on_cutscene_step_finished(cutscene: Cutscene, cutscene_step: CutsceneStep) -> void:
	if is_cutscene_over():
		cutscene_finished.emit(current_cutscene)
	else:
		current_cutscene_step = get_next_cutscene_step()
		run_cutscene_step(current_cutscene_step)
	
func is_cutscene_over() -> bool:
	var new_cutscene_step_index = current_cutscene.steps.find(current_cutscene_step) + 1
	return new_cutscene_step_index > current_cutscene.steps.size() - 1
	
func get_next_cutscene_step() -> CutsceneStep:
	return current_cutscene.steps[current_cutscene.steps.find(current_cutscene_step) + 1]
	
func on_cutscene_started(cutscene: Cutscene) -> void:
	Globals.pause_enemies()
	
func on_cutscene_finished(cutscene: Cutscene) -> void:
	Globals.start_enemies()
	Globals.get_camera().reset()
	
func on_move_camera_action(move_camera_action: MoveCameraAction) -> void:
	var camera = Globals.get_camera()
	camera.movement_strategy = NoMovementCamera.new()
	camera.position = move_camera_action.target_position
	
func on_show_dialog_action(show_dialog_action: ShowDialogAction) -> void:
	DialogManager.show_dialog(show_dialog_action.dialog, false)
