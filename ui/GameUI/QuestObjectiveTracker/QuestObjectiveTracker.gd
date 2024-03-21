extends VBoxContainer

@onready
var quests: VBoxContainer = $Quests

var QuestObjectiveTracker = preload("res://ui/GameUI/QuestObjectiveTracker/QuestEntry.tscn")

func _ready() -> void:
	QuestManager.quest_accepted.connect(add_quest_objective_tracker)
	for quest in QuestManager.get_active_quests():
		add_quest_objective_tracker(quest)
	
func add_quest_objective_tracker(quest: Quest) -> void:
	var quest_objective_tracker = QuestObjectiveTracker.instantiate()
	quests.add_child(quest_objective_tracker)
	quest_objective_tracker.set_quest(quest)
