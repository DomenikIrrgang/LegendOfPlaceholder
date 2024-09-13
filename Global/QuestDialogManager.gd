extends Node

signal quest_dialog_started(quest: Quest)
signal quest_dialog_stopped()

var quest_dialog_active = false
var prompted_quest: Quest = null

func prompt_quest(quest: Quest) -> void:
	quest_dialog_active = true
	prompted_quest = quest
	quest_dialog_started.emit(quest)
	
func accept_quest() -> void:
	QuestManager.accept_quest(prompted_quest)
	quest_dialog_active = false
	quest_dialog_stopped.emit()
	
func decline_quest() -> void:
	quest_dialog_active = false
	quest_dialog_stopped.emit()
	
func is_quest_dialog_active() -> bool:
	return quest_dialog_active
