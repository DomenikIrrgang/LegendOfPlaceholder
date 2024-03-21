class_name QuestEntry
extends VBoxContainer

@onready
var name_label: Label = $Quest/Margins/QuestName

@onready
var objective_label: Label = $Objectives/Objective

var quest: Quest

func _ready() -> void:
	QuestManager.quest_completed.connect(on_quest_unavailable)
	QuestManager.quest_abandoned.connect(on_quest_unavailable)
	QuestManager.objective_progress_changed.connect(on_objective_progress_changed)

func set_quest(_quest: Quest) -> void:
	quest = _quest
	name_label.text = "[" + str(quest.recommended_level) + "] " + quest.name
	update_objectives(quest)
		
func update_objectives(quest: Quest) -> void:
	objective_label.text = ""
	for objective in quest.objectives:
		objective_label.text += objective.get_progess_string() + "\n"
		
func on_objective_progress_changed(_quest: Quest, objective: QuestObjective) -> void:
	if quest == _quest:
		update_objectives(quest)
		
func on_quest_unavailable(_quest: Quest) -> void:
	if quest == _quest:
		queue_free()
	
