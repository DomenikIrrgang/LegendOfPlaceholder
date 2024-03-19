class_name QuestObjective
extends Resource

signal objective_progress_changed(objective: QuestObjective)

func is_completed() -> bool:
	return true
	
func get_progess_string() -> String:
	return ""
