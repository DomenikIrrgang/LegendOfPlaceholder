class_name DialogChoice
extends Resource

@export
var text: String = ""

@export
var actions: Array[DialogAction]
var finished_actions: Array[DialogAction] = []

signal dialog_choice_finished(dialog_choice: DialogChoice)

func start() -> void:
	for action in actions:
		action.dialog_action_finished.connect(on_dialog_action_finished)
		action.start()
	if actions.size() == 0:
		dialog_choice_finished.emit(self)
		
func update(delta: float) -> void:
	for action in actions:
		action.update(delta)
	
func on_dialog_action_finished(dialog_action: DialogAction) -> void:
	finished_actions.append(dialog_action)
	if finished_actions.size() == actions.size():
			dialog_choice_finished.emit(self)
