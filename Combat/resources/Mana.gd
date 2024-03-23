class_name Mana
extends UnitResource

func _init(_unit: Unit) -> void:
	super(_unit)
	type = ResourceType.Enum.MANA
	set_maximum_value(200)
	set_value(get_maximum_value())
	
func get_maximum_value() -> int:
	var inherited = super.get_maximum_value() + stat_calculator.get_mana()
	var stat  = stat_calculator.get_mana()
	return super.get_maximum_value() + stat_calculator.get_mana()
	
func on_stat_changed(stat, _value) -> void:
	if stat == Stat.Enum.MANA or stat == Stat.Enum.INTELLECT:
		resource_maximum_value_changed.emit(self, get_maximum_value())
