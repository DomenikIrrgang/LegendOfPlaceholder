class_name CompleteQuestInteraction
extends Interaction

@export
var quest: Quest

func start() -> void:
	if QuestManager.can_complete_quest(quest):
		QuestManager.complete_quest(quest)

func get_icon() -> Texture:
	if QuestManager.quest_objectives_completed(quest):
		return load("res://assets/ui/quest/complete_quest.png")
	else:
		return load("res://assets/ui/quest/potential_turn_in.png")

func get_alias() -> String:
	return quest.name

func is_useable() -> bool:
	return QuestManager.can_complete_quest(quest)
	
func is_visible() -> bool:
	return QuestManager.is_on_quest(quest)
