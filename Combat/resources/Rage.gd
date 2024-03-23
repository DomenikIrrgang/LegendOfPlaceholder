class_name Rage
extends UnitResource

func _init(_unit: Unit) -> void:
	super(_unit)
	type = ResourceType.Enum.RAGE
	set_maximum_value(100)
	value = 0
	unit.combat_logic_result.connect(on_combat_logic_result)

func on_combat_logic_result(_result: CombatLogicResult) -> void:
	increase_value(2)

func reset() -> void:
	set_value(0)
	
func get_maximum_value() -> int:
	return super.get_maximum_value() + stat_calculator.get_rage()
	
func on_stat_changed(stat, _value) -> void:
	if stat == Stat.Enum.RAGE:
		resource_maximum_value_changed.emit(self, get_maximum_value())
