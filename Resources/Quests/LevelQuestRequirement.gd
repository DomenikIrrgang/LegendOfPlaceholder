class_name LevelQuestRequirement
extends QuestRequirement

@export
var level: int = 1

func is_fulfilled() -> bool:
	return Globals.get_player().get_level() >= level
