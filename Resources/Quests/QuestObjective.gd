class_name QuestObjective
extends Resource

signal objective_progress_changed(objective: QuestObjective)

func init() -> void:
	pass
	
func reset() -> void:
	pass
	
func quest_complete() -> void:
	if is_completed():
		reset()

func is_completed() -> bool:
	return true
	
func get_progess_string() -> String:
	return ""
