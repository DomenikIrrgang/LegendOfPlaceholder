class_name Energy
extends UnitResource

func _init(_stat_calculator: StatCalculator) -> void:
	super(_stat_calculator)
	type = ResourceType.Enum.ENERGY
	set_maximum_value(20)
	
func get_maximum_value() -> int:
	return super.get_maximum_value() + stat_calculator.get_stat_set().get_stat(Stat.Enum.ENERGY)
	
func on_stat_changed(stat, _value) -> void:
	if stat == Stat.Enum.ENERGY:
		resource_maximum_value_changed.emit(self, get_maximum_value(), get_maximum_value())
