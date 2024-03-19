class_name QuestCompletedRequirement
extends QuestRequirement

@export
var quests: Array[Quest] = []

func is_fulfilled() -> bool:
	for quest in quests:
		if not QuestManager.has_completed_quest(quest):
			return false
	return true
