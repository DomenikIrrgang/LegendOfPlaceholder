@tool
class_name DialogStep
extends Resource

@export
var type: DialogType.Enum

@export
var author: UnitData

@export_multiline
var text: String

var choices: Array[DialogChoice] = []

var choice: DialogChoice

@export
var actions: Array[DialogAction] = []
var finished_actions: Array[DialogAction]
var choice_finished: bool = false
var approved: bool = false

signal dialog_step_finished(cutscene_step: CutsceneStep)

func start() -> void:
	for action in actions:
		action.dialog_action_finished.connect(on_dialog_action_finished)
		action.start()
		
func approve() -> void:
	approved = true
	check_finished()
		
func update(delta: float) -> void:
	for action in actions:
		action.update(delta)
	if choice != null:
		choice.update(delta)
		
func choose(_choice: DialogChoice) -> void:
	choice = _choice
	choice.dialog_choice_finished.connect(on_dialog_choice_finished)
	choice.start()
	
func on_dialog_choice_finished(_dialog_choice: DialogChoice) -> void:
	choice.dialog_choice_finished.disconnect(on_dialog_choice_finished)
	choice_finished = true
	check_finished()
	
func on_dialog_action_finished(dialog_action: DialogAction) -> void:
	dialog_action.dialog_action_finished.disconnect(on_dialog_action_finished)
	finished_actions.append(dialog_action)
	check_finished()

func check_finished() -> void:
	if type == DialogType.Enum.CHOICE:
		if finished_actions.size() == actions.size() and choice_finished == true and approved:
			dialog_step_finished.emit(self)
	else:
		if finished_actions.size() == actions.size() and approved:
			dialog_step_finished.emit(self)

func set_type(_type: DialogType.Enum) -> void:
	type = _type
	notify_property_list_changed()

func _get_property_list() -> Array:
	var list = []
	if type == DialogType.Enum.CHOICE:
		list.push_back({
			name = "choices",
			type = TYPE_ARRAY,
			hint = PROPERTY_HINT_TYPE_STRING,
			hint_string = "%s/%s:%s" % [TYPE_OBJECT, PROPERTY_HINT_RESOURCE_TYPE, "DialogChoice"],
		})
	return list
