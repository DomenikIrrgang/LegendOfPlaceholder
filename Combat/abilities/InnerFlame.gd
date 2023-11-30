extends Ability

var InnerFlameBuff = load("res://Resources/StatusEffects/InnerFlame.tres")

func on_assign(unit: Unit) -> void:
	print("assigned inner flame")
	unit.apply_status_effect(InnerFlameBuff, unit)
	
func on_unassign(unit: Unit) -> void:
	print("unassigned inner flame")
	unit.remove_status_effect(InnerFlameBuff, unit)
