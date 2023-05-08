class_name CutsceneStep
extends Resource

@export
var actions: Array[CutsceneAction]
var finished_actions: Array[CutsceneAction]

signal cutscene_step_finished(cutscene_step: CutsceneStep)

func start() -> void:
	cutscene_step_finished.connect(on_cutscene_step_finished)
	finished_actions = []
	for action in actions:
		action.cutscene_action_finished.connect(on_cutscene_action_finished)
		action.start()
		
func update(delta: float) -> void:
	for action in actions:
		action.update(delta)
		
func on_cutscene_action_finished(cutescene_action: CutsceneAction) -> void:
	finished_actions.append(cutescene_action)
	if finished_actions.size() == actions.size():
		cutscene_step_finished.emit(self)
	
func on_cutscene_step_finished(_cutscene_step: CutsceneStep) -> void:
	for action in actions:
		action.cutscene_action_finished.disconnect(on_cutscene_action_finished)
