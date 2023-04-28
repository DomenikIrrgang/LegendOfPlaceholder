class_name Mana
extends UnitResource

func _init(_stat_calculator: StatCalculator) -> void:
	super(_stat_calculator)
	type = ResourceType.Enum.MANA
	set_maximum_value(200)
	set_value(get_maximum_value())
	
func get_maximum_value() -> int:
	return super.get_maximum_value() + stat_calculator.get_mana()
	
func on_stat_changed(stat, _value) -> void:
	if stat == Stat.Enum.MANA or stat == Stat.Enum.INTELLECT:
		resource_maximum_value_changed.emit(get_maximum_value())
