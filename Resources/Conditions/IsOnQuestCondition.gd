class_name IsOnQuestCondition
extends Condition

@export
var quest: Quest

func is_fulfilled() -> bool:
	return QuestManager.is_on_quest(quest)
