extends CenterContainer

var ErrorMessageLabel = preload("res://ui/GameUI/Message.tscn")

@onready
var container: Container = $Container

func _ready() -> void:
	QuestManager.objective_progress_changed.connect(on_objective_progress_changed)
	
func on_objective_progress_changed(quest: Quest, objective: QuestObjective) -> void:
	var message = objective.get_progess_string()
	var error_message: ErrorMessage = has_error_message(message)
	if error_message == null:
		error_message = ErrorMessageLabel.instantiate()
		container.add_child(error_message)
		error_message.show_message(message)
	else:
		error_message.reset()
	
func has_error_message(message: String) -> ErrorMessage:
	for child in container.get_children():
		if child.text == message:
			return child
	return null
