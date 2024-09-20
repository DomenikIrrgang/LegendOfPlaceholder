class_name ReachLevelQuestObjective
extends QuestObjective

@export
var level: int = 1

func init() -> void:
	Globals.get_player().level_changed.connect(on_level_changed)
	
func reset() -> void:
	Globals.get_player().level_changed.disconnect(on_level_changed)

func on_level_changed(level: int) -> void:
	objective_progress_changed.emit(self)

func is_completed() -> bool:
	return Globals.get_player().get_level() >= level
	
func get_progess_string() -> String:
	return "Reach Level " + str(Globals.get_player().get_level()) + "/" + str(level)
	
