class_name StartQuestInteraction
extends Interaction

@export
var quest: Quest

func start() -> void:
	if QuestManager.can_accept_quest(quest):
		QuestManager.accept_quest(quest)

func get_icon() -> Texture:
	if QuestManager.can_accept_quest(quest):
		return load("res://assets/ui/quest/accept_quest.png")
	else:
		return load("res://assets/ui/quest/potential_quest.png")

func get_alias() -> String:
	return quest.name

func is_useable() -> bool:
	return QuestManager.quest_requirements_fulfilled(quest)
	
func is_visible() -> bool:
	return not QuestManager.has_completed_quest(quest) and not QuestManager.is_on_quest(quest)
