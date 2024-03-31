extends Node

signal cutscene_started(cutscene: Cutscene)
signal cutscene_finished(cutscene: Cutscene)

var current_cutscene: Cutscene
var current_cutscene_step: CutsceneStep

func _ready() -> void:
	cutscene_started.connect(on_cutscene_started)
	cutscene_finished.connect(on_cutscene_finished)

func start_cutscene(cutscene: Cutscene) -> void:
	current_cutscene = cutscene
	current_cutscene_step = cutscene.steps[0]
	cutscene_started.emit(current_cutscene)
	run_cutscene_step(current_cutscene_step)
	
func run_cutscene_step(cutscene_step: CutsceneStep) -> void:
	cutscene_step.cutscene_step_finished.connect(on_cutscene_step_finished)
	cutscene_step.start()
	
func _process(delta: float) -> void:
	if current_cutscene_step != null:
		current_cutscene_step.update(delta)
	
func on_cutscene_step_finished(cutscene_step: CutsceneStep) -> void:
	cutscene_step.cutscene_step_finished.disconnect(on_cutscene_step_finished)
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
	
func on_cutscene_started(_cutscene: Cutscene) -> void:
	Globals.pause_units()
	Globals.get_camera().movement_strategy = ManualMovementCamera.new()
	Globals.get_game_user_inteface().visible = false
	Globals.get_cutescene_bars().show_black_bars()
	
func has_active_cutscene() -> bool:
	return current_cutscene != null
	
func on_cutscene_finished(_cutscene: Cutscene) -> void:
	Globals.start_units()
	Globals.get_camera().reset()
	Globals.get_game_user_inteface().visible = true
	Globals.get_cutescene_bars().hide_black_bars()
	current_cutscene = null
	current_cutscene_step = null
	
