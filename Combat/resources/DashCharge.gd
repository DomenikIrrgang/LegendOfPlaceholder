class_name DashCharge
extends UnitResource

var scaling_factor: int = 10000
var regeneration_rate: float = 0.4 * scaling_factor

func _init(_stat_calculator: StatCalculator) -> void:
	super(_stat_calculator)
	type = ResourceType.Enum.DASH_CHARGE
	set_maximum_value(3 * scaling_factor)
	set_value(get_maximum_value())
	
func update(delta: float) -> void:
	increase_value(delta * regeneration_rate)
	
func get_charges() -> int:
	return floor(get_value() / scaling_factor)
	
func get_maximum_charges() -> int:
	return floor(get_maximum_value() / scaling_factor)
	
func reduce_charges(amount: int) -> int:
	return increase_value(-(amount * scaling_factor)) / scaling_factor
	
func get_maximum_value() -> int:
	return (super.get_maximum_value() + (stat_calculator.get_unit().get_stats().get_stat(Stat.Enum.DASH_CHARGE)) * scaling_factor)
	
	
func on_stat_changed(stat, _value) -> void:
	if stat == Stat.Enum.DASH_CHARGE:
		resource_maximum_value_changed.emit(get_maximum_value(), get_maximum_value())
