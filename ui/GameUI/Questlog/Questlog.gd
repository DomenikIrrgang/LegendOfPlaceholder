extends PanelContainer

@onready
var quest_information = $MarginContainer/VBoxContainer/Content/QuestInformation

@onready
var quest_list: QuestList = $MarginContainer/VBoxContainer/Content/QuestListScroll

@onready
var no_active_quests: Label = $MarginContainer/VBoxContainer/Content/NoActiveQuests

@onready
var seperator: NinePatchRect = $MarginContainer/VBoxContainer/Content/Seperator

func _ready() -> void:
	update_quest_log()
	QuestManager.quest_accepted.connect(func(quest: Quest): update_quest_log())
	QuestManager.quest_completed.connect(func(quest: Quest): update_quest_log())
	QuestManager.quest_abandoned.connect(func(quest: Quest): update_quest_log())
	QuestManager.objective_progress_changed.connect(func(quest: Quest, objective: QuestObjective): select_quest(quest_list.get_selected_quest()))
	quest_list.quest_selected.connect(select_quest)
	
func update_quest_log() -> void:
	print("updating quest log")
	if QuestManager.get_active_quests().size() == 0:
		quest_information.visible = false
		quest_list.visible = false
		no_active_quests.visible = true
		seperator.visible = false
	else:
		quest_information.visible = true
		quest_list.visible = true
		no_active_quests.visible = false
		seperator.visible = true
		
func select_quest(quest: Quest) -> void:
	quest_information.set_quest(quest)
	
func toggle() -> void:
	if visible:
		close()
	else:
		open()
		
func open() -> void:
	visible = true
	
func close() -> void:
	visible = false
