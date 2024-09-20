class_name KillUnitsObjective
extends QuestObjective

@export
var unit_data: UnitData

@export
var amount: int = 1

var progress = 0

func init() -> void:
	EventBus.on_event.connect(on_unit_died)
	
func reset() -> void:
	progress = 0
	EventBus.on_event.disconnect(on_unit_died)

func on_unit_died(event: String, data: Dictionary) -> void:
	if event == "UNIT_DIED" and data.unit.unit_data == unit_data and not is_completed():
		progress += 1
		objective_progress_changed.emit(self)
		
func quest_complete() -> void:
	if is_completed():
		reset()

func is_completed() -> bool:
	return progress >= amount
	
func get_progess_string() -> String:
	return str(min(progress, amount)) + "/" + str(amount) + " " + unit_data.alias + ("s" if amount > 1 else "") + " killed"
