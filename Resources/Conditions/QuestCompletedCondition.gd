class_name QuestCompletedCondition
extends Condition

@export
var quest: Quest

func is_fulfilled() -> bool:
	return QuestManager.has_completed_quest(quest)
