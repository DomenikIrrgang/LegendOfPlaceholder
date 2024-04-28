class_name QuestList
extends ScrollContainer

const QuestListItemComponent = preload("res://ui/GameUI/Questlog/QuestListItem.tscn")

@onready
var quest_list: VBoxContainer = $MarginContainer/QuestList

var selected_quest: Quest

signal quest_selected(quest: Quest)

func _ready():
	update_quest_list()
	SaveFileManager.game_state_loaded.connect(func(_game_state: Dictionary): update_quest_list())
	QuestManager.quest_accepted.connect(func(_quest: Quest): update_quest_list())
	QuestManager.quest_completed.connect(func(_quest: Quest): update_quest_list())
	QuestManager.quest_abandoned.connect(func(_quest: Quest): update_quest_list())
	
func update_quest_list() -> void:
	clear_quest_list()
	for quest in QuestManager.get_active_quests():
		var list_entry: QuestListItem = QuestListItemComponent.instantiate()
		quest_list.add_child(list_entry)
		list_entry.set_quest(quest)
		list_entry.gui_input.connect(on_quest_list_item_input.bind(quest))
	if quest_list.get_child_count() > 0 and selected_quest == null:
		select_quest_list_item(quest_list.get_child(0).quest)
	else:
		if QuestManager.get_active_quests().size() > 0:
			if not QuestManager.is_on_quest(selected_quest):
				select_quest_list_item(QuestManager.get_active_quests()[0])
			else:
				select_quest_list_item(selected_quest)
 		
func is_quest_selected() -> bool:
	for child in quest_list.get_children():
		if child.is_selected():
			return true
	return false

func on_quest_list_item_input(event: InputEvent, quest: Quest) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MASK_LEFT and event.is_pressed():
		select_quest_list_item(quest)
		
func select_quest_list_item(quest: Quest) -> void:
	for child in quest_list.get_children():
		if child.quest == quest:
			child.select()
		else:
			child.unselect()
	selected_quest = quest
	quest_selected.emit(quest)
	
func clear_quest_list() -> void:
	for child in quest_list.get_children():
		child.queue_free()

func get_selected_quest() -> Quest:
	return selected_quest
