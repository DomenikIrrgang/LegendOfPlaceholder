class_name Health
extends UnitResource

func _init(_stat_calculator: StatCalculator) -> void:
	super(_stat_calculator)
	set_maximum_value(100)
	
func get_maximum_value() -> int:
	return super.get_maximum_value() + stat_calculator.get_health()
	
func on_stat_changed(stat, _value) -> void:
	if stat == Stat.Enum.HEALTH or stat == Stat.Enum.STAMINA:
		resource_maximum_value_changed.emit(get_maximum_value(), get_maximum_value())
