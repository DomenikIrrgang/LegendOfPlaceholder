extends Node

var quests: Array[Quest] = []
var completed_quests: Array[Quest] = []

signal quest_accepted(quest: Quest)
signal quest_abandoned(quest: Quest)
signal quest_completed(quest: Quest)

signal objective_progress_changed(quest: Quest, objective: QuestObjective)

func accept_quest(quest: Quest) -> bool:
	if can_accept_quest(quest):
		quests.append(quest)
		for objective in quest.objectives:
			objective.objective_progress_changed.connect(on_objective_progress_changed.bind(quest))
		quest_accepted.emit(quest)
		return true
	return false
	
func on_objective_progress_changed(quest: Quest, objective: QuestObjective) -> void:
	print(quest, objective, objective.get_progress_string())
	
func get_active_quests() -> Array[Quest]:
	return quests
	
func complete_quest(quest: Quest) -> bool:
	if can_complete_quest(quest):
		quests.erase(quest)
		for reward in quest.rewards:
			reward.reward()
		completed_quests.append(quest)
		quest_completed.emit(quest)
		return true
	return false
	
func can_complete_quest(quest: Quest) -> bool:
	for reward in quest.rewards:
		if not reward.can_reward():
			return false
	return is_on_quest(quest)
	
func is_on_quest(quest: Quest) -> bool:
	return quests.has(quest)
	
func has_completed_quest(quest: Quest) -> bool:
	return completed_quests.has(quest)

func quest_requirements_fulfilled(quest: Quest) -> bool:
	for requirement in quest.requirements:
		if not requirement.is_fulfilled():
			return false
	return true

func can_accept_quest(quest: Quest) -> bool:
	return not is_on_quest(quest) and not has_completed_quest(quest) and quest_requirements_fulfilled(quest)
