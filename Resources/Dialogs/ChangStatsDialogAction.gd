class_name ChangeStatsDialogAction
extends DialogAction

@export
var unit_name: String

@export
var stats: Array[StatAssignment]

func start() -> void:
	var unit: Unit = Globals.get_unit(unit_name)
	for stat_assignment in stats:
		unit.stats.increase_stat(stat_assignment.stat, stat_assignment.value)
	dialog_action_finished.emit(self)
